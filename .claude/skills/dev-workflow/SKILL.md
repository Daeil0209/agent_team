---
name: dev-workflow
description: Run structured development workflow with phase gates, checkpoint resolution, iterative quality convergence, gap detection, and YAGNI review. Use when a development project needs phase-based orchestration from discovery through acceptance and iteration.
user-invocable: false
PRIMARY-OWNER: team-lead
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---
## Structural Contract
- Sharpens only its owned workflow surface.
- Fixed owner pattern:
  1. `Activation Criteria`
  2. `Workflow Core Law`
  3. Phase sections (Phase 0-5) in order
  4. Reference-owned workflow sections (active references in `references/`):
     - `Checkpoints`, `Phase Transition Gates`, `Phase Surfaces`, `Artifact Convergence Review`, `Review Convergence Review`, `Final Acceptance Review`, `Incident Response`, `Gap Iteration`, `Operator Delivery`
  5. Local orchestration sections:
     - `Resolve Next Owner And Action`, `Related Skills`, `Delivery Spine`, `Self-Growth And Structural Feedback`
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

Activation requires evaluated Codex MCP independent-review trigger handling.
`CODEX-INDEPENDENT-REVIEW-BASIS` records trigger handling, adjudication, or fail-open truth for that independent review; it does not grant Codex authority.
`work-planning` must freeze it as `triggered:*`, `fail-open:*`, or `skipped:no-material-codex-review-trigger:<basis>`.
If it is missing, invalidly skipped, or skipped despite a material trigger, reopen `work-planning`.
Unchecked development routes reopen `work-planning`.

Field consumption detail stays with `.claude/agents/team-lead/references/planning-field-consume.md`.

`work-planning` selects this workflow when:
- a development request spans meaningful plan, design, implementation, and analysis phases
- spreadsheet/workbook/manual workflow conversion becomes software delivery work
- structured checkpoint resolution materially improves quality or staffing
Single-phase bounded tasks stay outside this workflow.
Governance, config, or hook edits are not excluded when the accepted deliverable requires a development lifecycle with discovery, implementation, review, test, or validation lanes.

## Workflow Core Law
### 1. Cursor And Owner Truth
- Phase authority follows the frozen owner map; team-lead owns the workflow cursor from activation until complete, explicit cancel, `HOLD`, or closeout transfer.
- A phase advances only through team-lead synthesis of the current phase surface.
- Checkpoints follow `references/checkpoints.md`.
- Destructive/security-sensitive action, material ambiguity, or material architecture/risk/scope change forces `HOLD` and owner re-entry.

### 2. Phase Boundary Cycle
- Every new phase boundary or changed work-surface boundary runs one cycle: `work-planning -> execution/dispatch -> synthesis -> SV-RESULT -> exit law or correct owner`.
- Phase advancement, next-phase dispatch, CP escalation that consumes the current artifact, and phase-result reporting all share one precondition: team-lead consumes `references/phase-gates.md` plus every mandatory reference named by the active gate.
- A satisfied phase boundary is consumed in the same turn by executing or dispatching the next owner/action, `HOLD`/re-handoff, explicit blocker, or explicit cancel.
- Stall recognition (including user status questions) resumes by tool-call execution.
- Convergence loops, status questions, interrupts, rejection routes, and routine review offers continue through the next owner/action by tool-call execution.
- If a verified phase handoff or convergence record fixes the next phase boundary, team-lead bridges directly without user confirmation.
- Reopen `work-planning` only when a boundary changes or becomes untrue.

### 3. Lane Separation And Parallel Flow
- For Phase 1 (Plan) and Phase 2 (Design), team-lead solely owns planning, design, and canonical plan/design document authoring.
- Where the workflow names a separate phase owner and artifact producer, keep them separate.
- Phase owner consumes material specialist skills, freezes decisions, and cites basis.
- Assigned artifact producer writes from that frozen basis.
- Developer's dev-workflow lane begins at Phase 3 implementation.
- Review, proof, validation, routing, and acceptance stay with their owning lanes.
- Phase-local skill refinement stays inside the frozen lane map, deliverable shape, and proof/acceptance chain.
- Reopen `work-planning` when phase pressure creates a new lane, independent work surface, deliverable shape, or proof/acceptance owner.
- `session-boot` monitors delegated runtime; team-lead owns phase advancement, redistribution, and workflow re-entry.
- Serial waiting, merge backlog, stalled owner motion, or single-agent overload in nominal parallel work is a workflow bottleneck defect.

### 4. Convergence And Evidence
- Keep planning, dispatch, monitoring, synthesis, verification, and reporting gates active inside phase sequencing.
- Same-artifact convergence stays inside `artifact-convergence-review` while phase, artifact, owner map, deliverable, staffing, proof/acceptance chain, and user requirement are unchanged.
- Same-review-surface convergence stays inside `review-convergence-review` under the same unchanged-boundary rule.
- `task-execution` owns correction dispatch or reuse when another lane must revise.
- The phase owner owns integrated redesign planning and decision correction.
- For Phase 1/2 canonical artifacts, team-lead applies `REDESIGN-PLAN` edits directly to the canonical document.
- For Phase 3+ surfaces with a separate assigned producer, the producer updates the document from the redesign plan or reports a blocker.
- Re-review returns to the same convergence loop after correction.

### 5. User-Surface Closure And Acceptance
- Executable user-facing software requires reviewer plus tester in Phase 4.
- Phase 4/5 evidence closes the whole frozen deliverable contract per `CLAUDE.md` `[USER-DELIVERY-FIT]`, not only the parts that already work.
- Validator-required chains close through `references/final-acceptance-review.md`.
- Bounded non-executable paths with no final-arbitration trigger report only `verified result` through the frozen acceptance path.

## Phase 0: Discovery (Conditional)
**Purpose**: Resolve missing requirements or reference-fit ambiguity before plan writing begins.
**Owner lane**: researcher
**Canonical output**: evidence-backed requirements summary for team-lead CP1 synthesis
**Entry law**: activate only when the request, reference, target users, constraints, or success criteria are still materially unclear
**Execution law**: discovery shape per `references/phase-surfaces.md` Phase 0 Discovery Basis (`single` / `lead-boundary-read-then-shards` / `immediate-shards`).
**Exit law**: only verified findings or labeled inferences enter CP1.
**Exit law**: once verified discovery output exists, team-lead immediately opens the Phase 1 boundary through `work-planning` and uses the discovery output as the CP1 basis; a proven Phase 0 blocker records `HOLD` or next owner/action instead.
**Exit law**: implementation or design freeze requires its owning phase.
**Exit law**: discovery open questions default into Phase 1 configurable-parameter/assumption/open-question table.
**Exit law**: user escalation requires `work-planning`, Codex MCP independent-review handling when its trigger is material, and team-lead-verified evidence of the smallest true user-owned blocker.
**Exit law**: missing labels or policies represented as settings, rule tables, or user-editable categories are modeled, not asked.
**Exit law**: user questions become CP1 open questions or a proven user-owned blocker with next owner/action.

## Phase 1: Plan
**Purpose**: Produce the canonical feature plan surface.
**Owner lane**: team-lead
**Canonical output**: `docs/01-plan/features/{feature}.plan.md` unless project config names another canonical path
**Entry law**: Phase 0 output, if activated, must already be synthesized enough for CP1. Otherwise the request-fit basis must be stable
**Execution law**: team-lead Phase 1 execution:
- owns planning design, CP1/CP2, frozen `SCOPE-BASELINE`, open-question policy, YAGNI status, material specialist skill basis, canonical plan artifact direction, and canonical plan document authoring
- authors the canonical plan document directly from the frozen Phase 1 design basis
- receives accepted Codex or team-lead review findings through artifact-convergence and applies valid `REDESIGN-PLAN` edits directly to the canonical plan document
- treats the canonical plan artifact as the plan surface
**Exit law**: CP1 is resolved; CP2 either auto-resolves from the converged plan basis or surfaces only after artifact-level convergence when it consumes the canonical plan artifact.
**Exit law**: converged canonical plan artifact exists with frozen `SCOPE-BASELINE`; team-lead immediately opens the Phase 2 boundary through `work-planning` and uses the Phase 1 artifact as the design basis.
**Exit law**: unresolved open questions are recorded explicitly.
**Exit law**: open questions that still change scope, risk posture, or delivery expectations cannot exit Phase 1; they reopen or `HOLD` through CP2.
**Exit law**: Phase 1 closure records YAGNI scope-review status as `complete` or `not-applicable:<basis>` with no unreviewed scope inflation.
**Exit law**: Before CP2 is surfaced to the user from the canonical plan artifact, or before Phase 1 exits after CP2 auto-resolution, load and complete `references/artifact-convergence-review.md` only when the canonical plan artifact materially controls next-phase scope, risk, proof, acceptance, or downstream work; otherwise record `artifact-convergence: not-applicable:<low-risk/no-material-dependency basis>`.
**Exit law**: The Phase 1 artifact-convergence record is design-coherence level, not wording-review level or route-level `CODEX-INDEPENDENT-REVIEW-BASIS`; field schema is owned by `references/artifact-convergence-review.md` Output Record.

## Phase 2: Design
**Purpose**: Produce bounded architecture options and freeze one selected design direction.
**Owner lane**: team-lead
**Canonical output**: `docs/02-design/features/{feature}.design.md` unless project config names another canonical path
**Entry law**: converged Phase 1 canonical plan artifact, CP1/CP2 outputs, and the Phase 1 closure record with completed artifact-level convergence for the canonical plan artifact must already exist
**Execution law**: team-lead owns:
- the decision-level Phase 2 design basis and records it
- canonical design document authoring
**Execution law**: the design basis covers:
- selected direction, ER/data, interface/API/format, and UI/user-flow
- proof, acceptance, correction-readiness, launch/operator, implementation-binding internal detail bundle, and material specialist skill basis
**Execution law**: team-lead Phase 2 authorship:
- expands the frozen Phase 2 design basis directly into the required canonical design document structure
- keeps the decision basis operator-internal and decision-complete across the listed surfaces
- carries the expanded team-lead-authored body in the canonical design artifact
**Execution law**: accepted Codex or team-lead review findings return to team-lead redesign through artifact-convergence; team-lead applies valid `REDESIGN-PLAN` edits directly to the canonical design document.
**Execution law**: option count, design-surface requirements, and CP3 detail live in `references/phase-surfaces.md` and `references/checkpoints.md`.
**Execution law**: implementation planning starts after CP3 is resolved; production implementation starts only after Phase 2 exits and CP4 resolves.
**Execution law**: the internal detail bundle stays inside Phase 2 as implementation-binding detail and becomes CP4 translation input.
**Execution law**: internal detail bundle freeze:
- prepares Phase 3/CP4 production-lane decomposition; implementation dispatch waits for Phase 2 exit plus CP4 resolution
- covers real-use contracts, lane/surface responsibility, and shared source-of-truth
- covers interface or format contracts, dependency boundaries, and integration points
- covers error contracts, proof hooks, and return-evidence expectations
**Execution law**: internal detail bundle regions driving Phase 3 active parallel dispatch are fully frozen before that dispatch.
**Execution law**: vague regions:
- outside Phase 3 active parallel dispatch are sequenced before later dependent dispatch
- inside Phase 3 active parallel dispatch are design-time blockers, not downstream reviewer/validator burden
**Execution law**: cross-surface drift after PASS-attempt returns to Phase 2 correction.
**Execution law**: missed-catch classification selects workflow repair, owner correction, or `Self-Growth Sequence`.
**Exit law**: design artifact is decision-bearing for frozen `SCOPE-BASELINE`.
**Exit law**: selected architecture is explicit.
**Exit law**: verification and correction-readiness basis is recorded.
**Exit law**: Phase 2 closure:
- closes only when the artifact-convergence-review record for the Phase 2 design artifact or implementation-binding internal detail bundle is complete
- once satisfied, team-lead immediately opens the Phase 3 boundary through `work-planning`
**Exit law**: Phase 2 outputs:
- the internal detail bundle is the CP4 basis
- the artifact-convergence record:
  - is design-coherence level
  - is not wording-review level or route-level `CODEX-INDEPENDENT-REVIEW-BASIS`
**Exit law**: field schema:
- is owned by `references/artifact-convergence-review.md` Output Record
- includes internal detail bundle status and material specialist contract status when specialist output shapes implementation, proof, or acceptance

## Phase 3: Implementation
**Purpose**: Implement the feature inside the resolved design boundary.
**Owner lane**: developer
**Canonical output**: changed production surfaces plus an explicit developer handoff
**Entry law**: Phase 2 closure record exists, CP3 is resolved, and team-lead CP4 translates the Phase 2 implementation-binding internal detail bundle into implementation scope and lane decomposition.
**Execution law**: team-lead CP4 fixes parallel-default production ownership with bounded specialist-fit work surfaces, explicit dependency boundaries, surface-to-agent map, and explicit merge ownership.
**Execution law**: every independent, nonblocked CP4 surface whose needed input is already present in the Phase 2 implementation-binding internal detail bundle enters the first parallel dispatch segment.
**Execution law**: later dispatch segments are valid only for surfaces classified sequential or interdependent by the frozen parallel-fit basis, with exact dependency or interdependence recorded.
**Exit law**: developer handoff names:
- `OUTPUT-SURFACE`, changed surfaces, executed checks, `ACTIVE-SLICE`, and `SCOPE-BASELINE` coverage or stale rows
- `FROZEN-CONTRACT-STATUS`, unresolved assumptions, and the next owner/action
**Exit law**: if parallel production occurred, one authoritative integrated output surface from the frozen `MERGE-OWNER` is required before advancement.
**Exit law**: once the Phase 3 gate is satisfied, team-lead immediately opens the Phase 4 boundary through `work-planning` and routes reviewer, tester, and validator ingress from the frozen acceptance path.

## Phase 4: Analysis
**Purpose**: Execute planned review/proof and map gaps onto the Phase-2-derived correction contract needed for final user-surface acceptance.
**Owner lanes**: reviewer + tester. Validator joins for verdict arbitration when required
**Canonical output**: reviewer and tester completion-grade evidence blocks, then validator verdict when the acceptance path requires it
**Entry law**: implementation handoff and the current plan/design surfaces carry explicit acceptance basis for reviewer and tester.
**Execution law**: reviewer and tester remain separate; planned proof comes first, exploratory expansion second.
**Execution law**: proof tooling follows the decisive user surface per `references/phase-surfaces.md` Phase 4.
**Execution law**: tester applies smallest truthful proof default per `agents/tester.md`.
**Execution law**: validator applies highest-fidelity proof default per `agents/validator.md`.
**Execution law**: missing decisive user-surface tooling freezes bounded setup or stops on `hold|blocker`.
**Execution law**: parallel production requires explicit cross-surface contextual coherence review.
**Execution law**: cross-surface contextual coherence review covers API fit, runtime data shape, shared source-of-truth, integration points, error handling, computed-surface semantics, and `CORE-WORKFLOW-CLOSURE` end-to-end coverage.
**Execution law**: validator cross-surface integration verification is required before PASS.
**Execution law**: per-surface quality without cross-surface coherence is incomplete review.
**Execution law**: cross-surface drift after PASS opens CP5 correction and missed-catch classification; confirmed Phase 4 missed-catch process failure opens `Self-Growth Sequence` on the narrowest owner surface.
**Exit law**: CP5 routing — design-level/implementation/operator-delivery/route/scope/HOLD priorities — is owned by `references/checkpoints.md` `## CP5 -- Gap Resolution Decision` Auto-resolve priority. Apply that priority list before dispatch.
**Exit law**: correction paths derive the acceptance-grade correction contract from the frozen Phase 2 design basis, Phase 4 evidence, or `FINAL-REJECT` packet before dispatch.
**Exit law**: once CP5 selects a non-`HOLD` path, team-lead executes the selected next owner/action in the same execution segment; Phase 5 consumes the CP5 correction contract, not raw finding lists.
**Exit law**: non-validator closure is limited to bounded non-executable paths with no final-arbitration trigger and reports only `verified result`.

## Phase 5: Iteration
**Purpose**: Fix CP5-contracted gaps until corrected output is usable on the decisive user surface, then re-verify affected and stale acceptance surfaces.
**Owner lanes**: correcting owner named by CP5 or validator-authored `FINAL-REJECT` packet -> reviewer/tester re-evidence as required -> validator when final acceptance is still required
**Canonical output**: corrected-output evidence, re-review/re-proof evidence, validator verdict input, and explicit remaining gap state
**Entry law**: CP5 or validator-authored `FINAL-REJECT` correction packet has classified the remaining gap as implementation or operator-delivery.
**Entry law**: that classification must stay inside the unchanged Phase 1/2 delivery contract.
**Entry law**: design-level, scope, owner-map, route, proof-chain, or acceptance-chain changes route to Phase 2 or `work-planning` before Phase 5.
**Execution law**: Phase 5 iteration protocol per `references/gap-iteration.md` `Iteration Protocol Detail`; positive completion waits for re-verification against the CP5 correction contract and frozen acceptance basis.
**Exit law**: CP5 gap state routes as follows:
- cleared CP5-contracted blocking gaps against frozen `SCOPE-BASELINE` with required user-surface evidence let validator PASS immediately open Final Acceptance Review
- remaining blocking gaps make team-lead immediately return the workflow to the current root-cause owner
**Exit law**: valid return owners are Phase 4 review/proof, Phase 2 design correction, Phase 5 correction, or `work-planning`.
**Exit law**: the gap remains active until it converges, escalates, or reaches `HOLD`.
**Exit law**: executable user-facing deliverables require operator-delivery closure before `FINAL-ACCEPT` and `Complete`; missing, broken, unverified, or mismatched operator-delivery closure becomes `FINAL-REJECT`.
**Exit law**: launch, termination, clean re-launch, access, cleanup, artifact hygiene, or user-environment failure returns to Phase 5, Phase 2, or `work-planning` by root cause.

## Reference-Owned Workflow Sections
Load triggered references directly from `SKILL.md`.
- `references/checkpoints.md`: CP1-CP5 trigger, auto-resolve, reopen/HOLD, and iteration reuse rules.
- `references/phase-surfaces.md`: phase artifact minimums, option counts, implementation-surface, and Phase 4 user-surface proof defaults.
- `references/phase-gates.md`: phase transition hard gates and cursor consumption law.
- `references/artifact-convergence-review.md`: Codex MCP independent-review assisted dual-review convergence for canonical plan/design artifacts and implementation-binding Phase 2 detail; Codex remains non-authoritative.
- `references/review-convergence-review.md`: Codex MCP independent-review assisted reviewer-grade convergence for material Phase 4/5 reviewer-owned review surfaces; Codex remains non-authoritative.
- `references/final-acceptance-review.md`: team-lead closure reconciliation with Codex MCP independent-review support for validator-required chains after validator PASS; validator retains final `PASS/HOLD/FAIL` authority.
- `references/incident-response.md`: T0/T1 workflow incident response and launch-path failure rule.
- `references/gap-iteration.md`: YAGNI, gap dimensions, user-readiness proof, iteration convergence, and escalation.
- `references/operator-delivery.md`: executable deliverable launch/termination symmetry, operator OS coverage, demonstration data, and mental-model alignment.

Reference trigger rule:
- `references/phase-gates.md` is mandatory when clearing, contesting, or changing a phase entry, phase exit, transition gate, checkpoint gate, workflow completion, or workflow `HOLD`.
- `references/artifact-convergence-review.md` is mandatory when a canonical plan/design artifact is produced or materially revised and the next phase materially depends on it for scope, risk, architecture, proof, acceptance, or downstream work; low-risk/no-new-decision artifacts record `not-applicable:<basis>`.
- `references/review-convergence-review.md` is mandatory when material reviewer-owned review determines Phase 4/5 advancement, validator ingress, redispatch, or completion truth.
- `references/final-acceptance-review.md` is mandatory when validator PASS is used for workflow `Complete`, or when `FINAL-REJECT` is recorded or consumed.
- Any other listed reference is mandatory when its trigger is active.
- If a mandatory reference cannot load, `HOLD` or reopen the owning path.
- Advancement requires loaded owner basis.
- A missing mandatory convergence record opens the named convergence reference; it does not advance through CP, phase dispatch, phase-result reporting, or user review.

## Resolve Next Owner And Action
Resolve the phase cursor in the same turn by tool-call execution: dispatch or execute the next phase, place the workflow on `HOLD` or re-handoff, record an explicit blocker, or explicitly cancel the next stage.
Completed transition starts the next phase or records the exact blocker.

A satisfied non-destructive/non-security/non-operator-policy-choice phase gate is consumed by team-lead, not user confirmation.

When team-lead advances to a new phase, send the canonical `phase-transition-control` packet from `.claude/skills/task-execution/references/phase-transition-control.md` to each affected agent.
Affected agents acknowledge with `control-ack`.
Use assignment-grade packets for new bounded work and lifecycle-control for lifecycle decisions.
If the same agent also receives new bounded work in that segment, carry the needed phase context inside the assignment-grade packet.
Expect the normal `dispatch-ack`.

Record every phase transition in workspace-root `.runtime/procedure-state.json`.
Phase-internal scaffolding stays in current-cycle internal context.
Continuity files record only owner-required state.

## Related Skills
- Related skill selection is owned by `work-planning` trigger fields, lane-detail specialist matrices, and lawful phase-local refinement.
- `dev-workflow` consumes material specialist outputs as phase contract inputs; complete skill catalog ownership stays with the owning skill surfaces.
- Related skills refine the current phase without changing lane, proof, or acceptance ownership.

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
