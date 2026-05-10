---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/agents/team-lead.md
SOURCE-RULES: "RPA-1 Instruction Interpretation; RPA-3 Session And Route Bridge; Reference Binding; Procedure And Ownership"
---
# team-lead: Session And Route Bridge

## Purpose
Use this reference to bridge interpretation, session readiness, planning consumption, and dispatch route.
It keeps team-lead from treating setup, boot, planning, or dispatch as completion.

## Consume When
- A fresh instruction arrives.
- Boot, monitoring, recovery, or teardown may be active.
- A route could be lead-local, team-routed, workflow-owned, or sequence-owned.
- A frozen `NEXT-CONSEQUENTIAL-ACTION` must be consumed.
- FAR `FINAL-REJECT` requires correction routing.

## Required Output
Record:
- `REQUEST-INTENT`
- `WORK-SHAPE`
- `WORKFLOW-CANDIDATE`
- `SEQUENCE-CANDIDATE`
- `RUNTIME-READINESS`
- `ROUTE-OWNER`
- `NEXT-CONSEQUENTIAL-ACTION`
- `REFERENCE-CONSUMED`
- `APPLIED-RULE-MAPPING`

## Stop
Stop before dispatch until required boot/runtime-entry is complete.
Stop before local execution when `work-planning` boundary is missing, stale, contradictory, or changed.
Stop before team dispatch when task-execution packet preflight is missing.
Stop before correction dispatch after FAR `FINAL-REJECT` until the assigned-validator correction packet is consumed.
Stop before route execution when loaded owner documents lack applied-rule mapping.

## Next-Action Drive
- A stopped dispatch route opens boot or runtime-entry.
- A stopped local-execution route opens `work-planning`.
- A stopped team-dispatch route opens task-execution packet preflight.
- A stopped correction-dispatch route opens assigned-validator correction-packet consumption.
- A stopped applied-rule route opens loaded-document consumption.

## Fresh Instruction Interpretation
Name the thin request basis:
- intent
- concrete deliverable
- primary user
- reference use
- burden cues
- quality cues
- material blockers

Name the visible work shape:
- work type
- workflow or sequence candidate
- single stream, independent streams, sequential streams, or interdependent streams

Interpretation is pre-freeze.
Open `work-planning` when a consequential boundary exists.

## Session Bridge
Open `session-boot` when boot is incomplete, runtime entry is needed, monitoring is active, or recovery is active.
Run boot to runtime-ready or runtime-blocked outcome before `work-planning`, `task-execution`, `Agent`, or assignment-grade `SendMessage`.
Route assignment-grade dispatch to `task-execution`.
Route explicit teardown to `session-closeout`.
Once `session-closeout` owns the path, report only closeout residual truth.

## Planning Consume Bridge
Consume frozen planning fields through `.claude/skills/team-lead/references/planning-field-consume.md`.
Open or change phase/work-surface boundaries through `work-planning`.
Consume `NEXT-CONSEQUENTIAL-ACTION` before local execution, dispatch, phase movement, or reporting.
Repeated same-class blocking gaps are root-cause route evidence.
Classify repeated same-class blocking gaps as root-cause route evidence.

## Lead-Local Bridge
Lead-local work requires complete `LEAD-LOCAL-WORK-ITEMS`.
Lead-local work requires frozen `LEAD-LOCAL-REQUIRED-SKILLS`.
Lead-local work requires a first action and stop point.
Lead-local work stops when a lane-owned proof, validation, review, implementation, or acceptance surface appears.

## Team-Routed Bridge
`team-routing candidate` and `ambiguous-route` enter `task-execution`.
Task-execution translates the frozen route into assignment-grade packets.
Send teammate-required lead facts through packet fields, task state, workflow state, or cited artifacts.
Team runtime details use `.claude/skills/task-execution/references/runtime-dispatch-law.md`.

## FAR FINAL-REJECT Bridge
FAR `FINAL-REJECT` opens `task-execution` for assigned-validator rejection analysis before correction dispatch.
Validator correction packet is correction basis.
Team-lead classification chooses design, implementation/operator-delivery, or replanning route.
Detailed routing lives in `.claude/skills/team-lead/references/far-reject-routing.md`.
