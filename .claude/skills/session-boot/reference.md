---
name: session-boot-reference
PRIMARY-OWNER: team-lead
auto-inject: false
---
# Session-Boot Reference
Load only when runtime-state detail, lifecycle mapping, or recovery classification is needed.

## Boot Window And Startup Rules
- `Boot Sequence` is only for explicit runtime entry.
- During boot, allow only continuity reads, runtime-shape discovery, and read-only path probes needed to decide runtime entry.
- No production fan-out before boot closes.
- Prefer current-session authorities first: `./.runtime/procedure-state.json`, `./.claude/session-state.md`, `SessionStart` snapshot lines. Home-runtime continuity is fallback only.
- Fresh-task isolation stays active during startup. Inherited continuity may reveal blockers or residue, but it does not reopen prior goals by habit.
- If runtime is only partially booted and session end becomes explicit, hand directly to `session-closeout`.

## Session-Start Recovery
- `Session-Start Sequence` always runs; `Boot Sequence` is the optional explicit-runtime branch on top.
- Shared continuity read is reused when both run.
- Default startup scope is narrow: continuity, active root, runtime need, then stop unless contradiction or current request demands more.
- If explicit runtime becomes necessary later, re-enter through the runtime-entry gate instead of improvised fan-out.
- Compaction-triggered recovery must re-read open work, team channel, roster, and lifecycle truth from current-session authorities before consequential dispatch.

## Worker Lifecycle States
- `ACTIVE`: worker-start evidence exists and lifecycle is not resolved.
- `STANDBY`: governing lane approved preserved wait state.
- `SHUTDOWN-PENDING`: graceful shutdown requested, awaiting acknowledgment or timeout.
- `FORCE-STOPPED`: explicit forced termination.
- `HOLD-FOR-VALIDATION`: worker finished lane work and is reserved pending validator outcome.

Canonical rule:
- `dispatch-ack` is receipt only.
- `dispatch pending` is not `worker started`.
- `worker started` needs worker-side activity, progress, or other started-work evidence.

## Runtime Signals (Not Governance States)
- `idle_notification` is an observation signal, not a lifecycle transition.
- `permission_request` proves the worker is still active but blocked on permission.
- completion without `REQUESTED-LIFECYCLE` is a lifecycle evidence defect.
- observed single-worker collapse in nominal parallel work is a distribution-planning defect, not local runtime authority to rebalance staffing.
- when a workflow is active, runtime signals classify worker/runtime truth only; they do not advance phases or clear checkpoints.

## Supervisor Decisions On Turn-Ended Signals
After completion-grade output, governing control must pick one:
- `reuse`
- `standby`
- `shutdown`
- `hold-for-validation`

Rules:
- standby requires explicit approval; it is not inferred from idleness
- shutdown is graceful first, force-stop only as fallback
- hold-for-validation reserves the worker without new assignment until verdict resolves

## Message-First Lifecycle Rule
- Worker lifecycle is message-first.
- Completion creates a lifecycle obligation; it does not authorize auto-standby or removal.
- Worker completion should carry `REQUESTED-LIFECYCLE: standby|shutdown|hold-for-validation`; this is a request, not authority.
- `assignment` and `reuse` return a worker to `ACTIVE`.
- Teammate population changes only on creation and confirmed shutdown/removal.
- Closeout exception: session teardown may use the narrow closeout shutdown path from `session-closeout`.

## Cost Rule
- New dispatch is expensive.
- Reuse or standby is usually cheaper when ownership fit and context fit remain truthful.

## Health-Check Standard
- Cron-backed health monitoring runs only when a tracked health-check cron is actually active.
- Literal cadence and stale thresholds belong to `.claude/hooks/lib/hook-policy.sh`; do not restate numeric values here.
- Direct oversight remains primary even without cron-backed monitoring.
- Team existence and team activity are separate questions.
- Monitor rotation is not session closeout.

## Stale-Response Rule
- High-confidence stale -> investigate quickly; replace or force-stop only with evidence.
- Low-confidence stale during long-running work -> observe, extend if justified, then escalate.
- Repeated stale/error loops require reroute, resize, replacement, or re-plan.
- Observational stale signals do not by themselves prove tool-phase hang, non-working state, or team-infrastructure defect.

## Runtime-Pressure Rule
- Treat non-current `parent-session-id` workers as orphan residue, not live production workers.
- Hard runtime pressure or unresolved orphan residue blocks new fan-out.
- Orphan cleanup does not create closeout authority or bypass message-first lifecycle decisions for the current live session.

## Procedure-State Schema
Canonical structured runtime truth lives in `./.runtime/procedure-state.json`.
Continuity mirror lives in `./.claude/session-state.md`.

Minimum fields that must stay semantically stable:
- `workspaceRoot`
- `sessionId`
- `runtimeSessionId`
- `startupState`
- `teamRuntimeState`
- `teamExistenceEvidence`
- `teamDispatchState`
- `teamDispatchEvidence`
- `lastPendingWorker`
- `lastClaimedWorker`
- `lastPendingSince`
- `lastClaimedAt`
- `currentPhase`
- `phaseHistory`
- `checkpointStatus`

Workflow-owned phase fields extend the same runtime surface; they do not create a second authority.

## Canonical Runtime-State Model
Semantic ownership split:
- this reference owns runtime-state vocabulary
- `agents/team-lead.md` owns lead obligations against that vocabulary
- `task-execution/reference.md` owns packet schemas that consume it
- hooks enforce and record it without becoming alternate doctrine owners

Canonical classes:
- lifecycle state: `ACTIVE`, `STANDBY`, `SHUTDOWN-PENDING`, `FORCE-STOPPED`, `HOLD-FOR-VALIDATION`
- lifecycle control decision: `reuse`, `standby`, `shutdown`, `hold-for-validation`
- worker lifecycle request: `standby`, `shutdown`, `hold-for-validation`
- runtime recovery classification: `dispatch-pending-no-ack`, `ack-late`, `working-permission-pending`, `working-report-missing`, `working-blocked`, `not-working-awaiting-lifecycle`, `active-stall`, `unclaimed-dispatch-failure`, `pipeline-ready-idle`
- team runtime state: `active`, `inactive`
- team dispatch state: `none`, `pending`, `claimed`

Canonical evidence mapping:
- `TeamCreate` success -> current-session team existence proof
- live config backed by current-session panes -> corroborating existence proof
- `dispatch-ack` -> assignment receipt only
- worker `status`, `handoff|completion`, `hold|blocker`, or `scope-pressure` after receipt -> worker activity/start evidence
- current-session worker tool activity -> corroborating activity evidence
- `permission_request` -> active-but-permission-blocked evidence
- completion-grade output + `REQUESTED-LIFECYCLE` -> lifecycle obligation evidence
- explicit lifecycle-control message -> authoritative lead decision

## Hook-Owned Ledger Surfaces
These are hook-owned mirrors, not alternate semantic owners:
- `WORKER_REPORT_LEDGER`
- `WORKER_DISPATCH_ACK_PENDING_FILE`
- `IDLE_DECISION_PENDING_FILE`
- `WORKER_IDLE_NOTICE_FILE`
- `STANDBY_FILE`
- `TEAM_RUNTIME_ACTIVE_FILE`
- `KILL_LIST`

They may corroborate runtime truth, but must not invent competing lifecycle vocabulary.

## Workflow Continuity Bridge
- `session-boot` observes runtime for active workflows; it does not own workflow progression.
- `team-lead` plus the active workflow owner still own phase advancement, checkpoint resolution, redistribution, synthesis, and completion claims.
- Runtime observation may sharpen worker-start evidence, lifecycle evidence, stale/ghost classification, and bottleneck observation.
- If runtime blocks lawful workflow continuation, corrective ownership returns to `team-lead` plus the active workflow owner.

## Worker Lifecycle Rules
- Prefer shutdown when closeout is active, hard memory pressure exists, context exhaustion risk is real, or recurrence is clearly absent.
- Prefer standby when near-term reuse is concrete and context reuse is still valuable.
- Do not bypass runtime-capacity or overlap guards by forcing new fan-out while pressure or orphan residue remains unresolved.
- Historical continuity artifacts are not automatic shutdown targets.
