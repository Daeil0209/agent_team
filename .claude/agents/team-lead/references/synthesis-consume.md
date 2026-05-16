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
- A lane sends:
  - `MESSAGE-CLASS: handoff`
  - `MESSAGE-CLASS: completion`
- Multiple lane outputs must be reconciled.
- A strengthened synthesis or redispatch might be reported.
- FAR `FINAL-REJECT` has occurred and the next synthesis consumes correction evidence.

## Screen Boundary
Lane `handoff` and `completion` transports are not user reports even when Claude Code renders them on screen.
Team-lead must not summarize, translate, rank, celebrate, or narrate an arriving lane transport in pane/final prose.
Arrival opens retained-carrier consumption, synthesis, contradiction handling, lifecycle control, redispatch, or `SV-RESULT`; it never opens a user-facing shard summary.
If no admitted user report exists, visible team-lead prose after a lane transport is limited to the Minimal Visible State Token from `.claude/reference/user-reporting-law.md`.

## All-Required-Output Barrier
For a multi-lane, multi-shard, reviewer fan-out, proof fan-out, or validator-routed route, team-lead freezes the required output set from the active plan, dispatch record, task state, or route packet.
The required-output barrier blocks user-facing synthesis, phase result, completion claim, and shard-progress prose.
Blocking conditions include any required output that is pending, missing, unintegrated, contradictory, only screen-visible, or awaiting retained-carrier consumption.
A required output closes only through one of:
- completion-grade retained carrier consumed
- explicit owner deferral
- cited out-of-scope basis
- `scope-pressure`
- `hold|blocker`
- failed-send or replacement truth
- user-cancel or user-redirect
Partial arrivals are synthesis queue events.
Partial arrivals open internal merge work, not report text.
Explicit user status questions during this barrier answer only the user-relevant waiting condition.
The status answer omits shard identities, counts, findings, evidence detail, retained paths, and per-agent narratives.
Internal materials enter the status answer only on specific user request.

## Required Output
Record:
- required output set and per-output closure state
- synthesized lane message identities
- accepted evidence anchors
- open surfaces
- contradictions
- frozen delivery contract comparison
- next executable owner/action or `HOLD`
- `SV-RESULT` status when synthesis controls reporting or redispatch
- applicable per-claim basis when synthesis emits findings, patterns, rankings, defect labels, patch recommendations, or redispatch basis

## Verification Gate
Before any user-facing synthesis, completion claim, phase-result, or synthesis-triggered redispatch, team-lead loads `.claude/skills/self-verification/SKILL.md`.
Team-lead executes `SV-RESULT` mode through Steps 0-5 on the exact synthesized claim.
Team-lead records the internal `SELF-VERIFICATION:` block on that claim.
Mental review or inline reasoning does not satisfy this gate.
Full-corpus, multi-shard, defect-classifying, patch-worthiness, removal, or high-risk governance judgment requires independent verification when available.
Independent verification routes include reviewer/validator, Codex independent review, and equivalent independent proof surfaces.
Independent verification is internal Procedure Plane work unless `.claude/reference/user-reporting-law.md` admits a user report.
Raw lane convergence, shard counts, candidate totals, and retained-output presence are not verified synthesis.

## Stop
Stop positive synthesis when:
- the input is not completion-grade
- material open surfaces remain
- agent outputs conflict
- the conclusion outruns the reconciled verified surface
- required shard or lane outputs are missing, late, pending, unintegrated, contradictory, only screen-visible, or not explicitly deferred/out-of-scope
- any emitted finding, pattern, ranking item, class bucket, defect group, patch recommendation, or redispatch basis lacks applicable per-claim basis
- quality, evidence, independent review, proof, validation, Codex independent review, FAR gates, protected restatements, or owner-boundary repetitions are criticized without protected-function preservation analysis
- a meaning-dependent synthesis claim uses literal wording or target-purpose evidence while omitting or contradicting the frozen `SEMANTIC-INTENT-BASIS`
- `[RETRO-APPLY]` affected prior evidence remains stale or unclassified
Classify raw finding counts, candidate lists, shard labels, and multi-lane convergence as evidence; assign severity, priority, patch-worthiness, or confirmed-defect status through the common finding basis.

Per-claim basis is internal synthesis evidence.
For each emitted synthesis claim, record the applicable items:
- active rule or design-intent basis
- claim ceiling
- common finding class when the claim assigns finding status, defect status, priority, ranking, or patch-worthiness
- non-finding route basis when the claim assigns redispatch force
- `SEMANTIC-INTENT-BASIS` fit when the claim depends on user, team, design, governance, or artifact meaning
- protected-function preservation analysis when the claim criticizes protected procedure, owner boundary, evidence, review, proof, validation, FAR gate, or restatement function
- rejection basis for `protected-restatement`, `design-tradeoff`, and `non-issue` when the claim promotes a candidate toward confirmed defect, patch-worthiness, priority, ranking, or correction redispatch
Failed per-claim basis routes to claim narrowing, finding reclassification, `OPEN-SURFACES` downgrade, or exclusion from the outgoing synthesis body.

## Resolve Next Owner And Action
- A stopped input route opens completion-grade input recovery.
- A stopped open-surface route opens the smallest correcting owner.
- A stopped conflict route opens owner synthesis reconciliation.
- A stopped overclaim route opens claim narrowing.
- A stopped shard-merge route opens merge-owner integration, explicit deferral, or out-of-scope classification.
- A stopped per-claim-basis route opens failed per-claim basis routing.
- A stopped finding-class route opens finding reclassification before report or redispatch.
- A stopped semantic-frame route opens packet correction, claim reclassification, or reviewer/researcher re-analysis against `SEMANTIC-INTENT-BASIS`.
- A stopped `[RETRO-APPLY]` route opens affected-surface classification.

## Allowed Inputs
Synthesis is allowed only from `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion`.
Consume the completion-handoff common spine and any lane-specific fields needed for the synthesized claim.
For defect, removal, or patch-worthiness claims, also consume `SEMANTIC-INTENT-BASIS` and common finding basis items.

## Hard Rules
- Apply `CLAUDE.md` Communication message-class truth before synthesis.
- These message classes stop positive synthesis:
  - `hold|blocker`
  - `scope-pressure`
- These implemented artifacts prove `ACTIVE-SLICE` only within their covered surface:
  - routes
  - files
  - screens
  - sections
  - checks
- Compare implemented artifacts against the frozen delivery contract.
- Positive closure compares against the frozen request/plan delivery contract.
- Positive synthesis claims only the scope supported by Evidence-Quality Matrix rows, `FROZEN-CONTRACT-STATUS`, and retained open-surface state.
- Full-corpus, exhaustive, or `FINAL` synthesis requires required shard outputs and inspected corpus state to be integrated, owner-deferred, or out-of-scope with cited basis.
- Team-lead synthesis must preserve common finding classes: `confirmed-defect`, `risk-hypothesis`, `design-tradeoff`, `duplication`, `protected-restatement`, `non-issue`, or `unverified`.
- Do not promote `risk-hypothesis`, `design-tradeoff`, `duplication`, `protected-restatement`, `non-issue`, or `unverified` findings to `confirmed-defect` during synthesis.
- Do not promote researcher-only evidence to review finding, patch-worthiness, or confirmed defect without downstream review-classification basis.
- Treat these convergence patterns as packet-limited evidence:
  - multi-lane convergence from the same narrowed packet
  - Claude+Codex convergence from the same convenience-built packet
- Packet-limited evidence cannot satisfy per-claim basis by itself.
- Packet basis itself must be compared against:
  - the frozen delivery contract
  - the frozen `SEMANTIC-INTENT-BASIS` when analysis, critique, governance judgment, review, validation, or patch-worthiness depends on user/team/design meaning
- Missing frozen `REQUEST-BOUND-PACKET-FIELDS` baseline reopens the packet owner.

## Redispatch Rules
- Every non-final synthesis resolves to one next executable owner/action, bounded redispatch basis, or `HOLD`.
- If synthesis points to a next lane, run `SV-RESULT` on the synthesized result and proposed next owner/action before redispatch.
- `SV-RESULT` on strengthened synthesis verifies the per-claim basis actually used for every emitted synthesis claim.
- A generic `SV-RESULT` label without per-claim basis verification is stale or narrower than the outgoing synthesis claim.
- If synthesis touches existing-artifact integrity, apply `[DESIGN-INTENT]`.
- Apply `.claude/skills/work-planning/references/cross-continuity.md` before consuming parallel-lane handoffs.
- Handoff evidence of parallel collapse, idle preservation, missed parallel-fit, missed downstream-prep parallel-fit, or agent-charter mismatch opens `session-boot` Monitoring Sequence reassessment before redispatch.
- After FAR `FINAL-REJECT`, next synthesis consumes assigned-validator correction packet and team-lead-classified route before next FAR or workflow `Complete`.
