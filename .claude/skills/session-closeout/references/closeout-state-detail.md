---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/session-closeout/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
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
- Session produced zero implementation deliverable
Reason must be one of: `no-acceptance-surface`, `operational-only`, `research-only`.
## Hold Conditions
`closeout_state: hold` when:
- Active agent has unresolved handoff
- Implementation deliverable was produced but not validated
- User explicitly requested validation that was not completed
## Agent Lifecycle Resolution
Before closeout completion, each teammate must be resolved as `shutdown`, `terminated`, `hold-for-validation`, or non-live residue.
During session teardown, `standby` means eligible for automatic structured `shutdown_request`.
During active closeout, `TeamDelete` proceeds without a shutdown-order error; unresolved live-agent truth remains warning, hold, or residue truth.
A roster entry with no live agent-process proof is residue, not a live teammate. It does not require an impossible shutdown response before `TeamDelete`.

## Resolve Next Owner And Action
- Clean closeout state returns to session-closeout completion.
- Hold closeout state reports `HOLD` with residual owner and blocker.
- Partial closeout state reports warning-bearing closeout.
- Live teammate residue opens lifecycle resolution or warning-bearing closeout.
- Validation debt returns to the owning validation or acceptance path.
- Runtime cleanup debt returns to session-closeout teardown.
