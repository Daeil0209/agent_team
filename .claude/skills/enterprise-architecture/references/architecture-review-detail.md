---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/enterprise-architecture/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---

# Reference Material
## Contents
- Clean Architecture Layer Diagram
- Layer Violation Detection
- Architecture Review Checklist
- Pre-Production Checklist
- Anti-Pattern Detection
- Inter-Service Communication Patterns
- Infrastructure Change Protocol
- Resolve Next Owner And Action

## Clean Architecture Layer Diagram
```
┌─────────────────────────────────────────────┐
│  API Layer                                  │
│  (controllers, routes, request/response     │
│   DTOs, input validation)                   │
└────────────────────┬────────────────────────┘
                     │ depends on
┌────────────────────▼────────────────────────┐
│  Application Layer                          │
│  (use cases, application services,          │
│   command/query handlers, orchestration)    │
└────────────────────┬────────────────────────┘
                     │ depends on
┌────────────────────▼────────────────────────┐
│  Domain Layer                               │
│  (entities, value objects, domain events,   │
│   repository interfaces, domain services)   │
│  ← ZERO external dependencies →             │
└─────────────────────────────────────────────┘
                     ▲
                     │ implements
┌────────────────────┴────────────────────────┐
│  Infrastructure Layer                       │
│  (DB implementations, external API clients, │
│   message queue adapters, file storage)     │
└─────────────────────────────────────────────┘
```
## Layer Violation Detection
| Violation | Example | Severity |
|---|---|---|
| Domain imports infrastructure | Entity imports ORM model or HTTP client | T1 — block |
| Application bypasses domain | Use case calls DB directly instead of repository interface | T1 — block |
| Circular dependency | Module A imports Module B, Module B imports Module A | T1 — block |
| Framework leak into domain | Domain entity extends framework base class | T2 — gate |
| Infrastructure detail in API contract | DB column name exposed in response DTO | T2 — gate |
## Architecture Review Checklist
Run this checklist before accepting any enterprise architecture work. All items must pass or carry explicit blocked-state evidence with a corrective path.
- [ ] Clean Architecture layer separation maintained — no layer imports from an outer layer
- [ ] Domain layer has zero external dependencies (no ORM, HTTP, or framework imports)
- [ ] Repository interfaces defined in Domain layer; concrete implementations in Infrastructure layer
- [ ] Shared modules isolated with no circular dependencies
- [ ] API contracts documented and consistent between design doc and implementation
- [ ] Error handling structured: custom error types defined, consistent error response format enforced
- [ ] Logging structured: JSON format, correlation IDs propagated, appropriate log levels used
- [ ] Security documentation current: auth flow documented, RBAC model explicit, secret management policy stated
- [ ] Configuration externalized: no hardcoded environment-specific values in code
- [ ] Inter-service communication patterns documented: sync vs async decision explicit, retry and timeout policies stated
**Failing 1 or more items:** return blocked architecture-review evidence with the failed items listed and corrective actions specified. Architecture-review evidence release requires resolved layer violations; final acceptance authority remains with `validator` per `.claude/CLAUDE.md` `## Acceptance`.
## Pre-Production Checklist
Before declaring enterprise work production-ready, all items must pass or carry explicit blocked-state evidence with owner and timeline.
- [ ] All quality checks pass: code review complete, security scan clean, architecture compliance verified
- [ ] Performance benchmarks meet requirements: response time and throughput targets confirmed with measured values
- [ ] Monitoring and alerting configured: health checks active, error rate alerts defined, dashboard available
- [ ] Rollback plan documented and tested: procedure exists, last-tested date recorded
- [ ] Deployment pipeline verified: staging → production flow tested end-to-end
- [ ] Security scan completed: dependency audit run, secret detection clean, no known critical CVEs unaddressed
- [ ] Load testing completed if applicable: baseline and peak load results recorded
- [ ] Documentation updated: API docs current, architecture diagrams match implementation, runbooks exist
**Failing 1 or more items:** production-readiness evidence is blocked. Each failing item requires an owner, corrective action, and completion target before the production-readiness claim resumes; final acceptance authority remains with `validator` per `.claude/CLAUDE.md` `## Acceptance`.
## Anti-Pattern Detection
| Anti-Pattern | Symptoms | Correction |
|---|---|---|
| **Blind Trust** | AI output used before review or test evidence | Require code review and test coverage for all AI-generated code before merge |
| **Verbal Instructions** | Requirements exist only in conversation or memory | Write requirements in the project-local canonical requirements record before implementation begins; `docs/00-requirements/` is an example path |
| **Skipping Design** | Jump from idea directly to code | Require a project-local design record with architecture options and trade-off rationale before implementation begins; `docs/02-design/` is an example path |
| **Context Fragmentation** | Different team members operate from different understandings | Use Context Anchor pattern: WHY / WHO / RISK / SUCCESS / SCOPE — shared and visible |
| **Outdated Docs** | Code evolved while design or API docs stayed stale | Update the project-local design record and API contracts inside the implementation task |
| **Layer Leakage** | Business logic accumulates in API controllers or infrastructure adapters | Enforce Clean Architecture layer rules; return blocked architecture evidence on PR with misplaced logic |
| **God Service** | One application service handles unrelated responsibilities | Decompose by bounded context; each service owns one responsibility domain |
| **Hardcoded Configuration** | Environment-specific values embedded in source code | Externalize all configuration; fail architecture review if any hardcoded env value is found |
**Code quality deep review** (SOLID checklist, duplication taxonomy, reusability assessment, extensibility patterns, refactoring priority matrix) → see `.claude/skills/code-quality-review/SKILL.md`.
## Inter-Service Communication Patterns
### Synchronous Communication
Use when: **the caller needs the result before it can proceed.**
| Concern | Requirement |
|---|---|
| Protocol | REST or gRPC; internal service token auth |
| Service discovery | Registry or DNS-based; no hardcoded IP addresses |
| Circuit breaker | Required for calls across service boundaries; failure threshold and recovery period documented |
| Timeout policy | Required; timeout values explicit in configuration, not hardcoded |
| Retry policy | Idempotency required before retry; exponential backoff with jitter |
### Asynchronous Communication
Use when: **the caller can proceed before the result arrives.**
| Concern | Requirement |
|---|---|
| Transport | Message queue or event bus (technology is a project decision, not a skill mandate) |
| Pattern | Topic-based pub/sub for event-triggered flows |
| Event naming | Domain-prefixed verb-noun: `user.created`, `order.completed`, `payment.failed` |
| Consumer idempotency | All consumers must handle duplicate message delivery safely |
| Dead letter queue | Required; unprocessable messages route to the dead letter queue |
| Schema versioning | Event schemas versioned; breaking changes require coordination window |
### Selection Rule
Default to async for operations whose caller can proceed before the result arrives. Use sync when the caller genuinely needs the result before continuing. Undocumented sync calls where async is sufficient are an architecture review flag.
## Infrastructure Change Protocol
For all infrastructure changes (database schema, message queue topology, network configuration, secret rotation, service mesh rules):
1. **Documentation first** — update `docs/02-design/` with: what changes, why it changes, impact assessment on dependent services
2. **Dependency mapping** — identify all services and consumers affected by the change; no change proceeds until the dependency map is complete
3. **Change plan with rollback** — document the forward change steps and the rollback procedure; rollback must be tested before production
4. **Staging verification** — apply to staging environment, run affected integration tests, confirm monitoring shows expected behavior
5. **Production application with monitoring** — apply to production with active monitoring; rollback window must remain open until stability is confirmed
**Blocked condition:** production infrastructure change requires a tested rollback plan. Missing rollback proof is a T1 deployment block per `.claude/skills/security-review/references/security-review-detail.md` `## 3. Security Severity Framework` (T0-T3 anchor reused for infrastructure-change governance).

## Resolve Next Owner And Action
- Return architecture review findings, communication-pattern selection, infrastructure change requirements, and rollback status to the active enterprise-architecture workflow.
- If a finding affects dependency mapping, production readiness, or lane acceptance, route that requirement to the owning design, implementation, or validation path.
