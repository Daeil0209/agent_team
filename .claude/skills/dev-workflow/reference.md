# Reference Material
## Checkpoints
Checkpoint policy. CP1-CP5 are checkpoint surfaces, not default stop points. team-lead resolves checkpoints autonomously when the frozen request-fit basis and available evidence are sufficient. Destructive/security-sensitive action, material ambiguity, or material architecture/risk/scope change does not create a choice prompt here; it forces `HOLD` and re-entry through the owning path. CP5 is auto-resolved in normal gap flow; T0/T1 gaps follow Incident Response.

### CP1 -- Plan Confirmation
- **Phase**: Plan, before the canonical plan surface is finalized
- **Trigger**: problem understanding and request-fit basis are synthesized
- **Present**: problem, scope boundaries, constraints, delivery experience, acceptance evidence basis, and lightweight verification strategy basis; if a reference exists, also present adopted/adapted/rejected reference fit
- **Auto-resolve**: when the request-fit basis and available evidence make the plan basis clear
- **Reopen/HOLD**: when reference interpretation or core plan basis remains materially ambiguous

### CP2 -- Ambiguity Resolution
- **Phase**: Plan, after the plan draft exists
- **Trigger**: open design or integration questions remain
- **Present**: only the unresolved questions that still change scope, risk posture, or delivery expectations
- **Auto-resolve**: when the answer is still bounded by the request-fit basis and existing evidence
- **Reopen/HOLD**: when bounded inference no longer preserves scope, risk posture, or delivery expectations

### CP3 -- Architecture Selection
- **Phase**: Design
- **Trigger**: architecture options are produced
- **Present**: explicit options plus their verification, delivery, and implementation implications
- **Default path**: team-lead auto-resolution, usually from the pragmatic option with bounded supplementation
- **Reopen/HOLD**: when supplementation would materially change architecture family, risk posture, or implementation scope

### CP4 -- Implementation Scope Resolution
- **Phase**: Implementation, before any implementation begins
- **Trigger**: design is resolved and the implementation scope summary is available
- **Present**: files to create/modify, out-of-scope items, risk points, delivery experience check, and lane decomposition
- **Auto-resolve**: when the scope matches the design doc and the frozen request-fit basis
- **Reopen/HOLD**: for destructive/security-sensitive actions or material scope expansion beyond the resolved design

### CP5 -- Gap Resolution Decision
- **Phase**: Analysis
- **Trigger**: reviewer or tester reports blocking defects or significant coverage gaps
- **Auto-resolve priority**:
  1. design-level gap -> Phase 2
  2. implementation-level gap -> Phase 5
  3. no blocking gap and coverage sufficient -> final acceptance or workflow completion
- **Reuse rule**: original CP3/CP4 remain valid only while the corrected design preserves the selected architecture family and implementation scope
- **Iteration continuation reuse**: bounded iteration reuse is allowed only while the active workflow phase, owner surface, and acceptance path stay unchanged

## Phase Surfaces
### Phase 0 Discovery Basis
- Discovery shape must be explicit: `single`, `lead-skim-then-shards`, or `immediate-shards`
- `lead-skim-then-shards` exists only to reach boundary sufficiency; once shard boundaries are explicit, dispatch interpretive shards immediately
- Discovery output must separate: what the reference is, what the user wants from it, and what is adopted/adapted/rejected before planning begins
- Discovery does not authorize implementation dispatch or design freeze

### Phase 1 Canonical Plan Surface
- Canonical output path: `docs/01-plan/features/{feature}.plan.md` unless project config states otherwise
- The canonical plan surface, not internal reasoning, closes Phase 1
- Minimum canonical contents:
  - verbatim `USER-INSTRUCTION`
  - executive summary
  - WHY / WHO / RISK / SUCCESS / SCOPE / DELIVERY
  - Reference Fit Summary when a reference exists
  - Acceptance Evidence Basis
  - Verification Strategy Basis
  - explicit Open Questions
- team-lead may materialize already-frozen bridge sections into the canonical plan path before developer authors the remaining plan body

### Phase 2 Design Surface
- Canonical output path: `docs/02-design/features/{feature}.design.md` unless project config states otherwise
- Design options count scales by project tier: Lightweight 1, Standard 2, Precision 3
- Minimum design contents:
  - inherited `USER-INSTRUCTION`
  - selected option and rationale
  - component and responsibility map
  - API/data flow/dependency surface
  - Verification Plan derived from the plan's proof basis
- For executable, user-facing software deliverables, design must preserve delivery path, shutdown path, infrastructure exposure policy, and the control inventory needed for tester browser-proof first-pass proof and validator browser-proof final acceptance

### Phase 3 Implementation Surface
- Implementation may not start before CP4 is resolved
- CP4 scope summary must make lane decomposition explicit: serial prerequisites, parallel-eligible modules, module-to-worker map, merge ownership
- If decomposition shows independent implementation surfaces, serializing them onto one developer is a bottleneck defect
- Developer handoff must include changed surfaces, executed checks, and row-mapped Verification Plan coverage/delta so downstream proof does not re-derive stale acceptance

### Phase 4 Analysis And Acceptance
- Reviewer and tester are both mandatory analysis owners for executable, user-facing software
- Reviewer packet must evaluate design conformance, blocking defect classification, delivery experience, and user-readiness on the declared acceptance surface
- Tester packet must execute the planned proof surface, not a narrowed substitute
- For web/UI deliverables:
  - tester proof path = frozen browser-proof path on the browser interaction surface; Playwright CLI is the preferred fast profile when available or explicitly frozen
  - validator final acceptance path = browser-proof confirmation on the same resolved interaction/control inventory; Playwright MCP is the preferred precise profile when available or explicitly frozen
- Reviewer + tester no-gap is necessary but not sufficient when validator-governed acceptance is required

### Phase 5 Iteration Limits
- Iteration order is fixed: developer fix -> reviewer quick-check -> tester re-verify
- No self-certification inside iteration
- Maximum 5 iteration cycles per Phase 5 entry
- Maximum 2 Phase 4 re-entries per resolution cycle; recurring same gap class beyond that forces explicit `HOLD`/replan or Incident Response
- Iteration resets only after genuine re-analysis, not by habit

## Phase Transition Gates
Hard gates verified by team-lead before phase advancement or dispatch.

| Transition | Gate Condition |
|---|---|
| Phase 0 -> Phase 1 | discovery output synthesized and verified enough for CP1 |
| Phase 1 -> Phase 2 | canonical plan surface exists; CP1 + CP2 resolved |
| Phase 2 -> Phase 3 | design artifact exists; CP3 resolved |
| Phase 3 start | CP4 scope and lane decomposition resolved |
| Phase 3 -> Phase 4 | developer handoff includes changed surfaces, checks, and verification-plan delta |
| Phase 4 -> Phase 2 | CP5 classifies at least one blocking gap as design-level |
| Phase 4 -> Phase 5 | CP5 classifies blocking or significant coverage gap as implementation-level |
| Phase 4/5 -> Complete | no blocking gaps remain, coverage is sufficient, and validator PASS exists when required |

Additional gate law:
- Phase advancement requires completion-grade evidence, not artifact existence alone
- Phase cursor remains active until consumed by execute, dispatch, HOLD/re-handoff, explicit blocker, or explicit cancel
- When a verified handoff already fixes the next phase boundary, team-lead is the default bridge owner
- Material delivery-surface change supersedes prior reviewer/tester/validator acceptance evidence

## Phase Micro-Cycle
Within every active phase, use the same core procedure stack rather than inventing a workflow-local shortcut.
1. `work-planning` freezes the next bounded phase move
2. `SV-PLAN` verifies that move
3. the phase owner executes it directly or routes it through `task-execution`
4. delegated runtime is observed through `session-boot` when workers are active
5. completion-grade outputs return to team-lead
6. team-lead synthesizes the phase surface
7. `SV-RESULT` verifies the synthesized phase result
8. either the phase exit law clears, or the workflow reopens the correct owner/phase

`dev-workflow` adds phase order, checkpoint law, and iteration limits. It does not replace the standard planning, verification, dispatch, monitoring, synthesis, or reporting obligations.

## Context Anchor
Every downstream phase artifact and packet must preserve:
- `WHY`
- `WHO`
- `RISK`
- `SUCCESS`
- `SCOPE`

These anchors prevent downstream re-derivation and phase drift. If a downstream artifact cannot be traced back to WHY and SCOPE, the context anchor is broken and phase advancement should HOLD.

## Decision Record Chain
Decisions propagate forward:
- discovery -> plan -> design -> implementation -> report

At minimum, downstream artifacts must preserve:
- architecture selection and any bounded supplementation
- CP2 scope decisions
- delivery experience commitments
- CP5 gap-resolution direction when relevant
- reference adoption/adaptation decisions when a reference informed planning

Downstream silent override of an upstream decision is prohibited.

## Lane Responsibility Map
| Phase | team-lead | researcher | developer | reviewer | tester | validator |
|---|---|---|---|---|---|---|
| 0 Discovery | orchestrate, synthesize | evidence gathering | -- | -- | -- | -- |
| 1 Plan | CP1/CP2, gate check | support if gaps remain | write plan surface | -- | -- | -- |
| 2 Design | CP3, gate check | -- | write design surface | -- | -- | -- |
| 3 Implementation | CP4, gate check, monitor | -- | implement per design | -- | -- | -- |
| 4 Analysis | CP5, gap judgment | -- | provide handoff context | review and gap classification | proof and coverage | final acceptance when required |
| 5 Iteration | cycle tracking, auto-resolution | -- | apply fixes | quick-check | re-verify | final acceptance when still required |

Acceptance chain:
- reviewer -> tester -> validator
- executable, user-facing software enters validator path by default through task-execution routing

## Incident Response
Use Incident Response when T0/T1 severity appears.
- Detect and classify
- Analyze impact and blast radius
- Propose bounded fix plus verification path
- Apply fix and resume the correct workflow phase
- Record what failed and what recurrence barrier should be hardened

User-reported first-view or launch-path failure is blocking until reproduced or disproven on the intended user surface.

## Gap Detection And YAGNI Review
### YAGNI Scope Review
- Runs in Phase 1 before CP2
- Classify proposed features/components as MUST / SHOULD / COULD / WON'T
- Remove COULD and WON'T from current scope
- Record removed items as future consideration

### Gap Detection Dimensions
Phase 4 gap detection should separate:
- structural gaps
- functional gaps
- contract gaps
- delivery experience gaps
- user-readiness gaps

Blocking gaps are not just missing components. Missing proof on the required user surface is independently blocking.

### User-Readiness Principle
- verify the real launch/start path
- verify core workflows and all in-scope user-visible controls
- verify persistence/restart/error handling when in scope
- keep tester proof surface and validator acceptance surface aligned to the same resolved interaction/control inventory

### Iteration Protocol Detail
- reviewer quick-check stays blocking-only
- tester re-verifies affected surfaces first, then any stale interaction rows
- same unresolved blocking gap class after repeated cycles must escalate rather than loop indefinitely

### Gap Detection Self-Growth
- repeated missed gaps
- repeated YAGNI failure
- repeated phase drift
- repeated bottlenecking after decomposition
all count as workflow hardening signals for team-lead
