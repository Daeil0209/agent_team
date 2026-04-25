---
name: log-qa
description: Log-based QA methodology using structured JSON logging and Docker log monitoring as an alternative to traditional test scripts.
user-invocable: false
---

## Structural Contract

- Fixed top-level order: Activation Criteria → Core Methodology → JSON Log Format → Request ID Propagation → Implementation Patterns → Docker QA Workflow → Issue Detection → QA Workflow Steps → Convergence Tracking → Checklists.
- This skill **complements** the `tester` skill; it does not replace it. `tester` retains execution authority and the final proof-classification obligation. This skill provides the methodology surface when test scripts are absent or impractical.
- `PRIMARY-OWNER: tester`. `SECONDARY-CONSUMER: developer` (logging infrastructure setup only).
- Severity levels in this skill map to the shared T0–T3 framework in `CLAUDE.md`.
- Technology references (e.g., FastAPI, Next.js, Nginx) are illustrative examples, not requirements.
- Do not add new top-level sections without governance review.

---

## Activation Criteria

Load this skill when any of the following apply:
- No executable test scripts exist for the feature under test
- The test environment is Docker-based and log output is the primary observable signal
- Integration or end-to-end behavior must be verified through runtime signal rather than unit assertion
- `developer` needs logging infrastructure guidance to enable QA observability

team-lead may also direct loading via SKILL-AUTH.

**Backup authorization (team-lead directed)**:
```
SKILL-AUTH: lane=tester:<lane-id>; surface=<feature-under-test>; skill=log-qa
```

**This skill does not authorize** skipping test scripts when they already exist or are practical to write.

---

## Core Methodology

```
Traditional:  Write test code → Execute → Check results → Maintain
Log-Based QA: Build log infra → Manual UX test → Log analysis → Issue detection
```

**When to prefer log-based QA:**
- New features without established test harness
- UI/UX flows that are difficult to automate reliably
- Integration verification where observability matters more than assertion coverage
- Rapid iteration where log signal arrives faster than test scaffolding

**Core principles:**
1. Log all API calls including 200 OK — not just errors
2. Use structured JSON so logs are machine-parseable
3. Propagate a Request ID across all layers for end-to-end traceability
4. Monitor in real time and document issues immediately on detection

---

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
| service | string | Service name (api, web, worker, nginx, etc.) |
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

Generate at the entry point; propagate via `X-Request-ID` header so one request is traceable end-to-end:

```
Client → API Gateway → Backend → Database
  req_abc    req_abc     req_abc    req_abc
```

**Entry point (e.g., backend middleware):**
```python
request_id = request.headers.get('X-Request-ID') or f'req_{uuid4().hex[:8]}'
response.headers['X-Request-ID'] = request_id
```

**Downstream propagation (e.g., frontend API client):**
```typescript
const requestId = `req_${uuid().slice(0, 8)}`;
headers['X-Request-ID'] = requestId;
logger.info('Request started', { request_id: requestId });
```

---

## Logging Implementation Patterns

### Backend Middleware (e.g., FastAPI/Express)

```python
class LoggingMiddleware:
    async def __call__(self, request, call_next):
        request_id = request.headers.get('X-Request-ID', f'req_{uuid4().hex[:8]}')
        start = time.time()
        log('INFO', 'Request started', request_id,
            {'method': request.method, 'path': request.url.path})
        response = await call_next(request)
        log('INFO', 'Request completed', request_id,
            {'status': response.status_code,
             'duration_ms': round((time.time() - start) * 1000, 2)})
        response.headers['X-Request-ID'] = request_id
        return response
```

### Frontend Logger (e.g., Next.js/React)

```typescript
const MIN_LEVEL = process.env.NODE_ENV === 'production' ? 'INFO' : 'DEBUG';
const LEVEL_ORDER = { DEBUG: 0, INFO: 1, WARNING: 2, ERROR: 3 };

function log(level: LogLevel, message: string, data?: object) {
  if (LEVEL_ORDER[level] < LEVEL_ORDER[MIN_LEVEL]) return;
  console.log(JSON.stringify({
    timestamp: new Date().toISOString(), level,
    service: 'web', message, ...data
  }));
}
export const logger = { debug, info, warning, error }; // each wraps log()
```

### Nginx JSON Log Format

```nginx
log_format json_log escape=json
  '{"timestamp":"$time_iso8601","level":"INFO","service":"nginx",'
  '"request_id":"$http_x_request_id","data":{'
  '"method":"$request_method","uri":"$request_uri",'
  '"status":$status,"duration_ms":${request_time}000}}';

access_log /var/log/nginx/access.log json_log;
```

---

## Docker-Based QA Workflow

### docker-compose Logging Configuration

```yaml
services:
  api:
    environment:
      - LOG_LEVEL=DEBUG
      - LOG_FORMAT=json
    logging:
      driver: json-file
      options: { max-size: "10m", max-file: "3" }
```

### Real-Time Log Monitoring Commands

```bash
# Stream all services
docker compose logs -f

# Single service
docker compose logs -f api

# Filter by level
docker compose logs -f | grep '"level":"ERROR"'

# Filter 5xx responses
docker compose logs -f | grep '"status":5'

# Trace single request end-to-end
docker compose logs -f | grep 'req_abc123'

# Pretty-print JSON entries
docker compose logs -f | python3 -c \
  "import sys,json; [print(json.dumps(json.loads(l),indent=2)) for l in sys.stdin if l.strip()]"
```

---

## Issue Detection Thresholds

| Condition | Severity | Action |
|-----------|----------|--------|
| `level: ERROR` or `status: 5xx` | **T1** — governance block | Immediate: stop and report |
| `duration_ms > 3000` | **T1** — governance block | Immediate: report slow path |
| 3+ consecutive failures on same endpoint | **T1** — governance block | Escalate as system-level issue |
| `status: 401` or `403` unexpectedly | **T2** — quality gate | Warning: auth/permission investigation |
| `duration_ms > 1000` | **T2** — quality gate | Warning: performance degradation |
| Missing required log fields | **T3** — advisory | Note for logging infrastructure |
| `request_id` not propagated across layers | **T3** — advisory | Note for traceability gap |

> **Severity framework** (from `CLAUDE.md`): T0=system halt, T1=governance block, T2=quality gate, T3=advisory.

---

## QA Workflow Steps

### Step 1 — Start Environment
```bash
docker compose up -d
docker compose logs -f   # keep open throughout testing
```

### Step 2 — Manual UX Testing
Execute core user flows while monitoring the log stream:
- Authentication paths (sign up, login, logout, password reset)
- Core feature paths (happy path + edge cases)
- Error conditions (invalid input, missing auth, resource not found)
- Key state transitions

### Step 3 — Log Analysis
Actively monitor and record during testing:
- All ERROR entries → capture `request_id`, `message`, `data`
- Slow responses (`duration_ms > 1000`) → note endpoint and timing
- Unexpected status codes → note pattern and frequency
- Missing `request_id` propagation → flag traceability gaps

### Step 4 — Issue Documentation

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

---

## Iterative Convergence Tracking

Target: >85% scenario pass rate before declaring a feature stable.

### Cycle Documentation Template

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

### Convergence Signals

| Signal | Interpretation |
|--------|---------------|
| < 5% pass-rate gain over 2+ consecutive cycles | Plateau — explicitly scope remaining failures |
| Repeated T1 on same endpoint across cycles | Structural issue, not per-cycle noise — escalate |
| T3 items consistently unresolved | Logging infrastructure debt — route to developer |

---

## Implementation Checklists

### Logging Infrastructure
- [ ] JSON log format applied to all services
- [ ] Request ID generation at entry point
- [ ] `X-Request-ID` header propagated across all service layers
- [ ] Log level per environment (`DEBUG` for dev/staging, `WARN` for prod)
- [ ] Docker `json-file` logging driver with rotation configured

### Backend Logging
- [ ] Logging middleware captures request start + completion with `duration_ms`
- [ ] All API calls logged including 200 OK
- [ ] Business logic key steps logged with `request_id`
- [ ] Error conditions logged with full context in `data` field

### Frontend Logging
- [ ] Logger module implemented (level-aware, environment-configurable)
- [ ] API client logs request start, response received, and errors
- [ ] `X-Request-ID` header included in all outbound API requests

### QA Workflow Readiness
- [ ] Docker Compose environment starts cleanly and log stream confirms JSON output
- [ ] Manual test flow documented (core paths, edge cases, error paths)
- [ ] Issue documentation template ready
- [ ] Convergence cycle tracker initialized with target pass rate defined
