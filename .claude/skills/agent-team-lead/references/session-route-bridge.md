---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-1 Instruction Interpretation; RPA-3 Session And Route Bridge; Work Execution Philosophy"
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---
# team-lead: Session And Route Bridge

## Purpose
Use this reference to bridge interpretation, session readiness, planning consumption, and dispatch route.
It keeps team-lead from treating setup, boot, planning, or dispatch as completion.

Reporting curtain inheritance:
- This reference produces Procedure Plane records only.
- Its required output is not user-facing prose, status, progress, summary, or result.
- Route, boot, planning, dispatch, and readiness facts stay internal unless `.claude/reference/reporting-user-reporting-law.md` admits a report.
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
- `COMPLETION-STOP-CONDITION`
- `TEAM-LEAD-WORK-PLAN`
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
Stop before session-teardown tool calls outside an active `Skill(session-closeout)` boundary.
Structured lane-member release during team-routed work is not session teardown.
Stop before route execution when:
- loaded owner documents lack applied-rule mapping
- the selected route lacks a request basis that supports its channel class, owner, next action, and user-fit effect

## Resolve Next Owner And Action
- A stopped dispatch route loads `Skill(session-boot)` for boot or runtime-entry.
- A stopped local-execution route loads `Skill(work-planning)`.
- A stopped team-dispatch route loads `Skill(task-execution)` packet preflight.
- A stopped correction-dispatch route opens assigned-validator correction-packet consumption.
- A stopped session-teardown route loads `Skill(session-closeout)` Runtime Teardown Preflight.
- A stopped applied-rule route opens loaded-document consumption.

## Fresh Instruction Interpretation
Name the request basis before route choice using the intake items owned by `.claude/skills/work-planning/SKILL.md` `## Step 0: Request-Fit Intake`. This pre-freeze interpretation surface consumes the same intake items that `work-planning` later freezes.

Interpret the user's requested meaning before skill, workflow, sequence, tool-route, mutation, verification, dispatch, or report selection.
Skill-load eligibility per `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`.
Learning, relearning, familiarization, doctrine refresh, and change-understanding requests stay read-only doctrine refresh unless the same instruction asks for execution, planning, mutation, verification, dispatch, or reporting.

Use the request basis first to decide whether the instruction stays in a light channel or creates, reopens, or changes a consequential work boundary.
Consequential boundary opens `Skill(work-planning)`.
Light channel stays outside `work-planning`.

Name the visible work shape:
- work type
- workflow or sequence candidate
- single stream, independent streams, sequential streams, or interdependent streams

Interpretation is pre-freeze.

## Session Bridge
Session-start and consequential-boundary load triggers are owned by `.claude/CLAUDE.md` `## 3. Work Execution Philosophy`, `.claude/CLAUDE.md` `## 8. Environment Configuration Philosophy`, and team-lead RPA-1.
Assignment-grade team work then follows `Skill(work-planning)` -> `Skill(task-execution)` activation or valid loaded `task-execution` consumption.
If runtime/recovery/monitoring/cleanup evidence is absent, record `runtime-ready: clean` internally without runtime-detail consumption or visible prose.
A runtime-blocked session bridge opens recovery or `HOLD`.
Route assignment-grade dispatch to `Skill(task-execution)` when no current same-session loaded `task-execution` basis exists for the same dispatch owner boundary.
Route assignment-grade dispatch to loaded `task-execution` consumption when current same-session activation basis is valid for the same dispatch owner boundary.
Route explicit session teardown to `Skill(session-closeout)`.
Route lane-member release during team-routed work through `task-execution` only after reuse-fit failure, dead-or-unavailable target, or lane no-longer-needed basis.
Task completion is not session end.
Calling session-teardown tools outside an active `Skill(session-closeout)` boundary is a `[PROC-HABIT]` defect routed to `Skill(governance-modification)`.
Once `session-closeout` owns the path, report only closeout residual truth.

## Planning Consume Bridge
Consume frozen planning fields through `.claude/skills/agent-team-lead/references/planning-field-consume.md`.
Open or change phase/work-surface boundaries through `work-planning`.
Consume `TEAM-LEAD-WORK-PLAN` before `NEXT-CONSEQUENTIAL-ACTION`.
Consume `NEXT-CONSEQUENTIAL-ACTION` before local execution, dispatch, phase movement, or reporting.
Classify repeated same-class blocking gaps as root-cause route evidence.

## Lead-Local Bridge
Lead-local candidate work consumes `.claude/skills/agent-team-lead/references/lead-local-guarded-law.md`.
Lead-local route execution follows that reference's direct work conditions, break conditions, and next-owner routing.

## Team-Routed Bridge
`team-routing candidate` and `ambiguous-route` enter `Skill(task-execution)` when activation basis is absent, stale, or wrong-boundary.
`team-routing candidate` and `ambiguous-route` enter loaded `task-execution` consumption only when current same-session activation basis is valid for the same dispatch owner boundary.
Task-execution translates the frozen route into assignment-grade packets.
Apply `.claude/skills/agent-team-lead/references/planning-field-consume.md` Lead-Only Context Guard before dispatch.
Team runtime details use `.claude/skills/task-execution/references/runtime-dispatch-law.md`.
Same-lane follow-on work, wave transition, replacement, and redispatch consume `runtime-dispatch-law.md` reuse-fit before shutdown or new member creation.

## Final Acceptance Review (FAR) FINAL-REJECT Bridge
Final Acceptance Review (FAR) `FINAL-REJECT` opens `far-reject-routing` classification first.
Enter `Skill(task-execution)` activation or valid loaded `task-execution` consumption only for bounded correction dispatch after team-lead route classification.
Validator correction packet is correction basis.
Team-lead classification chooses design, implementation/operator-delivery, or replanning route.
Detailed routing lives in `.claude/skills/agent-team-lead/references/far-reject-routing.md`.
