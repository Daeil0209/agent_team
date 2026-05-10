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
- Next-Action Drive
- Same-Segment Reuse
- Gate Fields
- Evidence Boundary

## Purpose
Use this reference before each consequential action segment.
The gate prevents team-lead from reporting, dispatching, or patching before owner, evidence, and user-fit are named.

## Consume When
- A user request requires any channel beyond `answer-only`.
- The next move could use tools.
- The next move could mutate files.
- The next move could dispatch or message an agent.
- The next move could report a phase result, completion, blocker, or next action.

## Required Output
Record an internal gate result with these fields:
- `WORK`
- `INTENT`
- `OWNER`
- `REFERENCE`
- `APPLIED-RULE-MAPPING`
- `REPORT`
- `ROUTE`
- `USER-FIT`
- `CHANGE-FIT`
- `UNCERTAINTY`

## Stop
Stop before action until every field is named truthfully.
Stop before action when applied-rule mapping is missing for active owner documents.
Stop before reusing the gate when work, owner, route, report, mutation boundary, or uncertainty changed.
Stop before user-facing prose until the selected report surface is new or changed.
Stop before mutation until `[GOV-MIN]` is applied.

## Next-Action Drive
- A stopped action route opens the missing gate field.
- A stopped applied-rule route opens loaded-document consumption.
- A stopped stale-gate route reopens this gate.
- A stopped pre-action prose route continues internal execution.
- A stopped mutation route opens `[GOV-MIN]` inspection.

## Same-Segment Reuse
- A gate remains current while `WORK`, `INTENT`, `OWNER`, `REFERENCE`, `REPORT`, `ROUTE`, `USER-FIT`, `CHANGE-FIT`, and `UNCERTAINTY` remain true.
- Evidence-gathering tool calls inside a current gate use the current gate.
- Dispatch, mutation, reporting, owner change, route change, or uncertainty change reopens this gate.

## Gate Fields
### WORK
Name the exact requested deliverable.
Name the requested coverage.
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
Map each loaded document's active rules to action, stop, evidence, owner, or next-action effect.
Consume each required reference before execution, handoff, synthesis, or report.
If a reference is unavailable, return `HOLD` or reopen the smallest owner that can correct the path.

### REPORT
Select one user-facing truth surface:
- `verified result`
- `blocker`
- `next action`
- `dispatch pending`
- `closeout residual`

If no new or changed primary surface exists, keep the turn internal.

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
Prefer tighten, replace, trim, merge, re-home, or delete before appending.
Justify net growth only when no existing owner text can carry the meaning.

### UNCERTAINTY
Resolve derivable uncertainty through evidence-backed default, configurable parameter, narrowed scope, or marked inference.
Escalate to the user only for irreversible, destructive/security, policy, or proven user-owned blockers.

## Evidence Boundary
Source lookup, memory, advisory input, and internal judgment are evidence only.
Consume owner skills through their triggers.
Consume references through their triggers.
Route proof to the proof owner.
Route validation to validator.
Run `SV-RESULT` when the outgoing claim requires it.
