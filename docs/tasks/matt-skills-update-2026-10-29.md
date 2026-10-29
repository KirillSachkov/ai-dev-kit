# Matt skills installation update — 2026-10-29

## Assignment and inputs

Owner assignment: bounded update from [workspace #26](https://github.com/KirillSachkov/workspace/issues/26).
Pre-adoption and project policy commit: `022df06cf27e890fb20b898df0fb0d97b46f787e`.
Workspace source: `5cdf9b286b6b3244fd498e6f12ed58f0684a4ee8`.
Upstream full sync: `a496f5513d4a4cf889bc48e189e579f4b0bdf6aa`.

Graph: source comparison → single-writer installation → checks → independent focused review → integration/delivery.
This project session owns the only writing task and its temporary source extraction. Review workers are read-only.
Initial worktree was clean; no local task workers or writer lock existed. Preserve all foreign resources.
Session mode remains main; classification remains deferred. No product deployment.

## Initial installation (superseded dependency decision)

All 21 prior installed files matched manifest hashes and their recorded workspace sources.
Copy four complete canonical directories: classify-change, code-review, setup-matt-pocock-skills, tdd.
Retain implement-spec's two files at recorded sources: the latest canonical route needs absent implement
and changes invocation. The assignment excludes that migration and additions. Own kit skills, discovery
aliases, project contracts, and license notice remain unchanged.
Update provenance/manifest and the skills catalog's shared-source pointer; preserve the historical video selection.
No new skills are installed; setup is inspected and copied, never executed.

## Initial review and publication evidence

Project tracker: [ai-dev-kit #4](https://github.com/KirillSachkov/ai-dev-kit/issues/4).
Initial GitHub discovery EOF was transient; tracker delivery succeeded on retry.
Implementation reviewed at `bd20b424d21695aae56a6dca937a90e413b1f91a` against the pre-adoption base.
Policy identity remains `022df06cf27e890fb20b898df0fb0d97b46f787e`.

- `python3 scripts/check.py`: PASS, 77 files, 4 JSON, 6 TOML, 101 links, 7 skills.
- `git diff --check`: PASS.
- All 21 SHA-256 manifest entries and recorded source bytes: PASS.
- Exact file membership/bytes for four canonical directories: PASS (classify-change is unchanged).
- Manual implement-spec/setup metadata, both discovery surfaces, selected set: PASS.
- Retained MIT notice matches upstream `a496f5513d4a4cf889bc48e189e579f4b0bdf6aa/LICENSE` byte-for-byte.
- Independent native Standards reviewer: PASS, 0 findings; source/manifest, policies, links and license checked.
- Independent native Spec reviewer: PASS, 0 findings; assignment scope, dependencies and caller contracts checked.

No finding fixes were required. This task-record evidence update leaves reviewed skill/provenance inputs
unchanged. No new skills or executable code were introduced; setup was not invoked. No CI workflow
is configured in this repository. Fetch confirmed origin/main still at the pre-adoption base, so
integration is a normal fast-forward push of main after the final documentation check.
The retained implement-spec version is an explicit scope limitation, not a pending approved migration.
Publish completion and exact final commit in issue #4 and the requested external JSON result.
Cleanup covers only this task's temporary extraction and body files after evidence delivery.


## Dependency correction — same assignment

Orca message `msg_611a6a2df812` clarifies required dependencies are authorized; it supersedes the
initial decision to retain old implement-spec. Correction base and prior published head:
`914db8afd7acb8e523cd2bd0b13918f839892cd3`. Continue issue #4, reopened for this correction.

Copy exact canonical implement-spec and add implement plus codebase-design (TDD's conditional
reference); existing tdd/code-review/classify-change complete the required support set.
Preserve optional stages, own skills, session mode, deferred classification, editorial route and
checks/review/delivery gates. Remove only conflicting manual invocation facts from workflow/procedure
and provenance; keep the explicit whole-specification project pointer.

Graph: dependency inspection → single-writer copy → isolated routing/real-request exercise →
checks and independent focused Standards/Spec review → authorized push and updated RESULT JSON.
This session remains sole repository writer; native exercises use isolated scratch inputs.
Evidence for corrected input snapshot and review is pending; initial 21-file checks/review above
remain historical and do not establish acceptance of the correction.
