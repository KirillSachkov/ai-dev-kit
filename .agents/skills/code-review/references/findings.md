# Finding lifecycle

## Evidence and scope

Give each finding a stable assignment-local ID, axis, affected location, and introduced consequence.
Describe the triggering scenario and causal evidence; cite the source, requirement, or mandatory rule.
Use a test or reproduction when the conclusion otherwise remains disputed.
Security findings can use code evidence without production exploitation.
Separate confirmed errors, unmet requirements, and mandatory-rule violations from optional suggestions.
Fowler smells remain heuristics unless an applicable project rule establishes a violation.

The executing agent validates each finding before changing code.
Assign one disposition: fixed with evidence, rejected with evidence, or deferred to a linked issue with explicit delivery status.
A linked issue alone does not clear a blocking condition; follow project delivery rules.
Preserve nonblocking suggestions for consideration rather than automatically implementing them.
Record unchanged existing defects separately. Use the project blocker procedure if they prevent completion.

## Fixes and convergence

Review fixes, regressions introduced by fixes, and affected relationships against their committed inputs.
Retain prior IDs and dispositions; reopen a resolved finding only with new evidence.
Report the error class when multiple instances need correction.
After three unsuccessful review/fix cycles, assign fresh diagnosis of the approach and conflicting findings.
Record its proposed next step. Request the owner for a new decision or a persistent impasse.
The cycle threshold never clears unresolved blockers.

## Evidence applicability

Record the base, reviewed head, policy identity, worker result, and affected scope.
After new commits, determine which prior findings and checks remain applicable.
Recheck changed contracts and dependent conclusions while retaining unaffected evidence at its actual checked revision.
Policy changes invalidate the conclusions that rely on changed rules.
An accepted result needs renewed owner acceptance when later changes invalidate that acceptance.
