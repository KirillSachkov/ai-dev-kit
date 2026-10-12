---
name: orchestrate
description: Complete or resume an owner-assigned specification or set of tasks through independent workers, review, integration, and authorized delivery.
---

# Orchestrate

Own completion of the assignment. Workers own implementation, diagnosis, checks, fixes, and
cleanup. You own dependencies, acceptance, integration, and overall completion.
The owner's execution request starts this workflow. Preparing a specification or tickets does
not start execution. Project `AGENTS.md` and workflow govern dispatch, resources, and delivery.

## Establish the run

1. Read the assignment, project rules, specification, and tickets. Identify acceptance criteria,
   dependencies, delivered work, and existing workers. If tickets are missing, use an existing
   actionable plan or prepare them only within the owner's requested scope.
2. Reconcile Issues and PRs with actual branches, worktrees, checks, and worker state. Keep a short
   linked task map there: decisions, worker/session IDs, resource owners, results, and next actions.
   Use the project's durable task document when it has no Issue/PR workflow.
   Preserve active workers after resumption. Replace an unavailable worker from its recovered
   result and remaining scope. A transcript or completion message alone does not establish delivery.
3. Check the current environment's required skills, dependencies, services, and delivery permissions.
   Local Codex work stays in the current session. Cloud access must be checked inside the cloud
   task. Use the owner's agent/model selection; otherwise inherit the current agent and model.
   If the runtime cannot provide required delegation or selection, record the limitation and resolve
   it before dependent work. Project rules determine native subagents or managed sessions.

## Execute the task graph

4. Delegate substantial ready tasks in parallel as dependencies and resources permit. Each writing
   task has one owner. Isolate writing worktrees where the project permits them; serialize writes
   when the project uses its main checkout. Assign shared-resource work to one worker.
   A specification uses one integration branch and final PR by default. Independent tasks use
   separate PRs. Preserve the project's delivery convention when it does not use branches or PRs.
5. Give workers concise pointers to the goal, scope, acceptance criteria, upstream results, base
   commit, verification requirements, and relevant owner instructions. Workers use `implement`
   and `tdd` when available: test public behaviour in red-to-green slices. Respect owner-agreed
   test boundaries; workers choose remaining checks from acceptance criteria. For editorial or
   other non-code work, use the project's production and review workflow.
6. Require independent review of every task before accepting it into integration. Use `code-review`
   when available, with the task's fixed base, specification, and project standards. Return findings
   to the task worker. Assign shared conflicts or integrated failures to an integration worker when
   needed. Workers return commits/artifacts, actual check evidence, review results, and limitations.
7. Integrate accepted work continuously and dispatch newly unblocked tasks. Resolve bounded,
   reversible technical blockers within scope. Ask the owner about business ambiguities, changes
   outside the assignment, and explicit owner gates. Continue independent work while waiting.
   Pause the whole specification only when the decision affects the whole specification.

## Accept and deliver

8. Check integrated behaviour against all acceptance criteria. Require independent final review
   and the project's final checks on the integrated inputs. Record evidence with the checked
   commit, commands/scenarios, results, and accessible artifacts. Reuse evidence only while its
   checked inputs remain valid; repeat affected checks after input changes, failures, or new risks.
9. Complete authorized merge, task resolution, and cleanup through the project workflow. Deployment
   is separate unless included in the assignment. Clean up completed owned resources only after
   preserving required evidence and confirming no live worker needs them.
10. Finish when the assigned criteria and authorized delivery are verified. If work remains blocked,
    record what is complete, the remaining scope, the blocker, and the exact continuation condition.

After each verified stage, report changed behaviour, where the owner can inspect it, verification
and review, any required owner decision, and remaining work. Keep detailed logs behind links.
Update durable state at dispatch, acceptance, integration, owner decisions, and handoff.
