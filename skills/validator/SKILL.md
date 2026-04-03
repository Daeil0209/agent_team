---
name: validator
description: Final evidence-based validation procedure.
user-invocable: false
---

- Live file remains unchanged: `/home/daeil0209/.claude/skills/validator/SKILL.md`
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



# Validator Skill

## Preconditions
- Use only after team-lead assigns validation surface.
- Require: produced outputs, review findings, test evidence as inputs.
- For consequential lane dispatch, keep the lane packet explicit instead of relying on habit:
  - `validator` -> `VALIDATION-TARGET`, `EXPECTATION-SOURCES`, `REVIEW-STATE`, `TEST-STATE`, `DECISION-SURFACE`
- When the consequential lane work is building or reviewing a request-bound artifact whose value depends on question-fit or decision-fit, extend that packet with the request-fit fields as well: `REQUEST-INTENT`, `CORE-QUESTION`, `REQUIRED-DELIVERABLE`, `PRIMARY-AUDIENCE`, `EXCLUDED-SCOPE`.
- For office-format or page-read artifacts, require the rendered review path per CLAUDE.md: `developer/doc-auto` → `tester` render evidence → `reviewer` acceptance → `validator` when risk is meaningful.
- `validator` is assigned when acceptance risk is meaningful.

## Validation Inputs
- Requested expectations (user intent, acceptance criteria)
- Governing expectations (CLAUDE.md, project rules)
- Material references (specs, prior art)
- Produced outputs, review findings, test evidence

## Validation Workflow

### 1. Build The Expectation Suite
- Collect all expectation sources. Mark authoritative vs supplemental.

### 2. Inspect Requested Intent
- Does output answer what was asked? Scope silently changed?

### 3. Inspect Governing Expectations
- Complies with CLAUDE.md and project rules? Procedures followed?

### 4. Inspect Relevant References
- Aligns with specs? References used correctly?

### 5. Inspect Produced Outputs
- Direct examination. Completeness, accuracy, structural quality.

### 6. Incorporate Review And Test Evidence
- Reviewer findings = review-side truth. Tester proof = test-side truth.
- Do not overturn upstream blocking findings without factual error proof.
- If critical-path proof is still missing, route proof generation back to `tester` instead of silently replacing the tester lane inside validation.

### 7. Requirement-To-Evidence Comparison
- Each expectation: matched, partially matched, mismatched, blocked, not assessable.

### 8. Required Checks
- Completeness, scope, logic preservation, operability, criteria satisfaction, evidence coverage.
- For office-format or page-read artifacts, require rendered evidence strong enough to assess first-glance comprehension, page-level repetition, conclusion visibility, and section-order fitness.
- Keep matched, mismatched, blocked, and not-assessable items explicit rather than flattening weak evidence into a soft pass.

### 9. Final Acceptance Gate
- PASS: all met, no blocking findings, evidence sufficient.
- HOLD: ambiguous ownership, missing prerequisites, unresolved defects.
- FAIL: fundamental mismatch.
- PASS prohibited while blocking findings remain.
- For short request-bound artifacts, HOLD or FAIL when the output drifts into chapter-grade background, buries the direct answer under supporting context, or misses the frozen page/volume target without an explicit accepted reason.
- PASS is also prohibited when a request-bound artifact answers a neighboring question, lets excluded scope crowd out the requested answer, or lacks required rendered evidence for an office-format or page-read acceptance surface.
- When the rendered result is part of acceptance, do not pass without both text-review evidence and capture-render-review evidence.

### 10. Final Validation Handoff
- Verdict + strongest reasons. Comparison items. Confidence level.
- Next-action owner for HOLD/FAIL items.
- Keep the handoff verdict-driven and reconstructable: make matched, mismatched, blocked, and not-assessable items explicit enough that the lead can see why PASS, HOLD, or FAIL was recommended without re-running the whole arbitration pass.

## Blocked Validation
- Missing review/test evidence: HOLD + request lane.
- Contradictory upstream: state contradiction + resolution owner.
- Environmental blocker: report honestly as environmental.

## Active Communication Protocol

- After handoff content is prepared, actively deliver it via `SendMessage` to the governing lane. Passive output availability alone is not sufficient.
- When approaching turn-budget exhaustion (last ~5 turns), proactively report via `SendMessage`: current progress, preserved state, incomplete surfaces, and what a successor worker would need to continue. Do not exhaust turns silently.
