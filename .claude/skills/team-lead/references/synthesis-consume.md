---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/agents/team-lead.md
SOURCE-RULES: "RPA-6 Synthesis; Reference Binding; Procedure And Ownership"
---
# team-lead: Synthesis Consume

## Purpose
Use this reference when team-lead synthesizes lane outputs or decides redispatch after handoff.

## Consume When
- A lane sends `MESSAGE-CLASS: handoff`.
- A lane sends `MESSAGE-CLASS: completion`.
- Multiple lane outputs must be reconciled.
- A strengthened synthesis or redispatch might be reported.
- FAR `FINAL-REJECT` has occurred and the next synthesis consumes correction evidence.

## Required Output
Record:
- synthesized lane message identities
- accepted evidence anchors
- open surfaces
- contradictions
- frozen delivery contract comparison
- next executable owner/action or `HOLD`
- `SV-RESULT` status when synthesis drives reporting or redispatch

## Stop
Stop positive synthesis until the input is completion-grade.
Stop positive synthesis when material open surfaces remain.
Stop positive synthesis when agent outputs conflict.
Stop positive synthesis when the conclusion outruns the reconciled verified surface.
Stop positive synthesis while `[RETRO-APPLY]` affected prior evidence remains stale or unclassified.

## Next-Action Drive
- A stopped input route opens completion-grade input recovery.
- A stopped open-surface route opens the smallest correcting owner.
- A stopped conflict route opens owner synthesis reconciliation.
- A stopped overclaim route opens claim narrowing.
- A stopped `[RETRO-APPLY]` route opens affected-surface classification.

## Allowed Inputs
Synthesis is allowed only from `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion`.
Consume only the agent's returned:
- `TASK-ID`
- `OUTPUT-SURFACE`
- `EVIDENCE-BASIS`
- `OPEN-SURFACES`
- `RECOMMENDED-NEXT-LANE`

## Hard Rules
- Apply `CLAUDE.md` Communication message-class truth before synthesis.
- `hold|blocker` stops positive synthesis.
- `scope-pressure` stops positive synthesis.
- Implemented routes may prove `ACTIVE-SLICE`.
- Implemented files may prove `ACTIVE-SLICE`.
- Implemented screens may prove `ACTIVE-SLICE`.
- Implemented sections may prove `ACTIVE-SLICE`.
- Implemented checks may prove `ACTIVE-SLICE`.
- Compare implemented artifacts against the frozen delivery contract.
- Positive closure compares against the frozen request/plan delivery contract.
- Positive synthesis claims only the scope supported by Evidence-Quality Matrix rows, `FROZEN-CONTRACT-STATUS`, and retained open-surface state.
- Treat multi-lane convergence from the same narrowed packet as packet-limited evidence.
- Treat Claude+Codex convergence from the same convenience-built packet as packet-limited evidence.
- Packet basis itself must be compared against the frozen delivery contract.
- Missing frozen `REQUEST-BOUND-PACKET-FIELDS` baseline reopens the packet owner.

## Redispatch Rules
- Every non-final synthesis resolves to one next executable owner/action, bounded redispatch basis, or `HOLD`.
- If synthesis points to a next lane, run `SV-RESULT` on the synthesized result and proposed next owner/action before redispatch.
- If synthesis touches existing-artifact integrity, apply `[DESIGN-INTENT]`.
- Apply `.claude/skills/work-planning/references/cross-continuity.md` before consuming parallel-lane handoffs.
- Handoff evidence of parallel collapse, idle preservation, missed parallel-fit, missed downstream-prep parallel-fit, or agent-charter mismatch opens `session-boot` Monitoring Sequence reassessment before redispatch.
- After FAR `FINAL-REJECT`, next synthesis consumes assigned-validator correction packet and team-lead-classified route before next FAR or workflow `Complete`.
