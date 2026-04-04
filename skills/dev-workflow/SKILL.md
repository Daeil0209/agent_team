---
name: dev-workflow
description: Structured development workflow with phase gates, interactive checkpoints, and iterative quality convergence for development project orchestration.
user-invocable: false
---

## Structural Contract

- Fixed owner pattern for future skill growth:
  1. `Activation Criteria`
  2. named phase sections (Phase 0 through Phase 6) in order
  3. `Interactive Checkpoints` block
  4. `Phase Transition Gates` block
  5. `Context Anchor` block
  6. `Decision Record Chain` block
  7. `Lane Responsibility Map`
  8. `Related Skills` cross-reference block
- Do not add new top-level phase definitions without explicit governance review.
- Keep exact phase names stable when referenced by other doctrine or dispatch packets.
- Expand the owning phase section rather than appending detached sidecar procedure blocks.
- Structural connectivity is immutable: new workflow rules must remain attached to an owning phase, checkpoint, or gate block rather than appearing as free-floating doctrine.

# Dev Workflow Skill

This skill defines the structured development workflow for feature delivery. It governs how team-lead orchestrates researcher, developer, reviewer, tester, and validator lanes across a multi-phase development lifecycle with mandatory user decision points.

This workflow is adapted from a PDCA-style methodology and rewritten for our team architecture. Do not reintroduce PDCA terminology, direct leader file editing, automatic quality thresholds, or freeform cross-lane communication.

## Activation Criteria

Load this skill when:
- team-lead is orchestrating a feature development or implementation task
- the task spans multiple phases (plan, design, implement, verify)
- structured phase gates and user checkpoints are appropriate to the work scope

Do not load for single-phase bounded tasks (e.g., a one-file fix with clear scope). Use the standard Change Sequence for governance or doctrine changes.

Related skills loaded alongside this workflow:
- `gap-detect`: Design-implementation gap detection, YAGNI scope review, and iteration protocol. Load when Phase 4 (Analysis) or Phase 5 (Iteration) is active, or before CP2 for YAGNI review.
- `incident-response`: Incident classification, fix proposal workflow, and phase transition notification. Load when an error or regression is detected, or at every phase transition broadcast.

---

## Phase 0: Discovery (Optional)

**Purpose**: Gather requirements before planning begins, when requirements are ambiguous or unstated.

**Owner lane**: researcher

**Output**: Requirements summary delivered to team-lead as a handoff. Not a file artifact unless team-lead explicitly requests a PRD document.

**When to activate**:
- User request is high-level or open-ended (e.g., "build me a feature for X")
- Target users, constraints, and success criteria are unclear
- team-lead judges that plan-phase work would stall without prior evidence gathering

**Dispatch packet additions (researcher)**:
```
RESEARCH-MODE: bounded
DECISION-TARGET: requirements clarity for plan phase
QUESTION-BOUNDARY: target users, key constraints, success criteria, scope boundaries
SOURCE-FAMILY: repo|web|mixed
DOWNSTREAM-CONSUMER: developer (plan doc)
```


#### Intent Discovery Questions

When dispatching researcher for Phase 0 Discovery, include this structured question sequence:

1. **Core Problem**: What specific problem does this feature solve? Who experiences it and how often?
2. **Target Users**: Who are the primary users? What is their technical level and workflow context?
3. **Success Criteria**: What measurable outcome indicates this feature succeeded? (quantifiable where possible)
4. **Constraints**: What technical, time, resource, or compatibility constraints exist?

These questions structure the researcher's evidence gathering. Present findings to user at CP1.

**Exit condition**: researcher delivers requirements summary upward. team-lead synthesizes and advances to Phase 1.

---

## Phase 1: Plan

**Purpose**: Translate requirements into a structured feature plan with explicit scope, constraints, and success criteria.

**Owner lane**: developer (writes plan doc); researcher may support if evidence gaps remain after Phase 0.

**Output artifact**: `docs/01-plan/features/{feature}.plan.md`


#### Plan Executive Summary

Every plan document must begin with a 4-line executive summary:

- **Problem**: One sentence describing the core problem
- **Solution**: One sentence describing the proposed approach
- **Impact**: One sentence describing the expected user/business impact
- **Scope**: One sentence defining explicit boundaries (in-scope and out-of-scope)

This summary enables quick plan review without reading the full document.

**Required structure of plan doc**:
- Problem statement (WHY)
- Target users and stakeholders (WHO)
- Known risks and mitigation approach (RISK)
- Measurable success criteria (SUCCESS)
- Explicit in-scope and out-of-scope boundaries (SCOPE)
- Open questions / ambiguities (to be resolved at CP2)

**Mandatory checkpoints**:
- CP1 before plan doc is finalized (present problem understanding; user confirms or corrects)
- CP2 after plan doc draft (surface edge cases, integration questions, compatibility gaps; user resolves ambiguities)

Before finalizing the plan document (before CP2), apply YAGNI scope pruning — see `gap-detect` skill for the full procedure.

**Exit condition**: Plan doc exists at the designated path. User has confirmed problem understanding at CP1 and resolved ambiguities at CP2. team-lead records any unresolved open questions explicitly before advancing.

---

## Phase 2: Design

**Purpose**: Produce three architecture options and obtain user selection before any implementation begins.

**Owner lane**: developer

**Output artifact**: `docs/02-design/features/{feature}.design.md`

**Required output — three options**:

| Dimension      | Minimal                        | Clean                           | Pragmatic                        |
|----------------|--------------------------------|---------------------------------|----------------------------------|
| Approach       | Fastest path, least change     | Best architecture, full scope   | Balanced: quality + delivery     |
| Pros           | Low risk, quick delivery       | Long-term maintainability       | Reasonable effort, solid result  |
| Cons           | May accrue technical debt      | Higher effort and complexity    | Requires careful boundary work   |
| Effort estimate| (fill per feature)             | (fill per feature)              | (fill per feature)               |
| Risk level     | Low                            | Medium–High                     | Medium                           |
| Recommendation | Only if timeline is critical   | When longevity matters most     | Default recommendation           |

developer must produce all three options. team-lead presents them at CP3 and waits for user selection. developer must not begin design doc without generating all three; silent default to a preferred option is a compliance failure.

**Design doc must include**:
- Selected option label and rationale
- Component list with responsibilities
- API contracts (inputs, outputs, error paths)
- Data flow description
- Dependency map
- Decision Record Chain header (references plan doc, states constraints inherited from plan)

**Exit condition**: Design doc exists. User has selected an architecture option at CP3. CP3 confirmation is recorded in the design doc before advancing.

---

## Phase 3: Implementation

**Purpose**: Implement the feature per the approved design.

**Owner lane**: developer

**Prerequisite hard gates**:
1. Design doc exists at `docs/02-design/features/{feature}.design.md`
2. User approved architecture at CP3 (recorded in design doc)
3. User approved implementation scope at CP4 (see below)

**CP4 scope summary** (team-lead presents before implementation begins):
- Files to be created or modified
- Estimated change volume per file
- Explicit out-of-scope items
- Known risk points

**Implementation must not begin without CP4 user approval.**

**Developer execution rules**:
- Use python3 via Bash for all file writes and edits; do not use Edit or Write tools
- Stay within the approved scope; do not absorb adjacent cleanup or unrelated refactors
- Carry the Context Anchor forward: WHY, WHO, RISK, SUCCESS, SCOPE must remain visible in commit messages or implementation notes
- Report blockers upward immediately; do not silently resolve scope ambiguity by expanding implementation

**Exit condition**: Implementation complete per approved design. Developer sends explicit handoff to team-lead naming changed files, executed checks, unresolved assumptions, and next lane (reviewer/tester).

---

## Phase 4: Analysis

**Purpose**: Verify that implementation matches design. Produce gap analysis.

**Owner lanes**: reviewer (design conformance, blocking defect classification) + tester (executable verification, proof classification)

**Input**: Phase 3 handoff packet from developer; design doc at `docs/02-design/features/{feature}.design.md`

**Gap Detection Method**: reviewer and tester independently apply structural, functional, and contract checks per the `gap-detect` skill. Coverage scoring and gap classification are defined there as well.

**Scoring input** (for team-lead judgment only — NOT an automatic gate):
- Each component or file scored 0–100 on implementation coverage
- 0 = empty/not started
- 20 = skeleton only (stubs, no logic)
- 40 = basic structure with partial logic
- 60 = real logic present, key paths work
- 80 = most requirements implemented, minor gaps
- 100 = fully implements designed behavior

Scores are signals for team-lead to assess whether iteration is needed and how many cycles are warranted. A high aggregate score is not sufficient for `PASS` if a blocking defect exists. A lower score is not automatic `FAIL` if gaps are explicitly accepted.

**Reviewer dispatch additions**:
```
REVIEW-TARGET: implementation vs design doc
PREREQ-STATE: complete
EVIDENCE-BASIS: design doc + changed file list from developer handoff
ACCEPTANCE-SURFACE: blocking defects, design gap classification
```

**Tester dispatch additions**:
```
PROOF-TARGET: designed behavior per component
ENV-BASIS: repo runtime
SCENARIO-SCOPE: component-level functional checks per design
PROOF-EXPECTATION: pass/fail per scenario, gap score per file
```

**CP5 trigger**: If gaps are found, team-lead surfaces them at CP5 before deciding iteration path.

**Exit condition (no gaps)**:
- reviewer and tester both report no blocking defects
- team-lead judges coverage sufficient
- Advance to Phase 6 (Report)

**Exit condition (gaps found)**:
- Surface gaps at CP5
- User chooses: fix all / critical only / accept as-is
- Advance to Phase 5 (Iteration) or Phase 6 based on user decision

---

## Phase 5: Iteration

**Purpose**: Fix gaps identified in Phase 4. Re-verify after each iteration cycle.

**Owner lanes**: developer (fixes) → reviewer (quick-check, blocking defects only) → tester (re-verify affected paths)

**Iteration cycle structure**:
1. developer applies fixes per approved gap list
2. reviewer performs quick-check: blocking defects only (non-blocking issues deferred to report)
3. tester re-verifies affected components
4. team-lead assesses whether remaining gaps are acceptable
5. If gaps remain and cycles are available, repeat

**Hard limit**: Maximum 5 iteration cycles. If blocking gaps remain after 5 cycles, escalate to user with honest status before any further work.

**Escalation packet at cycle 5 exhaustion**:
```
ITERATION-STATUS: exhausted
REMAINING-GAPS: <list>
BLOCKING-COUNT: <n>
USER-DECISION-NEEDED: fix-scope-reduction | accept-as-is | redesign
```

**No auto-fix without review**: developer must not apply fixes and self-certify. Each cycle includes reviewer quick-check before the next tester run.

See `gap-detect` skill for full iteration cycle protocol, escalation packet format, and cycle counter rules.

**Exit condition**: team-lead judges remaining gaps acceptable (based on reviewer + tester reports), or user explicitly accepts remaining state after CP5 / escalation. Advance to Phase 6.

---

## Phase 6: Report

**Purpose**: Document the completed feature, decisions made, gaps accepted, and any follow-up work.

**Owner lane**: developer

**Output artifact**: `docs/04-report/features/{feature}.report.md`

**Required report structure**:
- Feature summary and outcome
- Context Anchor summary (WHY / WHO / RISK / SUCCESS / SCOPE) carried from Plan
- Decision Record Chain summary (key decisions from each phase, constraints propagated forward)
- Implementation coverage summary (gap analysis results, accepted gaps, rationale)
- Files created or modified (with brief description)
- Follow-up work (deferred issues, known tech debt, future hardening needs)
- Verification evidence summary (reviewer findings, tester proof results, iteration count)

**Exit condition**: Report doc exists. team-lead confirms report is complete. Closeout Sequence may begin if no remaining blockers.

---

## Interactive Checkpoints

These are mandatory user decision points. team-lead MUST stop and wait for explicit user response at each checkpoint. Do not proceed past a checkpoint on assumed or inferred approval.

### CP1 — Plan Confirmation
**Phase**: Plan (Phase 1, before plan doc finalized)
**Trigger**: team-lead has synthesized problem understanding from requirements
**Presentation**:
- Problem being solved
- Target scope boundaries
- Known constraints
**User question (Korean)**: "요구사항 이해가 맞나요? 추가하거나 수정할 내용이 있으면 알려주세요."
**Required user action**: Confirm or correct. If corrected, revise plan basis before continuing.

### CP2 — Ambiguity Resolution
**Phase**: Plan (Phase 1, after plan doc draft)
**Trigger**: Plan doc drafted; open questions surfaced
**Presentation**:
- Edge cases identified
- Integration or compatibility questions
- Missing information that blocks clean design
**User question (Korean)**: "아래 부분이 불명확합니다. 각 항목에 대한 결정이 필요합니다."
**Required user action**: Answer each open question or explicitly defer. Record answers in plan doc before Phase 2 begins.

### CP3 — Architecture Selection
**Phase**: Design (Phase 2, after three options generated)
**Trigger**: developer has produced Minimal / Clean / Pragmatic options
**Presentation**: Full comparison table (see Phase 2 format)
**User question (Korean)**: "3가지 설계안 중 하나를 선택해주세요. 추천안은 Pragmatic입니다."
**Required user action**: Select one option. Selection must be recorded in design doc. team-lead must not advance to implementation without confirmed selection.

### CP4 — Implementation Scope Approval
**Phase**: Implementation (Phase 3, before any implementation begins)
**Trigger**: team-lead has produced scope summary from design doc
**Presentation**:
- Files to create or modify
- Estimated change volume
- Out-of-scope items
- Risk points
**User question (Korean)**: "이 범위로 구현을 시작해도 괜찮겠습니까?"
**Required user action**: Explicit approval. Implementation must NOT begin without this approval. If user modifies scope, update design doc and re-present summary.

### CP5 — Gap Resolution Decision
**Phase**: Analysis (Phase 4, if gaps found)
**Trigger**: reviewer or tester reports blocking defects or significant coverage gaps
**Presentation**:
- Gap list with severity classification
- Blocking vs non-blocking classification from reviewer
- Coverage signal from tester
- Estimated iteration cost
**User question (Korean)**: "분석 결과 아래 이슈가 발견되었습니다. 어떻게 처리할까요?"
**Options to present**:
1. 전체 수정 (Fix all — enter Phase 5)
2. 중요 항목만 수정 (Fix critical only — enter Phase 5 with scoped list)
3. 현재 상태로 수용 (Accept as-is — advance to Phase 6)
**Required user action**: Select one option. team-lead records decision and routes accordingly.

**Checkpoint bypass rule**: If user says "전부 자동으로" or equivalent, respect the preference but warn once: "체크포인트를 건너뛰면 범위 오류나 방향 불일치가 나중에 발견될 수 있습니다. 계속하시겠습니까?" Proceed only after user confirms.

---

## Phase Transition Gates

Hard gates that must be satisfied before a phase begins. team-lead is responsible for gate verification before dispatching a lane.

| Transition               | Gate Condition                                                                 |
|--------------------------|--------------------------------------------------------------------------------|
| Phase 0 → Phase 1        | Discovery output delivered to team-lead (if Phase 0 activated)                 |
| Phase 1 → Phase 2        | Plan doc exists at `docs/01-plan/features/{feature}.plan.md`; CP1 + CP2 done  |
| Phase 2 → Phase 3        | Design doc exists at `docs/02-design/features/{feature}.design.md`; CP3 done  |
| Phase 3 start            | CP4 user scope approval obtained; design doc confirmed as prerequisite         |
| Phase 3 → Phase 4        | Developer explicit handoff received with changed file list and executed checks |
| Phase 4 → Phase 5        | CP5 user decision: fix all or critical only                                    |
| Phase 4 → Phase 6        | CP5 user decision: accept as-is, OR no blocking gaps found                     |
| Phase 5 → Phase 4        | Iteration cycle fixes applied; reviewer quick-check complete                   |
| Phase 5 cycle exhaustion | 5 cycles reached; escalate to user before any further iteration                |
| Phase 5 → Phase 6        | team-lead judges coverage acceptable; user has accepted remaining gaps         |
| Phase 6 complete         | Report doc exists; team-lead confirms report completeness                      |

Gating is team-lead's responsibility. Dispatching a lane before its gate condition is met is a workflow governance failure.

---

## Context Anchor

Every phase document must carry these five elements forward from the Plan phase. They prevent context loss across phases, sessions, and handoffs.

| Element | Description | Plan doc field |
|---------|-------------|----------------|
| **WHY** | The problem being solved and its business or user value | Problem statement |
| **WHO** | Target users and stakeholders affected by the feature | Target users section |
| **RISK** | Known risks and the chosen mitigation approach | Risk section |
| **SUCCESS** | Measurable criteria that define done | Success criteria section |
| **SCOPE** | Explicit in-scope features and out-of-scope exclusions | Scope boundaries section |

**Enforcement rule**: Design doc, implementation notes, and report doc must each reference the plan doc and carry these five elements forward. If a downstream phase doc cannot trace back to WHY and SCOPE from the plan, the context anchor is broken and must be repaired before the phase advances.

**Handoff rule**: Every lane dispatch packet for this workflow must include the context anchor by reference (plan doc path) or by inline summary when the full doc is not yet available.

---

## Decision Record Chain

Decisions propagate forward across the phase chain. Each phase document must reference upstream decisions that constrain it.

**Chain structure**:
```
Discovery → Plan → Design → Implementation → Report
```

**Required reference pattern** in each phase doc:

```markdown
## Decision Record Chain

| Decision | Phase | Reference | Constraint Imposed |
|----------|-------|-----------|-------------------|
| (decision text) | Phase N | (doc path or CP ref) | (how it constrains this phase) |
```

**Propagation rules**:
- Architecture selection (CP3) must appear in implementation notes and report
- Scope decisions from CP2 ambiguity resolution must appear in design and implementation
- Gap acceptance decisions (CP5) must appear in report with explicit rationale
- If a downstream phase needs to override an upstream decision, team-lead must surface the conflict to the user before proceeding. Silent override is prohibited.

---

## Lane Responsibility Map

This map is the authoritative routing reference for this workflow. team-lead dispatches per this map; lanes do not absorb work outside their column.

| Phase | team-lead | researcher | developer | reviewer | tester | validator |
|-------|-----------|------------|-----------|----------|--------|-----------|
| 0: Discovery | orchestrate, synthesize | execute evidence gathering | — | — | — | — |
| 1: Plan | CP1/CP2, gate check | support if gaps remain | write plan doc | — | — | — |
| 2: Design | CP3, gate check | — | produce 3 options, write design doc | — | — | — |
| 3: Implementation | CP4, gate check, monitor | — | implement per design | — | — | — |
| 4: Analysis | CP5, gap judgment | — | provide handoff context | structural + functional + contract review, gap classification | executable verification, coverage scoring | final acceptance if risk is meaningful |
| 5: Iteration | cycle tracking, escalation | — | apply fixes | quick-check (blocking only) | re-verify affected paths | — |
| 6: Report | confirm completeness | — | write report doc | — | — | — |

**Acceptance chain for Phase 4**: reviewer → tester → validator (when acceptance risk is meaningful). validator is not required for every feature but must be engaged when the feature scope, architectural changes, or blocking defect history makes final acceptance non-trivial. team-lead judges validator engagement; the default is explicit when risk is meaningful or high.

**Leader file editing rule**: team-lead does not directly edit or write phase documents. All document creation and modification is dispatched to developer lane. team-lead synthesizes, plans, gates, and reports — it does not write artifacts.

---

## Related Skills

- **`gap-detect`**: Design-implementation gap detection methodology (structural, functional, contract checks), coverage scoring, YAGNI scope review, and iteration protocol. Loaded alongside this skill during Phase 1 (before CP2), Phase 4 (Analysis), and Phase 5 (Iteration).
- **`incident-response`**: Incident classification (T0–T3), fix proposal workflow, and phase transition notification broadcasts. Loaded when an error or regression is detected, or at every phase transition.
- **`enterprise-arch`**: Enterprise architecture methodology, review checklists, and anti-pattern detection for enterprise-scale projects. Load for enterprise-scale architecture work during Phase 2 (Design) and Phase 4 (Analysis). Loaded by developer lane.
- **`code-quality`**: SOLID compliance, duplication detection, and refactoring priority. Reviewer-side skill for code quality deep review during Phase 4 (Analysis). Loaded by reviewer lane.
- **`log-qa`**: Log-based QA methodology using structured JSON logging and Docker log monitoring. Alternative QA methodology for Phase 4–5 when test scripts are absent and Docker-based environment is available. Loaded by tester lane.
- **`design-token`**: 3-layer design token architecture for cross-platform design system standardization. Load during Phase 2–3 when design system standardization is needed. Loaded by developer lane.
- **`ui-mockup`**: Mockup-to-component conversion methodology with 4-step transition strategy. Load during Phase 2–3 when a UI mockup exists and component conversion is needed. CSS variables from Step 2 feed into design-token Layer 1. Loaded by developer lane.
