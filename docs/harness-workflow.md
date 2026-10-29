# Project execution procedure

[WORKFLOW.md](../WORKFLOW.md) owns session configuration and stage selection. This procedure governs assigned maintenance and project-specific overrides when a stage is selected; distributable kit materials remain in `skills/`.

For independent session launch, assigned coordination (including monitor-only), and whole-specification invocation, follow the pinned [shared harness contract](https://github.com/KirillSachkov/workspace/blob/0017667f4e7beb5e3b6f8428ae21441496cdfec9/docs/harness-workflow.md#independent-handoff-and-assigned-coordination) and its stage ownership and editorial/engineering routes. The sections below supply project exceptions and delivery rules.

## Start or resume

Preparing a specification, task list, or report does not assign execution. Use the owner's selected stages, agents, and models; otherwise inherit the active session. Check required skills, dependencies, accesses, and runtime before dependent work. Local work stays in the current runtime; verify Cloud access inside its assigned task. Record unsupported delegation/model selection and resolve it before dependent work.

Read the assignment and acceptance criteria; inspect checkout, unrelated changes, and live workers. Use the GitHub project tracker linked from WORKFLOW. Keep a durable task record under `docs/tasks/` with graph dependencies, resource owners, decisions, verified inputs, results, and next actions. If tracker access fails, preserve verified local work and disclose pending tracker delivery.

Update evidence at dispatch, acceptance, integration, owner decisions, and handoff. On resumption reconcile records against actual files, checks, and workers; preserve active workers and accepted results, assigning only remaining work.

## Execute and review

Ordinary library documentation, skill maintenance, research, and material review use focused checks and review of the changed material. They do not invoke whole-specification execution. Explicit whole-specification assignments use implement-spec with the editorial exceptions below; executable tools retain engineering verification.

For editorial assignments, the current checkout has one writer and changes proceed sequentially. This is the project's exception to implement-spec's integration branch and per-worker branch defaults. Read-only exploration and independent review may run concurrently. For a software specification requiring branch isolation, use a temporary integration branch and separate worker worktrees; combine one specification into its final PR and deliver independent assignments separately.

Run bounded implementation, exploration, and review workers as native subagents of the active project task. An isolated worktree or read-only access to another repository does not create an independent owner session. Preserve foreign sessions and resources. If native workers are unavailable, record the limitation and leave independent review pending; resume in a native-capable session.

Each writing task has one worker responsible for implementation, checks, review fixes, and owned-resource cleanup. When coordination is assigned, the lead owns only the dependencies, acceptance, and delivery responsibilities assigned for that task set. Use the installed TDD reference for code behavior; editorial work uses this procedure and meaningful document/behavior checks.

Apply AGENTS checks and checks of changed behavior. For software/tooling changes and explicitly assigned implementation workflows, obtain independent per-ticket code-review before acceptance and independent final code-review of the complete result. Ordinary editorial maintenance uses focused review; an assignment may require independent Standards/Spec review, as this boundary-maintenance assignment does. Keep Standards and Spec axes distinct. Validate findings; commit fixes before affected re-review. A worker completion message alone does not establish acceptance or delivery.

Before completion verify every acceptance criterion and run final required checks. Record commands, actual results, checked commits or input snapshots, review dispositions, and accessible artifacts in the task/issue. Reuse evidence only while its checked inputs still apply. Repeat affected checks after changed inputs, failures, or unresolved concerns.

## Deliver

Complete authorized integration, tracker resolution, handoff, and cleanup under project gates. Deployment requires an assigned deployment scope. Apply the authority boundaries in [AGENTS.md](../AGENTS.md#help-users); existing owner authorization remains applicable within its scope.

Clean up only owned completed resources after preserving evidence and confirming no live worker needs them. Finish after criteria and authorized delivery are verified. If blocked, record completed work, remaining work, and the exact condition for continuation.

After each verified stage report observable result, inspection link/artifact/command, verified inputs and checks/review, any concrete owner decision, and remaining work. Distinguish prepared diff, local checks, CI, integration, application, and publication.
