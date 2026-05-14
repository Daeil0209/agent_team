---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/agents/team-lead.md
SOURCE-RULES: "RPA-2 Owner Trigger Order; Reference Binding; Procedure And Ownership"
---
# team-lead: Owner Trigger Order

## Purpose
Use this reference to decide which owner opens first when several triggers are active.
The goal is one executable next owner/action.
Treat procedural narration as nonterminal evidence.

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

## Stop
Stop before lower-trigger work until a higher trigger emits its named artifact.
Stop before owner execution credit until loaded owner text has applied-rule mapping.
Stop before reporting when the required artifact is stale or only described narratively.
Stop before dispatch when `work-planning` or primary sequence owner is required but missing.

## Resolve Next Owner And Action
- A stopped lower-trigger route opens the higher trigger owner.
- A stopped owner-execution-credit route opens loaded-document consumption.
- A stopped reporting route opens artifact refresh.
- A stopped dispatch route opens `work-planning` or primary sequence owner.

## Trigger Order
Consume the highest active trigger first:
1. explicit closeout
2. boot, runtime-entry, monitoring, or recovery
3. missing or changed `work-planning` boundary
4. confirmed primary sequence
5. frozen workflow or sequence owner
6. assignment-grade `task-execution`
7. required `self-verification` report or redispatch gate

## Named Artifacts
- `session-boot` emits runtime-ready or runtime-blocked declaration.
- `work-planning` emits frozen-fields record.
- `review-verification` emits `review_verification_packet`.
- `self-verification` emits `SV-RESULT` or `SV-PLAN`.
- `task-execution` emits dispatch-ready packet, dispatch-pending truth, or correction route.
- `self-growth-sequence` emits recurrence-barrier patch basis and post-verify result.
- `update-upgrade-sequence` emits update/upgrade patch basis and post-verify result.
- `session-closeout` emits closeout residual truth or teardown completion.

## Artifact Discipline
Skill load is availability only.
Loaded owner text becomes execution evidence only through applied-rule mapping.
Applied-rule mapping names action, stop, evidence, owner, or next-action effect.
Treat tool output as artifact only when the owner defines it as artifact.
Narrative claims of completed owner work are procedural failure.
Rerun the owner when:
- only narrative claim exists
- target, corpus, route, patch design, or diff changed

## Same-Boundary Continuation
Same-boundary iterations consume the frozen boundary.
Keep ordinary same-boundary correction inside the frozen boundary.
Reopen planning when owner, phase, deliverable shape, proof chain, acceptance chain, staffing shape, or user requirement changes.

## Status And Interruption
Status questions expose stalled execution.
Answer only the narrow status if the boundary is already complete.
If an open lead-owned path exists, continue through the next owner/action in the same turn.
Interrupt work uses `.claude/skills/team-lead/references/interrupt-autonomy.md`.
