---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
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
- Final Acceptance Review (FAR) `FINAL-REJECT` requires correction routing.

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
Stop before correction dispatch after Final Acceptance Review (FAR) `FINAL-REJECT` until the assigned-validator correction packet is consumed.
Stop before route execution when:
- loaded owner documents lack applied-rule mapping
- governance, analysis, critique, review, validation, or patch work lacks `SEMANTIC-INTENT-BASIS` or contradicts the user correction, team-operation philosophy, or target governance/design intent

## Resolve Next Owner And Action
- A stopped dispatch route loads `Skill(session-boot)` for boot or runtime-entry.
- A stopped local-execution route loads `Skill(work-planning)`.
- A stopped team-dispatch route loads `Skill(task-execution)` packet preflight.
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

## Session Bridge
Session start loads `Skill(session-boot)`.
A current instruction that creates, reopens, or changes a consequential work boundary loads `Skill(work-planning)`.
Assignment-grade team work then follows `Skill(work-planning)` -> `Skill(task-execution)`.
If runtime/recovery/monitoring/cleanup evidence is absent, record `runtime-ready: clean` internally without runtime-detail consumption or visible prose.
A runtime-blocked session bridge opens recovery or `HOLD`.
Route assignment-grade dispatch to `Skill(task-execution)`.
Route explicit teardown to `Skill(session-closeout)`.
Once `session-closeout` owns the path, report only closeout residual truth.

## Planning Consume Bridge
Consume frozen planning fields through `.claude/skills/agent-team-lead/references/planning-field-consume.md`.
Open or change phase/work-surface boundaries through `work-planning`.
Consume `NEXT-CONSEQUENTIAL-ACTION` before local execution, dispatch, phase movement, or reporting.
Classify repeated same-class blocking gaps as root-cause route evidence.

## Lead-Local Bridge
Lead-local candidate work consumes `.claude/skills/agent-team-lead/references/lead-local-guarded-law.md`.
Lead-local route execution follows that reference's direct work conditions, break conditions, and next-owner routing.

## Team-Routed Bridge
`team-routing candidate` and `ambiguous-route` enter `task-execution`.
Task-execution translates the frozen route into assignment-grade packets.
Send teammate-required lead facts through packet fields, task state, workflow state, or cited artifacts.
Team runtime details use `.claude/skills/task-execution/references/runtime-dispatch-law.md`.

## Final Acceptance Review (FAR) FINAL-REJECT Bridge
Final Acceptance Review (FAR) `FINAL-REJECT` opens `far-reject-routing` classification first; enter `task-execution` only for bounded correction dispatch after team-lead route classification.
Validator correction packet is correction basis.
Team-lead classification chooses design, implementation/operator-delivery, or replanning route.
Detailed routing lives in `.claude/skills/agent-team-lead/references/far-reject-routing.md`.
