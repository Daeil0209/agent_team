---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/agents/team-lead.md
SOURCE-RULES: "RPA-4 FAR FINAL-REJECT correction routing; Reference Binding; Procedure And Ownership"
---
# team-lead: FAR FINAL-REJECT Correction Routing

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
Stop before correction dispatch when validator correction packet is missing.
Stop before correction dispatch when root cause changes scope.
Stop before correction dispatch when root cause changes owner map.
Stop before correction dispatch when root cause changes route.
Stop before correction dispatch when root cause changes proof chain.
Stop before correction dispatch when root cause changes acceptance chain.
Stop before the next FAR until the assigned owner consumes correction evidence.

## Next-Action Drive
- A missing correction packet opens validator correction-packet retrieval.
- A changed-scope route opens `work-planning`.
- A changed-owner-map route opens `work-planning`.
- A changed-route route opens `work-planning`.
- A changed-proof-chain route opens `work-planning`.
- A changed-acceptance-chain route opens `work-planning`.
- A stopped next-FAR route opens assigned-owner correction-evidence consumption.

## Routing Rules
- Design-level root cause routes to the active workflow design-correction phase.
- Implementation root cause routes to the active workflow production-correction phase.
- Operator-delivery root cause routes to the active workflow production-correction phase.
- Changed scope reopens `work-planning`.
- Changed owner map reopens `work-planning`.
- Changed route reopens `work-planning`.
- Changed proof chain reopens `work-planning`.
- Changed acceptance chain reopens `work-planning`.

## Evidence Rules
- Validator evidence is correction basis.
- Team-lead classification is route basis.
- Route final acceptance to validator.
- Correction dispatch carries the validator-authored correction packet.
- The next FAR consumes the correction result and the prior `FINAL-REJECT` identity.
