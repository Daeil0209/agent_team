---
name: session-boot-reference
PRIMARY-OWNER: team-lead
auto-inject: false
---

# Session-Boot Reference

**Not auto-injected.** Load explicitly with `Read` when monitoring lifecycle detail, state tables, or runtime-pressure specifications are needed.

## Worker Lifecycle States

- `ACTIVE`: currently executing work — includes the period after turn completion until the governing lane explicitly approves standby, reuse, or shutdown
- `STANDBY`: governing lane has approved the worker to wait with preserved context for future reuse
- `SHUTDOWN-PENDING`: `shutdown_request` message sent and awaiting worker acknowledgment; worker is expected to complete its current turn and acknowledge gracefully. Transitions to fully removed from teammate population on acknowledgment, or to `FORCE-STOPPED` if the worker is unresponsive after timeout.
- `FORCE-STOPPED`: explicitly terminated — worker is no longer needed, harmful, stuck, or must be stopped immediately
- `HOLD-FOR-VALIDATION`: Worker has completed its task and is waiting for the validator lane to review its output before receiving a new assignment. The worker is idle but its output is under active acceptance review. Do not reassign until validator completes or issues a HOLD decision.

## Runtime Signals (Not Governance States)

- `idle_notification`: automatic runtime message indicating a worker's turn has ended. This is a technical signal, not a state transition. The worker remains `ACTIVE` until the governing lane makes an explicit lifecycle decision.
- Receiving `idle_notification` without a preceding completion report from the worker is a **handoff failure** (T2).
- Receiving a completion report without an explicit `REQUESTED-LIFECYCLE: standby|shutdown|hold-for-validation` field is a lifecycle evidence defect (T3).

## Supervisor Decisions on idle_notification

When an idle_notification is received with a valid completion report, the governing lane must make one of these decisions:

- `Reuse`: more work is immediately available and preserved context is still valuable
- `Standby Approve`: no immediate work, but near-future reuse is plausible. Current standard control path is an explicit governing-lane message (`MESSAGE-CLASS: standby`) to the concrete worker name; any helper or hook state update exists only to reflect that approved decision, not to replace it.
- `Shutdown (graceful → force-stop escalation)`: Send shutdown_request first (graceful path); if worker does not respond, escalate to mark-force-stop.sh as fallback. Force-stop is step 2, not an independent decision type. Worker is no longer needed, wrong, harmful, stuck, or must be terminated. Shutdown sequence: first send `SendMessage(to: "<worker-name>", message: {type: "shutdown_request"})` and wait for acknowledgment. If the worker is unresponsive, then use `bash "$HOME/.claude/hooks/mark-force-stop.sh" "<worker-name>"` as emergency fallback. Skipping `shutdown_request` leaves ghost entries in Claude Code's internal tracking.
- `Hold for Validation`: Worker output requires validator acceptance before reassignment. Send lifecycle control message with LIFECYCLE-DECISION: hold-for-validation. Worker remains idle-but-reserved until validator verdict is received. Do not send shutdown or new assignment until verdict is clear.

## Message-First Lifecycle Rule

- Worker lifecycle control is message-first: completion, reuse, standby approval, and shutdown decisions travel through explicit internal messages rather than through hook-feedback inference. `force-stop` remains the emergency runtime fallback when explicit shutdown cannot complete cleanly.
- Treat `TeammateIdle`, ledgers, and health-check output as observation surfaces that inform the next lifecycle message, not as authority to skip that message.
- Completion is an upward report requesting a governing decision; it does not by itself authorize auto-standby, replacement, or teammate removal.
- Consequential completion handoff should carry `REQUESTED-LIFECYCLE: standby|shutdown|hold-for-validation`. This is a worker request, not lifecycle authority.
- The governing lane owns the lifecycle transitions: dispatch or approved `assignment|reuse` moves a live worker to `ACTIVE`; turn completion without a further governing decision leaves the worker in ACTIVE state awaiting the governing lane's explicit lifecycle decision; explicit `standby` approval moves the worker to `STANDBY`; confirmed shutdown/removal removes the worker from teammate population.
- Until the governing lane answers with `standby`, `reuse`, or `shutdown`, the worker remains `ACTIVE`.
- Do not ignore a worker lifecycle request without reason. Brief hold is valid only while immediate reuse is being prepared.
- `assignment` is the generic downward activation packet for bounded work. `reuse` is the specific downward activation packet that reactivates an existing standby worker or reassigns work to an active worker awaiting a lifecycle decision on the same preserved topic/context. Both return the target worker to `ACTIVE`; neither creates a new teammate by itself.
- Teammate population changes only on worker creation and confirmed shutdown/removal. `standby` and `reuse` are state transitions, not teammate-count changes.
- Hook feedback may record or guard a lifecycle edge, but it does not create authority to infer session end or worker shutdown by itself.
- A worker-targeted `shutdown_request` sent after that worker is explicitly marked `FORCE-STOPPED` is part of worker lifecycle cleanup, not by itself evidence that the whole session is entering `Closeout Sequence`.
- If a stale current-runtime worker with worker-start evidence must be replaced outside closeout, follow message-first lifecycle order (→ Message-first lifecycle rule): send `shutdown_request`, wait for acknowledgment or timeout, use `mark-force-stop.sh` only if the worker is unresponsive, then dispatch the replacement. This does not govern `unclaimed-dispatch-failure`, where work continuity follows the dispatch reception channel's replacement-first rule.
- Previous-session remembered workers are continuity artifacts, not runtime shutdown targets in a later session. Do not send `shutdown_request` to historical workers unless they have been re-established as live workers in the current runtime.

Closeout exception: During session teardown (session-closeout sequence active), standby workers may be released with a brief shutdown_request without the full lifecycle decision packet. See `session-closeout/SKILL.md` for details.

## Lifecycle Decision Mapping

Lifecycle decision mapping: team-lead 'shutdown' decision = (1) send shutdown_request message → (2) if unresponsive after timeout, invoke mark-force-stop.sh. 'Force Stop' in this reference = step (2) only, not a separate decision type.

## Cost Rule

- New dispatch is expensive because context must be rebuilt.
- Reusing or keeping a suitable worker on standby is usually cheaper than shutdown plus redispatch.
- Reuse is preferred when workload, availability, context fit, and ownership safety all support it.

## Health-Check Standard

- For explicit team-runtime sessions, recurring health monitoring runs at the cadence configured in `hooks/lib/hook-policy.sh` and loaded through `hook-config.sh` only when a tracked health-check cron is actually active.
- Treat `hooks/lib/hook-policy.sh` as the single literal owner for cron cadence and stale threshold values. Session procedure text should reference the configured thresholds rather than re-copying the current numbers.
- Direct oversight, event-driven worker monitoring, and memory-pressure checks remain the primary lead-owned monitoring path even when no tracked health-check cron is active.
- `health-check.sh` classifies agents as active, standby, stale, or ghost based on the configured thresholds from `hooks/lib/hook-policy.sh`; do not restate the current numeric ghost threshold here.
- Actual team existence is proved by current-session `TeamCreate` success or a live team config backed by session-owned panes. Stored config files alone are continuity artifacts, not live-existence proof.
- A live team is not automatically an actively processing team. Keep `team exists`, `dispatch pending`, and `worker started` as separate monitoring questions.
- In single-primary automation mode, keep the watchdog armed during standby periods. Do not pause the health-check cron merely because all workers are currently standby.
- Replacing the tracked health-check cron is not the same as session closeout. For monitor rotation, record explicit rotation intent in structured runtime state first, then perform `CronDelete` and the replacement `CronCreate`. If rotation is deferred after intent was recorded, clear the deferred rotation residue before returning to normal monitoring.
- If no tracked health-check cron is active, do not create, rotate, or narrate one by ceremony. Continue the `Monitoring Sequence` through direct oversight until runtime policy or explicit runtime state requires cron-backed monitoring.

## Stale-Response Rule

- High-confidence stale: investigate quickly and consider replacement or force-stop.
- Low-confidence stale during long-running bash: observe, extend if justified, then escalate if the lane remains unproductive.
- Repeated stale or error-loop behavior requires reroute, resize, replacement, or re-plan rather than silent hope.
- Treat stale signals and idle_notification as observational only. Do not assert a specific tool-phase hang or a team-infrastructure defect unless ledger evidence, dispatch behavior, runtime-pressure evidence, or explicit tool errors support that diagnosis.
- Repo-local generated-output cleanup may use bounded destructive commands only inside the active repo's approved output roots (`./projects/`, `./outputs/`, `./backups/`). Keep that allowance scoped to generated child contents; it does not authorize deleting the root directories themselves, arbitrary repo deletion, hidden interpreter-based filesystem mutation, or main-thread mutation. A reset followed only by `mkdir -p` scaffold recreation under the same approved generated roots may use the bounded reset-scaffold pattern; do not mix that reset with build/test/git/touch/edit commands.

## Runtime-Pressure Rule

- In single-primary automation mode, treat non-current `parent-session-id` worker processes as orphan runtime residue rather than as valid parallel production sessions.
- When hard runtime pressure or unresolved orphan residue exists, stop new `Agent` fan-out until automatic or explicit cleanup clears that pressure.
- Use automatic orphan cleanup only against non-current runtime residue; do not let runtime-pressure handling invent session closeout authority or bypass message-first worker lifecycle decisions (→ Message-first lifecycle rule) for the current live session.
- If orphan historical workers are detected from a previous session, do not send `shutdown_request` to those remembered worker names from the new session. Use the orphan-runtime cleanup path instead of worker messaging.

## Procedure-State Schema

The procedure state is written to `./.claude/state/procedure-state.json`. This file is read-only from the skill layer as doctrine; governing hooks and session lifecycle procedures own it. A team-lead may make an exact `Edit`, `Update`, or `MultiEdit` checkpoint update to this file when recording required phase/procedure state. The workspace continuity surface is `./.claude/session-state.md`; exact `Edit`, `Update`, `MultiEdit`, or `Write` updates to that file are bounded continuity writes. These narrow operational exceptions do not authorize edits to sibling `.claude` files or semantic governance changes without the normal planning path.

| Field | Type | Description |
|-------|------|-------------|
| `workspaceRoot` | string | Absolute path to the active workspace root |
| `sessionId` | string | Current session identifier |
| `runtimeSessionId` | string | Current runtime session identifier (may differ from sessionId on resume) |
| `procedureAuthority` | string | Source of procedure authority (`workspace-local` or `global`) |
| `migrationPhase` | string | Continuity migration phase identifier |
| `projectContinuityFile` | string | Absolute path to the workspace-local continuity file |
| `globalContinuityFile` | string | Absolute path to the global continuity mirror file |
| `lastUpdated` | ISO 8601 | Timestamp of last state write |
| `lastResolvedMode` | string | Last resolved permission mode |
| `lastPermissionBasis` | string | Source basis for the last permission decision |
| `lastPermissionSource` | string | Specific settings field that provided the last permission |
| `lastRawMode` | string | Raw mode string before resolution (empty if not set) |
| `lastAgentDispatchName` | string | Name of the last dispatched agent |
| `projectContinuityState` | string | Staleness state of the workspace continuity file (`fresh` or `stale`) |
| `globalContinuityState` | string | Staleness state of the global continuity mirror (`fresh` or `stale`) |
| `continuityMirrorStatus` | string | Mirror sync status (`mirrored` or `diverged`) |
| `continuityReadPath` | string | Effective read path for continuity (preferred path, not fallback) |
| `bootSessionId` | string | Session identifier captured at boot |
| `continuitySeedAction` | string | Action that seeded continuity on this session start (`project-present`, `global-present`, `rebuilt`, etc.) |
| `startupState` | string | Current startup phase (`booting` or `ready`). startupState tracks the current boot phase only. Session termination state is owned by session-closeout; a new session always resets startupState to 'booting'. |
| `teamRuntimeState` | string | Current-session team-runtime state (`active` or `inactive`) |
| `teamExistenceEvidence` | string | Evidence class backing `teamRuntimeState` (`team-create`, `live-config`, `worker-activity`, `none`) |
| `teamDispatchState` | string | Current-session dispatch state (`none`, `pending`, or `claimed`) |
| `teamDispatchEvidence` | string | Evidence class backing `teamDispatchState` (`agent-dispatch`, `sendmessage-assignment`, `worker-activity`, `none`) |
| `lastDispatchWorker` | string | Most recent worker name mentioned by the dispatch channel |
| `lastPendingWorker` | string | Most recent worker with dispatch-pending evidence |
| `lastClaimedWorker` | string | Most recent worker with worker-start/claim evidence |
| `lastDispatchAt` | string | UTC timestamp of the most recent worker dispatch event |
| `lastPendingSince` | string | UTC timestamp when the current unclaimed dispatch-pending state began; compare with dispatch reception thresholds before failure classification |
| `lastClaimedAt` | string | UTC timestamp of the latest worker-start/claim evidence |
| `currentPhase` | string | Active governing workflow phase for the current session when a workflow owns execution |
| `phaseHistory` | array | Ordered record of completed or entered workflow phases for the current session |
| `designDocPath` | string | Concrete design-document path recorded by workflow gates when required |
| `checkpointStatus` | object | Per-checkpoint readiness or completion map used by active workflows |

Workflow-owned phase fields are extensions to the runtime/session base state above. When a governing workflow such as `dev-workflow` is active, these fields become part of the expected procedure-state surface and must remain synchronized with the active workflow's phase gates.

- Compaction/resume rule: when context is compacted, re-read the team channel from procedure state before any consequential dispatch. Use the `SessionStart` runtime snapshot and task state only to corroborate or refine that channel, never to replace it with summary memory.

## Worker Lifecycle Rules

- Apply shutdown (not standby) when: (a) session closeout is in progress, (b) measurable memory pressure (>80% threshold) is detected, (c) context window exhaustion risk is present, or (d) the worker's task class will not recur in the current session. If uncertain, default to standby.
- Recurrence uncertainty guidance: prefer standby when the worker has reusable accumulated context; prefer shutdown when the worker was single-use, exhausted, or its context is no longer relevant to future work in this session.
- Priority order when rules conflict: (1) shutdown conditions a-c are mandatory overrides when present; (2) condition d applies only when recurrence is clearly absent; (3) recurrence guidance (context-reuse vs single-use) is the tiebreaker for ambiguous cases; (4) standby is the absolute fallback when no higher-priority condition is determinative.
- External tool documentation (e.g., TeamCreate's "shutdown when complete" guidance) does not override this doctrine; lifecycle decisions follow internal doctrine, not tool vendor defaults. Reuse preserved context aggressively when it reduces successor-task cost without contaminating scope.
- Before force-stopping or replacing a worker, investigate the cause from evidence and follow the active lifecycle owner (`session-boot` Monitoring Sequence during active runtime; `session-closeout` during teardown). Slow ≠ stuck.
- Do not bypass runtime-capacity or overlap guards by forcing fan-out while pressure or orphan residue remains unresolved.
- Historical continuity artifacts are not automatic shutdown targets; apply the active session policy before acting on them.
- Closeout requires one authoritative acceptance basis and a truthful HOLD whenever unresolved surfaces remain. Replacement follows shutdown-first, force-stop only as fallback.
