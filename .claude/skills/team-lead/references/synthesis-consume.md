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
- `SV-RESULT` status when synthesis controls reporting or redispatch

## Stop
Stop positive synthesis until the input is completion-grade.
Stop positive synthesis when material open surfaces remain.
Stop positive synthesis when agent outputs conflict.
Stop positive synthesis when the conclusion outruns the reconciled verified surface.
Stop positive synthesis when required shard outputs are missing, late, unintegrated, or not explicitly deferred/out-of-scope.
Stop positive synthesis when audit findings are labeled as defects without the common finding-class basis and tested basis for rejecting `protected-restatement`, `design-tradeoff`, and `non-issue` classifications.
Classify raw finding counts, candidate lists, shard labels, and multi-lane convergence as evidence; assign severity, priority, patch-worthiness, or confirmed-defect status through the common finding basis.
Stop positive synthesis when quality, evidence, independent review, proof, validation, Codex-advisory, FAR gates, protected restatements, or owner-boundary repetitions are criticized without protected-function preservation analysis.
Stop positive synthesis when an agent conclusion uses literal wording or target-purpose evidence while omitting or contradicting the frozen `SEMANTIC-INTENT-BASIS`.
Stop positive synthesis while `[RETRO-APPLY]` affected prior evidence remains stale or unclassified.

## Resolve Next Owner And Action
- A stopped input route opens completion-grade input recovery.
- A stopped open-surface route opens the smallest correcting owner.
- A stopped conflict route opens owner synthesis reconciliation.
- A stopped overclaim route opens claim narrowing.
- A stopped shard-merge route opens merge-owner integration, explicit deferral, or out-of-scope classification.
- A stopped finding-class route opens finding reclassification before report or redispatch.
- A stopped semantic-frame route opens packet correction, claim reclassification, or reviewer/researcher re-analysis against `SEMANTIC-INTENT-BASIS`.
- A stopped `[RETRO-APPLY]` route opens affected-surface classification.

## Allowed Inputs
Synthesis is allowed only from `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion`.
Consume the completion-handoff common spine and any lane-specific fields needed for the synthesized claim.
For defect, removal, or patch-worthiness claims, also consume `SEMANTIC-INTENT-BASIS` and common finding basis items.

## Hard Rules
- Apply `CLAUDE.md` Communication message-class truth before synthesis.
- `hold|blocker` stops positive synthesis.
- `scope-pressure` stops positive synthesis.
- Implemented routes prove `ACTIVE-SLICE` only within their covered surface.
- Implemented files prove `ACTIVE-SLICE` only within their covered surface.
- Implemented screens prove `ACTIVE-SLICE` only within their covered surface.
- Implemented sections prove `ACTIVE-SLICE` only within their covered surface.
- Implemented checks prove `ACTIVE-SLICE` only within their covered surface.
- Compare implemented artifacts against the frozen delivery contract.
- Positive closure compares against the frozen request/plan delivery contract.
- Positive synthesis claims only the scope supported by Evidence-Quality Matrix rows, `FROZEN-CONTRACT-STATUS`, and retained open-surface state.
- Full-corpus, exhaustive, or `FINAL` synthesis requires required shard outputs and inspected corpus state to be integrated, owner-deferred, or out-of-scope with cited basis.
- Team-lead synthesis must preserve common finding classes: `confirmed-defect`, `risk-hypothesis`, `design-tradeoff`, `duplication`, `protected-restatement`, `non-issue`, or `unverified`.
- Do not promote `risk-hypothesis`, `design-tradeoff`, `duplication`, `protected-restatement`, `non-issue`, or `unverified` findings to `confirmed-defect` during synthesis.
- Do not promote researcher-only evidence to review finding, patch-worthiness, or confirmed defect without downstream review-classification basis.
- Treat multi-lane convergence from the same narrowed packet as packet-limited evidence.
- Treat Claude+Codex convergence from the same convenience-built packet as packet-limited evidence.
- Packet basis itself must be compared against the frozen delivery contract.
- Packet basis itself must be compared against the frozen `SEMANTIC-INTENT-BASIS` when analysis, critique, governance judgment, review, validation, or patch-worthiness depends on user/team/design meaning.
- Missing frozen `REQUEST-BOUND-PACKET-FIELDS` baseline reopens the packet owner.

## Redispatch Rules
- Every non-final synthesis resolves to one next executable owner/action, bounded redispatch basis, or `HOLD`.
- If synthesis points to a next lane, run `SV-RESULT` on the synthesized result and proposed next owner/action before redispatch.
- If synthesis touches existing-artifact integrity, apply `[DESIGN-INTENT]`.
- Apply `.claude/skills/work-planning/references/cross-continuity.md` before consuming parallel-lane handoffs.
- Handoff evidence of parallel collapse, idle preservation, missed parallel-fit, missed downstream-prep parallel-fit, or agent-charter mismatch opens `session-boot` Monitoring Sequence reassessment before redispatch.
- After FAR `FINAL-REJECT`, next synthesis consumes assigned-validator correction packet and team-lead-classified route before next FAR or workflow `Complete`.
