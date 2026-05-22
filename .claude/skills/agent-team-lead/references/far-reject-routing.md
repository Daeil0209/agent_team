---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "final-acceptance-reject; validator-correction-packet; root-cause-routing; acceptance-separation"
---
# team-lead: FAR FINAL-REJECT Route Classification

## Purpose
Classify the next correction or re-evidence route after `FINAL-REJECT`.
Validator correction packet is evidence for route classification, not team-lead implementation judgment or validation authority.

## Consume When
- Final Acceptance Review records `FINAL-REJECT`.
- Validator returns a correction packet.
- Correction or re-evidence dispatch would start from a rejected validator `PASS`.

## Required Output
- validator correction packet consumed
- root-cause class
- correction owner surface
- active workflow basis
- selected next executable owner/action

## Routing Gate
Correction or re-evidence dispatch requires a consumed validator correction packet and unchanged root-cause axes: scope, owner map, route, proof chain, and acceptance chain.
Root-cause-axis change reopens `work-planning`.
Next FAR entry requires correction or re-evidence result and prior `FINAL-REJECT` identity per `.claude/skills/dev-workflow/references/final-acceptance-review.md`.

## Resolve Next Owner And Action
- A missing correction packet opens validator correction-packet retrieval.
- Any root-cause-axis change (scope, owner map, route, proof chain, or acceptance chain) reopens `work-planning`.
- Proof/acceptance-chain evidence gap inside unchanged axes opens active workflow Phase 4 review/proof/validation re-evidence.
- Classified route opens the owning workflow correction or re-evidence phase before `task-execution` dispatch.
- Next FAR gaps open `.claude/skills/dev-workflow/references/final-acceptance-review.md`.

## Routing Rules
- Design-level root cause routes to the active workflow design-correction phase.
- Implementation root cause routes to the active workflow production-correction phase.
- Operator-delivery root cause routes to the active workflow production-correction phase.
- Proof/acceptance-chain root cause routes to `work-planning` when proof chain or acceptance chain changes; otherwise it opens active workflow Phase 4 review/proof/validation re-evidence.
- Scope/boundary root cause reopens `work-planning`.
- `undetermined:<basis>` root cause opens root-cause clarification from the active workflow basis before correction or re-evidence dispatch.

## Evidence Rules
- Validator correction packet is follow-on basis.
- Team-lead classification is route basis.
- Route final acceptance to validator.
- Correction or re-evidence dispatch carries the validator-authored correction packet.
