---
name: session-closeout-reference
PRIMARY-OWNER: team-lead
auto-inject: false
---
# Session Closeout Reference
## Auto-inject
false — load explicitly when detailed closeout state is needed.
## Closeout State Schema
- `session_id`: string
- `closeout_initiated`: ISO8601 timestamp
- `validation_ownership`: string | "not-needed"
- `acceptance_evidence`: string | "not-needed" | null
- `worker_lifecycle_resolved`: boolean
- `runtime_cleaned`: boolean
- `continuity_captured`: boolean
- `closeout_state`: "clean" | "hold" | "partial"
## not-needed Conditions
`validation_ownership: not-needed` is valid when:
- Session performed only research, Q&A, or read-only analysis
- No implementation deliverable was produced or accepted
Reason must be one of: `no-acceptance-surface`, `operational-only`, `research-only`.
## Hold Conditions
`closeout_state: hold` when:
- Active worker has unresolved handoff
- Implementation deliverable was produced but not validated
- User explicitly requested validation that was not completed
## Worker Lifecycle Resolution
Before teardown, every worker must have one of: `standby`, `shutdown`, `hold-for-validation`.
Workers on `standby` may be shut down during teardown without separate SendMessage if session is ending.
