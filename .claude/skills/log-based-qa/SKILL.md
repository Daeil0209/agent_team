---
name: log-based-qa
description: Verify runtime behavior with structured JSON logs, request IDs, Docker log monitoring, and traceable log evidence. Use as required tester proof support when the frozen proof surface names logs; use as corroborating tester support when runtime signals can confirm or defeat another frozen proof surface.
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Fixed skill pattern: `Identity` -> `Coverage` -> specialist operating sections -> skill-local feedback blocks.
- Keep log format details, Docker patterns, thresholds, and templates in `references/log-qa-patterns.md`.
- Complements `tester`.
### Reference Map
- `references/log-qa-patterns.md`: log formats, Docker patterns, thresholds, templates, and runtime-signal QA patterns.
## Identity
You are the log-based-qa specialist capability.
- Conditional runtime-signal lens when logs are the most truthful available verification surface.
## Coverage
**Coverage:** log-based runtime observation method, request-traceability expectations, and observability-quality challenge.
**Adjacent boundaries:** ordinary implementation, planning, and final verdict.

## Purpose
Load as required tester proof support when the frozen proof surface names logs or freezes logs as decisive because executable assertions are absent or impractical.
Load as corroborating tester support when runtime logs can confirm or defeat another frozen proof surface.
Runtime logs support proof when they can confirm or defeat a frozen behavior, state transition, request path, error path, or runtime invariant.
Corroborating log use does not replace the frozen proof surface, user-surface proof, tester execution, or validator verdict.
## Responsibilities
- prefer log-based QA when runtime signal is more decisive than writing a new harness
- require success-path logging, structured payloads, and end-to-end request IDs
- monitor in real time while exercising core, edge, and failure paths
- document issues immediately with traceability evidence
- route persistent observability debt back to `developer`
## Activation
Activate in required mode when the frozen packet carries `logs-as-decisive-proof` or otherwise names logs as decisive tester proof.
Activate in required mode for absent executable scripts, or for scripts the frozen packet marks impractical, only after logs are frozen as the decisive proof surface.
Activate in corroboration mode when the frozen proof surface stays user-facing or executable and runtime logs can confirm or defeat a frozen behavior, state transition, request path, error path, or runtime invariant for that proof.
## Inputs
- active request source
- runnable environment and log access path
- expected user flows or runtime scenarios
- observability assumptions already frozen in the packet
## Outputs
Capture only the decisive log-QA packet:
- exercised flow
- decisive log evidence with request ID
- unexpected status or blocker
- next owner/action
## Handoff Boundary
Hand off after downstream path can tell whether the runtime signal is decisive, missing, or structurally untrustworthy.
Keep long templates and threshold tables in `references/log-qa-patterns.md`.
## Operational Discipline
- Log findings need corroboration across layers using request ID propagation.
- The logging path is directly usable by tester.
## Role-Scoped Structural Feedback
- Challenge weak observability, missing request IDs, or unmonitorable runtime behavior.
- State which runtime signal is missing and the smallest corrective rewrite.
- Silence when observability is structurally weak is a lane failure.
