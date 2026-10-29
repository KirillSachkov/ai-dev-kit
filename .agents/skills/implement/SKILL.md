---
name: implement
description: "Implement assigned software/tooling work, including a request to build the agreed result after discussion. Capture the task, implement with tests, and complete independent review and project checks. Use for one task or a ticket within an assigned specification."
---

If the user passes a ticket reference, fetch it from the issue tracker and state its title before starting. If the reference is ambiguous, ask.

## Capture and route the assignment

1. Read the project's `AGENTS.md`, `WORKFLOW.md`, and tracker instructions. Recover the requested
   result from the conversation and any supplied task. An instruction to implement the agreed result
   assigns execution; questions and discussion remain discussion. Research, prototypes, editorial work,
   and independent handoffs retain their project workflows and requested deliverables.
2. Before changing implementation files, find an existing matching task and its branch/PR. Reuse it,
   including on continuation or corrective feedback. Otherwise create a task in the configured tracker.
   Record the observable result, agreed decisions, scope and exclusions, acceptance criteria,
   verification, and unresolved decisions. A small change may use the PR description instead when
   project rules permit it: prepare that description before edits and publish it with the first
   reviewable commit under project rules. If neither a configured tracker nor an authorized PR task
   surface is available, request the missing setup before implementation.
3. Synthesize the record from the agreed context. Report the task reference (or the prepared
   description's path until the PR exists) and proceed within existing
   authorization. Ask about material product choices or missing authority before dependent work;
   routine technical choices and restating agreed requirements need no renewed approval.
4. Use the single-task execution below when one coherent result can be implemented and reviewed as
   one task. When the assigned result requires a graph of separately verifiable tasks, prepare a concise
   parent specification, child tasks, and blocking edges in the configured tracker, then invoke
   `implement-spec`. Preserve an approved graph. Routine decomposition within the agreed scope may
   proceed; ask before changing agreed deliverables, sequencing constraints, or owner decisions.
   A file count or a long checklist alone does not require a graph. Manual `to-spec` and `to-tickets`
   remain separately assigned workflows.

## Execute one task

Record the immutable base before changes. Implement the captured assignment in the project's assigned
writing context. A ticket worker already given a specification and task starts here after confirming
that its task record is complete; it keeps the coordinator's assigned scope and integration target.

For a project with classification enabled in root `WORKFLOW.md`, invoke `classify-change` provisionally before implementation.
A missing configured policy leaves automatic completion pending; unconfigured projects keep their existing route.

Invoke `tdd` for changed behavior at agreed public test boundaries. A criterion with no executable
behavior needs no artificial test. Load applicable domain/surface skills required by the project.

Run focused checks during implementation and the project's required final checks on the prepared
result. Choose applicable checks from the changed behavior and project contracts. Reuse evidence
only while its checked inputs remain valid; rerun affected checks after fixes or failures.

Commit the implementation to the current branch before actual-change classification and diff-based review.

After initial implementation, invoke `classify-change` for actual-change risk before finalizing review and verification in enabled projects.
Complete its assigned checks and invoke `code-review` with the immutable base, committed head,
task reference, acceptance criteria, and applicable project standards. Resolve validated blocking
findings and obtain affected re-review; preserve separate Standards and Spec results.
Before any planned protected boundary, invoke or reuse applicable participation assessment and satisfy its conditions.

Maintain relevant project risk facts in the same change. Follow `classify-change` for authority changes and trusted prior policy.

Commit each set of review fixes before affected re-review and reassess conclusions invalidated by those fixes.

For an enabled project, assess participation on the actual prepared result and verify risk/evidence applicability through `classify-change`.
If fixes change relevant inputs, reassess affected conclusions. Record evidence and next actions in the existing issue/PR.
Complete only the assigned delivery stage under project workflow; classification does not grant merge or deployment authorization.
