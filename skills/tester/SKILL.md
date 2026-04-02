---
name: tester
description: Test execution and verification procedure.
user-invocable: false
---

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

## Testing Workflow

### 1. Declare The Test Surface
- Name: artifact under test, version, environment, scope boundaries.

### 2. Choose The Smallest Credible Test Set
- Cover critical path and highest-risk paths first.
- Add boundary, negative, error cases proportional to risk.

### 3. Execute Direct Checks
- Run actual commands. Record exact commands, outputs, exit codes.
- For code: syntax check, import check, unit tests, integration.
- For documents: rendering, structure, content spot-checks.

### 4. Negative Coverage
- Test error paths, invalid inputs, boundary values, missing deps.
- Each function/endpoint: at least one success + one failure case.

### 5. Human-Facing Checks (when relevant)
- Capture page images, check visual layout, first-glance comprehension.

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

## Pre-Handoff Self-Check
1. All scenarios executed or marked blocked.
2. Commands and outputs recorded.
3. Proof classification applied.
4. No validation claims without execution evidence.

## Active Communication Protocol

- After handoff content is prepared, actively deliver it via `SendMessage` to the governing lane. Passive output availability alone is not sufficient.
- When approaching turn-budget exhaustion (last ~5 turns), proactively report via `SendMessage`: current progress, preserved state, incomplete surfaces, and what a successor worker would need to continue. Do not exhaust turns silently.
