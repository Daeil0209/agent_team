---
name: dev-workflow
description: Structured development workflow with phase gates, checkpoint resolution, iterative quality convergence, gap detection, and YAGNI review for development project orchestration.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Fixed owner pattern:
  1. `Activation Criteria`
  2. Phase sections (Phase 0-5) in order
  3. Reference-owned workflow sections: `Checkpoints`, `Phase Transition Gates`, `Context Anchor`, `Decision Record Chain`, `Lane Responsibility Map`, `Incident Response`, `Gap Detection And YAGNI Review`
  4. Local orchestration sections: `Phase Transition Notification`, `Related Skills`, `Deliverable Quality Philosophy Application`, `Self-Growth And Structural Feedback`
- Do not add new top-level phase definitions without governance review.
- Keep exact phase names stable when referenced by doctrine or dispatch packets.
- Phase sections own only phase charter, owner, canonical output, and entry/exit law.
- Checkpoint detail, document templates, comparison tables, gap methodology, and ambiguity-handling prompts belong to `reference.md`.
- New workflow rules must attach to an owning phase, checkpoint, gate, or local orchestration section.
Governs how team-lead orchestrates researcher, developer, reviewer, tester, and validator lanes across a multi-phase development lifecycle with checkpoint resolution, bounded team-lead bridge writes, iterative quality convergence, and explicit phase gates. All lane dispatches retain evidence-bearing handoff discipline from task-execution. Do not reintroduce PDCA terminology, direct leader file editing as the default authoring path, automatic quality thresholds, or freeform cross-lane communication.
## Activation Criteria
Activated only when `work-planning` freezes `ACTIVE-WORKFLOW: dev-workflow` and the current owner transfers control here. `task-execution` validates the load state but does not activate this skill. This skill does not self-authorize from generic development shape, direct execution routing, or worker packets alone.

Workflow core law:
- Phase authority follows the frozen owner map. team-lead orchestrates and bridges; lane owners author their own bounded phase artifacts.
- In this workflow, the developer lane owns bounded development production artifacts: Phase 1 plan, Phase 2 design, and Phase 3 implementation. That workflow-local ownership does not grant developer review, proof, validation, routing, or acceptance authority.
- Checkpoints are checkpoint surfaces, not default stop points. team-lead auto-resolves them when the frozen basis is sufficient; unresolved destructive/security-sensitive action, material ambiguity, or material architecture/risk/scope change forces `HOLD` and owner re-entry instead.
- team-lead owns the active workflow cursor from activation until complete, explicit cancel, `HOLD`, or closeout transfer. A phase does not advance itself.
- A satisfied phase boundary must be consumed in the same execution segment by bounded execution, dispatch, `HOLD`/re-handoff, explicit blocker, or explicit cancel. Quiet waiting at a phase boundary is a management defect.
- Phase-local skill refinement is allowed only inside the already frozen lane map, deliverable shape, and proof/acceptance chain.
- If refinement or phase pressure would create a new lane, new independent work surface, new deliverable shape, or changed proof/acceptance owner, reopen `work-planning` rather than refining locally.
- If a verified phase handoff already fixes the next phase boundary, team-lead bridges directly instead of inserting a transition-only scout or rediscovery roundtrip.
- During delegated phases, `session-boot` monitors runtime and worker state, but phase advancement, redistribution, and workflow re-entry decisions remain with team-lead.
- Worker outputs do not advance the workflow by themselves. team-lead must synthesize the current phase surface and run the required verification gate before phase advancement, redispatch, or completion claims.
- Serial waiting, merge backlog, stalled owner motion, or single-worker overload in nominal parallel work is a workflow bottleneck defect. Reopen `work-planning` instead of pushing the active lane through it.
- Every active phase still runs the standard work cycle. For each bounded phase step: freeze the next lawful move through `work-planning`, verify it through `SV-PLAN`, execute or dispatch it, let `session-boot` observe delegated runtime when applicable, synthesize the returned phase surface, run `SV-RESULT`, then either clear the phase exit law or reopen the correct owner.
- `dev-workflow` never replaces the core procedure stack. It sequences repeated phase gates over the same planning, verification, dispatch, monitoring, synthesis, and reporting path.
- For executable, user-facing software deliverables, Phase 4 requires reviewer plus tester, and workflow completion requires validator PASS.
- Low-risk bounded paths may close through reviewer+tester as `verified result` without validator PASS when the frozen acceptance path stays non-executable and does not require formal validator arbitration.

Load when:
- a development request spans meaningful plan, design, implementation, and analysis phases
- spreadsheet/workbook/manual workflow conversion becomes software delivery work
- structured checkpoint resolution materially improves quality or staffing
Do not load for single-phase bounded tasks or governance-only edits.

## Phase 0: Discovery (Optional)
**Purpose**: Resolve missing requirements or reference-fit ambiguity before plan writing begins.
**Owner lane**: researcher
**Canonical output**: evidence-backed requirements summary for team-lead CP1 synthesis
**Entry law**: activate only when the request, reference, target users, constraints, or success criteria are still materially unclear
**Execution law**: discovery shape must be explicit: `single`, `lead-skim-then-shards`, or `immediate-shards`. Lead skim stays boundary-only; once shard boundaries are explicit, dispatch shards immediately.
**Exit law**: only verified findings or labeled inferences may enter CP1; discovery does not authorize implementation or design freeze

## Phase 1: Plan
**Purpose**: Produce the canonical feature plan surface.
**Owner lane**: developer
**Canonical output**: `docs/01-plan/features/{feature}.plan.md` unless project config names another canonical path
**Entry law**: Phase 0 output, if activated, must already be synthesized enough for CP1; otherwise the request-fit basis must already be stable
**Execution law**: team-lead may bridge already-frozen plan-basis sections into the canonical plan path, but developer remains the plan-writing owner; internal reasoning is never the canonical plan surface
**Exit law**: CP1 and CP2 resolved, canonical plan artifact exists, and unresolved open questions are recorded explicitly before design begins

## Phase 2: Design
**Purpose**: Produce bounded architecture options and freeze one selected design direction.
**Owner lane**: developer
**Canonical output**: `docs/02-design/features/{feature}.design.md` unless project config names another canonical path
**Entry law**: canonical plan surface and CP1/CP2 outputs must already exist
**Execution law**: option count, design-surface requirements, and CP3 selection detail live in `reference.md`; implementation may not start before CP3 is resolved
**Exit law**: design artifact exists, selected architecture is explicit, and the verification plan basis is recorded before implementation begins

## Phase 3: Implementation
**Purpose**: Implement the feature inside the resolved design boundary.
**Owner lane**: developer
**Canonical output**: changed implementation surfaces plus an explicit developer handoff
**Entry law**: design artifact exists, CP3 is resolved, and CP4 implementation scope and lane decomposition are resolved
**Execution law**: CP4 fixes serial vs parallel module ownership. If decomposition shows independent implementation surfaces, collapsing them onto one developer is a bottleneck defect.
**Exit law**: developer handoff names changed surfaces, executed checks, verification-plan coverage or stale rows, unresolved assumptions, and the next owner lane

## Phase 4: Analysis
**Purpose**: Execute planned review and proof, then classify gaps.
**Owner lanes**: reviewer + tester; validator joins for final acceptance when required
**Canonical output**: reviewer and tester completion-grade evidence blocks, then validator verdict when the acceptance path requires it
**Entry law**: implementation handoff and the current plan/design surfaces must already be explicit enough that reviewer and tester do not re-derive acceptance from memory
**Execution law**: planned proof comes first, exploratory expansion second. Reviewer and tester remain separate. Deliverable-type tool mapping and gap methodology live in `reference.md`.
**Execution law**: proof tooling follows the decisive user surface, not the source artifact alone. For executable web/UI deliverables, tester proof and validator-governed final acceptance must use the resolved browser interaction/control inventory through a frozen browser-proof path. Playwright CLI/MCP are preferred profiles when available or explicitly frozen, not the only lawful tools.
**Execution law**: for slides, word-processing documents, spreadsheets, PDFs, HWP/HWPX, or other human-consumed artifacts, tester and validator must prove the actual reader/operator surface through a native-capable or format-faithful rendered/runtime path. Extracted text, storage-level checks, or source-only inspection do not close user-surface acceptance when layout, pagination, formulas, interaction, or visible burden matter.
**Execution law**: if the current toolchain cannot truthfully exercise the decisive user surface, do not collapse to weaker evidence. Freeze one bounded tooling/setup path through the appropriate owner or stop on `hold|blocker`.
**Exit law**: either no blocking gaps remain and the acceptance chain closes, or CP5 selects one next path only: bounded design correction or implementation iteration
**Exit law**: reviewer+tester closure without validator is lawful only for low-risk bounded paths that remain non-executable, keep the same frozen acceptance chain, and end as `verified result` rather than formal `PASS/HOLD/FAIL`.

## Phase 5: Iteration
**Purpose**: Fix bounded gaps found in Phase 4 and re-verify the affected surfaces.
**Owner lanes**: developer -> reviewer -> tester -> validator when final acceptance is still required
**Canonical output**: bounded fix cycle evidence with explicit remaining gap state
**Entry law**: CP5 has already classified the remaining gap as implementation-level
**Execution law**: iteration order stays `developer fix -> reviewer quick-check -> tester re-verify`; no self-certification and no silent promotion back to complete
**Exit law**: blocking gaps are cleared and final acceptance closes, or the workflow returns to Phase 4/Phase 2 per the reference-owned cycle limits and re-entry rules

> Checkpoints, Phase Transition Gates, Context Anchor, Decision Record Chain, Lane Responsibility Map, Incident Response, and Gap Detection And YAGNI Review: see `reference.md`.

## Phase Transition Notification
At any satisfied phase boundary, the phase cursor must be resolved in the same execution segment: dispatch or execute the next phase, place the workflow on `HOLD` or re-handoff, record an explicit blocker, or explicitly cancel the next stage. Saying "next phase is ..." without starting it or recording the exact blocker is not a completed transition.

When team-lead advances to a new phase, send the canonical `phase-transition-control` packet from `.claude/skills/task-execution/reference.md` individually to each affected worker. Affected workers acknowledge with `control-ack`. `phase-transition-control` does not replace assignment-grade work packets or lifecycle control. If the same worker also receives new bounded work in that execution segment, do not send a separate standalone control packet; carry the needed phase context inside the assignment-grade packet and expect the normal `dispatch-ack`.

Record every phase transition in `./.runtime/procedure-state.json`. This is bounded checkpoint/continuity state, not production implementation or semantic governance editing. Phase-internal procedure scaffolding stays in internal context for the current cycle and is not mirrored to a continuity file by habit (per CLAUDE.md `## Communication`).

## Related Skills
- `enterprise-architecture`: Phase 2-4 architecture review when scale or boundary complexity warrants it
- `code-quality-review`: Phase 4 review refinement for implementation quality or duplication risk
- `log-based-qa`: Phase 4-5 proof path when log-based QA is the bounded truthful fallback
- `design-system-tokens`: Phase 2-3 UI/system token architecture
- `mockup-to-component`: Phase 2-3 mockup-to-component transition
- `security-review`: Phase 4 security-focused review when trust boundaries or privileged operations are in scope
These skills refine the current phase only. They do not create new lanes or override the frozen proof/acceptance chain.

## Deliverable Quality Philosophy Application
- **request fit and deliverable fit**: keep the real user problem and feature job explicit before phase work proceeds
- **Communication And Reporting Law**: every phase artifact must be usable by the next owner without re-derivation
- **[PLAN-SV]**: surface hidden dependency, rollback, and delivery-path constraints before they escape into late-phase blockers

## Self-Growth And Structural Feedback
- Repeated skipped checkpoints, missing canonical phase artifacts, or repeated phase-cursor stalls are workflow hardening signals
- Repeated misclassification of design-vs-implementation gaps is a workflow-quality signal
- Repeated serial bottlenecks after decomposition, or repeated need for transition-only scouts, is a staffing/bridge design signal
