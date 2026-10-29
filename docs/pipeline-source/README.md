# Installed pipeline provenance

Four installed directories (`classify-change`, `code-review`, `setup-matt-pocock-skills`, and `tdd`)
match [Kirill Sachkov's shared source](https://github.com/KirillSachkov/workspace/tree/5cdf9b286b6b3244fd498e6f12ed58f0684a4ee8/pipeline/skills)
byte-for-byte at workspace commit `5cdf9b286b6b3244fd498e6f12ed58f0684a4ee8`.
The complete upstream sync is `a496f5513d4a4cf889bc48e189e579f4b0bdf6aa` from Matt Pocock's skills.
The [SHA-256 manifest](manifest.json) records source identities and every installed source hash.
`.claude/skills/` retains relative aliases to these canonical project directories.
The two public kit guides remain canonical in `skills/`.

## Retained project exception

`implement-spec` retains its self-contained execution and manual invocation policy:
`SKILL.md` comes from workspace `0017667f4e7beb5e3b6f8428ae21441496cdfec9` and
`agents/openai.yaml` from `d459183f46290ef74ede4f3eca349ab0682cbd0c`.
The new canonical body requires the uninstalled `implement` skill and conversational routing.
The owner excluded that migration and additions to the selected five-skill set from this update.
`file_source_commits` overrides `source_commit` for those two files; their hashes remain verified.

Installation does not execute setup. Its updated template describes a future accepted implementation
route; any future setup must preserve this project's selection and authority until the owner assigns
that migration. Existing workflow, deferred classification, and invocation exceptions remain in force.
TDD can reference the uninstalled `codebase-design`; that pre-existing recommendation does not install it.

## Source and license

Matt Pocock authored the upstream pipeline skills; `classify-change` is a shared local addition.
This is an adapted shared set, not pristine upstream. Accepted adaptations and the upstream corrections
are recorded in the [pinned pipeline README](https://github.com/KirillSachkov/workspace/blob/5cdf9b286b6b3244fd498e6f12ed58f0684a4ee8/pipeline/README.md).
The GitLab template preserves `glab mr list -F json` and uses `glab issue list -O json`.
The source's wizard marker correction does not apply because `wizard` is not installed.

The [MIT license notice](LICENSE-Matt-Pocock.txt) was originally fetched from the
[immutable upstream restoration commit](https://github.com/mattpocock/skills/blob/49dd158d1076134a641b33efb035946536778336/LICENSE).
Copyright (c) 2026 Matt Pocock. Retain this notice when redistributing substantial upstream material.

Project exceptions, tracker, resources, review, and delivery live in [WORKFLOW](../../WORKFLOW.md)
and its project procedure. Preserve manual invocation in both SKILL frontmatter and
`agents/openai.yaml`; importing setup does not authorize its execution or install further skills.
Consult WORKFLOW for the project classification state.

To roll back this assignment, prepare and review a selective reversal from the pre-adoption commit
recorded in the [task](../tasks/matt-skills-update-2026-10-29.md), covering only assigned installed
skills and provenance. Check reverse-patch applicability, preserve unrelated work and runtime state,
run required checks/review, and record the resulting installed and project policy identities.
Do not reset the entire repository.
