# Installed pipeline provenance

Seven installed directories (`classify-change`, `code-review`, `codebase-design`, `implement`,
`implement-spec`, `setup-matt-pocock-skills`, and `tdd`) match
[Kirill Sachkov's shared source](https://github.com/KirillSachkov/workspace/tree/5cdf9b286b6b3244fd498e6f12ed58f0684a4ee8/pipeline/skills)
byte-for-byte at workspace commit `5cdf9b286b6b3244fd498e6f12ed58f0684a4ee8`.
The complete upstream sync is `a496f5513d4a4cf889bc48e189e579f4b0bdf6aa` from Matt Pocock's skills.
The [SHA-256 manifest](manifest.json) records source identities, the installed set and every file hash.
`.claude/skills/` contains relative aliases to these canonical project directories.
The two public kit guides remain canonical in `skills/`.

## Dependency-complete installation

The owner's follow-up clarified that required dependencies belong to this update.
`implement-spec` now delegates ticket execution to installed `implement`; its required TDD,
review and classification support is present. `codebase-design` supplies TDD's conditional seam-design
reference, including both linked design documents. No unrelated optional stages were added.
Both implementation entrypoints retain the canonical model-invocable metadata. Setup stays manual.

Installation does not execute setup or change accepted project delivery authority.
The project retains its explicit whole-specification entrypoint, main-session editorial writer,
deferred classification, project checks and review gates. Only the conflicting manual invocation
claim was removed from WORKFLOW; no broad conversational routing migration was performed.

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
and its project procedure. Preserve canonical invocation policy in both SKILL frontmatter and
`agents/openai.yaml`; importing setup does not authorize its execution or install further skills.
Consult WORKFLOW for the project classification state.

To roll back this assignment, prepare and review a selective reversal from the pre-adoption commit
recorded in the [task](../tasks/matt-skills-update-2026-10-29.md), covering only assigned installed
skills and provenance. Check reverse-patch applicability, preserve unrelated work and runtime state,
run required checks/review, and record the resulting installed and project policy identities.
Do not reset the entire repository.
