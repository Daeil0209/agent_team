---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-1 Instruction Interpretation; RPA-2 Consequential Boundary; RPA-3 Runtime Readiness Blocker; RPA-6 Session And Route Bridge; Work Execution Philosophy"
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# team-lead: Session And Route Bridge

## Purpose
Use this reference to bridge interpretation, session readiness, planning consumption, and dispatch route.
It keeps team-lead from treating setup, boot, planning, or dispatch as completion.

Reporting curtain inheritance:
- This reference produces Procedure Plane records only.
- Its required output is not user-facing prose, status, progress, summary, or result.
- Route, boot, planning, dispatch, and readiness facts stay internal unless `.claude/reference/reporting-prohibition-law.md` grants a narrow report exception.
- If route evidence is current and no report exception is granted, continue through the next owner/action silently.

## Consume When
- A fresh instruction arrives.
- Boot, monitoring, recovery, or teardown can be active.
- A route can be lead-local, team-routed, workflow-owned, or sequence-owned.
- `Agent` tool use is being considered as evidence gathering, member creation, reuse, or dispatch.
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

## Routing Gate
Dispatch requires completed boot/runtime-entry when that entry is required.
Local execution requires current `work-planning` boundary.
Team dispatch requires task-execution packet preflight.
Correction dispatch after Final Acceptance Review (FAR) `FINAL-REJECT` requires assigned-validator correction packet consumption.
Session-teardown tool calls require an active `Skill(session-closeout)` boundary.
Structured lane-member release during team-routed work stays outside session teardown.
Route execution requires:
- loaded owner documents carrying applied-rule mapping
- selected route carrying a request basis that supports its channel class, owner, next action, and user-fit effect
- selected route treating standalone `Agent` as fallback evidence only

## Resolve Next Owner And Action
- Dispatch gaps load `Skill(session-boot)` for boot or runtime-entry.
- Local-execution gaps load `Skill(work-planning)`.
- Team-dispatch gaps load `Skill(task-execution)` packet preflight.
- Correction-dispatch gaps open assigned-validator correction-packet consumption.
- Session-teardown gaps load `Skill(session-closeout)` Runtime Teardown Preflight.
- Applied-rule gaps open loaded-document consumption.

## Fresh Instruction Interpretation
Name the request basis before route choice using the intake items owned by `.claude/skills/work-planning/SKILL.md` `## Step 0: Request-Fit Intake`. This pre-freeze interpretation surface consumes the same intake items that `work-planning` later freezes.

Interpret the user's requested meaning before skill, workflow, sequence, tool-route, mutation, verification, dispatch, or report selection.
Skill-load eligibility per `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`.
Learning, relearning, familiarization, doctrine refresh, and change-understanding requests stay read-only doctrine refresh unless the same instruction asks for execution, planning, mutation, verification, dispatch, or reporting.
Status, yes/no, verification, explanation, or audit questions stay light-channel unless the same instruction asks for correction, mutation, dispatch, validation, cleanup, or execution.
Discovered gaps during a light-channel answer remain answer evidence and require a separate mutation-authorized owner path before governance asset change.

Use the request basis first to decide whether the instruction stays in a light channel or creates, reopens, or changes a consequential work boundary.
Consequential boundary opens `Skill(work-planning)`.
Light channel stays outside `work-planning`.

Name the visible work shape:
- work type
- workflow or sequence candidate
- single stream, independent streams, sequential streams, or interdependent streams

Interpretation is pre-freeze.

## Session Bridge
Session-start load triggers are owned by `.claude/CLAUDE.md` `## 3. Work Execution Philosophy`, `.claude/CLAUDE.md` `## 8. Environment Configuration Philosophy`, and team-lead RPA-1.
Consequential-boundary load triggers are owned by `.claude/CLAUDE.md` `## 3. Work Execution Philosophy` and team-lead RPA-2.
Runtime-readiness blockers are owned by `.claude/CLAUDE.md` `## 8. Environment Configuration Philosophy` and team-lead RPA-3.
Assignment-grade team work then follows `Skill(work-planning)` -> one-time same-session `Skill(task-execution)` activation or loaded `task-execution` consumption.
If runtime/recovery/monitoring/cleanup evidence is absent, record `runtime-ready: clean` internally without runtime-detail consumption or visible prose.
A runtime-blocked session bridge opens recovery or `HOLD`.
Route assignment-grade dispatch to `Skill(task-execution)` only when no current same-session loaded `task-execution` basis exists.
Route assignment-grade dispatch to loaded `task-execution` consumption when current same-session `task-execution` basis exists.
Route evidence-only standalone `Agent` consideration as lead-local evidence gathering, not team dispatch.
Route any configured lane work, receipt requirement, reuse, monitoring, or completion handoff through team-routed `Skill(task-execution)`.
Route explicit session teardown or session-end intent to `Skill(session-closeout)`.
Route user-directed lane-member cleanup through `task-execution` unless explicit session-end intent creates a `Skill(session-closeout)` trigger.
Route lane-member release during team-routed work through `task-execution` when reuse-fit fails, the target is dead-or-unavailable, the lane or member is no longer needed, or the user explicitly directs named lane/member cleanup.
Task completion keeps the session route active unless explicit session-end intent is present.
Session-teardown tool calls require an active `Skill(session-closeout)` boundary; violations route to `Skill(governance-modification)` as `[PROC-HABIT]`.
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
`team-routing candidate` and `ambiguous-route` enter `Skill(task-execution)` only when no current same-session loaded `task-execution` basis exists.
`team-routing candidate` and `ambiguous-route` enter loaded `task-execution` consumption when current same-session `task-execution` basis exists.
Task-execution translates the frozen route into assignment-grade packets.
Apply `.claude/skills/agent-team-lead/references/planning-field-consume.md` Lead-Only Context Guard before dispatch.
Team runtime details use `.claude/skills/task-execution/references/runtime-dispatch-law.md`.
Same-lane follow-on work, wave transition, replacement, and redispatch consume `runtime-dispatch-law.md` reuse-fit before shutdown or new member creation.

## Final Acceptance Review (FAR) FINAL-REJECT Bridge
Final Acceptance Review (FAR) `FINAL-REJECT` opens `far-reject-routing` classification first.
Enter one-time same-session `Skill(task-execution)` activation or loaded `task-execution` consumption only for bounded correction dispatch after team-lead route classification.
Validator correction packet is correction basis.
Team-lead classification chooses design, implementation/operator-delivery, or replanning route.
Detailed routing lives in `.claude/skills/agent-team-lead/references/far-reject-routing.md`.
