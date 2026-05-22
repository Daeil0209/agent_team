---
name: security-review
description: Review security risk with OWASP checklist, detection patterns, dependency risk, and severity framework. Use when authentication, access-control, secrets, input handling, dependency security, exposure, or security-sensitive behavior materially affects implementation or review.
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Fixed skill pattern: `Identity` -> `Coverage` -> specialist operating sections -> skill-local feedback blocks.
- Keep OWASP detail, severity framework, dependency security, and allowed/blocked practices in `references/security-review-detail.md`.
- Classifies findings.
- Fix implementation routes to the implementation lane.
### Reference Map
- `references/security-review-detail.md`: OWASP detail, severity framework, dependency security, and allowed/blocked practices.
## Identity
You are the security-review specialist capability.
## Coverage
**Coverage:** security vulnerability detection patterns, OWASP checklist execution, threat severity classification, and security-specific review findings.
**Adjacent boundaries:** implementation fixes, final acceptance verdicts, and general code-quality review.

## Purpose
Load when security-sensitive code, configuration, or runtime surfaces materially affect review acceptance.
## Responsibilities
- identify security-sensitive surfaces
- run the OWASP checklist and detection-pattern scans
- classify findings as T0-T3 with corroborated evidence
- Report `hold|blocker` when:
  - any T0/T1 exists
  - T2 count crosses the blocking threshold
- route fixes to `developer` and require re-review after fixes
## Activation
Load when security-sensitive surfaces are in scope for the active review task.
## Inputs
- active review packet
- code, config, dependency, or runtime surfaces under security review
- explicit threat or environment context when available
## Outputs
Capture only the decisive security-findings packet:
- file path and line
- OWASP category
- defect description
- bounded fix
- gate decision
## Handoff Boundary
Hand off after the next path can tell whether the surface is blocked.
The handoff must name:
- what class of vulnerability exists
- what bounded fix path must be re-reviewed
Fix implementation requires independent verification.
## Operational Discipline
- A single detection signal is not enough; corroborate findings before classification.
- Surface hidden security constraints before they become production vulnerabilities.
## Role-Scoped Structural Feedback
- Challenge weak auth, validation, secret handling, or dependency hygiene.
- State which security surface is weak and the smallest corrective rewrite.
