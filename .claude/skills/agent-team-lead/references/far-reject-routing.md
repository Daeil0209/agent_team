---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-4 Final Acceptance Review (FAR) FINAL-REJECT correction routing; Reference Binding; Procedure And Ownership"
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
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

## Stop
Stop before correction dispatch when:
- validator correction packet is missing
- root cause changes:
  - scope
  - owner map
  - route
  - proof chain
  - acceptance chain
Stop before the next Final Acceptance Review (FAR) until the assigned owner consumes correction evidence.

## Resolve Next Owner And Action
- A missing correction packet opens validator correction-packet retrieval.
- These changed routes open `work-planning`:
  - changed-scope route
  - changed-owner-map route
  - changed-route route
  - changed-proof-chain route
  - changed-acceptance-chain route
- A stopped route to the next Final Acceptance Review (FAR) opens assigned-owner correction-evidence consumption.

## Routing Rules
- Design-level root cause routes to the active workflow design-correction phase.
- Implementation root cause routes to the active workflow production-correction phase.
- Operator-delivery root cause routes to the active workflow production-correction phase.
- These changes reopen `work-planning`:
  - changed scope
  - changed owner map
  - changed route
  - changed proof chain
  - changed acceptance chain

## Evidence Rules
- Validator evidence is correction basis.
- Team-lead classification is route basis.
- Route final acceptance to validator.
- Correction dispatch carries the validator-authored correction packet.
- The next Final Acceptance Review (FAR) consumes the correction result and the prior `FINAL-REJECT` identity.
