---
name: log-qa
description: Log-based QA methodology using structured JSON logging and Docker log monitoring as an alternative to traditional test scripts.
user-invocable: false
---

PRIMARY-OWNER: tester

## Structural Contract

- Fixed ownership order: local sections `Activation Criteria` → `Core Methodology` → `QA Workflow Steps` → `Iterative Convergence Tracking` → owner-local feedback blocks. Reference-owned detail sections are `JSON Log Format Standard`, `Request ID Propagation`, `Logging Implementation Patterns`, `Docker-Based QA Workflow`, `Issue Detection Thresholds`, `Implementation Checklists`, and `Cycle Documentation Template`.
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

> For JSON Log Format Standard, see reference.md

> For Request ID Propagation, see reference.md

> For Logging Implementation Patterns, see reference.md

> For Docker-Based QA Workflow, see reference.md

> For Issue Detection Thresholds, see reference.md

## QA Workflow Steps

### Step 1 — Start Environment
Start environment with `docker compose up -d`, then stream logs (`docker compose logs -f`) to monitor throughout testing.

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

> For Issue Documentation template, see reference.md

---

## Iterative Convergence Tracking

Target: >85% scenario pass rate before declaring a feature stable.


> For Convergence Cycle Documentation Template, see reference.md

### Convergence Signals

| Signal | Interpretation |
|--------|---------------|
| < 5% pass-rate gain over 2+ consecutive cycles | Plateau — explicitly scope remaining failures |
| Repeated T1 on same endpoint across cycles | Structural issue, not per-cycle noise — escalate |
| T3 items consistently unresolved | Logging infrastructure debt — route to developer |

---

> For Implementation Checklists, see reference.md

## Deliverable Quality Philosophy Application

Role-specific application of CLAUDE.md Deliverable Quality Philosophy principles:

- P11 Cross-Verification: Log-based QA findings must be corroborated across service layers using request ID propagation. A single-layer log signal is a candidate finding; end-to-end trace confirmation is required before severity classification.
- P9 Operational Usability: Log infrastructure must be usable by the tester without developer assistance — JSON format, Docker commands, and issue templates must be self-contained and immediately runnable.

## Role-Scoped Self-Growth Loop

- Track repeated log coverage gaps (missing request ID propagation, services without structured JSON, unmonitored error paths) across sessions.
- When the same coverage gap class recurs, escalate to team-lead as a capability-gap signal for checklist or infrastructure hardening.

## Structural Feedback To Upstream

- Signal to team-lead when monitoring blind spots (services without log coverage, recurring T1 errors on the same endpoint) suggest upstream implementation or infrastructure gaps.
