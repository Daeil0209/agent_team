---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "owner-trigger-priority; skill-activation; artifact-discipline; reporting-prohibition; environment-readiness"
---
# team-lead: Owner Trigger Order

## Purpose
Consume this reference when several owner triggers are active.
Select one executable next owner/action.
Treat procedural narration as nonterminal evidence.
Use `.claude/skills/agent-team-lead/references/pre-action-gate.md` only when the selected next procedure action can drift in owner, route, mutation boundary, dispatch boundary, proof/review/validation boundary, or claim strength.
Keep trigger order, named artifacts, consumption status, and next-owner/action internal unless `.claude/reference/reporting-prohibition-law.md` grants a narrow exception.
When no narrow report exception exists, continue through the selected next owner/action internally.

## Consume When
- A named owner skill or sequence trigger is active.
- The route can enter planning, workflow, sequence, task-execution, dispatch, mutation, self-verification, or reporting.
- A previous owner outcome is stale, missing, or only narrated.
- The user challenges whether work is actually progressing.

## Required Output
Record the highest active trigger and its named artifact:
- `TRIGGER`
- `OWNER`
- `REQUIRED-REFERENCE`
- `APPLIED-RULE-MAPPING`
- `NAMED-ARTIFACT`
- `CONSUMPTION-STATUS`
- `NEXT-OWNER-ACTION`

## Routing Gate
Lower-trigger work requires higher-trigger named artifact emission.
Owner execution credit requires loaded owner text with applied-rule mapping.
Reporting artifact gaps refresh the required artifact only; report admission stays with `.claude/reference/reporting-prohibition-law.md`.
Task work requires resolved session-start readiness.
Skill activation follows `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`.
Dispatch-trigger work opens `Skill(work-planning)`, the primary sequence owner, or `Skill(task-execution)` as named by the active trigger.
Same-session `task-execution` reuse stays valid only while the dispatch boundary and trigger-specific reference consumption stay current.
Positive result, completion, report, or redispatch gates open `Skill(self-verification)` on the produced surface and intended claim.
Governance-modification activation requires a current owner/action basis; inspection, audit, proposal-only, review, reporting, and expected later patch need do not outrank planning, review-verification, self-verification, or the active procedure owner.

## Resolve Next Owner And Action
- A lower-trigger gap opens the higher trigger owner.
- An owner-execution-credit gap opens loaded-document consumption.
- A reporting gap opens artifact refresh.
- A dispatch gap loads `Skill(work-planning)` or the primary sequence skill owner.

## Trigger Order
Consume the highest active trigger first:
1. `Skill(session-closeout)` for explicit closeout
2. `Skill(session-boot)` for session start, boot, runtime-entry, monitoring, recovery, or unresolved session-start readiness
3. `Skill(work-planning)` when a current instruction creates, reopens, or changes a consequential work boundary
4. confirmed primary sequence skill owner
5. frozen workflow or sequence skill owner
6. `Skill(task-execution)` for assignment-grade dispatch
7. `Skill(self-verification)` for required report or redispatch gate
8. `Skill(governance-modification)` when the current owner path names `.claude` governance asset change or confirmed recurrence-barrier hardening as the next owner/action after required `Skill(self-verification)` convergence

After the current session-start artifact is current, trigger 3 reopens trigger 2 only when trigger 2 is independently active.

## Named Artifacts
- `Skill(session-boot)` emits `runtime-ready: clean`, runtime-ready, or runtime-blocked declaration.
- `Skill(work-planning)` emits frozen-fields record.
- `Skill(review-verification)` returns internal `review_verification_packet`.
- `Skill(self-verification)` emits an internal convergence-state record.
- `Skill(task-execution)` emits dispatch-ready packet, dispatch-pending truth, or correction route.
- `Skill(governance-modification)` emits asset-change or recurrence-hardening patch basis and post-verify result.
- `Skill(session-closeout)` emits closeout residual truth or teardown completion.

## Artifact Discipline
Skill load is availability only.
Loaded owner text becomes execution evidence only through applied-rule mapping.
Applied-rule mapping names action, stop, evidence, owner, or next-action effect.
Tool result is artifact only when the owner defines it as artifact.
Narrative claims of completed owner work are procedural failure.
Owner rerun triggers:
- only narrative claim exists
- target, corpus, route, patch design, or diff changed

## Same-Boundary Continuation
PROTECTED-LOCAL-RESTATEMENT-BASIS: pre-planning atomic-check — Same-Boundary Continuation rules colocated for atomic team-lead consultation before invoking `Skill(work-planning)`. `.claude/skills/work-planning/references/boundary-gates.md` defines boundary-change axes; this surface applies them at the pre-planning decision moment when `work-planning` may not yet be loaded.
Same-boundary iterations consume the frozen boundary.
Keep ordinary same-boundary correction inside the frozen boundary.
Reopen planning when owner, phase, deliverable shape, proof chain, acceptance chain, staffing shape, or user requirement changes.

## Status And Interruption
Routine in-flight status uses `.claude/skills/agent-team-lead/references/routine-gate-continuation.md`.
Interrupted or interrupt-blocked path status/challenge uses `.claude/skills/agent-team-lead/references/interrupt-autonomy.md`.
If the boundary is already complete, route any answer through `.claude/reference/reporting-prohibition-law.md` `## Pre-Report Gate` first; use `## Report Shape` only after admission, otherwise suppress prose and continue the owning path or truthful `HOLD`.
If an open lead-owned path exists, continue through the next owner/action in the same turn.
