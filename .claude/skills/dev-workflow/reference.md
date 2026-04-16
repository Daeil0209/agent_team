# Reference Material

## Interactive Checkpoints

Checkpoint policy. CP1-CP4 are checkpoint surfaces, not automatic user-stop points. In this repository, team-lead resolves checkpoints autonomously when the user's directive and available evidence are sufficient. Escalate to the user only when the checkpoint exposes material ambiguity, destructive or security-sensitive action, or a material change in architecture, risk posture, or implementation scope. CP5 is auto-resolved by team-lead in normal gap-resolution flow; T0/T1 severity gaps follow the incident-response workflow instead.

_**Korean escalation prompts** below are locale-specific examples for Korean-language deployments. Adapt to the project's operating language._

### CP1 -- Plan Confirmation
**Phase**: Plan (before plan doc finalized) | **Trigger**: problem understanding synthesized
**Present**: Problem being solved; scope boundaries; known constraints; delivery experience. When the user supplied a reference, also present: the user's requested outcome, the key elements observed from the reference, what will be adopted, what will be adapted, and what will not be adopted.
**Korean escalation prompt**: "현재 요구사항 해석에 결정이 필요한 불명확점이 있습니다. 아래 항목만 확인해주세요."
When a reference was supplied, use instead: "레퍼런스 반영 방향에서 결정이 필요한 불명확점이 있습니다. 아래 항목만 확인해주세요."
**Required action**: Resolve or correct the plan basis. Team-lead should auto-resolve when the user's directive and available evidence make the basis clear. Escalate to the user only when material ambiguity remains. When a reference was supplied, any escalation must cover both (1) whether the reference was understood correctly and (2) whether the planned interpretation of that reference matches the user's actual request. If corrected, revise the plan basis before continuing.

### CP2 -- Ambiguity Resolution
**Phase**: Plan (after plan doc draft) | **Trigger**: open questions surfaced
**Present**: Edge cases; integration/compatibility questions; missing information blocking clean design. When a reference was supplied, include only the adaptation questions that remain unresolved after CP1 reference-fit confirmation.
**Korean escalation prompt**: "아래 항목은 자동으로 확정하면 범위나 위험이 바뀔 수 있습니다. 필요한 결정만 확인해주세요."
**Required action**: Resolve each open question or explicitly defer. Auto-resolve questions when bounded by the user's directive and available evidence. Escalate to the user only for material ambiguity or a real choice that would change scope, risk posture, or delivery expectations. Record answers in the plan doc before Phase 2 begins.

### CP3 -- Architecture Selection
**Phase**: Design (after design options generated) | **Trigger**: Minimal/Clean/Pragmatic options produced
**Present**: Full comparison table (see Phase 2 format)
**Korean escalation prompt**: "설계 방향이 실제로 갈릴 수 있어 결정이 필요합니다. 아래 옵션 중 하나를 선택해주세요. 추천안은 Pragmatic입니다."
**Required action**: Select one option; record selection and basis in the design doc before advancing.
**Default path**: Team-lead auto-resolution.
**Auto-resolution**: Base on `Pragmatic`. Compare against the user's original requirements and clarified constraints from CP1/CP2. If `Pragmatic` sufficiently covers them, select `Pragmatic`. If bounded supplementation is needed, team-lead may add specific implementation or design requests derived from `Minimal` or `Clean` while keeping `Pragmatic` as the selected architecture. Such supplementation may refine the selected `Pragmatic` option, but must not change the architecture family, resolved risk posture, or expected implementation scope. If supplementation would materially change those, rerun the affected checkpoint or escalate to user.
**Escalate to user when**: gaps cannot be covered by bounded supplementation; the architecture direction would fundamentally change; expected implementation scope would materially expand; risk posture would materially change; or confidence is low.
**Notification**: When auto-resolved, report the selected option, any bounded supplements, and the reason in one concise message. Do not proceed silently.

### CP4 -- Implementation Scope Resolution
**Phase**: Implementation (before any implementation begins) | **Trigger**: scope summary prepared from design doc
**Present**: Files to create/modify; estimated change volume; out-of-scope items; risk points; delivery experience
**Korean escalation prompt**: "현재 범위를 넘는 변경이 필요합니다. 아래 확장/위험 항목에 대한 결정이 필요합니다."
**Required action**: Implementation may begin autonomously when the scope matches the design doc and the user's task-level directive. If the user modifies scope, update the design doc and re-present the summary. Destructive actions, security-sensitive actions, or scope expansion beyond the resolved design still require explicit user confirmation.

### CP5 -- Gap Resolution Decision
**Phase**: Analysis (if gaps found) | **Trigger**: reviewer or tester reports blocking defects or significant coverage gaps
**Present**: Gap list with severity classification; blocking vs non-blocking from reviewer; coverage signal from tester
**Auto-resolution**: team-lead compares gaps against the user's original requirements and clarified constraints from CP1/CP2, then determines one next path only. Apply this priority order:
1. If any blocking gap is design-level, transition to Phase 2 for bounded design correction.
2. Else if any blocking gap or significant coverage gap is implementation-level, transition to Phase 5 with explicit fix direction and iteration counter reset to 1.
3. Else, if no blocking gaps remain and coverage is sufficient, proceed to final acceptance, then workflow completion.
Design-level means the resolved design no longer satisfies the original requirements or clarified constraints. Implementation-level means the resolved design remains valid, but the produced implementation does not satisfy it.
**Checkpoint reuse rule**: Original CP3/CP4 resolutions remain valid only when the corrected design preserves the selected architecture family and stays within the previously resolved implementation scope. Otherwise rerun the affected checkpoint(s) before implementation resumes.
**Incident exception**: T0/T1 severity gaps do not follow normal CP5 auto-resolution. Route them through Incident Response immediately.
**Notification**: When auto-resolved, report the gap summary, mismatch analysis against CP1/CP2, chosen next path, and fix direction. Do not proceed silently.

**Autonomy rule**: If the user says "전부 자동으로" or equivalent, treat that as an explicit instruction to minimize mid-task user interruption. Continue using checkpoint auto-resolution wherever the checkpoint criteria are satisfied, report concise checkpoint results instead of asking for approval, and interrupt the user only for destructive, security-sensitive, or materially scope-changing decisions.

**Auto-resolution vs destructive escalation**: Checkpoint auto-resolution is team-lead exercising delegated authority under specific conditions. It does not waive destructive or security-sensitive safeguards.

---

## Phase Transition Gates

Hard gates verified by team-lead before dispatching any lane. Dispatching before gate conditions are met is a workflow governance failure.

| Transition               | Gate Condition                                                                 |
|--------------------------|--------------------------------------------------------------------------------|
| Phase 0 -> Phase 1       | Discovery output delivered to team-lead (if Phase 0 activated)                 |
| Phase 1 -> Phase 2       | Plan doc exists at docs/01-plan/features/{feature}.plan.md; CP1 + CP2 done     |
| Phase 2 -> Phase 3       | Design doc exists at docs/02-design/features/{feature}.design.md; CP3 resolved |
| Phase 3 start            | CP4 scope resolved; design doc confirmed as prerequisite                       |
| Phase 3 -> Phase 4       | Developer explicit handoff received with changed file list and executed checks  |
| Phase 4 -> Phase 2       | CP5 resolved: at least one blocking gap is design-level                        |
| Phase 4 -> Phase 5       | CP5 resolved: blocking gap or significant coverage gap is implementation-level |
| Phase 4 -> Complete      | No blocking gaps remain and coverage is sufficient; for executable, user-facing software deliverables, validator PASS is also required |
| Phase 5 -> Phase 4       | Iteration fixes applied; reviewer quick-check complete; tester re-verification complete |
| Phase 5 -> Phase 2       | team-lead judges remaining blocking gaps or significant coverage gaps require design-level correction |
| Phase 5 -> Complete      | team-lead judges no blocking gaps remain and coverage is sufficient from reviewer + tester reports; for executable, user-facing software deliverables, validator PASS is also required |
| Phase 5 cycle exhaustion | 5 cycles complete without clearing blocking gaps or significant coverage gaps; return to Phase 4 for re-analysis, unless Incident Response applies |

**Phase advancement evidence rule**: team-lead must not advance on artifact existence alone. Any phase-closing or phase-advancing lane output must arrive as a completion-grade evidence block in a handoff or completion report that makes `PLANNING-BASIS`, `SELF-VERIFICATION`, `CONVERGENCE-PASS`, and lane-specific `EVIDENCE-BASIS` explicit enough for the next lane to proceed without re-derivation. Missing evidence-contract fields are workflow defects and require HOLD or re-handoff before advancement.

For executable, user-facing software deliverables, phase-advancing evidence must also include tester direct proof for the real launch/start path, the core completion path, and an interaction-coverage matrix covering all in-scope user-visible controls. Missing direct proof for any of those surfaces is a workflow defect and a Blocking gap. Reviewer + tester no-gap is necessary but not sufficient for final acceptance; validator PASS is required before workflow completion.

**Evidence supersession rule**: when delivery surface, runtime architecture, or primary interaction model materially changes during the lifecycle, all prior reviewer, tester, and validator acceptance evidence becomes stale and must not be reused for phase advancement or final acceptance. The affected phases must re-run acceptance from the changed surface.

---

## Context Anchor

Every phase document carries these five elements forward from Plan. They prevent context loss across phases, sessions, and handoffs.

| Element     | Description                                  | Plan doc field            |
|-------------|----------------------------------------------|---------------------------|
| **WHY**     | Problem being solved and its value           | Problem statement         |
| **WHO**     | Target users and stakeholders                | Target users section      |
| **RISK**    | Known risks and mitigation                   | Risk section              |
| **SUCCESS** | Measurable criteria defining done            | Success criteria section  |
| **SCOPE**   | In-scope features and out-of-scope exclusions| Scope boundaries section  |

**Enforcement**: Design doc, implementation notes, and report doc must each reference the plan doc and carry all five elements forward. If a downstream phase doc cannot trace back to WHY and SCOPE, the context anchor is broken and must be repaired before the phase advances.

**Handoff rule**: Every lane dispatch packet must include the context anchor by reference (plan doc path) or inline summary when the full doc is not yet available.

---

## Decision Record Chain

Decisions propagate forward across phases. Each phase document must reference upstream decisions that constrain it.

**Chain**: Discovery -> Plan -> Design -> Implementation -> Report

**Required reference pattern** in each phase doc:

    ## Decision Record Chain
    | Decision | Phase | Reference | Constraint Imposed |
    |----------|-------|-----------|-------------------|

**Propagation rules**:
- Architecture selection (CP3), including any bounded supplementation, must appear in implementation notes and report
- Scope decisions from CP2 ambiguity resolution must appear in design and implementation
- Delivery experience from Plan must appear in design, implementation scope, and report
- Gap resolution decisions (CP5 auto-resolution rationale, chosen next path, fix direction, and checkpoint re-run requirement if any) must appear in report
- Downstream override of an upstream decision requires user surface before proceeding; silent override prohibited.
- When a user-supplied reference informed the plan, the plan's adopted / adapted / not-adopted reference decisions must appear in design and report; downstream lanes must not silently revert to raw reference imitation

---

## Lane Responsibility Map

Authoritative routing reference. team-lead dispatches per this map; lanes do not absorb work outside their column.

| Phase              | team-lead                    | researcher              | developer                            | reviewer                                                          | tester                                     | validator                              |
|--------------------|------------------------------|-------------------------|--------------------------------------|-------------------------------------------------------------------|--------------------------------------------|----------------------------------------|
| 0: Discovery       | orchestrate, synthesize      | execute evidence gathering | --                                 | --                                                                | --                                         | --                                     |
| 1: Plan            | CP1/CP2, gate check          | support if gaps remain  | write plan doc                       | --                                                                | --                                         | --                                     |
| 2: Design          | CP3, gate check              | --                      | produce design options (per tier), write design doc  | --                                                                | --                                         | --                                     |
| 3: Implementation  | CP4, gate check, monitor     | --                      | implement per design                 | --                                                                | --                                         | --                                     |
| 4: Analysis        | CP5, gap judgment            | --                      | provide handoff context              | structural + functional + contract + delivery experience + user-readiness review, gap classification     | executable verification, coverage scoring  | final acceptance when risk is meaningful |
| 5: Iteration       | cycle tracking, auto-resolution   | --                      | apply fixes                          | quick-check (blocking only)                                       | re-verify affected paths                   | final acceptance after last cycle (executable, user-facing software) |

**Acceptance chain (Phase 4)**: reviewer -> tester -> validator. validator engaged when feature scope, architectural changes, or blocking defect history makes final acceptance non-trivial. team-lead judges; default is explicit when risk is meaningful. Executable, user-facing software deliverables enter this validator path by default through task-execution routing.

**Leader file editing rule**: team-lead does not directly edit or write phase documents. All document creation and modification dispatched to developer lane.

---

## Incident Response

When an error or regression is detected during or after implementation:

**Step 1: Detection and Classification**
Identify what failed (error log, test failure, user report, monitoring alert). Classify using T0-T3 framework:
- T0 (system halt): production down or data loss risk -> immediate escalation to user
- T1 (governance block): core feature broken -> block further work, fix first
- T2 (quality gate): non-critical defect -> fix in current iteration cycle
- T3 (advisory): minor issue -> record and schedule

**Step 2: Impact Analysis**
- Scope: which components/services are affected?
- Blast radius: how many users/features impacted?
- Dependencies: what downstream work is blocked?
- Regression check: did this break something previously working?

**Step 3: Fix Proposal (NOT automatic)**
Developer proposes: root cause analysis; proposed change (bounded, specific files); risk assessment of the fix; verification plan. team-lead reviews; user approves if T0/T1.

**Step 4: Apply and Verify**
Developer applies the resolved fix, then resumes the active Phase 4/Phase 5 acceptance path. For executable, user-facing software deliverables, require validator PASS before closeout. If fix verification fails, return to Step 3 (max 3 attempts, then escalate to user).

**Step 5: Post-Incident Record**
Document what happened, root cause, fix applied, and time to resolution. Identify whether a missing check or gate could have prevented it. Add prevention rule to relevant checklist if pattern is recurring. Post-incident record must reference the resumed acceptance path and final validator verdict when validator-governed acceptance was required.

---

## Gap Detection And YAGNI Review

Methodology for YAGNI scope pruning, design-implementation gap analysis, and iteration protocol detail. Applies across Phase 1 (YAGNI), Phase 4 (Analysis), and Phase 5 (Iteration).

---

### YAGNI Scope Review

**Phase**: Plan (Phase 1, before CP2)

**Purpose**: Prevent scope creep before design begins by forcing a deliberate scope-pruning exercise on the plan document.

**Procedure** (before finalizing the plan document, before CP2):

1. List all proposed features/components from the plan
2. For each item, ask: "Is this essential for the core problem, or is it nice-to-have?"
3. Classify:
   - **MUST** -- blocks core value; required in current scope
   - **SHOULD** -- improves but not essential
   - **COULD** -- nice-to-have
   - **WON'T** -- out of scope
4. Remove all COULD and WON'T items from the current plan scope
5. Record removed items as "Future Consideration" in the plan document

**Rule**: Do not advance to CP2 without completing this classification. Scope inflation in the plan doc will compound in every downstream phase.

---

### Design-Implementation Gap Detection

**Purpose**: Give reviewer and tester a structured method to verify implementation against design. This is an analytical tool, not an automatic pass/fail gate.

#### Structural Check

Verify that all components defined in the design doc exist in the codebase.

For each component in the design doc:
1. Does the file or module exist?
2. Does the class, function, or namespace match the designed structure?
3. Are all sub-components present (not just the parent)?

**Defect signal**: Component defined in design has no corresponding implementation artifact.

#### Functional Check

Verify that each component implements its designed behavior.

For each component:
1. Does the implementation cover the primary use case described in the design?
2. Are error paths and edge cases from the design present in code?
3. Does observable behavior match designed behavior (not just presence of code)?

**Defect signal**: Component exists structurally but does not perform its designed function.

#### Contract Check

Verify that API contracts are consistent across design, server, and client.

For each interface or API point in the design:
1. Does the server implementation match the designed contract (inputs, outputs, error codes)?
2. Does the client consumption match the same contract?
3. Are data shapes, field names, and types consistent across the boundary?

**Defect signal**: Contract mismatch between design doc and either server or client implementation.

#### Delivery Experience Check

Verify that the final deliverable meets the Plan's DELIVERY requirements.

For each DELIVERY requirement:
1. Does the deliverable launch via the specified method (e.g., single-action icon double-click)?
2. Does the user see only the intended interface, with no technical infrastructure exposed (consoles, server processes, logs, raw configuration)?
3. Can the user operate the deliverable independently without developer intervention?
4. Are any other end-user-facing operational conditions from the Plan satisfied?
5. Does the application shut down cleanly when the user closes the window? A separate shutdown script, command, or procedure is a design defect unless technically unavoidable — and if so, the unavoidability must be documented in the design doc with justification.
6. Minimum user action verification: for each user-facing operation (start, configure, use, stop), count the required user actions. Every step that can be eliminated, automated, or combined without losing functionality is a delivery experience defect. Examples: separate stop script when window-close suffices, manual environment setup that could be bundled, configuration steps that could use sensible defaults.

**Defect signal**: Deliverable requires technical steps, exposes infrastructure, requires a separate shutdown procedure when window-close would suffice, imposes unnecessary intermediate steps on the user, or fails to meet a stated DELIVERY requirement from the Plan.

#### User-Readiness Check

Verify that the deliverable is practically usable by the end user — not just technically correct.

Prerequisite: Delivery Experience Check passed.
Verification tool: Select per Phase 4 § Deliverable-type verification tool recommendations. For web app deliverables, tester uses Playwright CLI on the browser interaction surface in all phases. Playwright MCP belongs to validator for final acceptance. curl/API-only checks can supplement diagnosis, but they do not satisfy the UI proof obligation.

For software deliverables:
1. Seed the application with representative demo data that exercises all implemented features.
2. Build a feature-and-control inventory from the resolved scope and the actual interface.
3. Verify the real launch/start path through the actual delivery method the user will use.
4. Verify every implemented feature works as intended through the actual interface — do not skip features regardless of perceived importance.
5. Verify every in-scope interactive control responds correctly to user action at least once. This includes buttons, links, tabs, dropdown-triggered actions, form submissions, modal confirms/cancels, navigation actions, edit/save actions, delete actions, and other state-changing controls.
6. Verify cross-feature workflows: confirm that data and state propagate correctly across connected features.
7. Verify data displays correctly — formatting, layout, values, empty states, and dependent views.
8. Verify data persistence — close and reopen the application, then confirm previously entered data is retained where persistence is part of the intended workflow.
9. Verify error handling from the user's perspective — invalid input and edge cases produce user-friendly responses, not raw errors or crashes.
10. Verify i18n and locale rendering — confirm that all user-visible text (including canvas-rendered elements such as charts, graphs, and generated images) renders correctly in the target locale. Verify font stack covers all target language glyphs, character encoding is consistent (HTML meta, database, JSON serialization), and locale-specific formats (dates, numbers, currency) display correctly.
11. Verify data deletion and modification work correctly through the interface, then clean up demo data.

**Verification artifact rule**: tester handoff for executable, user-facing software must include an interaction-coverage matrix covering launch path, core workflows, and every in-scope user-visible control with proof status: direct proof, disproof, blocked proof, or explicitly out-of-scope by dispatch.

#### Web App Testing Environment Setup

When the deliverable-type verification tool mapping specifies Playwright CLI or MCP for web app deliverables, use this environment configuration:

- **Playwright CLI**: Write pytest scripts using `playwright.sync_api`, execute via `python3 -m pytest`.
- **WSL Environment**: `export LD_LIBRARY_PATH=$HOME/.local/lib:${LD_LIBRARY_PATH:-}` (required for libasound.so.2). _(Adapt $HOME path to the actual user environment if different.)_
- **Browser**: Chromium headless with `--no-sandbox` on WSL environments.
- **MCP**: Available via MCP server (`playwright` in mcpServers config) for real-time browser control.

For document deliverables:
1. Render in the intended delivery format (PDF, HTML, etc.).
2. Verify visual design: layout, typography, spacing, hierarchy.
3. Verify content completeness: no placeholders, no TODOs, all sections filled.
4. Verify readability: language fits target audience, logical flow.
5. Verify accuracy: data, references, cross-references, links are correct and functional.
6. Verify actionable content: instructions are executable, code examples run, procedures produce stated results.

For other deliverable types:
1. Reproduce the intended usage path with representative sample input.
2. Verify output quality matches user expectations.
3. Verify error and edge cases produce appropriate responses.

Skill recommendations: team-lead includes relevant specialist skills in Phase 4 dispatch based on deliverable type — ui-ux for visual composition; doc-auto for document structure; code-quality for implementation quality; biz-sys for business rule validation; sec-review for security-sensitive deliverables.

**Defect signal**: Deliverable passes structural and functional checks but fails under realistic user operation — non-responsive elements, broken cross-feature workflows, data loss on restart, display errors, poor visual quality, incomplete content, non-functional instructions, raw error messages, or any condition preventing the end user from immediately using the deliverable as intended. Missing direct proof for the real launch/start path, the core completion path, or any in-scope user-visible interactive control is itself a Blocking gap.

#### Gap Classification

reviewer classifies each gap found:

| Class | Definition | Iteration required |
|-------|------------|-------------------|
| **Blocking** | Missing component, broken contract, or failure to implement primary use case | Yes; team-lead auto-resolves fix direction at CP5 |
| **Non-blocking** | Minor behavioral gap, cosmetic mismatch, low-risk deviation | No, but record in report |
| **Deferred** | Design decision intentionally not implemented in this iteration | No, but document in report under follow-up |

**Severity escalation rule**: When a gap is classified as Blocking at T0 or T1 severity, escalate immediately to the incident-response workflow. T0/T1 gaps must not be treated as normal iteration candidates -- they require the incident-response classification, impact analysis, and fix proposal process before iteration resumes.

**Coverage sufficiency rule**: A significant coverage gap prevents workflow completion until reviewer and tester evidence shows coverage is sufficient, even when no single item is independently classified as Blocking.

**P11 Cross-Verification**: Gap classification requires independent structural, functional, contract, delivery experience, and user-readiness checks -- a single check type is insufficient. Blocking gaps must be confirmed across at least two check dimensions before classification. Missing direct proof required by the phase advancement evidence rule or User-Readiness Check is independently blocking and does not require two-dimension confirmation. Self-evident single-dimension defects with decisive evidence against an explicit requirement recorded in the active plan/design/delivery contract are also independently blocking and do not require two-dimension confirmation.

---

### Iteration Protocol Detail

Supplements Phase 5 Iteration with cycle counter rules and escalation format.

**Quick-check scope** (reviewer, iteration cycles): blocking defects introduced or unresolved by the fix. Do not run a full review cycle in iteration; save that for Phase 4. The quick-check gate exists to prevent fix-introduced regressions, not to repeat Phase 4 analysis.

**Re-verify scope** (tester, iteration cycles): affected components only. Full scenario re-run is not required unless the fix scope was broad.
**Re-verify tool**: Selected by the tester based on the deliverable's proof surface from Phase 4 § Deliverable-type verification tool recommendations. Verification evidence must match the deliverable's actual user-interaction surface (see `CLAUDE.md` `§Acceptance Core`). For UI deliverables, final acceptance (validator PASS) requires Playwright MCP visual inspection regardless of whether Phase 5 was entered.

**Interaction matrix invalidation** (tester, iteration cycles): when a fix touches delivery surface, navigation, shared state, persistence, or shared interaction components, interaction-coverage matrix entries that depend on the changed surface become stale. Stale entries must be re-verified before validator PASS. tester must explicitly mark which matrix rows were invalidated and re-proven in each iteration cycle handoff.

**Cycle 4 assessment**: At cycle 4, team-lead assesses remaining gaps: if the same blocking gap class persists across cycles, evaluate whether the issue is implementation-level (continue iteration) or design-level (prepare Phase 2 rollback).

**Cycle 5 exhaustion**: When 5 cycles complete without resolving all blocking gaps, transition to Phase 4 for re-analysis. team-lead reassesses the remaining gaps against the original requirements and clarified constraints from CP1/CP2, then applies the CP5 priority order again. Iteration counter resets to 1 only for a newly authorized Phase 5 entry after that re-analysis. If the same blocking gap class re-enters Phase 5 again after re-analysis, do not reset indefinitely; escalate to Incident Response or explicit user surface.

**No self-certification in iteration**: developer cannot close an iteration cycle without reviewer quick-check. tester cannot declare re-verify complete without running the affected scenarios. team-lead cannot declare workflow complete without explicit reports from both reviewer and tester for the final cycle.

---

### Gap Detection Self-Growth

- Track repeated gap detection misses (missed contract mismatches, undetected structural gaps, YAGNI scope inflation that survived pruning) across sessions.
- When the same gap detection miss class recurs, escalate to team-lead as a capability-gap signal for checklist or boundary hardening.
- Signal to team-lead when repeated design-implementation drift patterns suggest upstream design doc quality or scope-freeze gaps that gap detection alone cannot prevent.
