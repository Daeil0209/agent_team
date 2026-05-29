---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/external-tool-bridge/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# Int-Op — Reference Material
Reference checklists, tables, and catalogs for the external-tool-bridge skill.
Read this file when bridge detail is required by the active owner path.
### Pre-Verification Checklist
Before initiating any external bridge, verify all of the following:
- **Credentials**: present, non-expired, and loaded from secure source
- **Endpoint reachability**: target host/port/path accessible from execution environment
- **Quota/rate-limit**: current usage headroom confirmed before bulk operations
- **Permission scope**: token or credential scope covers required operations at minimum scope
- **Setup safety**: classify required setup as `allowed-setup`, `approval-required`, `defer-capable`, or `blocked`; `allowed-setup` proceeds inside the frozen boundary
- **Cleanup path**: explicit procedure exists to close sessions, revoke tokens, and remove residual state on success and on failure
### Integration Failure Patterns
Standard response patterns for external service failures:
- **Retry policy**: retry requires changed timing, endpoint health, fallback route, or setup state that can produce new signal. Use backoff. Document each retry basis in the bridge report. Same failure with no new route -> blocked-state report
- **Timeout**: define explicit timeout per external call. Default 30s for API calls, 60s for file transfers. Timeout with no response -> blocked state
- **Circuit breaker**: repeated consecutive failures to the same endpoint with unchanged route stop further attempts. Report service-level block.
- **Fallback escalation**: when primary bridge fails, attempt fallback path if defined. If no fallback defined, this is a bridge design defect — report it as such
All failure states must produce a structured blocked-condition report, not a generic error message.
Allowed setup means bounded, reversible where practical, non-damaging, credential-free, non-paid, and directly needed for the frozen proof or delivery path.
Standard font packages, browser runtime/cache, and equivalent local tool prerequisites run under a frozen allowed-setup boundary.
The following are approval-required or blocked by default:
- Docker Desktop-class installers
- persistent daemons/services
- credential repair
- paid/licensed tools
- destructive package actions
- security-setting changes
### Blocked-Condition Report Schema
Required fields for every blocked-state report:
- `bridge_step`: which integration step failed (setup, auth, endpoint, quota, data transfer, cleanup)
- `failure_type`: classification (auth_error, timeout, quota_exceeded, permission_denied, endpoint_unreachable, config_missing, cleanup_failure)
- `evidence`: raw error message, status code, or observable symptom
- `retries_attempted`: count and outcomes of each retry
- `fallback_attempted`: whether an alternative path was tried and what happened
- `downstream_impact`: which downstream lanes or deliverables are blocked
- `unblock_path`: concrete steps that would resolve the block (credential rotation, quota increase, local-first substitution, operator intervention)
### Auth Bridge Discipline
- Keep credentials, tokens, and session keys out of output artifacts such as integration notes, logs, and bridge reports. A-02 violation risk
- Use minimum token scope: request only the permissions required for the specific bridge operation
- Define session lifecycle at bridge design time: when the session opens, when it closes, and what triggers early termination
- Document rotation risk: note any tokens or credentials with expiry windows that can invalidate mid-session, and specify the re-auth path
### Data Pipeline Bridge Rules
When the external bridge involves batch data transfer, streaming ingest, or pipeline synchronization:
- **Idempotency proof**: define the condition under which re-running the bridge step produces identical results with no side effects (duplicate records, double charges, duplicate notifications)
- **Checkpoint/resume**: for interruptible operations, define the minimum recoverable state and the resume entry point that avoids full restart
- **Batch vs streaming**: declare the transfer pattern upfront (batch pull, streaming push, polling, webhook) and justify the choice relative to delivery latency and quota constraints; switching patterns mid-bridge requires re-verification

## Resolve Next Owner And Action
- Passing pre-verification opens bounded external bridge execution.
- Failed credential, endpoint, quota, permission, setup, or cleanup check opens blocked-condition report.
- Allowed setup opens bounded setup execution.
- Approval-required setup opens explicit approval or deferral path.
- Retryable failure opens one retry path with changed timing, endpoint health, fallback route, or setup state.
- Repeated unchanged failure opens blocked-condition report.
- Successful bridge execution returns evidence to the consuming owner.
