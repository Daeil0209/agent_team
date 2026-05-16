# dev-workflow: Checkpoints
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/dev-workflow/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
auto-inject: false

Checkpoint policy.
CP1-CP5 are checkpoint surfaces, not default stop points or user-confirmation labels.
team-lead resolves checkpoints autonomously when the frozen request-fit basis and available evidence are sufficient.
Destructive/security-sensitive action, material ambiguity, or material architecture/risk/scope change does not create a choice prompt here.
Those classes force `HOLD` and re-entry through the owning path.
CP5 is auto-resolved in normal gap flow.
T0/T1 gaps follow Incident Response.

## CP1 -- Plan Basis Freeze
- **Phase**: Plan, before the canonical plan surface is finalized
- **Trigger**: problem understanding and request-fit basis are synthesized
- **Present**: problem, scope boundaries, frozen `SCOPE-BASELINE` for in-scope features/surfaces/controls, constraints, delivery experience, acceptance evidence basis, and lightweight verification strategy basis; if a reference exists, also present adopted/adapted/rejected reference fit
- **Auto-resolve**: when the request-fit basis and available evidence make the plan basis clear
- **Reopen/HOLD**: when reference interpretation or core plan basis remains materially ambiguous

## CP2 -- Ambiguity Resolution
- **Phase**: Plan, after the plan draft exists
- **Trigger**: open design or integration questions remain
- **Present**: only the unresolved questions that still change scope, risk posture, or delivery expectations
- **Auto-resolve**: when the answer is still bounded by the request-fit basis and existing evidence
- **Reopen/HOLD**: when bounded inference no longer preserves scope, risk posture, or delivery expectations

## CP3 -- Architecture Selection
- **Phase**: Design
- **Trigger**: architecture options are produced
- **Present**: explicit options plus their `SCOPE-BASELINE` closure, verification, delivery, and implementation implications
- **Default path**: team-lead auto-resolution from the pragmatic option with bounded supplementation
- **Reopen/HOLD**: when supplementation would materially change architecture family, risk posture, or implementation scope

## CP4 -- Implementation Scope Resolution
- **Phase**: Implementation, before any implementation begins
- **Trigger**: design is resolved and the implementation scope summary is available
- **Owner action**: team-lead freezes CP4 by translating the Phase 2 implementation-binding internal detail bundle into production assignments; developer receives CP4 as implementation basis only
- **Present**: work surfaces to create/modify, out-of-scope items, risk points, `SCOPE-BASELINE` coverage, delivery experience check, specialist-fit lane decomposition, dependency boundaries, surface-to-agent map, first parallel dispatch segment, later-segment parallel-fit basis, and merge ownership
- **Auto-resolve**: when the scope matches the design contract and frozen request-fit basis with no unresolved design-level gap
- **Reopen/HOLD**: for destructive/security-sensitive actions or material scope expansion beyond the resolved design

## CP5 -- Gap Resolution Decision
- **Phase**: Analysis
- **Trigger**: reviewer or tester transports blocking defects or significant coverage gaps
- **Auto-resolve priority**:
  1. design-level gap, missing/untrue Phase 2 source-of-truth, or repeated same-class cross-surface contract gap caused by weak design contract -> Phase 2 correction
  2. implementation or operator-delivery gap inside unchanged Phase 1/2 contract, including repeated same-class implementation drift with adequate design contract -> Phase 5 systemic correction with Phase-2-derived acceptance-grade gap-to-correction-surface map
  3. changed scope, owner map, route, proof chain, or acceptance chain -> `work-planning`
  4. no blocking gap, all frozen `SCOPE-BASELINE` features/surfaces/controls and every `CORE-WORKFLOW-CLOSURE` row covered, and operator-delivery closure sufficient -> Final Acceptance Review for validator-required chains; workflow completion only after `FINAL-ACCEPT` or when no final-arbitration trigger applies
- **Reuse rule**: original CP3/CP4 remain valid only while the corrected design preserves the selected architecture family and implementation scope
- **Iteration continuation reuse**: bounded iteration reuse is allowed only while the active workflow phase, owner surface, and acceptance path stay unchanged

## Resolve Next Owner And Action
- CP1 resolved opens Phase 1 plan finalization.
- CP2 resolved opens Phase 2 boundary when Phase 1 exit law is satisfied.
- CP3 resolved opens Phase 2 design closure.
- CP4 resolved opens Phase 3 implementation dispatch.
- CP5 design-level result opens Phase 2 correction.
- CP5 implementation or operator-delivery result opens Phase 5 correction.
- CP5 route-changing result opens `work-planning`.
- CP5 no-blocking-gap result opens Final Acceptance Review or bounded verified-result closure by acceptance path.
- T0/T1 gap opens `incident-response`.
