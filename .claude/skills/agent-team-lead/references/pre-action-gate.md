---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "Priority 0: Pre-Action Gate; Work Execution Philosophy"
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# team-lead: Pre-Action Gate

## Contents
- Purpose
- Consume When
- Required Output
- Routing Gate
- Resolve Next Owner And Action
- Same-Segment Reuse
- Gate Fields
- Evidence Boundary

## Purpose
Use this reference before each consequential action segment.
The gate prevents team-lead from reporting, dispatching, or patching before owner, evidence, and user-fit are named.

Non-overlap boundary with `.claude/skills/agent-team-lead/references/owner-trigger-order.md`:
- This reference owns the per-segment gate fields (`WORK`, `INTENT`, `OWNER`, `REFERENCE`, `APPLIED-RULE-MAPPING`, `REPORT-ADMISSION`, `ROUTE`, `USER-FIT`, `CHANGE-FIT`, `UNCERTAINTY`) and missing-field routing.
- Trigger-priority selection across multiple active owner triggers, named-artifact emission, and per-skill routing requirements live at `owner-trigger-order.md`; this gate consumes that selection through the `OWNER` field rather than restating trigger order here.

Reporting curtain inheritance:
- This reference records an internal gate result only.
- Gate fields, route checks, user-fit checks, uncertainty checks, and report-prohibition checks remain internal control evidence.
- `REPORT-ADMISSION` is the compatibility field name for the reporting-prohibition result.
- `REPORT-ADMISSION` preserves the current owner route and records only a narrow report exception granted by reporting-prohibition law.
- If no narrow report exception exists, continue the current owner action silently.

## Consume When
- A user request requires any channel beyond `answer-only`.
- The next move can:
  - use tools
  - mutate files
  - dispatch or message an agent
  - prepare a report excepted by `.claude/reference/reporting-prohibition-law.md`

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

## Routing Gate
Action requires every required field named truthfully and active owner documents carrying applied-rule mapping.
Gate reuse requires unchanged work, owner, route, report-prohibition result, mutation boundary, and uncertainty.
User-facing prose requires `.claude/reference/reporting-prohibition-law.md` narrow exception for a new or changed report reason.
Lane/shard arrival, partial completion, partial convergence, retained-output availability, and findings-count visibility route to internal continuation before user-facing prose.
Lane/shard arrival, partial completion, partial convergence, retained-output availability, and findings-count visibility open synthesis or monitoring, not reporting.
Tool-adjacent progress prose routes to the current owner tool action without prose.
Doctrine-derivable choices resolve through evidence-backed default, owner route, or a valid escalation exception.
Process-state prose requires a same-turn truthful next owner/action or reporting-prohibition-law-excepted status, blocker, or verified result.
Answer-only, status, yes/no, verification, explanation, audit, or explicit hold-conversation instructions preserve mutation closed unless mutation authorization already exists.
Mutation requires `[GOV-MIN]` application.

## Resolve Next Owner And Action
- A current instruction that creates, reopens, or changes a consequential work boundary loads `Skill(work-planning)` through `session-route-bridge`.
- Unresolved session-start, active runtime, recovery, monitoring, or cleanup evidence loads `Skill(session-boot)`.
- Missing action fields open the missing gate field.
- Missing applied-rule mapping opens loaded-document consumption.
- Stale gate fields reopen this gate.
- Non-excepted pre-action prose continues internal execution.
- Tool-adjacent prose continues through the current owner tool action without prose.
- Doctrine-derivable choice executes the evidence-backed default, owner route, or valid escalation exception.
- Process-state prose gaps continue the current owner action or emit only a reporting-prohibition-law-excepted status, blocker, or verified result.
- Light-channel mutation gaps emit the narrow-exception answer or audit result and preserve discovered gaps as evidence only.
- Lane-arrival prose gaps open retained-carrier consumption, all-required-output barrier tracking, monitoring, synthesis, or `Skill(self-verification)` result verification.
- Mutation gaps open `[GOV-MIN]` inspection.

## Same-Segment Reuse
- A gate remains current while `WORK`, `INTENT`, `OWNER`, `REFERENCE`, `APPLIED-RULE-MAPPING`, `REPORT-ADMISSION`, `ROUTE`, `USER-FIT`, `CHANGE-FIT`, and `UNCERTAINTY` remain true.
- Evidence-gathering tool calls inside a current gate use the current gate.
- Dispatch, mutation, reporting, owner change, route change, or uncertainty change reopens this gate.

## Gate Fields
### WORK
Name the exact requested deliverable.
Name the requested coverage.
Name `SEMANTIC-INTENT-BASIS` when user concern, anti-goal, active philosophy section or keyword, governance/design intent, or priority order affects channel class, owner choice, next action, stop, evidence, routing, or burden.
Name `TARGET-INTENT-BASIS` per `[DESIGN-INTENT]`.

### INTENT
Classify the channel as light or consequential.
Classify the interpreted requested outcome before choosing tool, skill, workflow, sequence, mutation, dispatch, verification, or report.
Light channels stay `answer-only`, `self-verification-only audit`, or `notification-only carry-forward` under `.claude/CLAUDE.md` `## 3. Work Execution Philosophy`.
Verification or defect-filtering questions remain light-channel unless the user asks to apply, patch, correct, dispatch, validate, or continue an already frozen execution boundary.
Consequential channels open the owning procedure.

### OWNER
Name the next owner rule, skill, workflow, sequence, or lane.
Pre-`Skill(<skill>)` tool-call record duties are owned by `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`.
Open the owner when its trigger is active.
When the owner is a skill, owner opening requires actual `Skill(<skill>)` load or current same-session loaded-skill basis under the named skill's freshness rule.
Direct `Read`, `Grep`, `Glob`, `LS`, summary, memory, or reference-map traversal of skill-owned files is inspection only for owner opening.
Run the owner to its named artifact.
Consume the named owner artifact as owner execution evidence.

### REFERENCE
Name every always-loaded owner document and trigger-bound reference required by `CLAUDE.md`, this role, the active skill, or the receiving lane.
Before a `Skill(<skill>)` tool call, consume `.claude/reference/work-skill-reference-binding-law.md` for skill-load eligibility.
Consume each required reference before execution, handoff, synthesis, or report.
If a reference is unavailable, return `HOLD` or reopen the smallest owner that can correct the path.

### APPLIED-RULE-MAPPING
Map each loaded document's active rules to action, stop, evidence, owner, or next-action effect.

### REPORT-ADMISSION
`REPORT-ADMISSION` is the compatibility field name for Reporting Plane prohibition/exception classification.
Apply `.claude/reference/reporting-prohibition-law.md` to classify the reporting-prohibition result.
Narrow exception reasons are owned by `.claude/reference/reporting-prohibition-law.md`.
If no narrow report exception exists, keep the turn internal.

### ROUTE
Use configured lanes before lead-local substitution.
Lead-local work requires frozen local item list.
Route lane-owned proof to the proof owner.
Route lane-owned review to reviewer.
Route lane-owned validation to validator.
Route lane-owned implementation to developer.
Route lane-owned acceptance to validator.
Preserve producer, review, proof, and acceptance separation.
Before same-lane follow-on dispatch, wave transition, replacement, or redispatch, evaluate live or standby reuse through `.claude/skills/task-execution/references/runtime-dispatch-law.md` `## Parallel And Reuse Law`.
When reuse-fit holds, route to `task-execution` reuse-via-`SendMessage` instead of shutdown or new `Agent`.
Shutdown-before-create requires reuse-fit failure, dead-or-unavailable target, lane absence, lane no-longer-needed basis, or active `session-closeout` teardown.

### USER-FIT
Choose the path that reduces user setup, decisions, debugging, rework, and interpretation burden.
Resolve derivable decisions through evidence and doctrine.

### CHANGE-FIT
Apply `[GOV-MIN]` before doctrine or code mutation.
Apply tighten, replace, trim, merge, re-home, or delete before appending.
Justify net growth only when no existing owner text can carry the meaning.

### UNCERTAINTY
Resolve derivable uncertainty through evidence-backed default, configurable parameter, narrowed claim strength, or marked inference.
Uncertainty handling preserves frozen deliverable scope, `SCOPE-BASELINE`, completion closure, promotion coverage, patch-loop coverage, and validation scope unless explicit user acceptance or `[USER-DELIVERY-FIT]` lawful basis changes them.
Escalation criteria follow `.claude/CLAUDE.md` `## 3. Work Execution Philosophy`.

## Evidence Boundary
Source lookup, memory, review-tool input, and internal judgment are evidence only.
Consume owner skills through their triggers.
Consume references through their triggers.
Route proof to the proof owner.
Route validation to validator.
Load `Skill(self-verification)` and run result verification when the outgoing claim requires it.
