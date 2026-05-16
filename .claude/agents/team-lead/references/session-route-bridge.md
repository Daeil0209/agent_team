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

Reporting curtain inheritance:
- This reference produces Procedure Plane records only.
- Its required output is not user-facing prose, status, progress, summary, or result.
- Route, boot, planning, dispatch, and readiness facts stay internal unless `.claude/reference/user-reporting-law.md` admits a report.
- If route evidence is current and no report is admitted, continue through the next owner/action silently.

## Consume When
- A fresh instruction arrives.
- Boot, monitoring, recovery, or teardown can be active.
- A route can be lead-local, team-routed, workflow-owned, or sequence-owned.
- A frozen `NEXT-CONSEQUENTIAL-ACTION` must be consumed.
- FAR `FINAL-REJECT` requires correction routing.

## Required Output
Record:
- `REQUEST-INTENT`
- `SEMANTIC-INTENT-BASIS`
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
Stop before route execution when:
- loaded owner documents lack applied-rule mapping
- governance, analysis, critique, review, validation, or patch work lacks `SEMANTIC-INTENT-BASIS` or contradicts the user correction, team-operation philosophy, or target governance/design intent

## Resolve Next Owner And Action
- A stopped dispatch route opens boot or runtime-entry.
- A stopped local-execution route opens `work-planning`.
- A stopped team-dispatch route opens task-execution packet preflight.
- A stopped correction-dispatch route opens assigned-validator correction-packet consumption.
- A stopped applied-rule route opens loaded-document consumption.

## Fresh Instruction Interpretation
Name the thin request basis:
- intent
- user concern signal and anti-goal
- concrete deliverable
- primary user
- reference use
- burden cues
- quality cues
- material blockers
- governing team-operation philosophy or target governance/design intent
- priority order when the user states one — examples include quality, evidence, autonomy, silence, speed, removal-first, acceptance integrity, or other operator-named priority axes

Name the visible work shape:
- work type
- workflow or sequence candidate
- single stream, independent streams, sequential streams, or interdependent streams

Interpretation is pre-freeze.
After the Session Bridge minimal gate is satisfied, open `work-planning` when a consequential boundary exists.

## Session Bridge
Fresh consequential instructions follow this canonical order after the Startup Contract and User Surface Gate:
`session-boot` minimal gate -> `work-planning` -> `task-execution`.
Open `session-boot` before `work-planning` for the minimal gate. If runtime/recovery/monitoring/lifecycle evidence is absent, the gate records `runtime-ready: clean` internally and opens `work-planning` without runtime-detail consumption or visible prose.
When boot is incomplete, runtime entry is needed, monitoring is active, or recovery is active, keep `session-boot` open until runtime-ready before `work-planning`, `task-execution`, `Agent`, or assignment-grade `SendMessage`.
A runtime-blocked session bridge opens recovery or `HOLD`, not `work-planning`.
Route assignment-grade dispatch to `task-execution`.
Route explicit teardown to `session-closeout`.
Once `session-closeout` owns the path, report only closeout residual truth.

## Planning Consume Bridge
Consume frozen planning fields through `.claude/agents/team-lead/references/planning-field-consume.md`.
Open or change phase/work-surface boundaries through `work-planning`.
Consume `NEXT-CONSEQUENTIAL-ACTION` before local execution, dispatch, phase movement, or reporting.
Classify repeated same-class blocking gaps as root-cause route evidence.

## Lead-Local Bridge
Lead-local work requires:
- complete `LEAD-LOCAL-WORK-ITEMS`
- frozen `LEAD-LOCAL-REQUIRED-SKILLS`
- a first action and stop point
Lead-local work stops when a lane-owned proof, validation, review, implementation, or acceptance surface appears.

## Team-Routed Bridge
`team-routing candidate` and `ambiguous-route` enter `task-execution`.
Task-execution translates the frozen route into assignment-grade packets.
Send teammate-required lead facts through packet fields, task state, workflow state, or cited artifacts.
Team runtime details use `.claude/skills/task-execution/references/runtime-dispatch-law.md`.

## FAR FINAL-REJECT Bridge
FAR `FINAL-REJECT` opens `far-reject-routing` classification first; enter `task-execution` only for bounded correction dispatch after team-lead route classification.
Validator correction packet is correction basis.
Team-lead classification chooses design, implementation/operator-delivery, or replanning route.
Detailed routing lives in `.claude/agents/team-lead/references/far-reject-routing.md`.
