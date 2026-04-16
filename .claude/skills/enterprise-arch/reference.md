# Reference Material

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

### Layer Violation Detection

| Violation | Example | Severity |
|---|---|---|
| Domain imports infrastructure | Entity imports ORM model or HTTP client | T1 — block |
| Application bypasses domain | Use case calls DB directly instead of repository interface | T1 — block |
| Circular dependency | Module A imports Module B, Module B imports Module A | T1 — block |
| Framework leak into domain | Domain entity extends framework base class | T2 — gate |
| Infrastructure detail in API contract | DB column name exposed in response DTO | T2 — gate |


## Architecture Review Checklist

Run this checklist before accepting any enterprise architecture work. All items must pass or carry an explicit `HOLD` with a corrective path.

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

**Failing 1 or more items:** return `HOLD` with the failed items listed and corrective actions specified. Do not approve architecture with unresolved layer violations.


## Pre-Production Checklist

Before declaring enterprise work production-ready, all items must pass or carry an explicit `HOLD` with owner and timeline.

- [ ] All quality checks pass: code review complete, security scan clean, architecture compliance verified
- [ ] Performance benchmarks meet requirements: response time and throughput targets confirmed with measured values
- [ ] Monitoring and alerting configured: health checks active, error rate alerts defined, dashboard available
- [ ] Rollback plan documented and tested: procedure exists, last-tested date recorded
- [ ] Deployment pipeline verified: staging → production flow tested end-to-end
- [ ] Security scan completed: dependency audit run, secret detection clean, no known critical CVEs unaddressed
- [ ] Load testing completed if applicable: baseline and peak load results recorded
- [ ] Documentation updated: API docs current, architecture diagrams match implementation, runbooks exist

**Failing 1 or more items:** production declaration is `HOLD`. Each failing item requires an owner, corrective action, and completion target before the `HOLD` lifts.


## Anti-Pattern Detection

| Anti-Pattern | Symptoms | Correction |
|---|---|---|
| **Blind Trust** | AI output used without review or tests | Require code review and test coverage for all AI-generated code before merge |
| **Verbal Instructions** | Requirements exist only in conversation or memory | Write requirements in `docs/00-requirements/` before implementation begins |
| **Skipping Design** | Jump from idea directly to code | Require design doc in `docs/02-design/` with architecture options and trade-off rationale |
| **Context Fragmentation** | Different team members operate from different understandings | Use Context Anchor pattern: WHY / WHO / RISK / SUCCESS / SCOPE — shared and visible |
| **Outdated Docs** | Code evolved without updating design or API docs | Update `docs/02-design/` and API contracts as part of the implementation task, not after |
| **Layer Leakage** | Business logic accumulates in API controllers or infrastructure adapters | Enforce Clean Architecture layer rules; return `HOLD` on PR with misplaced logic |
| **God Service** | One application service handles unrelated responsibilities | Decompose by bounded context; each service owns one responsibility domain |
| **Hardcoded Configuration** | Environment-specific values embedded in source code | Externalize all configuration; fail architecture review if any hardcoded env value is found |

**Code quality deep review** (SOLID checklist, duplication taxonomy, reusability assessment, extensibility patterns, refactoring priority matrix) → see `skills/code-quality/SKILL.md`.


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

Use when: **the caller does not need the result to proceed.**

| Concern | Requirement |
|---|---|
| Transport | Message queue or event bus (technology is a project decision, not a skill mandate) |
| Pattern | Topic-based pub/sub for event-driven flows |
| Event naming | Domain-prefixed verb-noun: `user.created`, `order.completed`, `payment.failed` |
| Consumer idempotency | All consumers must handle duplicate message delivery safely |
| Dead letter queue | Required; unprocessable messages must not be silently dropped |
| Schema versioning | Event schemas versioned; breaking changes require coordination window |

### Selection Rule

Default to async for operations that do not need an immediate response. Use sync only when the caller genuinely cannot proceed without the result. Undocumented sync calls where async is sufficient are an architecture review flag.


## Infrastructure Change Protocol

For all infrastructure changes (database schema, message queue topology, network configuration, secret rotation, service mesh rules):

1. **Documentation first** — update `docs/02-design/` with: what changes, why it changes, impact assessment on dependent services
2. **Dependency mapping** — identify all services and consumers affected by the change; no change proceeds until the dependency map is complete
3. **Change plan with rollback** — document the forward change steps and the rollback procedure; rollback must be tested before production
4. **Staging verification** — apply to staging environment, run affected integration tests, confirm monitoring shows expected behavior
5. **Production application with monitoring** — apply to production with active monitoring; rollback window must remain open until stability is confirmed

**HOLD condition:** infrastructure change applied to production without a tested rollback plan is a T1 governance block.

