---
name: implement-spec
description: "Implement the result of /to-spec and /to-tickets in code."
disable-model-invocation: true
---

You have been provided a spec. This spec should have tickets associated with it, describing how to implement the spec.

An explicit owner request to implement the whole specification invokes this workflow, whether the
owner names the skill or uses natural language. A request to launch that work in another session
assigns execution to the destination session; the launcher's responsibility follows its handoff scope.
Run bounded workers as native subagents under the project's rules. Independent owner sessions
participate only under an explicit coordination assignment; launching one does not make it a worker.

The issue tracker should have been provided to you. If not, tell the user to run `/setup-matt-pocock-skills`.

The goal is the entire spec implemented on a single **integration branch**, with every ticket resolved the way the issue tracker closes work.

The tickets are not a list of steps. They are a **task graph** with blocking relationships between them. This means there is always a **frontier** of tickets which are ready to be grabbed.

Communication to and from subagents should be sparse. Communicate primarily through **context pointers**: to the spec, tickets, research notes, and previous commits. Don't duplicate information already available via pointers.

**Implementer subagents** should be run in the background where possible for maximum concurrency.

## Steps

1. Read the spec and tickets to understand the task graph.
   For a project enabling classification in root `WORKFLOW.md`, invoke `classify-change` for provisional assessment.
   Preserve the owner-approved ticket graph; unconfigured projects keep their existing route.

2. (optional) Use an **exploration subagent** to conduct any exploration required by the tickets - relevant codebase files or external documentation. Ensure the exploration subagent can save files - it should save its markdown notes in a directory outside the repo, accessible by all future subagents. This lets **implementer subagents** focus on implementation rather than exploration.

3. Create the integration branch. If the issue tracker closes work through PRs, or the user asks for one, open a draft PR after the first merge in step 5 (a branch with no commits ahead of main can't open one), marked as closing the spec and tickets.

4. Use **implementer subagents** to implement each ticket, each in its own worktree on its own branch. Each implementer subagent:
   - confirms its worktree is based on the integration branch before starting, and resets onto it if not;
   - invokes `classify-change` for its ticket when project classification is enabled;
   - calls the Skill tool with `tdd` to build the ticket;
   - commits its implementation before actual-change classification and diff-based review;
   - assesses actual-change risk with `classify-change` after initial implementation, before finalizing ticket review and verification, when enabled;
   - maintains relevant project risk facts and obtains independent per-ticket `code-review` before integration acceptance;
   - invokes or reuses applicable participation assessment before any planned protected boundary and satisfies its conditions;
   - records the actual assessed commit, checks, review outcomes, and participation conditions in the existing ticket/PR;
   - merges the integration branch tip into its own branch before reporting done;
   - assesses participation on the prepared ticket result and rechecks risk applicability with `classify-change`, when enabled;
   - rechecks review/evidence applicability after integration updates before reporting completion

5. Once an **implementer subagent** completes independent ticket review, merge its work with a **merger subagent**.
   Honor earlier owner gates before consequential actions. Acceptance required only before final merge permits isolated integration-branch assembly.

6. If this changes the **frontier** of available tickets, kick off more **implementer subagents** to work on the new tickets. This allows for maximum concurrency.

7. Once all tickets are complete, assess integrated actual-change risk with `classify-change`, when enabled, before finalizing review and verification.
   Account for cross-ticket interactions and complete assigned verification. Invoke or reuse participation assessment before planned protected boundaries.
   Call the Skill tool with `code-review` on the integration branch. Validate and resolve blocking findings under `code-review` in a single **implementer subagent**.
   Commit fixes before affected re-review; retain dispositions for optional suggestions and unrelated unchanged defects.

8. For enabled projects, assess participation on the final prepared integrated result and recheck risk/evidence applicability through `classify-change`.
   Complete required verification and review; reassess conclusions affected by fixes or policy changes.
   Satisfy participation conditions and preserve evidence in the existing issue/PR before authorized final merge.
   Project workflow determines assigned delivery completion; deployment retains its separate gates.

9. If a draft PR exists, mark it ready for review. Otherwise, resolve each ticket the way the issue tracker closes work, and report the integration branch.

10. Clean up all **implementer subagent** worktrees.
