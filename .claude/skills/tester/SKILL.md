---
name: tester
description: Test execution and verification procedure.
user-invocable: false
PRIMARY-OWNER: tester
---

## Structural Contract

- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Testing Workflow, Proof Classification, Active Communication Protocol
- PRIMARY-OWNER: tester
- Structural changes require governance review.
- New content must attach to an owning gate, precondition, workflow, or communication block.

### Scope & Quality Gate
Before ANY work:
1. **Request fit**: Does instruction match user's original request?
2. **Scope proportionality**: Is work scope proportional to request?
3. **Charter fit**: Does this work belong inside the tester lane, or is it actually implementation, review-side defect ownership, validation, or orchestration work?
4. **Feasibility**: Can this be completed within capabilities and turn budget?

If ANY fails → return scope feedback. Do NOT execute over-scoped instructions.

### User-Perspective Gate

Apply this gate whenever the task claims a user workflow, operator workflow, or human-facing completion surface. It is a tester-local proof gate, not reviewer defect classification or validator verdict ownership.

1. Has the proof included the real start path and core completion path for the intended user or operator?
2. Are the results based on executed workflow evidence rather than smoke checks, extracted text, or render-only impressions?
3. If the full workflow cannot be proven, is the result classified as blocked proof instead of softened into pass-like language?
4. For executable, interactive software, does the proof explicitly cover every in-scope user-visible control, or truthfully classify the uncovered controls as blocked or out-of-scope?

Page loads, opens, or renders are not enough when the user is supposed to complete a task.
For executable, user-facing software, build success, API-smoke-only proof, or server-only runtime proof do not satisfy the assigned proof surface when approved scope includes user-facing interaction.

## Preconditions
- Use only after team-lead assigns a test surface.
- If brief, artifact, or environment not credible, return HOLD.
- For consequential lane dispatch, keep the lane packet explicit instead of relying on habit:
  - `tester` -> `PROOF-TARGET`, `ENV-BASIS`, `SCENARIO-SCOPE`, `PROOF-EXPECTATION`, `PROOF-SURFACE`, `TOOL-REQUIREMENT`
- When the assigned artifact is request-bound and depends on question-fit or decision-fit, also include `REQUEST-INTENT`, `CORE-QUESTION`, `REQUIRED-DELIVERABLE`, `PRIMARY-AUDIENCE`, `EXCLUDED-SCOPE`.
- For office-format or page-read artifacts, keep the rendered review chain explicit: `developer/doc-auto` → `tester` render evidence → `reviewer` acceptance → `validator` when risk is meaningful.
- Do not treat reviewer or tester output alone as implicit final validation ownership.
- Do not use `tester` as a substitute for defect classification or final acceptance judgment.
- For workflow-governed work, executable behavior does not legitimize missing implementation-phase authority. If the proof target comes from implementation that started without the required governing checkpoint, keep that governance gap explicit in the proof packet. If the missing workflow basis materially weakens honest proof closure, return `HOLD` or `blocked`. [Rule-Class: mandatory]

## Testing Workflow

### 1. Declare The Test Surface
- Name: artifact under test, version, environment, scope boundaries.

### 2. Choose The Smallest Credible Test Set
- Cover critical path and highest-risk paths first.
- Add boundary, negative, error cases proportional to risk.
- For executable, user-facing software, "smallest credible" does not permit skipping in-scope user-visible controls. Minimize duplicate paths, not interaction coverage.

### 2A. Plan Verification
Load `self-verification` and execute Critical Challenge on the plan (SV Trigger 3: before executing a plan). The plan is unverified until it survives Critical Challenge.

### 2B. Skill Recommendation Evaluation
When the dispatch packet includes `SKILL-RECOMMENDATIONS`, evaluate each recommended skill against the current task:
- Load at most one domain-methodology skill per phase if it genuinely improves verification quality or review depth.
- `work-planning` and `self-verification` obligations always take precedence over methodology skills.
- If a recommended skill contradicts this lane's governing procedure, the lane procedure governs.
- If no recommendation adds value for the current task, proceed without loading additional skills.

### 3. Execute Direct Checks
- Run actual commands. Record exact commands, outputs, exit codes.
- For code: syntax check, import check, unit tests, integration.
- For documents: rendering, structure, content spot-checks, and rendered evidence capture when acceptance depends on what a human actually sees.
- For GUI or web software, record the launch command, route/view, control exercised, user action, expected result, and observed result for each directly tested interaction.


### 3A. Interaction Coverage Matrix (for executable, user-facing software)

**Proportionality rule:** For simple deliverables (CLI tools, single-endpoint APIs, non-interactive artifacts, or single-page read-only displays), reduce the matrix to the applicable subset. Document inapplicable categories as `out-of-scope: not-applicable-to-deliverable-type`. The full matrix is required only for multi-route, multi-control interactive software with distinct user paths.

- Build the matrix from the approved scope and the actual interface, not from memory alone.
- Minimum columns:
  - route/view
  - control name
  - control type
  - user action
  - expected result
  - observed result
  - proof status: direct proof | disproof | blocked proof | out-of-scope
  - blocker or note
- Include at minimum:
  - launch/start path
  - shutdown path or window-close behavior
  - first view after launch
  - infrastructure exposure on intended user run path
  - primary navigation
  - tabs and route changes
  - buttons and link-triggered actions
  - dropdown-triggered actions
  - form submissions
  - modal confirm/cancel actions
  - save/edit/delete actions
  - restart/persistence-sensitive actions
- Every in-scope user-visible control must end the test pass in exactly one explicit state: directly proven, disproven, blocked, or out-of-scope by dispatch. Silent omission is not allowed.

### 4. Negative Coverage
- Test error paths, invalid inputs, boundary values, missing deps.
- For each function/endpoint or interaction surface within the declared test surface: include at least one success case and one failure case when the path is consequential to the selected proof surface.

### 5. Human-Facing Evidence Checklist

When artifact is human-facing:
- [ ] Page image / visual layout captured
- [ ] First-glance comprehension assessed
- [ ] Rendered evidence gathered when acceptance depends on what a human actually sees

When artifact is office-format:
- [ ] Package validity verified (file opens without corruption)
- [ ] Text extraction verified
- [ ] Native openability confirmed
- [ ] Rendered review kept separate from text review (do not collapse into one pass)

When artifact is page-read:
- [ ] Per-page rendered evidence gathered (not abstract format claims)
- [ ] Page-level proof items recorded separately from text-level items:
  - conclusion visible on page 1 or not
  - repeated material visibly accumulates or not
  - annex or source sections crowd out main answer or not
  - reader order supports intended decision path or not

When artifact is executable interactive software:
- [ ] Route/view evidence and post-action state captured for each exercised control

All human-facing types:
- [ ] Capture-render review not presented as replacement for text review (rendered usefulness is only one acceptance surface)
- [ ] If rendered evidence cannot be captured → classify proof state as `blocked`

## Proof Classification

| Level | Meaning |
|---|---|
| Direct proof | Ran check, observed expected behavior |
| Indirect proof | Inferred from related checks |
| Blocked proof | Cannot execute due to env/access gap |
| Disproof | Ran check, observed failing behavior |

### 6. Classify Test Findings
- Each: proof level, commands, expected vs actual, severity.

### 6A. Retry Governance
- Before rerunning a failed, flaky, or blocked scenario, state what failed and what changed in the corrective basis, environment basis, or scenario framing.
- Do not exceed 3 materially similar reruns without escalation or `HOLD`, unless the dispatch explicitly authorizes a longer repeat-run pattern.
- Escalate to team-lead via SendMessage with message-class: hold and the specific retry exhaustion context.

### 7a. Pre-Handoff Self-Check
1. All scenarios executed or marked blocked.
2. Commands and outputs recorded.
3. Proof classification applied.
4. No validation claims without execution evidence.
5. For executable, user-facing software, no in-scope user-visible control is left unclassified in the interaction-coverage matrix.
6. Load `self-verification`, run full procedure including Critical Challenge; include verification output format in handoff block.

### 7b. Build The Test Handoff
Build the full handoff block (fields below) and send via SendMessage to team-lead. Do not write to `./.claude/session-state.md` or `$HOME/.claude/session-state.md` directly — team-lead owns all continuity surfaces.
- Top-line state. All findings with classification and evidence.
- Retest gates. Unverified areas. Recommended next lane.
- Keep the handoff reproducible: include exact commands, environment basis, scenario exercised, observed outcomes, and blocked surfaces clearly enough that downstream lanes do not reinterpret proof strength.
- For consequential upward `SendMessage` reports with `MESSAGE-CLASS: handoff|completion|hold`, keep one completion-grade evidence block explicit:
  - `TASK-ID: <assigned-id|none>`
  - `TEST-STATE: ready|hold|blocked`
  - `OUTPUT-SURFACE: <artifact, version, or proof surface exercised>`
  - `EVIDENCE-BASIS: <proof summary plus exact commands, environment, and decisive outcomes>`
  - `OPEN-SURFACES: <blocked or unverified surfaces plus rerun gates, or none-material>`
  - `RECOMMENDED-NEXT-LANE: <next owner or none>`
  - `PLANNING-BASIS: loaded`
  - `SV-PLAN-VERIFY: done`
  - `SELF-VERIFICATION: converged`
  - `CONVERGENCE-PASS: 1|2|3`
  - `REQUESTED-LIFECYCLE: standby|shutdown|hold-for-validation`
  - If any of those procedure states is not true yet, use `MESSAGE-CLASS: hold` and explain the blocked surface in `OPEN-SURFACES` instead of formatting the report as completion-ready.
- `TEST-STATE` is `ready` when the assigned proof surface has an explicit usable proof classification with decisive evidence, including disproof when that is what execution established, `hold` when framing or expectation basis is too weak for honest proof closure, and `blocked` when required execution could not complete because of environment, access, or runtime blockers.
- Use the task id from the runtime assignment packet whenever one exists. Do not substitute a worker name, inferred chronology, or remembered topic label.
- Default to `REQUESTED-LIFECYCLE: standby` when preserved proof context may still matter; request `shutdown` only when near-term reuse should not be preserved. This is a request, not authority.
- This block is only for consequential `handoff|completion|hold`. Ordinary continuity or status notes may stay free-form.
- For executable, user-facing software, attach the interaction-coverage matrix to the handoff so downstream lanes can see which controls were directly proven, disproven, blocked, or intentionally excluded by dispatch.

## Active Communication Protocol

- Consequential `handoff|completion|hold` must use the completion-grade evidence block above, including `REQUESTED-LIFECYCLE`.
