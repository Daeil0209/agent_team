---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/session-closeout/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# Session Closeout Reference
## Closeout State Schema
- `sessionId`: string
- `workersDrained`: boolean
- `healthCronRemoved`: boolean
- `runtimeRemoved`: boolean
- `validationOwnerState`: "assigned" | "not-needed" | "missing" | "unknown"
- `acceptanceEvidenceState`: "present" | "not-needed" | "missing" | "unknown"
- `supervisorReviewState`: "completed" | "not-needed" | "required" | "missing" | "unknown"
- `closeoutNotNeededReason`: "no-acceptance-surface" | "operational-only" | "research-only" | ""
- `continuityState`: "current" | "captured-clean" | "captured-with-warnings" | "not-required" | "stale" | "missing" | "unknown"
- `holdReason`: string
- `closeoutDisposition`: "none" | "blocked" | "hold"
- `cleanupEligibility`: "ready" | "blocked"
## not-needed Conditions
`validationOwnerState: not-needed` and `acceptanceEvidenceState: not-needed` are valid when the session produced zero implementation deliverable and one condition applies:
- Session performed only research, Q&A, or read-only analysis
- Session performed only runtime setup, teardown, monitoring, or cleanup operations
`closeoutNotNeededReason` must be one of: `no-acceptance-surface`, `operational-only`, `research-only`.
## Hold Conditions
`closeoutDisposition: hold` when:
- Active agent has unresolved handoff
- Implementation deliverable was produced but not validated
- User explicitly requested validation that was not completed
- Closeout governance remains unresolved and `holdReason` names the residual blocker.
## Agent Cleanup Resolution
Before closeout completion, each teammate must be resolved as structured shutdown path, terminated, `STANDBY` with an owning validation or correction route, or non-live residue.
During session teardown, a canonical `STANDBY` teammate with no remaining validation, correction, or reuse route becomes eligible for automatic structured `shutdown_request`. Canonical `STANDBY` semantics are owned by `.claude/skills/session-boot/references/runtime-state-detail.md`; reuse-fit predicate is owned by `.claude/reference/work-execution-core-law.md` `## Parallelism And Bottleneck Law`; closeout does not redefine either.
During active closeout, `TeamDelete` opens only after each live process-backed teammate has termination proof or non-live residue classification; unresolved live-agent truth remains warning, hold, or residue truth before teardown.
A roster entry with no live agent-process proof is residue, not a live teammate. `TeamDelete` uses live-process proof only.
Structured shutdown request shape is owned by `.claude/skills/task-execution/references/message-classes.md`.

## Resolve Next Owner And Action
- `cleanupEligibility: ready` returns to session-closeout completion.
- `closeoutDisposition: hold` records blocker-routing with residual owner, blocker, exhausted cleanup basis, and next safe owner/action; any user-facing residual prose requires `.claude/reference/reporting-prohibition-law.md` admission.
- `cleanupEligibility: blocked` with preserved residual truth routes cleanup recovery first; warning-bearing closeout opens only when no executable cleanup route remains and `.claude/reference/reporting-prohibition-law.md` admits it.
- Live teammate residue opens shutdown resolution first; warning-bearing closeout opens only when no executable cleanup route remains and `.claude/reference/reporting-prohibition-law.md` admits it.
- Validation debt returns to the owning validation or acceptance path.
- Runtime cleanup debt returns to session-closeout teardown.
