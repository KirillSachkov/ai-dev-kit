---
name: classify-change
description: Classify change risk, required verification, and owner participation when a project enables classification or the owner requests assessment.
---

# Classify change

Assess an assigned change through two independent native read-only workers. This skill supplies evidence and conditions, not action authorization.

## Project routing

Read root `AGENTS.md` for scope and root `WORKFLOW.md` for classification configuration. The explicit opt-in in `WORKFLOW.md` is:

```text
Classification: enabled; policy: docs/agents/change-risk.md
```

The path is repository-relative. `WORKFLOW.md` owns the single declaration; `AGENTS.md` routes to it.
A legacy declaration in `AGENTS.md` requires explicit migration before automatic completion; it is not a second opt-in source.
Duplicate or conflicting declarations require resolution before automatic completion.
Unconfigured projects retain their existing route. An explicit assessment may report advisory results without inventing project authority.
An enabled project with a missing policy, unavailable trusted revision, or unavailable worker has unresolved configuration uncertainty.
Continue independent preparation, but keep automatic merge pending until resolved or decided by the owner.

## Inputs and authority

1. Identify the task/spec and acceptance criteria, repository, target branch, comparison base, and actual head commit.
2. Read policy and delivery authority from the trusted target main-branch revision; record that revision and policy path.
3. Separate proposed policy updates from the rules governing this assignment. A candidate policy cannot authorize its own merge.
4. Collect changed paths, diff, relevant unchanged callers, review outcomes, check evidence, existing owner decisions, and unresolved questions.

Before implementation, use the available task/design for provisional assessment. Mark absent code and evidence as unavailable.
After initial implementation, assess actual-change risk before finalizing review and verification, so required checks shape those activities.
Assess participation on the prepared result. Before a planned protected boundary, invoke or reuse participation assessment for that action.
An unresolved participation condition blocks that boundary, while independent preparation may continue.
For a specification, apply these checkpoints to tickets and the final integrated result, including cross-ticket interactions.

## Independent workers

Use the runtime's native subagents under the project's worker rules. Each worker receives the same inputs and read-only repository access.
Read [risk assessment](references/risk-assessment.md) for the risk worker and [owner participation](references/owner-participation.md) for the participation worker.
For a full classification, assign both bounded jobs. Each must return its initial conclusion before receiving the other's result.
For a timing-specific invocation, run the needed role and retain a stored counterpart only when its inputs remain applicable.
Keep counterpart results hidden until the invoked role returns its initial conclusion; then reconcile applicable results.
If no applicable counterpart exists, record the partial assessment and obtain the missing role before declaring classification complete.
Record invoked roles, reused conclusions, and their evidence revisions. Reuse does not require an irrelevant duplicate full classification.
Sequential execution is acceptable when native capacity is limited; preserve that independence.

Once both initial results exist, compare their premises, mandatory conditions, and conclusions.
For a material contradiction, obtain targeted source evidence and let the affected worker reassess explicitly.
Unresolved contradictions remain uncertainty; a favorable result cannot override a mandatory condition.
Assign triggered specialist verification through the implementation/review route, then reassess affected conclusions.

## Result and completion

Record one compact classification in the existing issue/PR, with both worker conclusions distinguishable:

- Task/spec pointer; assessment stage; repository, base, target revision, and assessed head.
- Trusted policy path and revision; candidate policy changes and required owner decision.
- Risk level, semantic consequences, cited sources, and any justified decrease from an earlier assessment.
- Required checks and specialist reviews, their actual evidence revisions, missing evidence, and security trigger or reason for absence.
- Whether owner participation is required, at which action/stage, and the concrete decision or acceptance requested.
- Contradictions, uncertainties, current blockers, and next action.

Low risk still receives short independent review. Medium risk receives behavior-focused review.
High risk requires acceptance of the prepared result before final merge. Project mandatory exceptions remain binding.
Successful tests alone do not reduce inherent consequences. Classification applies approved authority; deployment retains its own project gates.
The assigning owner is the directing human, not a substitute for explicitly required acceptance of the finished result.

Before merge, verify current classification applicability, review dispositions, required owner acceptance, and required CI through existing commands.
For owner acceptance, identify the accepted commit/result. Reassess changes that affect what was accepted.
After commits, target/policy changes, or new evidence, invalidate only affected conclusions and explain retained evidence applicability.
If uncertainty persists, preserve the record and ask a concrete owner question before automatic merge.
