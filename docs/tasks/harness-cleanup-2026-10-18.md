# Harness cleanup — 18 October 2026

Tracker: [ai-dev-kit #1](https://github.com/KirillSachkov/ai-dev-kit/issues/1). Cross-project assignment: [workspace #61](https://github.com/KirillSachkov/workspace/issues/61).

## Inputs and decisions

- Pre-adoption project HEAD: `863cfb467b31823c237f590c17f31d2567d853e3`; clean checkout confirmed before writing.
- Owner assignment: dispatch brief `1792308226571091000`, accepted cleanup using implement-spec with project-owned editorial overrides and native bounded workers. Coordinator `/root`; sole writer `/root/cleanup_writer`.
- Immutable source: `d459183`, fully resolved in the [installed-file manifest](../pipeline-source/manifest.json). [Provenance and license](../pipeline-source/README.md) record upstream bases and shared adaptations. Installed source files remain byte-identical.
- Root WORKFLOW owns both configuration declarations. No accepted previous classification policy was found. The assignment explicitly authorizes deferred state; disabled is recommended for this static editorial/configuration library, pending owner acceptance. Existing checks and review remain required.
- Root CLAUDE contained only a pointer to AGENTS; no unique rule was lost. The owner-provided brief confirms Claude Code 2.1.301 supports native AGENTS with fallback enabled. No historical snapshots or imported fixtures were rewritten.
- Removed active retired coordinator after preserving project-specific procedure. Git history preserves its source; no unrelated runtime state or global settings are changed.
- No karpathy-guidelines or modern-web-guidance installation exists in this project's discovery directories. No unrelated global installations inspected.

## Task graph and resource ownership

One implementation ticket, followed by independent ticket acceptance and final acceptance:

1. **T1 — editorial migration:** sole writer owns the current project checkout. Install the five selected source directories and metadata/references; preserve licensing and hashes; remove redundant bridge/retired discovery; update active installation guidance and narrowly support canonical aliases/manual metadata in validator. Apply the project's sequential editorial exception to branch/worktree defaults.
2. **R1 — independent ticket review:** blocked on committed T1. Coordinator dispatches independent native Standards and Spec review against immutable pre-adoption/head inputs, validates findings, and returns fixes to the sole writer. Ticket acceptance requires resolved blocking findings and applicable checks.
3. **F1 — final acceptance and delivery:** blocked on R1. Coordinator obtains independent final review on the integrated result, verifies required checks and isolated real-request skill scenarios, updates the issue, and writes the assigned cross-project handoff. Authorised delivery and publication are tracked separately; a worker commit alone does not close the assignment.

Read-only reviewers may run concurrently. Foreign sessions, worktrees, history, published configs, and snapshots remain outside this resource assignment.

## Verification and current state

T1 implementation was committed as `979d8e3c9c10a8f8c5077c33b6a1fadcc91f5b88`. Writer verification on 18 October 2026: `python3 scripts/check.py` passed (74 files, 4 JSON, 6 TOML, 98 links, 7 skills). Temporary-directory validator scenarios passed: old validator rejected the canonical manual installation (red); updated validator accepted it (green), retained public kit aliases, rejected absolute/broken/escaping/arbitrary symlinks, and rejected an implicit Codex adapter for a manual skill. Manifest verification matched all 21 source files. Root declaration checks passed; `configs/` and `sources/` had no diff. Public validation inputs were the test boundary.

Independent Standards review of `979d8e3` reported zero findings. Spec review identified validated blocking finding **SPEC-01**: active installation guidance first selected upstream folders/setup, then attributed the shared adaptation's native AGENTS/WORKFLOW behavior to that route. The follow-up correction explicitly separates upstream behavior from the pinned adapted shared set and routes the project-owned harness setup to the latter. Affected Spec re-review is pending on the follow-up commit. Coordinator independently reran the required check on the project and a fresh Git archive snapshot, checked all 21 installed source files against the immutable shared commit, verified unique declarations, and confirmed no config/source changes or active legacy bridge/coordinator discovery.

Isolated real-request skill evaluation and final acceptance remain pending. Required checks are `python3 scripts/check.py` and `git diff --check`; the writer reruns both for the guidance correction. Coordinator records actual reviewed commits, findings, and final delivery evidence in the tracker.

Suggested isolated real requests: resume this assigned editorial spec through implement-spec using the project overrides; discuss a topic without invoking a manual stage; assess classification with deferred policy without inventing enabled gates; request setup without installing unrelated skills; review fixed immutable inputs on both axes. New imported skills require these isolated behavioral checks before delivery.

Writer does not push or access accounts. Remaining delivery: independent native reviews/evaluation, tracker evidence, final handoff, and coordinator-authorized integration/publication. No production deployment is assigned.
