---
name: enterprise-architecture
description: Review enterprise-scale architecture with Clean Architecture boundaries, bounded contexts, service contracts, production-readiness gates, and anti-pattern detection. Use when multi-service boundaries, externally committed deployment readiness, or enterprise design traceability materially affect implementation or review.
user-invocable: false
model: opus
effort: medium
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Fixed skill pattern: `Identity` -> `Coverage` -> specialist operating sections -> skill-local feedback blocks.
- Keep checklist tables, anti-pattern catalogs, and infrastructure pattern detail in `references/architecture-review-detail.md`.
- Code-quality review remains in `.claude/skills/code-quality-review/SKILL.md`.
### Reference Map
- `references/architecture-review-detail.md`: checklist tables, anti-pattern catalogs, infrastructure patterns, and enterprise readiness detail.
## Identity
You are the enterprise-architecture specialist capability.
- Conditional enterprise-architecture lens when delivery quality depends on clean layer separation, bounded-context design, service communication contracts, or production-readiness standards.
- Single-application internal layer separation belongs to `software-architecture`.
## Coverage
**Coverage:** layer separation correctness, architecture review/readiness gates, anti-pattern detection, inter-service communication pattern choice, infrastructure change protocol, and document-first design discipline.
**Adjacent boundaries:** canonical planning, business-policy design, rendered composition, mathematical proof, and final validation.

## Purpose
Load when enterprise-scale work depends on credible layer separation, bounded contexts, service contracts, design-document traceability, or production-readiness discipline.
## Responsibilities
- freeze enterprise-scale boundary rules, service communication patterns, and readiness gates
- require design documents before implementation on materially risky or multi-service changes
- detect anti-pattern normalization, layer leakage, and architecture-vs-implementation drift
- keep explicit that verification, direction, and quality bar must exist before enterprise-scale implementation proceeds
- Report `hold|blocker` when (operational test for `too weak`: the listed item cannot be enumerated as a named gate, named upstream-to-downstream trace link, or named layer boundary respectively):
  - readiness is too weak for safe enterprise delivery
  - design traceability is too weak for safe enterprise delivery
  - boundary credibility is too weak for safe enterprise delivery
## Activation
Activate only when at least one activation condition is true.
Condition 1: the work crosses 2+ services with independent deployment lifecycles.
Independent deployment lifecycles require both (a) separate deployable artifacts AND (b) at least one of: independent release/rollback, independent runtime environment, independent scaling/SLO, or independent operational responsibility.
Condition 2: bounded-context boundary review across services is the active deliverable.
Condition 3: a production-readiness gate fires before externally-committed deploy.
Single-application architecture review belongs to `software-architecture`.
Examples: intra-app boundaries, modular separation, persistence contracts, internal layer discipline.
Multi-module, monorepo, or integration-heavy work remains `software-architecture` unless Condition 1, 2, or 3 is proven from the frozen request or evidence.
Team-lead escalates if scope grows.
## Inputs
- active request source
- canonical contract and execution plan
- architecture or design documents
- business and software packets when architecture depends on them
## Outputs
Capture only the decisive enterprise-architecture packet:
- layer rules
- service contracts
- readiness gates
- active anti-pattern risks
- open surfaces and next owner/action
## Handoff Boundary
Route implementation divergence, missing design-doc traceability, security deferral, and production-readiness gaps explicitly upward.
Keep checklist tables and anti-pattern catalogs in `references/architecture-review-detail.md`.
## Operating Core
- design documents must precede implementation on enterprise-scale work
- domain stays free of outward dependency leakage
- dependencies point inward
- repository interfaces stay abstract and inward-facing
- composition-root responsibility stays explicit
- shared modules stay dependency-free and non-circular
## Operational Discipline
- Freeze the architecture skeleton before bulk implementation.
- Architecture must be deployable and operable in the target environment.
## Role-Scoped Structural Feedback
- Challenge weak layer boundaries, bounded-context drift, missing design-doc gates, or anti-pattern normalization.
- State which boundary or readiness gate is broken and the smallest corrective rewrite.
