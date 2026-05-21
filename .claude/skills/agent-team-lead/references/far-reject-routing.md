---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-8 Final Acceptance Review (FAR) FINAL-REJECT correction routing; Work Execution Philosophy; Judgment Philosophy"
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# team-lead: Final Acceptance Review (FAR) FINAL-REJECT Correction Routing

## Purpose
Route correction after `FINAL-REJECT` without turning validator evidence into team-lead implementation judgment.

## Consume When
- Final Acceptance Review records `FINAL-REJECT`.
- Validator returns a correction packet.
- A rejected validator `PASS` must become correction input.

## Required Output
Record:
- validator correction packet consumed
- root-cause class
- correction owner surface
- active workflow basis
- selected next executable owner/action

## Routing Gate
Correction dispatch requires validator correction packet and unchanged root-cause axes:
  - scope
  - owner map
  - route
  - proof chain
  - acceptance chain
The next Final Acceptance Review (FAR) requires assigned-owner correction-evidence consumption.

## Resolve Next Owner And Action
- A missing correction packet opens validator correction-packet retrieval.
- Any root-cause-axis change (scope, owner map, route, proof chain, or acceptance chain) reopens `work-planning`.
- Next-Final-Acceptance-Review gaps open assigned-owner correction-evidence consumption.

## Routing Rules
- Design-level root cause routes to the active workflow design-correction phase.
- Implementation root cause routes to the active workflow production-correction phase.
- Operator-delivery root cause routes to the active workflow production-correction phase.
- `undetermined:<basis>` root cause opens root-cause clarification from the active workflow basis before correction dispatch.
- Root-cause-axis changes reopen `work-planning` per the Stop section enumeration.

## Evidence Rules
- Validator evidence is correction basis.
- Team-lead classification is route basis.
- Route final acceptance to validator.
- Correction dispatch carries the validator-authored correction packet.
- The next Final Acceptance Review (FAR) consumes the correction result and the prior `FINAL-REJECT` identity.
