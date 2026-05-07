# dev-workflow: Checkpoints
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Checkpoint policy. CP1-CP5 are checkpoint surfaces, not default stop points or user-confirmation labels. team-lead resolves checkpoints autonomously when the frozen request-fit basis and available evidence are sufficient. Destructive/security-sensitive action, material ambiguity, or material architecture/risk/scope change does not create a choice prompt here; it forces `HOLD` and re-entry through the owning path. CP5 is auto-resolved in normal gap flow; T0/T1 gaps follow Incident Response.

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
- **Default path**: team-lead auto-resolution, usually from the pragmatic option with bounded supplementation
- **Reopen/HOLD**: when supplementation would materially change architecture family, risk posture, or implementation scope

## CP4 -- Implementation Scope Resolution
- **Phase**: Implementation, before any implementation begins
- **Trigger**: design is resolved and the implementation scope summary is available
- **Owner action**: team-lead freezes CP4 by translating the Phase 2 implementation-binding contract into production assignments; developer receives CP4 as implementation basis only
- **Present**: work surfaces to create/modify, out-of-scope items, risk points, `SCOPE-BASELINE` coverage, delivery experience check, specialist-fit lane decomposition, dependency boundaries, surface-to-agent map, and merge ownership
- **Auto-resolve**: when the scope matches the design contract and frozen request-fit basis with no unresolved design-level gap
- **Reopen/HOLD**: for destructive/security-sensitive actions or material scope expansion beyond the resolved design

## CP5 -- Gap Resolution Decision
- **Phase**: Analysis
- **Trigger**: reviewer or tester reports blocking defects or significant coverage gaps
- **Auto-resolve priority**:
  1. design-level gap -> Phase 2
  2. production-level gap -> Phase 5 with gap-to-correction-surface map
  3. no blocking gap, all frozen `SCOPE-BASELINE` features/surfaces/controls covered, and operator-delivery closure sufficient -> Final Acceptance Review for validator-required chains; workflow completion only after `FINAL-ACCEPT` or when no final-arbitration trigger applies
- **Reuse rule**: original CP3/CP4 remain valid only while the corrected design preserves the selected architecture family and implementation scope
- **Iteration continuation reuse**: bounded iteration reuse is allowed only while the active workflow phase, owner surface, and acceptance path stay unchanged
