# Session boundaries — 18 October 2026

Tracker: [ai-dev-kit #3](https://github.com/KirillSachkov/ai-dev-kit/issues/3). Umbrella and assigned coordinator: [workspace #64](https://github.com/KirillSachkov/workspace/issues/64).

## Assignment and ownership

Owner-approved dispatch `1792343052414654000` assigns bounded harness maintenance, not an implement-spec run. Base: `37b87d5207c3d480cc6f18f361fce85ed5c2cf90`; initial checkout clean, one main worktree. Source: immutable workspace `0017667f4e7beb5e3b6f8428ae21441496cdfec9`, inspected with `git show` for its harness contract, pipeline README, and implement-spec.

This project session is the sole writer. Native read-only reviewers own only their review tasks. workspace#64 collects this task's progress/result and may close only the newly created assigned session after durable handoff; this session does not close itself. Foreign sessions, results, resources, historical snapshots, classification state/risk policy, and publication/paid/deployment gates remain outside scope. No foreign changes were present initially. No independent sessions are launched.

Task graph: bounded editorial update → committed immutable review inputs → independent ticket Standards/Spec review → validated fixes if needed → independent final Standards/Spec review → required checks and authorized integration/push → tracker handoff. Existing owner authorization covers scoped delivery; no deployment assigned.

## Prepared result and checks

WORKFLOW routes explicit natural-language whole-spec assignments to installed implement-spec. Project procedure points to the pinned shared contract for handoff/coordination semantics and retains local editorial exceptions. Ordinary library maintenance uses focused checks/review; executable tooling and explicit implementation retain engineering review. Only implement-spec/SKILL.md changes among installed skill files, byte-for-byte from the assigned source. Manifest uses a per-file source override; other files retain baseline provenance and bytes.

Initial required checks: `python3 scripts/check.py` passed (75 files, 4 JSON, 6 TOML, 100 links, 7 skills); `git diff --check` passed. A Python comparison verified all 21 manifest hashes and effective immutable source files, and all 20 other installed files against base, including native manual metadata. No scripts, public product skills, configs, or source snapshots changed.

## Scenario inspection

Read WORKFLOW → project procedure → pinned shared contract, plus installed implement-spec:

| Scenario | Required route confirmed |
|---|---|
| Independent launch | Shared independent-handoff section: deliver assignment, verify receipt, report location; launch complete. |
| Launch specification elsewhere | Installed skill assigns execution to destination; shared invocation route excludes launcher execution. |
| Monitor only | Shared coordination section restricts monitor-only authority; direction and acceptance require assignment. |
| Coordinate assigned tasks | Shared contract limits lead to assigned task set; local worker paragraph limits responsibilities to assignment. |
| Natural-language whole-spec execution | WORKFLOW and installed skill accept explicit whole-spec requests without literal skill name. |
| Discussion-only specification | Shared stage ownership and local start section distinguish discussion/preparation from execution. |
| Ordinary editorial material | Local execute section routes documentation/skill maintenance through focused checks/review; explicit spec remains separate. |
| Required native review | Local worker route requires native subagents; unavailable runtime leaves review pending; pinned contract excludes independent Herdr substitution. |

All eight inspections passed. These are bounded contract walkthroughs, not live Herdr launches or new product-skill installations. Independent reviewers will examine changed routes and neighboring contracts. Review inputs/results and delivery evidence follow in the issue; pending until recorded.
