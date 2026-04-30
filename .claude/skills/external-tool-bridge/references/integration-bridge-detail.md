---
PRIMARY-OWNER: developer
LOAD-POLICY: on-demand reference only
---

# Int-Op — Reference Material
Reference checklists, tables, and catalogs for the external-tool-bridge skill.
Agents must Read this file when needed — it is NOT auto-injected on Skill load.
### Pre-Verification Checklist
Before initiating any external bridge, verify all of the following:
- **Credentials**: present, non-expired, loaded from secure source (not hardcoded)
- **Endpoint reachability**: target host/port/path accessible from execution environment
- **Quota/rate-limit**: current usage headroom confirmed before bulk operations
- **Permission scope**: token or credential scope covers required operations and no more
- **Cleanup path**: explicit procedure exists to close sessions, revoke tokens, and remove residual state on success and on failure
### Integration Failure Patterns
Standard response patterns for external service failures:
- **Retry policy**: max 2 retries with exponential backoff (1s, 3s). Document retry count in bridge report. Same failure on all retries → stop and report blocked state
- **Timeout**: define explicit timeout per external call. Default 30s for API calls, 60s for file transfers. Timeout without response = blocked state, not silent retry
- **Circuit breaker**: after 3 consecutive failures to same endpoint, stop attempting and report service-level block. Do not continue with degraded assumptions
- **Fallback escalation**: when primary bridge fails, attempt fallback path if defined. If no fallback defined, this is a bridge design defect — report it as such
All failure states must produce a structured blocked-condition report, not a generic error message.
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
- Do not embed credentials, tokens, or session keys in any output artifact (integration notes, logs, bridge reports). A-02 violation risk
- Use minimum token scope: request only the permissions required for the specific bridge operation
- Define session lifecycle at bridge design time: when the session opens, when it closes, and what triggers early termination
- Document rotation risk: note any tokens or credentials that have expiry windows that could invalidate mid-session, and specify the re-auth path
### Data Pipeline Bridge Rules
When the external bridge involves batch data transfer, streaming ingest, or pipeline synchronization:
- **Idempotency proof**: define the condition under which re-running the bridge step produces identical results without side effects (duplicate records, double charges, duplicate notifications)
- **Checkpoint/resume**: for operations that may be interrupted, define the minimum recoverable state and the resume entry point that avoids full restart
- **Batch vs streaming**: declare the transfer pattern upfront (batch pull, streaming push, polling, webhook) and justify the choice relative to delivery latency and quota constraints; switching patterns mid-bridge without re-verification = bridge design defect
