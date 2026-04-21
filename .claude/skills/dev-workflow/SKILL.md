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
- Expand the owning phase section rather than appending detached sidecar blocks.
- New workflow rules must attach to an owning phase, checkpoint, or gate block.

Governs how team-lead orchestrates researcher, developer, reviewer, tester, and validator lanes across a multi-phase development lifecycle with checkpoint resolution, selective team-lead auto-resolution, minimal user interruption, iterative quality convergence, and explicit phase gates. All lane dispatches retain evidence-bearing handoff discipline from task-execution. Do not reintroduce PDCA terminology, direct leader file editing, automatic quality thresholds, or freeform cross-lane communication.

## Activation Criteria

Activated by `work-planning`'s Post-Planning Gate when Step 1 Q3 sets `ACTIVE-WORKFLOW: dev-workflow` for a multi-phase development request. `task-execution` validates the load state but does not activate this skill. This skill does not self-authorize from generic planning alone.

Load when:
- team-lead orchestrates a feature development or implementation task spanning multiple phases
- structured phase gates and checkpoint resolution are appropriate to the work scope
- conversion of spreadsheets, manual workflows, or workbook logic into software
- discovery, planning, design, implementation, and acceptance are meaningfully separate phases

Do not load for single-phase bounded tasks. Use the standard Change Sequence for governance changes.

Gap detection and YAGNI review procedures are defined in reference.md §Gap Detection And YAGNI Review -- see the inline pointer below.

---

## Phase 0: Discovery (Optional)

**Purpose**: Gather requirements when they are ambiguous or unstated before planning begins.
**Owner lane**: researcher
**Output**: Requirements summary delivered to team-lead as handoff (not a file artifact unless explicitly requested). If project-local persistence is needed, team-lead synthesizes and records the integrated Phase 0 result unless the workflow explicitly assigns a write-compatible artifact owner.

**When to activate**: User request is high-level or open-ended; target users, constraints, and success criteria are unclear.

**Researcher dispatch**: include RESEARCH-MODE: bounded; DECISION-TARGET: requirements clarity; QUESTION-BOUNDARY: target users, key constraints, success criteria, scope boundaries; SOURCE-FAMILY: repo|web|mixed; DOWNSTREAM-CONSUMER: team-lead (CP1 synthesis).
**Discovery split check**: Before Phase 0 researcher dispatch, classify the discovery shape as `single`, `scout-then-shards`, or `immediate-shards`.
- `single`: one bounded decision target with tightly coupled questions.
- `scout-then-shards`: mechanical inventory, source mapping, or sheet/file extraction is the prerequisite for clean shard boundaries.
- `immediate-shards`: 2+ explicit non-overlapping discovery surfaces already exist; 3+ time-consuming independent surfaces default here.
The default bounded researcher dispatch applies only to `single` discovery or a scout-only inventory that excludes independent interpretation. A packet that combines mechanical inventory, source extraction, or workbook mapping with 2+ interpretive surfaces is not `single`; use `scout-then-shards` when the extraction is prerequisite, or `immediate-shards` when boundaries are already explicit. For shard paths, use `RESEARCH-MODE: sharded`, assign `SHARD-ID`, `SHARD-BOUNDARY`, and `MERGE-OWNER` before fan-out, and return one integrated Phase 0 evidence handoff for team-lead synthesis. Delivery/deployment uncertainties may be surfaced in Discovery Question 5, but concrete stack/runtime option selection belongs to later planning/design unless explicitly scoped as its own bounded follow-up.
**Discovery questions** (structure researcher evidence gathering; present findings at CP1):
1. Core Problem: What specific problem does this feature solve? Who experiences it and how often?
2. Target Users: Who are the primary users? What is their technical level and workflow context?
3. Success Criteria: What measurable outcome indicates success?
4. Constraints: What technical, time, resource, or compatibility constraints exist?
5. Delivery Experience: How should the end user receive, launch, and operate the deliverable?
6. Reference Fit (when reference is supplied): What is the user asking to preserve, what is the user asking to change, and what parts of the reference are only inspirational rather than binding?
7. Target Language/Locale: What language, locale, and internationalization requirements exist? _(Technical font stack and encoding decisions belong to Phase 2 Design.)_
8. Acceptance Evidence Basis: From the user's original instruction, the `work-planning` Step 0 request-fit basis, and supplied references, what evidence would prove the requested outcome later? Derive defaults from references when bounded; surface only non-derivable or contradictory validation ambiguities.

**Discovery verification method**: Before Phase 1 synthesis, team-lead verifies evidence anchors, inference labels, reference-fit separation, unresolved assumptions, and split basis. If independent unresolved surfaces remain, run sharded discovery or mark them non-blocking; only verified findings or labeled inferences may enter CP1.

Discovery output feeds Phase 1 planning only. When a reference is supplied, the output must separate: (1) what the reference is, (2) what the user actually wants from it, and (3) what must be adopted, adapted, or rejected before planning begins. Reference analysis alone does not authorize plan direction. It does not authorize implementation dispatch or design freeze.

**Exit condition**: Researcher delivers requirements summary to team-lead; team-lead synthesizes and advances to Phase 1.

---

## Phase 1: Plan

**Purpose**: Translate requirements into a structured feature plan with explicit scope, constraints, and success criteria.
**Owner lane**: developer (writes plan doc); researcher supports if evidence gaps remain after Phase 0.
**Output artifact**: docs/01-plan/features/{feature}.plan.md _(default path — override in project config if structure differs)_

Plan doc must begin with:
- **USER-INSTRUCTION**: the user's original request quoted verbatim at the very top of the document, preserved without paraphrase. This block persists across all downstream phase artifacts as a live comparison anchor; if the user's instruction is later amended, append the amendment verbatim with its turn reference rather than overwriting.
- 4-line executive summary (Problem / Solution / Impact / Scope)

Any pre-Phase-1 instruction-anchor file created for the project follows the same verbatim rule. Do not reconstruct the instruction from memory, wrapped excerpts, or reordered fragments; if the exact text cannot be preserved, write no paraphrase, record only the source turn, and HOLD until the canonical plan can quote it exactly.

Plan doc must also include:
- Problem statement (WHY), Target users and stakeholders (WHO), Known risks and mitigation (RISK)
- Measurable success criteria (SUCCESS), Explicit scope boundaries (SCOPE)
- Acceptance Evidence Basis: instruction-derived done state, reference-derived evidence/defaults, tolerance or baseline artifact when known, and unresolved validation assumptions that cannot be derived without changing scope or risk
- Verification Strategy Basis: what must later be proven, expected proof surface, evidence source (instruction/reference/default), and verification assumptions or blockers; not a full Phase 4 test plan.
- Delivery experience (DELIVERY), Open questions (resolved at CP2)
- When a user-supplied reference exists: Reference Fit Summary (user-requested intent, adopted elements, adapted elements, rejected elements, unresolved adaptation questions)

**Mandatory checkpoints**: CP1 before plan doc finalized; CP2 after plan doc draft.
Before CP2: apply YAGNI scope pruning -- full procedure in ## Gap Detection And YAGNI Review below.

**Exit condition**: Plan doc exists; CP1 + CP2 complete; unresolved open questions recorded before advancing. When a reference was supplied, the plan must explicitly record how that reference was interpreted against the user's request before Phase 2 begins. Acceptance Evidence Basis and Verification Strategy Basis are planning handoffs, not full Phase 4 test plans or extra user-interruption gates; they must preserve enough proof intent that Phase 2 can produce the Verification Plan.

### Canonical Plan Surface

Planning is complete only when: (1) Phase 1 plan artifact exists, (2) CP1 complete, (3) CP2 complete, (4) unresolved open questions explicitly recorded. Internal reasoning, scope freeze notes, or worker instructions are not the canonical plan surface. Until these conditions hold, planning remains provisional.
When a reference is part of the request, planning is not complete until the canonical plan surface explicitly states how that reference is being used relative to the user's requested outcome. For request-bound development, the canonical plan surface must also preserve the Acceptance Evidence Basis and Verification Strategy Basis derived at CP1 so downstream design, testing, and validation do not reconstruct acceptance expectations or proof scope from memory.

---

## Phase 2: Design

**Purpose**: Produce architecture options (scaled to project tier) and obtain a resolved architecture selection before any implementation begins.
**Owner lane**: developer
**Output artifact**: docs/02-design/features/{feature}.design.md _(default path — override in project config if structure differs)_

**Required: design options** — Design options count scales with project tier: Lightweight — 1 option minimum; Standard — 2 options minimum; Precision — 3 options required. When project-scaling is not loaded, default to 2 options. Silent default to preferred option without documentation remains a compliance failure at any tier.

| Dimension      | Minimal                        | Clean                           | Pragmatic                        |
|----------------|--------------------------------|---------------------------------|----------------------------------|
| Approach       | Fastest path, least change     | Best architecture, full scope   | Balanced: quality + delivery     |
| Pros           | Low risk, quick delivery       | Long-term maintainability       | Reasonable effort, solid result  |
| Cons           | May accrue technical debt      | Higher effort and complexity    | Requires careful boundary work   |
| Effort estimate| (fill per feature)             | (fill per feature)              | (fill per feature)               |
| Risk level     | Low                            | Medium-High                     | Medium                           |
| Recommendation | Only if timeline is critical   | When longevity matters most     | Default recommendation           |

_(Table above is the full-form template with three options. For Lightweight tier: complete one option minimum. For Standard tier: complete at least two. For Precision tier: complete all three. Leave unused columns blank or omit them.)_

team-lead presents the CP3 selection basis. Default path: team-lead auto-resolves per the CP3 auto-resolution criteria in reference.md while keeping one selected architecture option explicit and reporting it concisely. Escalate to the user only when the architecture family, risk posture, or expected implementation scope would materially change beyond the active directive.
For executable, user-facing software deliverables, CP3 comparison must explicitly surface delivery burden, user run path, shutdown path, user action count per operation, and infrastructure exposure across the presented options. Silent omission is a compliance failure.

**Design doc must include**: The **USER-INSTRUCTION** block inherited verbatim from the Plan doc at the very top of the document (unchanged across phases unless the user amended the instruction). Selected option + rationale, component list with responsibilities, API contracts (inputs/outputs/error paths), data flow description, dependency map. Verification Plan derived from the Plan's Verification Strategy Basis: critical paths, data/state changes, reference-derived behaviors, contracts, delivery proof surface, tool mapping, and verification blockers. The Verification Plan must be concrete enough for Phase 4 to execute without re-deriving scope, but it is not full test-script enumeration by default. For executable, user-facing software deliverables: delivery surface design with minimum user action principle: launch path (single-action start from the end-user's OS environment — e.g., desktop icon or file double-click; CLI commands requiring terminal navigation are not single-action), first view (immediately usable state), shutdown path (window close = stop, no separate shutdown script unless technically unavoidable with documented justification), and infrastructure exposure policy (no consoles, logs, or server processes visible to user). Every user-facing operation path (start, use, stop) must require the fewest possible steps — if a step can be eliminated or automated, its presence is a design defect.,
- For executable, user-facing software deliverables — Hybrid file structure (feature-modular + shared core): combine the debugging clarity of feature-modular organization with the maintainability of a shared infrastructure layer. (1) **Feature-modular layer** — each functional module groups its router, service, templates, and module-specific business logic in one folder, enabling isolated per-feature debugging and parallel development. (2) **Shared core layer** — cross-module infrastructure (DB, i18n, middleware) and common functions used by 2+ modules go in a `core/` layer to prevent duplication and centralize cross-cutting concerns. The design doc must show the module folder tree and explicitly identify which functions belong to core vs. module-specific.
 Decision Record Chain header referencing plan doc constraints. For user-facing software deliverables: i18n architecture decision (target locale font stack, character encoding strategy, locale-specific formatting, and whether runtime language switching is in scope or explicitly excluded).

**Exit condition**: Design doc exists; architecture selection resolved at CP3 (explicit user choice or team-lead auto-resolution per CP3 criteria); selection, resolution basis, and Verification Plan recorded in doc before advancing.

---

## Phase 3: Implementation

**Purpose**: Implement the feature per the resolved design.
**Owner lanes**: developer(s) — single when feature decomposition shows no parallel surfaces; multiple when independent feature modules exist after serial prerequisites (spike, shared core) are resolved. Lane count is fixed by the CP4 lane decomposition, not by habit.

**Prerequisite hard gates**:
1. Design doc exists at docs/02-design/features/{feature}.design.md
2. Architecture resolved at CP3 — explicit user choice or team-lead auto-resolution per CP3 criteria (recorded in design doc)
3. CP4 implementation scope resolved — team-lead auto-resolves by default when scope matches the resolved design and the user's task-level directive. Explicit user confirmation is required only for destructive, security-sensitive, or materially scope-expanding changes.
4. Parallelization re-planning resolved — at Phase 3 entry, re-run `work-planning` Step 3.4 (parallelizability) and the `PARALLEL-GROUPS` field against the feature decomposition from Phase 2 Design. Apply `CLAUDE.md [PARALLEL]` and `agents/team-lead.md §IR-2 #8` as non-negotiable constraints. The CP4 scope summary must then carry a lane decomposition (serial-vs-parallel phase boundaries, module-to-worker map, merge ownership). Single-developer dispatch is valid only when decomposition evidence shows no independent parallel surfaces; otherwise serializing independent module work is a bottleneck defect.

**CP4 scope summary** (team-lead freezes internally before implementation begins; presented to the user only when CP4 escalation criteria trigger): files to create/modify, estimated change volume per file, out-of-scope items, known risk points, delivery experience check, and lane decomposition (serial prerequisite phases, parallel-eligible feature modules, module-to-worker map, merge ownership) per Prerequisite hard gate 4. Default path: team-lead resolves CP4 autonomously by verifying that implementation scope matches the resolved design doc and the user's task-level directive. Feature additions, destructive actions, security-sensitive actions, or scope changes beyond the resolved design require explicit user confirmation.
For executable, user-facing software deliverables, team-lead must verify that the planned delivery surface satisfies the Plan's DELIVERY requirements before CP4 resolution.
Any dispatch whose expected output includes code creation, app scaffolding, database/schema setup, business-logic implementation, or executable project structure is implementation-phase work and must not begin before CP4 resolution.

**Developer rules**: Use Claude Code's edit tools as the default file-mutation path; stay within resolved scope; carry Context Anchor (WHY/WHO/RISK/SUCCESS/SCOPE) forward in commit messages or implementation notes; preserve implementation compatibility with the Design Verification Plan; report blockers immediately rather than silently resolving scope ambiguity.

**Exit condition**: Implementation complete per resolved design. Developer sends explicit handoff naming changed files, executed checks, Verification Plan coverage/delta, invalidated verification assumptions if any, unresolved assumptions, and next lane (reviewer/tester). `Verification Plan coverage/delta` must be a row-mapped continuity block, not a prose summary: for each affected Verification Plan or SC row, state the row id or coordinate, current state (`covered|partial|blocked|stale|deferred`), the evidence anchor or execution note that justifies that state, any assumption or delivery-path delta introduced during implementation, and the next owner when the row remains open. If implementation changes a planned proof surface, user path, data/state behavior, or delivery promise, mark the affected Verification Plan row stale in that continuity block and route back to Phase 2 or HOLD unless the design doc already reflects the delta.

---

## Phase 4: Analysis

**Purpose**: Execute the planned verification against the implementation and produce gap analysis.
**Owner lanes**: reviewer (design conformance, blocking defect classification) + tester (executable verification, proof classification)

**Input**: Phase 3 developer handoff including the row-mapped Verification Plan coverage/delta continuity block; design doc at docs/02-design/features/{feature}.design.md including Verification Plan; plan doc including Verification Strategy Basis.
**Gap Detection**: reviewer and tester execute planned verification first, then apply gap detection checks from their lane perspective across structural, functional, contract, delivery experience, and user-readiness dimensions per ## Gap Detection And YAGNI Review below. Exploratory checks are allowed as support, but they do not replace planned scope or silently expand acceptance beyond the active plan/design.

**Coverage scoring** (team-lead judgment signal -- NOT an automatic gate):
- 0=empty; 20=stubs only; 40=partial logic; 60=key paths work; 80=minor gaps; 100=fully implements designed behavior
- High aggregate score does not equal PASS if a blocking defect exists. Lower score is not auto-FAIL if gaps are explicitly accepted.

**Reviewer dispatch**: REVIEW-TARGET: implementation vs design doc and Verification Plan; PREREQ-STATE: complete; EVIDENCE-BASIS: design doc at concrete file path + Verification Plan coordinate + developer handoff changed file list and row-mapped Verification Plan coverage/delta continuity block (abstract "included" prohibited — team-lead must supply the actual design doc path or session-state.md section coordinate containing requirements); ACCEPTANCE-SURFACE: blocking defects, stale proof-surface deltas, gap classification across all check dimensions (structural, functional, contract, delivery experience, user-readiness)

**Tester dispatch**: Tester executes the Design Verification Plan. For executable, user-facing software deliverables, `PROOF-TARGET` is the planned actual delivery surface and user-operable behavior; `ENV-BASIS` is repo runtime; `SCENARIO-SCOPE` is derived from the Verification Plan and the row-mapped continuity block from Phase 3 and includes the real launch/start path verified from the end-user's OS environment (double-click launcher, not developer terminal), the core completion path, cross-feature workflows, persistence/restart checks, and an interaction-coverage matrix for all user-visible controls within resolved scope; `PROOF-EXPECTATION` is direct proof, disproof, or blocked proof per planned scenario/control, with exact commands, route/view, user action, expected result, and observed result. Keep the delivery contract explicit in the packet with `USER-RUN-PATH: <promised user launch/operation path>` and `BURDEN-CONTRACT: hands-off|low-touch|normal|not-applicable`. In the actual packet, keep `PROOF-TARGET`, `ENV-BASIS`, `SCENARIO-SCOPE`, `PROOF-EXPECTATION`, `PROOF-SURFACE`, `TOOL-REQUIREMENT`, `USER-RUN-PATH`, and `BURDEN-CONTRACT` as same-line `KEY: value` entries; if expanded scenario bullets are needed, place them under `DETAILS:` after the scalar summary. For other deliverable types, apply the proof surface planned in the design doc. Tester dispatch owns planned proof execution, not implicit integration-ready closure or Phase 4 merge/report closure. If migration/seed/boot/readiness is still unresolved after Phase 3 handoff, close that uncertainty first through an implementation follow-up, lead-local readiness check, or one bounded readiness packet before browser-proof dispatch. Report exploratory checks separately from planned verification coverage.
**Skill recommendations**: team-lead selects relevant specialist skills for Phase 4 dispatch based on deliverable type per User-Readiness Check in reference.md.

**Deliverable-type verification tool recommendations** (reference for tool selection based on deliverable type):

| Deliverable Type | Default Tester Tool | Default Validator Tool |
|---|---|---|
| Web app (UI) | Playwright CLI (automated functional tests) | Playwright MCP (interactive visual/UX inspection) |
| API service | curl/httpie endpoint verification | — |
| CLI tool | Bash execution + output verification | — |
| Document/Report | Rendered review (browser/PDF viewer) | — |

Deliverable-type proof follows proof-surface correspondence (see `CLAUDE.md` `§Acceptance Core`): verification evidence must be gathered at the same interaction level the end user actually uses. For web app deliverables, the default and expected tester proof path is Playwright CLI on the browser-level interaction surface, and final acceptance requires Playwright MCP visual inspection. curl/API-only checks are supportive evidence only; they do not replace browser-level proof for UI deliverables. If the browser-level path is blocked, report blocked proof and HOLD rather than silently downgrading the proof surface.
For promised single-action or low-touch delivery paths, failure on the real user run path reopens acceptance as a blocking defect. Do not shift cleanup commands, manual rebuild steps, or terminal recovery onto the user before self-owned remediation is exhausted.

**UI evidence ladder**: For web/UI deliverables, classify evidence by the strongest directly observed surface:

| Level | Evidence surface | Permitted claim |
|---|---|---|
| L1 | build success, server start, health endpoint, curl/API response | runtime/API support only |
| L2 | route HTML or static text response | routing/content support only |
| L3 | browser-level interaction proof from the tester tool path | tester proof for exercised controls |
| L4 | validator visual/user-perspective inspection on the required acceptance tool path | final user-view acceptance |

Lower levels support diagnosis but cannot be promoted to a higher claim. If Playwright MCP visual inspection is the required validator path and it is unavailable, screenshot or HTML fallback must be reported as blocked or partial validation unless the workflow explicitly changes the required acceptance path before validation begins and records why the substitute is equivalent for the user-view claim.


**Phase 4 completeness rule**: For executable, user-facing software deliverables, Phase 4 is incomplete if either the reviewer or tester completion-grade evidence block is missing. Reviewer-only closure, build-only proof, API-smoke-only proof, or tester omission is not sufficient.

**CP5 trigger**: If the reviewer or tester completion-grade evidence block reports blocking defects or significant coverage gaps, team-lead resolves CP5 by comparing the gaps against the original requirements and clarified constraints from CP1/CP2, then selecting one next path only per the CP5 priority order in reference.md. T0/T1 severity gaps follow Incident Response instead.

**Exit (no gaps)**: reviewer + tester completion-grade evidence blocks report no blocking defects and coverage sufficient. For executable, user-facing software deliverables, or when acceptance risk is meaningful, team-lead routes the evidence to validator for final acceptance; workflow completes after validator PASS. For other deliverable types, workflow completes once reviewer + tester evidence is sufficient and no higher-risk acceptance owner is required. Closeout Sequence may begin if no remaining blockers.
**Exit (gaps found)**: CP5 resolved to one next path only -> Phase 2 for bounded design correction, or Phase 5 for implementation iteration.

---

## Phase 5: Iteration

**Purpose**: Fix gaps identified in Phase 4; re-verify after each iteration cycle.
**Owner lanes**: developer (fixes) -> reviewer (quick-check, blocking defects only) -> tester (re-verify affected paths); validator performs final acceptance after the last successful cycle for executable, user-facing software deliverables.

**Iteration cycle**:
1. Developer applies fixes per resolved gap list
2. Reviewer quick-check: blocking defects only (non-blocking deferred to report)
3. Tester re-verifies affected components
4. team-lead assesses whether remaining gaps are acceptable
5. If gaps remain and cycles are available, repeat

**Cycle limit**: Maximum 5 iteration cycles per Phase 5 entry (multi-agent: developer→reviewer→tester→lead). Distinct from agent-local convergence maximum of 3 passes (see `CLAUDE.md` `§Authoritative Operating Values`); project-scaling/SKILL.md defers to this cycle limit definition. At exhaustion, return to Phase 4 for re-analysis and apply the CP5 priority order again. Iteration counter resets to 1 only for a newly authorized Phase 5 entry after that re-analysis. If the same blocking gap class re-enters Phase 5 again after re-analysis, do not reset indefinitely; escalate to Incident Response or explicit user surface.

**Phase 4 re-entry limit**: Phase 5 may trigger at most 2 Phase 4 re-entries per resolution cycle. If the same blocking gap class recurs after 2 re-entries, escalate to explicit user surface with the gap description and block until direction is received. A resolution cycle resets when Phase 5 addresses a different gap class. Aggregate limit across all gap classes: 6 Phase 4 re-entries per deliverable; exceeding the aggregate limit escalates to team-lead judgment or explicit user direction regardless of gap class rotation.

**No auto-fix without review**: developer must not apply fixes and self-certify; each cycle includes reviewer quick-check before the next tester run.

See ## Gap Detection And YAGNI Review below for full iteration protocol detail and cycle counter rules.

**Phase 5 → Complete requires**: (a) no blocking gaps from reviewer + tester reports, (b) validator PASS for executable, user-facing software deliverables. See reference.md §Phase Transition Gates for complete gate specification.

**Exit condition**: No blocking gaps remain and coverage is sufficient from reviewer + tester reports. Executable, user-facing software deliverables must then pass validator final acceptance before workflow completion. If remaining blocking gaps or significant coverage gaps require design-level correction -> Phase 2. If 5 cycles exhaust without clearing blocking gaps or significant coverage gaps -> Phase 4 re-analysis before any further Phase 5 entry.

---

> For Checkpoints, Phase Transition Gates, Context Anchor, Decision Record Chain, Lane Responsibility Map, and Incident Response details, see reference.md.

## Phase Transition Notification

At any satisfied phase boundary, the phase cursor must be resolved in the same execution segment: dispatch or execute the next phase, place the workflow on `HOLD`/re-handoff, record an explicit blocker, or explicitly cancel the next stage. Saying "next is Task #N" or "next phase is ..." without starting it or recording why it cannot start is not a completed phase transition.

When team-lead advances to a new phase, send the structured phase-transition packet individually to each affected worker via `SendMessage(to: "<worker-name>")`:

    Phase Transition: {previous_phase} -> {next_phase}
    Feature: {feature_name}
    Context Anchor: WHY={why} | SCOPE={scope}
    Delivery Constraint: {delivery}
    Gate Status: {gate_result}
    Active Workers: {workers and new assignments}
    Blocking Issues: {unresolved items carried forward}

Send this packet at every phase transition to each worker whose active assignment, standby readiness, or immediate next-phase coordination is affected. Include Context Anchor and Delivery Constraint so workers maintain shared understanding. List blocking issues carried forward. Workers with active assignments in the new phase should acknowledge. Do not use `to: "*"` for this structured packet; broadcast is not valid for structured control messages.

### Phase State Recording

Team-lead must record every phase transition in the workspace-local procedure state (`./.claude/state/procedure-state.json`) and mirror continuity in `./.claude/session-state.md`. Exact `Edit`, `Update`, or `MultiEdit` updates to `./.claude/state/procedure-state.json`, and exact `Edit`, `Update`, `MultiEdit`, or `Write` updates to `./.claude/session-state.md`, are bounded checkpoint/continuity writes, not production implementation or semantic governance editing; edits to any other `.claude` surface remain governed by the normal planning and compliance gates. The current-session authority is workspace-local procedure state plus workspace-local continuity. During the active migration path, `$HOME/.claude/session-state.md` remains a legacy mirror and fallback only. Phase 3 (Implementation) entry is blocked until the design doc path is recorded in phase state and the file exists at that path. For executable, user-facing software deliverables, validator PASS coordinate must also be recorded before workflow completion. This recording obligation is mechanical and remains a hard gate. If the phase state is missing or incomplete at the point of completion reporting, the report is HOLD until the section is reconstructed from evidence.


---

> For Gap Detection And YAGNI Review details, see reference.md

## Related Skills
- **`enterprise-arch`**: Enterprise architecture review for enterprise-scale projects. Load during Phase 2-4 (developer lane).
- **`code-quality`**: SOLID compliance, duplication detection, refactoring priority. Load during Phase 4 (reviewer lane).
- **`log-qa`**: Log-based QA for Phase 4-5 when test scripts are absent and Docker environment available (tester lane). Verify Docker is available before dispatching log-qa.
- **`design-token`**: 3-layer design token architecture. Load during Phase 2-3 when design system standardization is needed (developer lane).
- **`ui-mockup`**: Mockup-to-component conversion. Load during Phase 2-3 when UI mockup exists; CSS variables feed into design-token Layer 1 (developer lane).
- **`sec-review`**: Security review specialist for security-sensitive implementations. Load during Phase 4 when trust boundaries, auth, secret handling, external input, privileged operations, or dependency risk are in scope (reviewer lane).

## Deliverable Quality Philosophy Application
- **P1 Purpose**: Freeze the user's real problem and the feature's core job before phase execution; proceeding without confirmed problem statement = P1 defect.
- **P9 Operational Usability**: Phase deliverables must be usable by the next lane without re-derivation; plan/design/handoff docs that force context reconstruction = P9 defect.
- **P10 Hidden Requirements**: Surface hidden incident constraints (blast radius, dependency blocks, rollback feasibility, data integrity risk) during Step 2 Impact Analysis before fix proposals are drafted.

## Self-Growth And Structural Feedback
- Track repeated phase-gate failures (skipped checkpoints, missing plan docs, implementation without CP4) across sessions. Recurrence -> escalate to team-lead as capability-gap signal for gate hardening.
- Track repeated incident classification errors (severity mis-classification, missed blast radius, regressions from fixes). Recurrence -> escalate to team-lead for workflow hardening.
- Signal to team-lead when repeated workflow bottlenecks (stalled phases, missing handoffs, checkpoint bypass pressure) suggest upstream dispatch or scope-freeze gaps.
- Signal to team-lead when recurring incident patterns on the same component or phase suggest upstream design, testing, or acceptance gaps.
