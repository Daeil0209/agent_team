---
name: dev-workflow
description: Structured development workflow with phase gates, checkpoint resolution, iterative quality convergence, gap detection, and YAGNI review for development project orchestration.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Sharpens only its owned workflow surface.
- Fixed owner pattern:
  1. `Activation Criteria`
  2. `Workflow Core Law`
  3. Phase sections (Phase 0-5) in order
  4. Reference-owned workflow sections:
     - `Checkpoints`, `Phase Transition Gates`, `Artifact Convergence Advisory`, `Review Convergence Advisory`, `Final Acceptance Review`
     - `Context Anchor`, `Decision Record Chain`, `Lane Responsibility Map`, `Incident Response`, `Gap Detection And YAGNI Review`
  5. Local orchestration sections:
     - `Phase Cursor Consumption`, `Related Skills`, `Delivery Spine`, `Self-Growth And Structural Feedback`
- New top-level phase definitions require governance review.
- Keep exact phase names stable when referenced by doctrine or dispatch packets.
- Phase sections own only phase charter, owner, canonical output, and entry/exit law.
- Checkpoint detail, document templates, comparison tables, gap methodology, ambiguity-handling prompts, and operator-delivery edge cases belong to direct files under `references/`.
- New workflow rules must attach to an owning phase, checkpoint, gate, or local orchestration section.
### Reference Map
- Load direct files in `Reference-Owned Workflow Sections` when their triggers are active.
- Load triggered references directly.
- Governs team-lead orchestration across multi-phase development lifecycle.
- Lane dispatch retains task-execution evidence-bearing handoff discipline.
- Preserve named phase gates, lane-owned authoring, evidence-bearing handoff, and governed cross-lane communication.
## Activation Criteria
Enter only when `work-planning` freezes `ACTIVE-WORKFLOW: dev-workflow` and the current owner transfers control here.
Activation requires the frozen workflow route.

Activation requires evaluated Codex advisory trigger handling.
`CODEX-ADVISORY-BASIS` records trigger handling, adjudication, or fail-open truth, not Codex authority.
`work-planning` must freeze it as `triggered:*`, `fail-open:*`, or `skipped:no-material-advisory-trigger:<basis>`.
If it is missing, invalidly skipped, or skipped despite a material trigger, reopen `work-planning`.
Unchecked development routes reopen `work-planning`.

Field consumption detail stays with `.claude/skills/team-lead/references/planning-consume.md`.

`work-planning` selects this workflow when:
- a development request spans meaningful plan, design, implementation, and analysis phases
- spreadsheet/workbook/manual workflow conversion becomes software delivery work
- structured checkpoint resolution materially improves quality or staffing
Single-phase bounded tasks stay outside this workflow.
Governance, config, or hook edits are not excluded when the accepted deliverable requires a development lifecycle with discovery, implementation, review, test, or validation lanes.

## Workflow Core Law
### 1. Cursor And Owner Truth
- Phase authority follows the frozen owner map.
- team-lead owns the workflow cursor from activation until complete, explicit cancel, `HOLD`, or closeout transfer.
- A phase advances only through team-lead synthesis of the current phase surface.
- Checkpoints are checkpoint surfaces, not default stop points.
- team-lead auto-resolves checkpoints when the frozen basis is sufficient.
- Destructive/security-sensitive action, material ambiguity, or material architecture/risk/scope change forces `HOLD` and owner re-entry.

### 2. Phase Boundary Cycle
- Every new phase boundary or changed work-surface boundary runs one cycle: `work-planning -> execution/dispatch -> synthesis -> SV-RESULT -> exit law or correct owner`.
- A satisfied phase boundary is consumed in the same execution segment.
- Valid consumption is bounded execution, dispatch, `HOLD`/re-handoff, explicit blocker, or explicit cancel.
- Long convergence loops, status questions, and routine user-review offers preserve team-lead gate consumption.
- If a verified phase handoff fixes the next phase boundary, team-lead bridges directly.
- Reopen `work-planning` only when a boundary changes or becomes untrue.

### 3. Lane Separation And Parallel Flow
- Lane owners author their own bounded phase artifacts.
- Developer owns Phase 1 plan, Phase 2 design, and Phase 3 implementation.
- Review, proof, validation, routing, and acceptance stay with their owning lanes.
- Phase-local skill refinement stays inside the frozen lane map, deliverable shape, and proof/acceptance chain.
- Reopen `work-planning` when phase pressure creates a new lane, independent work surface, deliverable shape, or proof/acceptance owner.
- `session-boot` monitors delegated runtime; team-lead owns phase advancement, redistribution, and workflow re-entry.
- Serial waiting, merge backlog, stalled owner motion, or single-agent overload in nominal parallel work is a workflow bottleneck defect.

### 4. Convergence And Evidence
- Keep planning, dispatch, monitoring, synthesis, verification, and reporting gates active inside phase sequencing.
- Same-artifact convergence stays inside `artifact-convergence-advisory` while phase, artifact, owner map, deliverable, staffing, proof/acceptance chain, and user requirement are unchanged.
- Same-review-surface convergence stays inside `review-convergence-advisory` under the same unchanged-boundary rule.
- `task-execution` owns correction dispatch or reuse when another lane must revise.
- The artifact owner or producer owns correction or blocker reporting.
- Re-review returns to the same convergence loop after correction.

### 5. User-Surface Closure And Acceptance
- Executable user-facing software requires reviewer plus tester in Phase 4.
- Phase 4/5 evidence must close the whole frozen deliverable contract, not only the parts that already work.
- Half-delivered software is a blocking defect under `CLAUDE.md` `[USER-DELIVERY-FIT]`.
- Validator PASS opens Final Acceptance Review for validator-required chains.
- Low-risk bounded non-executable paths may report `verified result` only through the frozen acceptance path.
- Formal `PASS/HOLD/FAIL` requires validator.

## Phase 0: Discovery (Optional)
**Purpose**: Resolve missing requirements or reference-fit ambiguity before plan writing begins.
**Owner lane**: researcher
**Canonical output**: evidence-backed requirements summary for team-lead CP1 synthesis
**Entry law**: activate only when the request, reference, target users, constraints, or success criteria are still materially unclear
**Execution law**: discovery shape must be explicit: `single`, `lead-skim-then-shards`, or `immediate-shards`.
**Execution law**: lead skim stays boundary-only.
**Execution law**: once shard boundaries are explicit, dispatch shards immediately.
**Exit law**: only verified findings or labeled inferences enter CP1.
**Exit law**: implementation or design freeze requires its owning phase.
**Exit law**: discovery open questions default into Phase 1 configurable-parameter/assumption/open-question table.
**Exit law**: user escalation requires `work-planning`, Codex confirmation review, and team-lead-verified evidence of the smallest true user-owned blocker.
**Exit law**: missing labels or policies represented as settings, rule tables, or user-editable categories are modeled, not asked.
**Exit law**: user questions become CP1 open questions or a proven user-owned blocker with next owner.

## Phase 1: Plan
**Purpose**: Produce the canonical feature plan surface.
**Owner lane**: developer
**Canonical output**: `docs/01-plan/features/{feature}.plan.md` unless project config names another canonical path
**Entry law**: Phase 0 output, if activated, must already be synthesized enough for CP1. Otherwise the request-fit basis must be stable
**Execution law**: team-lead bridges only already-frozen plan-basis sections into the canonical plan path.
**Execution law**: developer remains the plan-writing owner.
**Execution law**: the canonical plan artifact is the plan surface.
**Exit law**: CP1 and CP2 are resolved.
**Exit law**: canonical plan artifact exists with frozen `SCOPE-BASELINE`.
**Exit law**: unresolved open questions are recorded explicitly.
**Exit law**: open questions that still change scope, risk posture, or delivery expectations cannot exit Phase 1; they reopen or `HOLD` through CP2.
**Exit law**: Phase 1 closure records YAGNI scope-review status as `complete` or `not-applicable:<basis>` with no unreviewed scope inflation.
**Exit law**: Phase 1 closes with a completed artifact-convergence-advisory record for the Phase 1 canonical plan artifact.
**Exit law**: The Phase 1 artifact-convergence record names the canonical plan artifact path, team-lead own-review basis, Codex advisory status, reconciliation result, accepted high/medium issue state, and next owner action.

## Phase 2: Design
**Purpose**: Produce bounded architecture options and freeze one selected design direction.
**Owner lane**: developer
**Canonical output**: `docs/02-design/features/{feature}.design.md` unless project config names another canonical path
**Entry law**: current canonical plan surface, CP1/CP2 outputs, and the Phase 1 closure record with completed artifact-convergence-advisory for the canonical plan artifact must already exist
**Execution law**: option count, design-surface requirements, and CP3 detail live in `references/phase-surfaces.md` and `references/checkpoints.md`.
**Execution law**: implementation planning starts after CP3 is resolved; production implementation starts only after Phase 2 exits and CP4 resolves.
**Execution law**: contract freeze prepares Phase 3/CP4 production-lane decomposition; it does not authorize implementation dispatch by itself.
**Execution law**: contract freeze covers shared source-of-truth, interface or format contracts, dependency boundaries, integration points, and error contracts.
**Execution law**: contract regions driving Phase 3 active parallel dispatch are fully frozen before that dispatch.
**Execution law**: vague regions outside Phase 3 active parallel dispatch are sequenced before later dependent dispatch.
**Execution law**: vague regions inside Phase 3 active parallel dispatch are design-time blockers, not downstream reviewer/validator burden.
**Execution law**: cross-surface drift after PASS-attempt returns to Phase 2 correction.
**Execution law**: missed-catch classification selects workflow repair, owner correction, or `Self-Growth Sequence`.
**Exit law**: design artifact is decision-bearing for frozen `SCOPE-BASELINE`.
**Exit law**: selected architecture is explicit.
**Exit law**: verification plan basis is recorded.
**Exit law**: Phase 2 closes with a completed artifact-convergence-advisory record for the Phase 2 design artifact or implementation-binding design bundle.
**Exit law**: The Phase 2 artifact-convergence record names the design artifact or bundle paths, team-lead own-review basis, Codex advisory status, reconciliation result, accepted high/medium issue state, implementation-binding status, and next owner action.

## Phase 3: Implementation
**Purpose**: Implement the feature inside the resolved design boundary.
**Owner lane**: developer
**Canonical output**: changed production surfaces plus an explicit developer handoff
**Entry law**: design artifact exists, CP3 is resolved, and CP4 implementation scope and lane decomposition are resolved
**Execution law**: CP4 fixes parallel-default production ownership with bounded specialist-fit work surfaces, explicit dependency boundaries, surface-to-agent map, and explicit merge ownership. If decomposition shows independent specialist-fit work surfaces, collapsing them onto one agent is a bottleneck defect.
**Exit law**: developer handoff names `OUTPUT-SURFACE`, changed surfaces, executed checks, `ACTIVE-SLICE`, `SCOPE-BASELINE` coverage or stale rows, `FROZEN-CONTRACT-STATUS`, unresolved assumptions, and the next owner lane. If parallel production occurred, phase advancement requires one authoritative integrated output surface routed forward from the frozen `MERGE-OWNER`.

## Phase 4: Analysis
**Purpose**: Execute planned review and proof, then classify gaps.
**Owner lanes**: reviewer + tester. Validator joins for verdict arbitration when required
**Canonical output**: reviewer and tester completion-grade evidence blocks, then validator verdict when the acceptance path requires it
**Entry law**: implementation handoff and the current plan/design surfaces carry explicit acceptance basis for reviewer and tester
**Execution law**: planned proof comes first, exploratory expansion second.
Reviewer and tester remain separate.
Deliverable-type tool mapping and gap methodology live in `references/phase-surfaces.md` and `references/gap-iteration.md`.
**Execution law**: proof tooling follows the decisive user surface, not the source artifact alone.
**Execution law**: executable web/UI proof uses the resolved browser interaction/control inventory through a frozen browser-proof path.
**Execution law**: tester applies `agents/tester.md` RPA-1 smallest truthful proof default.
**Execution law**: validator applies `agents/validator.md` RPA-1 highest-fidelity proof default.
**Execution law**: human-consumed artifacts require actual reader/operator surface proof through native-capable or format-faithful rendered/runtime path.
**Execution law**: acceptance closes through rendered/runtime surface when layout, pagination, formulas, interaction, or visible burden matter.
**Execution law**: missing decisive user-surface tooling freezes bounded setup through the appropriate owner or stops on `hold|blocker`.
**Execution law**: parallel production requires explicit cross-surface contextual coherence review.
**Execution law**: coherence review covers API fit, shared data shape, integration points, error handling, and computed-surface semantics.
**Execution law**: per-surface quality without cross-surface coherence is incomplete review.
**Execution law**: validator includes cross-surface integration verification before PASS.
**Execution law**: cross-surface drift after PASS opens CP5 correction and missed-catch classification.
**Execution law**: confirmed Phase 4 missed-catch process failure opens `Self-Growth Sequence` on the narrowest owner surface.
**Exit law**: either no blocking gaps remain after reconciling `ACTIVE-SLICE` evidence against `SCOPE-BASELINE`, or CP5 selects one next path.
**Exit law**: CP5 selects bounded design correction or implementation iteration.
**Exit law**: non-validator closure is limited to low-risk bounded non-executable paths and reports only `verified result`.

## Phase 5: Iteration
**Purpose**: Fix bounded gaps found in Phase 4 and re-verify the affected surfaces.
**Owner lanes**: developer correction -> reviewer evidence + tester proof -> validator when final acceptance is still required
**Canonical output**: bounded fix cycle evidence with explicit remaining gap state
**Entry law**: CP5 has already classified the remaining gap as implementation-level
**Execution law**: independent correction surfaces are split by correcting owner and run in parallel when lawful; integrated quick-check and re-verification follow the authoritative corrected output. Positive completion waits for re-verification
**Exit law**: blocking gaps are cleared against frozen `SCOPE-BASELINE` and validator PASS opens Final Acceptance Review.
**Exit law**: otherwise the workflow returns to Phase 4 or Phase 2 until the blocking gap converges, escalates by root cause, or reaches `HOLD`.
**Exit law**: executable user-facing completion also requires operator-delivery closure before `Complete`.
**Exit law**: launch, termination, clean re-launch, access, cleanup, artifact hygiene, or user-environment failure returns to Phase 5, Phase 2, or `work-planning` by root cause.

> Checkpoints, Phase Transition Gates, Context Anchor, Decision Record Chain, Lane Responsibility Map, Incident Response, and Gap Detection And YAGNI Review: see the direct files in `references/` named below.

## Reference-Owned Workflow Sections
Load triggered references directly from `SKILL.md`.
- `references/checkpoints.md`: CP1-CP5 trigger, auto-resolve, reopen/HOLD, and iteration reuse rules.
- `references/phase-surfaces.md`: phase artifact minimums, option counts, implementation-surface, and Phase 4 user-surface proof defaults.
- `references/phase-gates.md`: phase transition hard gates and cursor consumption law.
- `references/artifact-convergence-advisory.md`: Codex-assisted, advisory-only dual-review convergence for canonical plan/design artifacts and implementation-binding Phase 2 detail.
- `references/review-convergence-advisory.md`: Codex-assisted, reviewer-grade convergence for material Phase 4/5 reviewer-owned review surfaces.
- `references/final-acceptance-review.md`: team-lead+Codex final ACCEPT/REJECT gate for validator-required chains after validator PASS.
- `references/phase-micro-cycle.md`: repeated phase-local WP/SV/dispatch/monitor/synthesis/SV cycle.
- `references/context-decision-chain.md`: WHY/WHO/RISK/SUCCESS/SCOPE anchors and decision propagation.
- `references/lane-responsibility-map.md`: phase-to-lane responsibility and acceptance-chain map.
- `references/incident-response.md`: T0/T1 workflow incident response and launch-path failure rule.
- `references/gap-iteration.md`: YAGNI, gap dimensions, user-readiness proof, iteration convergence, and escalation.
- `references/operator-delivery.md`: executable deliverable launch/termination symmetry, operator OS coverage, demonstration data, and mental-model alignment.

Reference trigger rule:
- `references/phase-gates.md` is mandatory when clearing, contesting, or changing a phase entry, phase exit, transition gate, checkpoint gate, workflow completion, or workflow `HOLD`.
- `references/phase-micro-cycle.md` is mandatory when a same-phase iteration, redispatch, or phase-local convergence loop must be classified or resumed.
- `references/artifact-convergence-advisory.md` is mandatory when a canonical plan/design artifact is produced or materially revised and the next phase depends on it.
- `references/review-convergence-advisory.md` is mandatory when material reviewer-owned review drives Phase 4/5 advancement, validator ingress, redispatch, or completion truth.
- `references/final-acceptance-review.md` is mandatory when validator PASS is used for workflow `Complete`, or when `FINAL-REJECT` is recorded or consumed.
- Any other listed reference is mandatory when its trigger is active.
- If a mandatory reference cannot load, `HOLD` or reopen the owning path.
- Advancement requires loaded owner basis.

## Phase Cursor Consumption
At any satisfied phase boundary, resolve the phase cursor in the same execution segment.
Valid resolution: dispatch or execute the next phase, place the workflow on `HOLD` or re-handoff, record an explicit blocker, or explicitly cancel the next stage.
Completed transition starts the next phase or records the exact blocker.

A satisfied non-destructive/non-security/non-policy phase gate is consumed by team-lead, not user confirmation.

When team-lead advances to a new phase, send the canonical `phase-transition-control` packet from `.claude/skills/task-execution/references/phase-transition-control.md` to each affected agent.
Affected agents acknowledge with `control-ack`.
Use assignment-grade packets for new bounded work and lifecycle-control for lifecycle decisions.
If the same agent also receives new bounded work in that segment, carry the needed phase context inside the assignment-grade packet.
Expect the normal `dispatch-ack`.

Record every phase transition in workspace-root `.runtime/procedure-state.json`.
Phase-internal scaffolding stays in current-cycle internal context.
Continuity files record only owner-required state.

## Related Skills
- Architecture, design, and visible surfaces: `enterprise-architecture`, `design-system-tokens`, `mockup-to-component`, `visual-composition`.
- Human-consumed generation: `document-automation`, `instructional-design`.
- Review and proof refinement: `code-quality-review`, `security-review`, `log-based-qa`.
Related skills refine the current phase without changing lane, proof, or acceptance ownership.

## Delivery Spine
- Freeze the receiver surface before production inherits the contract.
- Carry `SCOPE-BASELINE`, user surface, proof path, and skill basis into downstream packets.
- Prove the artifact on the real run/read/operate/decide/learn/present surface.
- Treat retained artifacts as evidence only after the relevant defect classes are inspected.
- Keep acceptance fresh: correction after rejection returns through the owning review, proof, validation, and final-acceptance chain.

Executable launch, shutdown, operator-OS, demo-data, and mental-model detail lives in `references/operator-delivery.md`.

## Self-Growth And Structural Feedback
- Repeated skipped checkpoints, missing canonical phase artifacts, or repeated phase-cursor stalls are workflow hardening signals
- Repeated misclassification of design-vs-implementation gaps is a workflow-quality signal
- Repeated serial bottlenecks after decomposition, or repeated need for transition-only scouts, is a staffing/bridge design signal
