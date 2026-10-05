#!/usr/bin/env python3
"""Check navigation, skill structure and exported configs without network calls."""
from __future__ import annotations

import json
import re
import sys
import tomllib
from pathlib import Path
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parents[1]
IGNORED = {".git", ".reports", ".checks", ".venv", "__pycache__"}
LINK = re.compile(r"\[[^\]]*\]\((<[^>]+>|[^\s)]+)(?:\s+\"[^\"]*\")?\)")
NAME = re.compile(r"[a-z0-9]+(?:-[a-z0-9]+)*\Z")
SKILL_FIELDS = {"name", "description", "license", "allowed-tools", "metadata"}
SECRET = re.compile(
    r"(?:sk-[A-Za-z0-9_-]{20,}|gh[pousr]_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}"
    r"|-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----|/[U]sers/[^/\s]+/)"
)


def files(root: Path):
    return sorted(p for p in root.rglob("*") if p.is_file() and not any(x in IGNORED for x in p.relative_to(root).parts))


def headings(text: str):
    used = {}
    result = set()
    in_code = False
    for line in text.splitlines():
        if line.startswith("```"):
            in_code = not in_code
        if in_code or not re.match(r"^#{1,6} ", line):
            continue
        value = re.sub(r"^#{1,6} ", "", line).strip().lower()
        value = re.sub(r"[`*_]", "", value)
        value = re.sub(r"[^\w\s-]", "", value).replace(" ", "-")
        count = used.get(value, 0)
        used[value] = count + 1
        result.add(value if not count else f"{value}-{count}")
    return result


def validate(root: Path):
    root = root.resolve()
    errors = []
    counts = {"files": 0, "json": 0, "toml": 0, "links": 0, "skills": 0}
    for path in files(root):
        relative = path.relative_to(root)
        counts["files"] += 1
        if path.is_symlink():
            errors.append(f"{relative}: exported file must not be a symlink")
            continue
        try:
            text = path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            continue
        if SECRET.search(text):
            errors.append(f"{relative}: private data pattern found; value suppressed")
        try:
            if path.suffix == ".json":
                json.loads(text)
                counts["json"] += 1
            elif path.suffix == ".toml":
                tomllib.loads(text)
                counts["toml"] += 1
        except ValueError:
            errors.append(f"{relative}: invalid {path.suffix} syntax")
        if path.name == "SKILL.md":
            counts["skills"] += 1
            match = re.match(r"\A---\n(.*?)\n---\n", text, re.S)
            if not match:
                errors.append(f"{relative}: missing frontmatter")
            else:
                fields = {}
                for line in match.group(1).splitlines():
                    if line.startswith((" ", "\t")) or line.startswith("#"):
                        continue
                    key, separator, value = line.partition(":")
                    if separator:
                        fields[key] = value.strip().strip('"')
                name = fields.get("name", "")
                if not NAME.fullmatch(name) or len(name) > 64 or name != path.parent.name:
                    errors.append(f"{relative}: invalid skill name")
                if not fields.get("description"):
                    errors.append(f"{relative}: missing skill description")
                if set(fields) - SKILL_FIELDS:
                    errors.append(f"{relative}: unexpected frontmatter fields")
        if path.suffix != ".md":
            continue
        for match in LINK.finditer(text):
            target = match.group(1).strip("<>")
            parsed = urlsplit(target)
            if parsed.scheme or parsed.netloc:
                continue
            counts["links"] += 1
            resolved = (path.parent / unquote(parsed.path)).resolve() if parsed.path else path
            if not resolved.is_relative_to(root):
                errors.append(f"{relative}: local link leaves the kit")
            elif not resolved.exists():
                errors.append(f"{relative}: missing target {target}")
            elif parsed.fragment and resolved.is_file() and resolved.suffix == ".md":
                if unquote(parsed.fragment) not in headings(resolved.read_text(encoding="utf-8")):
                    errors.append(f"{relative}: missing heading {target}")
    return errors, counts


def main():
    errors, counts = validate(ROOT)
    for message in errors:
        print(message, file=sys.stderr)
    print(json.dumps({"ok": not errors, **counts}, ensure_ascii=False))
    return bool(errors)


if __name__ == "__main__":
    raise SystemExit(main())
