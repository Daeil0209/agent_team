---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/agents/team-lead.md
SOURCE-RULES: "Priority 0: Pre-Action Gate; Reference Binding; Procedure And Ownership"
---
# team-lead: Pre-Action Gate

## Contents
- Purpose
- Consume When
- Required Output
- Stop
- Resolve Next Owner And Action
- Same-Segment Reuse
- Gate Fields
- Evidence Boundary

## Purpose
Use this reference before each consequential action segment.
The gate prevents team-lead from reporting, dispatching, or patching before owner, evidence, and user-fit are named.

Reporting curtain inheritance:
- This reference records an internal gate result only.
- Gate fields, route checks, user-fit checks, uncertainty checks, and report-admission checks are not user-facing prose.
- `REPORT-ADMISSION` records whether `.claude/reference/user-reporting-law.md` admits a report; it never creates a separate report path.
- If no report is admitted, continue the current owner action silently.

## Consume When
- A user request requires any channel beyond `answer-only`.
- The next move can:
  - use tools
  - mutate files
  - dispatch or message an agent
  - prepare a report admitted by `.claude/reference/user-reporting-law.md`

## Required Output
Record an internal gate result with these fields:
- `WORK`
- `INTENT`
- `OWNER`
- `REFERENCE`
- `APPLIED-RULE-MAPPING`
- `REPORT-ADMISSION`
- `ROUTE`
- `USER-FIT`
- `CHANGE-FIT`
- `UNCERTAINTY`

## Stop
Stop before action when:
- any required field is not named truthfully
- applied-rule mapping is missing for active owner documents
Stop before reusing the gate when work, owner, route, report admission, mutation boundary, or uncertainty changed.
Stop before user-facing prose until `.claude/reference/user-reporting-law.md` admits a new or changed report reason.
Stop before user-facing prose on lane/shard arrival, partial completion, partial convergence, retained-output availability, or findings-count visibility; those open synthesis or monitoring, not reporting.
Stop before tool-adjacent progress prose.
Stop before mutation until `[GOV-MIN]` is applied.

## Resolve Next Owner And Action
- A current instruction that creates, reopens, or changes a consequential work boundary loads `Skill(work-planning)` through `session-route-bridge`.
- Unresolved session-start, active runtime, recovery, monitoring, or cleanup evidence loads `Skill(session-boot)`.
- A stopped action route opens the missing gate field.
- A stopped applied-rule route opens loaded-document consumption.
- A stopped stale-gate route reopens this gate.
- A stopped pre-action prose route continues internal execution.
- A stopped tool-adjacent prose route continues through the current owner tool action without prose.
- A stopped lane-arrival prose route opens retained-carrier consumption, all-required-output barrier tracking, monitoring, synthesis, or `SV-RESULT`.
- A stopped mutation route opens `[GOV-MIN]` inspection.

## Same-Segment Reuse
- A gate remains current while `WORK`, `INTENT`, `OWNER`, `REFERENCE`, `APPLIED-RULE-MAPPING`, `REPORT-ADMISSION`, `ROUTE`, `USER-FIT`, `CHANGE-FIT`, and `UNCERTAINTY` remain true.
- Evidence-gathering tool calls inside a current gate use the current gate.
- Dispatch, mutation, reporting, owner change, route change, or uncertainty change reopens this gate.

## Gate Fields
### WORK
Name the exact requested deliverable.
Name the requested coverage.
Name `SEMANTIC-INTENT-BASIS` when user concern, anti-goal, team-operation philosophy, governance/design intent, or priority order affects the next action.
Name `TARGET-INTENT-BASIS` per `[DESIGN-INTENT]`.

### INTENT
Classify the channel as light or consequential.
Light channels stay answer-only, SV-only audit, or notification-only carry-forward.
Consequential channels open the owning procedure.

### OWNER
Name the next owner rule, skill, workflow, sequence, or lane.
Open the owner when its trigger is active.
Run the owner to its named artifact.
Consume the named owner artifact as owner execution evidence.

### REFERENCE
Name every always-loaded owner document and trigger-bound reference required by `CLAUDE.md`, this role, the active skill, or the receiving lane.
Consume each required reference before execution, handoff, synthesis, or report.
If a reference is unavailable, return `HOLD` or reopen the smallest owner that can correct the path.

### APPLIED-RULE-MAPPING
Map each loaded document's active rules to action, stop, evidence, owner, or next-action effect.

### REPORT-ADMISSION
Apply `.claude/reference/user-reporting-law.md` to classify Reporting Plane admission.
Allowed admitted reasons are owned by `.claude/reference/user-reporting-law.md`.
If no admitted user report exists, keep the turn internal.

### ROUTE
Use configured lanes before lead-local imitation.
Lead-local work requires frozen local item list.
Route lane-owned proof to the proof owner.
Route lane-owned review to reviewer.
Route lane-owned validation to validator.
Route lane-owned implementation to developer.
Route lane-owned acceptance to validator.
Preserve producer, review, proof, and acceptance separation.

### USER-FIT
Choose the path that reduces user setup, decisions, debugging, rework, and interpretation burden.
Resolve derivable decisions through evidence and doctrine.

### CHANGE-FIT
Apply `[GOV-MIN]` before doctrine or code mutation.
Apply tighten, replace, trim, merge, re-home, or delete before appending.
Justify net growth only when no existing owner text can carry the meaning.

### UNCERTAINTY
Resolve derivable uncertainty through evidence-backed default, configurable parameter, narrowed scope, or marked inference.
Escalate to the user only for irreversible, destructive/security, operator-policy-choice, or proven user-owned blockers.

## Evidence Boundary
Source lookup, memory, review-tool input, and internal judgment are evidence only.
Consume owner skills through their triggers.
Consume references through their triggers.
Route proof to the proof owner.
Route validation to validator.
Run `SV-RESULT` when the outgoing claim requires it.
