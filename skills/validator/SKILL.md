---
name: validator
description: Final evidence-based validation procedure.
user-invocable: false
---

# Validator Skill

## Preconditions
- Use only after team-lead assigns validation surface.
- Require: produced outputs, review findings, test evidence as inputs.

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

### 7. Requirement-To-Evidence Comparison
- Each expectation: matched, partially matched, mismatched, blocked, not assessable.

### 8. Required Checks
- Completeness, scope, logic preservation, operability, criteria satisfaction, evidence coverage.

### 9. Final Acceptance Gate
- PASS: all met, no blocking findings, evidence sufficient.
- HOLD: ambiguous ownership, missing prerequisites, unresolved defects.
- FAIL: fundamental mismatch.
- PASS prohibited while blocking findings remain.

### 10. Final Validation Handoff
- Verdict + strongest reasons. Comparison items. Confidence level.
- Next-action owner for HOLD/FAIL items.

## Blocked Validation
- Missing review/test evidence: HOLD + request lane.
- Contradictory upstream: state contradiction + resolution owner.
- Environmental blocker: report honestly as environmental.

## Active Communication Protocol

- After handoff content is prepared, actively deliver it via `SendMessage` to the governing lane. Passive output availability alone is not sufficient.
- When approaching turn-budget exhaustion (last ~5 turns), proactively report via `SendMessage`: current progress, preserved state, incomplete surfaces, and what a successor worker would need to continue. Do not exhaust turns silently.
