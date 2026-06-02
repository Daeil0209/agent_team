# dev-workflow: Checkpoints
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/dev-workflow/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
auto-inject: false

Checkpoint policy.
CP1-CP5 are checkpoint surfaces, not default stop points or user-confirmation labels.
team-lead resolves checkpoints autonomously when the frozen request-fit basis and available evidence are sufficient.
Destructive/security-sensitive action, material ambiguity, or material architecture/risk/scope change does not create a choice prompt here.
Those classes open blocker-routing and re-entry through the owning path after internal recovery.
CP5 is auto-resolved in normal gap flow.
P0/P1 gaps follow Incident Response; adjacent T labels map through `.claude/skills/dev-workflow/references/incident-response.md`.

## CP1 -- Plan Basis Freeze
- **Phase**: Plan, before the canonical plan surface is finalized
- **Trigger**: problem understanding and request-fit basis are synthesized
- **Present**: problem, scope boundaries, frozen `SCOPE-BASELINE` for in-scope features/surfaces/controls, constraints, delivery experience, acceptance evidence basis, and lightweight verification strategy basis; if a reference exists, also present adopted/adapted/rejected reference fit
- **Auto-resolve**: when the request-fit basis and available evidence make the plan basis clear
- **Reopen/blocker-routing**: when reference interpretation or core plan basis remains materially ambiguous after internal recovery

## CP2 -- Ambiguity Resolution
- **Phase**: Plan, after the plan draft exists
- **Trigger**: open design or integration questions remain
- **Present**: only the unresolved questions that still change scope, risk posture, or delivery expectations
- **Auto-resolve**: when the answer is still bounded by the request-fit basis and existing evidence
- **Reopen/blocker-routing**: when bounded inference no longer preserves scope, risk posture, or delivery expectations after internal recovery

## CP3 -- Architecture Selection
- **Phase**: Design
- **Trigger**: architecture options are produced
- **Present**: explicit options plus their `SCOPE-BASELINE` closure, verification, delivery, and implementation implications
- **Default path**: team-lead auto-resolution from the pragmatic option with bounded supplementation
- **Reopen/blocker-routing**: when supplementation would materially change architecture family, risk posture, or implementation scope after internal recovery

## CP4 -- Implementation Scope Resolution
- **Phase**: Implementation, before any implementation begins
- **Trigger**: design is resolved and the implementation scope summary is available
- **Owner action**: team-lead freezes CP4 by translating the Phase 2 implementation-binding internal detail bundle into production assignments; developer receives CP4 as implementation basis only
- **Present**: work surfaces to create/modify, out-of-scope items, risk points, `SCOPE-BASELINE` coverage, delivery experience check, specialist-fit lane decomposition, dependency boundaries, surface-to-agent map, first parallel dispatch segment, later-segment parallel-fit basis, and merge ownership
- **Auto-resolve**: when the scope matches the design contract and frozen request-fit basis with no unresolved design-level gap
- **Reopen/blocker-routing**: for destructive/security-sensitive actions or material scope expansion beyond the resolved design after internal recovery

## CP5 -- Gap Resolution Decision
- **Phase**: Analysis
- **Trigger**: reviewer or tester transports blocking defects or significant coverage gaps
- **Auto-resolve priority**:
  1. design-level gap, missing/untrue Phase 2 source-of-truth, or repeated same-class cross-surface contract gap caused by weak design contract -> Phase 2 correction
  2. implementation or operator-delivery gap inside unchanged Phase 1/2 contract, including repeated same-class implementation drift with adequate design contract -> Phase 5 systemic correction with Phase-2-derived acceptance-grade gap-to-correction-surface map
  3. proof/acceptance-chain evidence gap inside unchanged scope, owner map, route, proof chain, and acceptance chain -> Phase 4 review/proof/validation re-evidence
  4. changed scope, owner map, route, proof chain, or acceptance chain -> `work-planning`
  5. no blocking gap, all frozen `SCOPE-BASELINE` features/surfaces/controls and every applicable `CORE-WORKFLOW-CLOSURE` row covered, and operator-delivery closure sufficient -> acceptance-path closure.
     - Validator-required chains open validator ingress unless a fresh or still-current validator `PASS` already covers the corrected surfaces.
     - Fresh or still-current validator `PASS` opens Final Acceptance Review.
     - Workflow completion opens only after `FINAL-ACCEPT` or when no final-arbitration trigger applies.
- **Reuse rule**: original CP3/CP4 remain valid only while the corrected design preserves the selected architecture family and implementation scope
- **Iteration continuation reuse**: bounded iteration reuse is allowed only while the active workflow phase, owner surface, and acceptance path stay unchanged

## Resolve Next Owner And Action
- CP1 resolved opens Phase 1 plan finalization.
- CP2 resolved opens Phase 2 boundary when Phase 1 exit law is satisfied.
- CP3 resolved opens Phase 2 design closure.
- CP4 resolved opens Phase 3 implementation dispatch.
- CP5 design-level result opens Phase 2 correction.
- CP5 implementation or operator-delivery result opens Phase 5 correction.
- CP5 proof/acceptance-chain evidence gap inside unchanged axes opens Phase 4 review/proof/validation re-evidence.
- CP5 route-changing result opens `work-planning`.
- CP5 no-blocking-gap result opens validator ingress, Final Acceptance Review after fresh or still-current validator `PASS`, or bounded acceptance-path closure.
- P0/P1 gap opens `incident-response`.
