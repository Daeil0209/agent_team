---
name: tester
description: Test execution and verification procedure.
user-invocable: false
---

- Live file remains unchanged: `/home/daeil0209/.claude/skills/tester/SKILL.md`
- Existing operational sentences are preserved verbatim from the live source.
- This draft adds only a structural contract and review wrapper. No factual corrections are applied yet.
- Source status: active project skill.

## Structural Contract

- Fixed owner pattern for future skill growth:
  1. `Scope & Quality Gate` when present
  2. `Preconditions` or required input surface
  3. the main workflow block
  4. blocked/proof/self-check sections when present
  5. `Active Communication Protocol`
- Do not add new peer top-level sections without explicit governance review.
- Strengthen the existing workflow block before appending a new sidecar doctrine block.
- Keep dispatch-packet requirements, HOLD/escalation triggers, workflow steps, and communication rules in owner-local form.
- Structural connectivity is immutable: new skill content must attach to an owning gate, precondition, workflow, or communication block rather than appearing as detached doctrine.

### Scope & Quality Gate (before ANY work begins)

FIRST action on any assignment — before ANY tool calls:

1. **Request fit**: Does this instruction match the user's original request as stated in the dispatch?
2. **Scope proportionality**: Is the work scope proportional to the request? (Example: a 2-question request should not produce a 10-chapter report)
3. **Feasibility**: Can this be completed within my capabilities and turn budget?

If ANY check fails → return scope feedback as your COMPLETE response:
- Which check failed
- Why (specific evidence)
- Suggested correction (concrete alternative)

Do NOT execute over-scoped instructions. Return scope feedback INSTEAD of executing.
Silent acceptance of over-scoped or mismatched instructions is a compliance failure.



# Tester Skill

## Preconditions
- Use only after team-lead assigns a test surface.
- If brief, artifact, or environment not credible, return HOLD.
- For consequential lane dispatch, keep the lane packet explicit instead of relying on habit:
  - `tester` -> `PROOF-TARGET`, `ENV-BASIS`, `SCENARIO-SCOPE`, `PROOF-EXPECTATION`
- When the consequential lane work is building or reviewing a request-bound artifact whose value depends on question-fit or decision-fit, extend that packet with the request-fit fields as well: `REQUEST-INTENT`, `CORE-QUESTION`, `REQUIRED-DELIVERABLE`, `PRIMARY-AUDIENCE`, `EXCLUDED-SCOPE`.
- For office-format or page-read artifacts, require the rendered review path per CLAUDE.md: `developer/doc-auto` → `tester` render evidence → `reviewer` acceptance → `validator` when risk is meaningful.
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

### 7. Build The Test Handoff
- Top-line state. All findings with classification and evidence.
- Retest gates. Unverified areas. Recommended next lane.
- Keep the handoff reproducible: include exact commands, environment basis, scenario exercised, observed outcomes, and blocked surfaces clearly enough that downstream lanes do not reinterpret proof strength.

## Pre-Handoff Self-Check
1. All scenarios executed or marked blocked.
2. Commands and outputs recorded.
3. Proof classification applied.
4. No validation claims without execution evidence.

## Active Communication Protocol

- After handoff content is prepared, actively deliver it via `SendMessage` to the governing lane. Passive output availability alone is not sufficient.
- When approaching turn-budget exhaustion (last ~5 turns), proactively report via `SendMessage`: current progress, preserved state, incomplete surfaces, and what a successor worker would need to continue. Do not exhaust turns silently.
