---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
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
- `agent_lifecycle_resolved`: boolean
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
- Active agent has unresolved handoff
- Implementation deliverable was produced but not validated
- User explicitly requested validation that was not completed
## Agent Lifecycle Resolution
Before teardown, every agent must have one of: `standby`, `shutdown`, `hold-for-validation`.
Agents on `standby` may be shut down during teardown without separate SendMessage if session is ending.
