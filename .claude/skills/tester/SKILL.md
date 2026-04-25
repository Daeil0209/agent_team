---
name: tester
description: Test execution and verification procedure.
user-invocable: false
---

## Structural Contract

- Fixed owner pattern for future skill growth:
  1. `Scope & Quality Gate` when present
  2. `User-Perspective Gate` when the lane owns a user-facing completion surface
  3. `Preconditions` or required input surface
  4. the main workflow block
  5. blocked/proof/self-check sections when present
  6. `Active Communication Protocol`
- Do not add new peer top-level sections without explicit governance review.
- Strengthen the existing workflow block before appending a new sidecar doctrine block.
- Keep dispatch-packet requirements, HOLD/escalation triggers, workflow steps, and communication rules in owner-local form.
- Structural connectivity is immutable: new skill content must attach to an owning gate, precondition, workflow, or communication block rather than appearing as detached doctrine.

### Scope & Quality Gate (before ANY work begins)

FIRST action on any assignment — before ANY tool calls:

1. **Request fit**: Does this instruction match the user's original request as stated in the dispatch?
2. **Scope proportionality**: Is the work scope proportional to the request? (Example: a 2-question request should not produce a 10-chapter report)
3. **Charter fit**: Does this work belong inside the tester lane, or is it actually implementation, review-side defect ownership, validation, or orchestration work?
4. **Feasibility / quality risk**: Can this be completed honestly within the available environment, proof surface, and turn budget without overstating proof?

If ANY check fails, return scope feedback as the complete response: failed check, specific evidence, and concrete correction. Do NOT execute over-scoped instructions; silent acceptance is a compliance failure.

### User-Perspective Gate

Apply this gate whenever the task claims a user workflow, operator workflow, or human-facing completion surface. It is a tester-local proof gate, not reviewer defect classification or validator verdict ownership.

1. Has the proof included the real start path and core completion path for the intended user or operator?
2. Are the results based on executed workflow evidence rather than smoke checks, extracted text, or render-only impressions?
3. If the full workflow cannot be proven, is the result classified as blocked proof instead of softened into pass-like language?

Page loads, opens, or renders are not enough when the user is supposed to complete a task.



# Tester Skill

## Preconditions
- Use only after team-lead assigns a test surface.
- If brief, artifact, or environment not credible, return HOLD.
- For consequential lane dispatch, keep the lane packet explicit instead of relying on habit:
  - `tester` -> `PROOF-TARGET`, `ENV-BASIS`, `SCENARIO-SCOPE`, `PROOF-EXPECTATION`
- When the assigned artifact is request-bound and depends on question-fit or decision-fit, also include `REQUEST-INTENT`, `CORE-QUESTION`, `REQUIRED-DELIVERABLE`, `PRIMARY-AUDIENCE`, `EXCLUDED-SCOPE`.
- For office-format or page-read artifacts, keep the rendered review chain explicit: `developer/doc-auto` → `tester` render evidence → `reviewer` acceptance → `validator` when risk is meaningful.
- Do not treat reviewer or tester output alone as implicit final validation ownership.
- Do not use `tester` as a substitute for defect classification or final acceptance judgment.

## Testing Workflow

### 1. Declare The Test Surface
- Name: artifact under test, version, environment, scope boundaries.

### 2. Choose The Smallest Credible Test Set
- Cover critical path and highest-risk paths first.
- Add boundary, negative, error cases proportional to risk.

### 3. Execute Direct Checks
- Run actual commands. Record exact commands, outputs, exit codes.
- For code: syntax check, import check, unit tests, integration.
- For documents: rendering, structure, content spot-checks, and rendered evidence capture when acceptance depends on what a human actually sees.

### 4. Negative Coverage
- Test error paths, invalid inputs, boundary values, missing deps.
- Each function/endpoint: at least one success + one failure case.

### 5. Human-Facing Checks (when relevant)
- Capture page images, check visual layout, first-glance comprehension.
- Require rendered evidence when acceptance depends on what a human actually sees.
- For office-format outputs, record package validity, text extraction, native openability, and rendered review as separate checks. Do not collapse them into one flattering pass.
- When the artifact is page-read, prefer page-image capture or equivalent per-page rendered evidence over abstract format claims.
- For visualized, office-format, or page-read human-facing artifacts, do not present capture-render review as if it replaced text review. Keep the proof packet explicit that rendered usefulness is only one acceptance surface.
- Record page-level proof items separately when relevant: conclusion visible on page 1 or not, repeated material visibly accumulates or not, annex or source sections crowd out the main answer or not, and reader order supports the intended decision path or not.
- If rendered evidence cannot be captured, keep the proof state blocked rather than pretending text extraction or package validity covered the same risk.

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

### 7. Build The Test Handoff
- Top-line state. All findings with classification and evidence.
- Retest gates. Unverified areas. Recommended next lane.
- Keep the handoff reproducible: include exact commands, environment basis, scenario exercised, observed outcomes, and blocked surfaces clearly enough that downstream lanes do not reinterpret proof strength.
- For consequential upward `SendMessage` reports with `MESSAGE-CLASS: handoff|completion|hold`, keep the authoritative handoff block explicit:
  - `TEST-STATE: ready|hold|blocked`
  - `OUTPUT-SURFACE: <artifact, version, or proof surface exercised>`
  - `EVIDENCE-BASIS: <proof summary plus exact commands, environment, and decisive outcomes>`
  - `OPEN-SURFACES: <blocked or unverified surfaces plus rerun gates, or none-material>`
  - `RECOMMENDED-NEXT-LANE: <next owner or none>`
  - `REQUESTED-LIFECYCLE: standby|shutdown`
- `TEST-STATE` is `ready` when the assigned proof surface has an explicit usable proof classification with decisive evidence, including disproof when that is what execution established, `hold` when framing or expectation basis is too weak for honest proof closure, and `blocked` when required execution could not complete because of environment, access, or runtime blockers.
- Default to `REQUESTED-LIFECYCLE: standby` when preserved proof context may still matter; request `shutdown` only when near-term reuse should not be preserved. This is a request, not authority.
- This block is only for consequential `handoff|completion|hold`. Ordinary continuity or status notes may stay free-form.

## Pre-Handoff Self-Check
1. All scenarios executed or marked blocked.
2. Commands and outputs recorded.
3. Proof classification applied.
4. No validation claims without execution evidence.

## Active Communication Protocol

- Use `SendMessage` for mandatory handoff delivery and late-turn continuity reporting. Ordinary continuity or status notes may stay free-form. Consequential `handoff|completion|hold` must use the block above, including `REQUESTED-LIFECYCLE`. Passive output availability and silent turn exhaustion are failures; when turn budget is nearly exhausted, report current progress, preserved state, incomplete surfaces, and successor needs explicitly.
