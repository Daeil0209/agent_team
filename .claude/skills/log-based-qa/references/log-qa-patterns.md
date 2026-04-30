---
PRIMARY-OWNER: tester
LOAD-POLICY: on-demand reference only
---

# Reference Material
## JSON Log Format Standard
### Required Fields
```json
{
  "timestamp": "2026-01-08T10:30:00.000Z",
  "level": "INFO",
  "service": "api",
  "request_id": "req_abc123",
  "message": "Request completed",
  "data": { "method": "POST", "path": "/api/users", "status": 200, "duration_ms": 45 }
}
```
| Field | Type | Description |
|-------|------|-------------|
| timestamp | ISO 8601 | Time of occurrence |
| level | string | DEBUG, INFO, WARNING, ERROR |
| service | string | Service name (api, web, job, nginx, etc.) |
| request_id | string | Request tracking ID |
| message | string | Human-readable log message |
| data | object | Additional context (optional) |
### Log Level Policy
| Environment | Minimum Level | Purpose |
|-------------|---------------|---------|
| Development / Local | DEBUG | Full visibility for QA |
| Staging | INFO | Integration verification |
| Production | WARN | Operations monitoring only |
---
## Request ID Propagation
Generate UUID at entry point, propagate via `X-Request-ID` header, include in all log entries for cross-service tracing.
```
Client → API Gateway → Backend → Database
  req_abc    req_abc     req_abc    req_abc
```
---
## Logging Implementation Patterns
- **Backend middleware** (e.g., FastAPI/Express): Intercept each request at entry to extract or generate `request_id`, log method/path at start and status/duration_ms at completion, propagate `X-Request-ID` in response headers.
- **Frontend logger** (e.g., Next.js/React): Level-aware JSON logger (DEBUG/INFO/WARNING/ERROR) that includes timestamp, service, request_id, and message; includes `X-Request-ID` on all outbound API requests.
- **Nginx JSON logging**: Configure `log_format` to emit structured JSON with timestamp, request_id, method, URI, status, and duration_ms fields.
---
## Docker-Based QA Workflow
- **docker-compose**: Set `LOG_LEVEL=DEBUG` and `LOG_FORMAT=json` in service environment; use `json-file` driver with rotation (`max-size: 10m`, `max-file: 3`).
- **Real-time monitoring**: Stream with `docker compose logs -f [service]`; filter by `'"level":"ERROR"'`, `'"status":5'`, or a specific `request_id` to trace issues end-to-end.
---
## Issue Detection Thresholds
| Condition | Severity | Action |
|-----------|----------|--------|
| `level: ERROR` or `status: 5xx` | **T2** — quality gate | Stage-blocking: report and investigate |
| `duration_ms > 3000` | **T2** — quality gate | Warning: report slow path |
| 3+ consecutive failures on same endpoint | **T1** — governance block | Escalate as system-level issue |
| `status: 401` or `403` unexpectedly | **T2** — quality gate | Warning: auth/permission investigation |
| `duration_ms > 1000` | **T2** — quality gate | Warning: performance degradation |
| Missing required log fields | **T3** — advisory | Note for logging infrastructure |
| `request_id` not propagated across layers | **T3** — advisory | Note for traceability gap |
> **Severity framework** (used locally): T0=system halt, T1=governance block, T2=quality gate, T3=advisory.

If logs are the frozen decisive proof surface, missing required log fields or request_id propagation gaps are `blocked proof`, not advisory, until another truthful proof surface is frozen.
---
### Issue Documentation Template
```markdown
### ISSUE-001: {short title}
- **Request ID**: req_xxxxxx
- **Severity**: T1 / T2 / T3
- **Reproduction**: {steps to reproduce}
- **Log evidence**:
  ```json
  {"level":"ERROR","request_id":"req_xxxxxx","message":"...","data":{...}}
  ```
- **Root cause**: {description}
- **Recommended fix**: {action}
```
## Implementation Checklists
### Logging Infrastructure
- [ ] JSON log format applied to all services
- [ ] Request ID generation at entry point
- [ ] `X-Request-ID` header propagated across all service layers
- [ ] Log level per environment (`DEBUG` for dev/staging, `WARN` for prod)
- [ ] Docker `json-file` logging driver with rotation configured
### QA Workflow Readiness
- [ ] Docker Compose environment starts cleanly and log stream confirms JSON output
- [ ] Manual test flow documented (core paths, edge cases, error paths)
- [ ] Issue documentation template ready
- [ ] Convergence cycle tracker initialized with target pass rate defined
## Cycle Documentation Template
```markdown
## QA Cycle N — {feature name} — {YYYY-MM-DD}

- **Pass Rate**: N% (X passed / Y total scenarios)

| Scenario | Status | Log Evidence |
|----------|--------|--------------|
| Scenario 1 | ✅ PASS | |
| Scenario 2 | ❌ FAIL | {request_id + error summary} |

### Bugs Found This Cycle
- **BUG-N01**: {title} — Root cause: {desc} — Fix: {what changed} — Files: `path/file:line`

### Next Cycle Focus
- {what to retest or add coverage for}
```
