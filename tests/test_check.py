"""Failures a maintainer should see before publishing an edited kit."""
import importlib.util
import tempfile
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location("kit_check", Path(__file__).resolve().parents[1] / "scripts/check.py")
check = importlib.util.module_from_spec(spec)
spec.loader.exec_module(check)


class CheckTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)

    def write(self, name, text):
        path = self.root / name
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text)
        return path

    def test_navigation_and_heading(self):
        self.write("README.md", "[Setup](guide.md#настройка)\n")
        self.write("guide.md", "# Настройка\n")
        self.assertEqual(check.validate(self.root)[0], [])
        self.write("guide.md", "# Другая тема\n")
        self.assertTrue(check.validate(self.root)[0])

    def test_missing_and_external_local_file(self):
        self.write("README.md", "[Missing](missing.md)\n[Outside](../private.md)\n")
        self.assertEqual(len(check.validate(self.root)[0]), 2)

    def test_malformed_config(self):
        self.write("settings.json", '{"theme": }')
        self.write("config.toml", "theme = [")
        self.assertEqual(len(check.validate(self.root)[0]), 2)

    def test_private_value_is_not_printed(self):
        synthetic = "ghp_" + "A" * 30
        self.write("config", synthetic)
        errors, _ = check.validate(self.root)
        self.assertTrue(errors)
        self.assertNotIn(synthetic, " ".join(errors))

    def test_skill_copied_with_its_references(self):
        self.write("skills/sample/SKILL.md", '---\nname: sample\ndescription: "Example task"\n---\n[Context](references/context.md)\n')
        self.write("skills/sample/references/context.md", "# Context\n")
        self.assertEqual(check.validate(self.root / "skills/sample")[0], [])
        self.write("skills/sample/SKILL.md", '---\nname: sample\ndescription: "Example task"\n---\n[Context](../../README.md)\n')
        self.assertTrue(check.validate(self.root / "skills/sample")[0])

    def test_symlink_cannot_export_other_files(self):
        target = self.write(".checks/private", "Private")
        (self.root / "export").symlink_to(target)
        self.assertTrue(check.validate(self.root)[0])

    def test_relative_skill_discovery_survives_relocation(self):
        import shutil

        self.write("skills/sample/SKILL.md", '---\nname: sample\ndescription: "Example task"\n---\n[Context](references/context.md)\n')
        self.write("skills/sample/references/context.md", "# Context\n")
        for runtime in (".agents", ".claude"):
            parent = self.root / runtime / "skills"
            parent.mkdir(parents=True)
            (parent / "sample").symlink_to("../../skills/sample", target_is_directory=True)
        moved = self.root / ".checks" / "moved"
        shutil.copytree(self.root, moved, symlinks=True, ignore=shutil.ignore_patterns(".checks"))
        self.assertEqual(check.validate(moved)[0], [])
        for runtime in (".agents", ".claude"):
            entry = moved / runtime / "skills/sample/SKILL.md"
            self.assertEqual(entry.read_bytes(), (moved / "skills/sample/SKILL.md").read_bytes())

    def test_discovery_rejects_wrong_absolute_or_broken_targets(self):
        self.write("skills/sample/SKILL.md", '---\nname: sample\ndescription: "Example task"\n---\n')
        self.write("skills/other/SKILL.md", '---\nname: other\ndescription: "Other task"\n---\n')
        parent = self.root / ".agents/skills"
        parent.mkdir(parents=True)
        link = parent / "sample"
        for target in ("../../skills/other", str(self.root / "skills/sample"), "../../missing"):
            with self.subTest(target=target):
                link.symlink_to(target, target_is_directory=True)
                self.assertTrue(check.validate(self.root)[0])
                link.unlink()

    def test_directory_and_broken_export_symlinks_are_rejected(self):
        target = self.write(".checks/private/file", "Private").parent
        (self.root / "directory").symlink_to(target, target_is_directory=True)
        (self.root / "broken").symlink_to("missing")
        self.assertEqual(len(check.validate(self.root)[0]), 2)

    def test_skill_metadata_and_maximum_name_length(self):
        name = "a" * 64
        self.write(f"skills/{name}/SKILL.md", f'---\nname: {name}\ndescription: "Example task"\nmetadata:\n  author: Example\n---\n')
        self.assertEqual(check.validate(self.root)[0], [])

    def test_unsupported_skill_field(self):
        self.write("skills/sample/SKILL.md", '---\nname: sample\ndescription: "Example task"\nunexpected: value\n---\n')
        self.assertTrue(check.validate(self.root)[0])


if __name__ == "__main__":
    unittest.main()
