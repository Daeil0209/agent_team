---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false
---
# Session-Boot Reference
Load only when runtime-state detail, lifecycle mapping, or recovery classification is needed.

## Boot Window And Startup Rules
- `Boot Sequence` is first for lead-session boot; its team-agent runtime branch is only for explicit runtime readiness, recovery, or entry gating.
- Runtime-entry `TeamCreate`, team-scoped agent launch, and assignment-grade reuse are `task-execution` moves after `work-planning` and `SV-PLAN`. Standalone `Agent` is not team-runtime dispatch.
- During boot, allow only continuity reads, runtime-shape discovery, and read-only path probes needed to decide runtime entry.
- No production fan-out before boot closes.
- Prefer current-session authorities first: workspace-root `.runtime/procedure-state.json`, `SessionStart` snapshot lines. Home-runtime continuity is fallback only. Per CLAUDE.md `## Communication`, internal procedure scaffolding stays in internal context and is not mirrored to a continuity file by habit; treat any pre-existing workspace-root `.claude/session-state.md` as advisory snapshot only.
- Fresh-task isolation stays active during startup. Inherited continuity may reveal blockers or residue, but it does not reopen prior goals by habit.
- If runtime is only partially booted and session end becomes explicit, hand directly to `session-closeout`.

## Session-Start Recovery
- `Session-Start Sequence` always runs; `Boot Sequence` is the optional explicit-runtime branch on top.
- Shared continuity read is reused when both run.
- Default startup scope is narrow: continuity, active root, runtime need, then stop unless contradiction or current request demands more.
- If explicit team-agent runtime becomes necessary later, re-enter through the runtime-entry gate, then return to `task-execution` for any assignment-grade `TeamCreate` or agent fan-out instead of improvising fan-out.
- Compaction-triggered recovery must re-read open work, team channel, roster, and lifecycle truth from current-session authorities before consequential dispatch.

## Team-Lead Entry Trigger Detail
`agents/team-lead.md` owns the decision to enter `session-boot`; this reference owns the runtime-state detail behind that decision.

`team-lead` MUST load `session-boot` as the first consequential action before `work-planning`, `task-execution`, `Agent` dispatch, or assignment-grade `SendMessage` when any of these conditions holds:
- session entry still has boot incomplete
- explicit team-runtime activation is needed
- current-runtime monitoring or recovery is materially active
- compaction recovery must reconstruct open work, team channel, roster, lifecycle truth, or dispatch state before consequential work resumes

Current-runtime monitoring or recovery is materially active when workspace-root `.runtime/procedure-state.json` has `teamRuntimeState: active` and any agent has live, standby, hold, stale, unresolved startup, stale dispatch, recovery, or monitoring state that could affect the next consequential step.

The `session-start.sh` hook may detect active runtime from a runtime snapshot, but it does not auto-load this skill. Hook observation is evidence only; it never replaces `team-lead`'s duty to enter `session-boot` when the active-runtime condition holds.

Failure to enter `session-boot` when the condition holds is a procedure violation. It suppresses `Monitoring Sequence` proactive team-composition reassessment and can allow ghost agents, stale agents, idle holds, or missing-handoff agents to accumulate without lifecycle-control release.

## Agent Lifecycle States
- `ACTIVE`: agent-start evidence exists and lifecycle is not resolved.
- `STANDBY`: governing lane approved preserved wait state.
- `SHUTDOWN-PENDING`: graceful shutdown requested, awaiting acknowledgment or timeout.
- `FORCE-STOPPED`: explicit forced termination.
- `HOLD-FOR-VALIDATION`: agent finished lane work and is reserved pending validator outcome.

Canonical rule:
- `dispatch-ack` is receipt only.
- `dispatch pending` is not `agent started`.
- `agent started` needs agent-side activity, progress, or other started-work evidence.

## Runtime Signals (Not Governance States)
- `idle_notification` is an observation signal, not a lifecycle transition.
- `permission_request` proves the agent is still active but blocked on permission.
- completion without `REQUESTED-LIFECYCLE` is a lifecycle evidence defect.
- observed single-agent collapse in nominal parallel work is a distribution-planning defect, not local runtime authority to rebalance staffing.
- when a workflow is active, runtime signals classify agent/runtime truth only; they do not advance phases or clear checkpoints.

## Supervisor Decisions On Turn-Ended Signals
After completion-grade output, governing control must pick one:
- `reuse`
- `standby`
- `shutdown`
- `hold-for-validation`

Rules:
- standby requires explicit approval; it is not inferred from idleness
- shutdown is graceful first, force-stop only as fallback
- hold-for-validation reserves the agent without new assignment until verdict resolves

## Message-First Lifecycle Rule
- Agent lifecycle is message-first.
- Completion creates a lifecycle obligation; it does not authorize auto-standby or removal.
- Completion-grade agent reports must carry `REQUESTED-LIFECYCLE: standby|shutdown|hold-for-validation`; this is a request, not authority.
- During active runtime, `session-boot` owns lifecycle interpretation and lifecycle-control need after completion-grade output when no new assignment-grade packet is being sent.
- `assignment` and `reuse` return an agent to `ACTIVE`.
- Teammate population changes only on creation and confirmed shutdown/removal.
- Closeout exception: session teardown may use the narrow closeout shutdown path from `session-closeout`.

## Cost Rule
- New dispatch is expensive.
- Reuse or standby is a cost preference only; it is valid only when ownership fit and context fit remain truthful.

## Health-Check Standard
- Cron-backed health monitoring runs only when a tracked health-check cron is actually active.
- Team-agent runtime requires tracked health monitoring before team-scoped agent launch when hook policy enforces it.
- Team existence alone is not team-scoped launch readiness when health monitoring is required by hook policy.
- Standalone `Agent` calls are synchronous host calls outside team-agent runtime; they do not create team mailbox state, dispatch-ack debt, or health-cron duty and must not replace configured lane dispatch.
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
- Treat non-current `parent-session-id` agents as orphan residue, not live production agents.
- Hard runtime pressure or unresolved orphan residue blocks new fan-out.
- Orphan cleanup does not create closeout authority or bypass message-first lifecycle decisions for the current live session.

## Procedure-State Schema
Canonical structured runtime truth lives in workspace-root `.runtime/procedure-state.json`. Internal procedure scaffolding stays in internal context for the current cycle (per CLAUDE.md `## Communication`); a workspace-root `.claude/session-state.md` snapshot, when present, is advisory only.

Minimum fields that must stay semantically stable:
- `workspaceRoot`
- `sessionId`
- `runtimeSessionId`
- `startupState`
- `teamRuntimeState`
- `teamExistenceEvidence`
- `teamDispatchState`
- `teamDispatchEvidence`
- `lastDispatchWorker`
- `lastPendingWorker`
- `lastClaimedWorker`
- `lastDispatchAt`
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
- `.claude/skills/task-execution/references/assignment-packet.md` and `.claude/skills/task-execution/references/message-classes.md` own packet schemas that consume it
- hooks enforce and record it without becoming alternate doctrine owners

Canonical classes:
- lifecycle state: `ACTIVE`, `STANDBY`, `SHUTDOWN-PENDING`, `FORCE-STOPPED`, `HOLD-FOR-VALIDATION`
- lifecycle control decision: `reuse`, `standby`, `shutdown`, `hold-for-validation`
- agent lifecycle request: `standby`, `shutdown`, `hold-for-validation`
- runtime recovery classification: `dispatch-pending-no-ack`, `ack-late`, `working-permission-pending`, `working-report-missing`, `working-blocked`, `not-working-awaiting-lifecycle`, `active-stall`, `unclaimed-dispatch-failure`, `pipeline-ready-idle`
- team runtime state: `active`, `inactive`
- team dispatch state: `none`, `pending`, `claimed`

Canonical evidence mapping:
- `TeamCreate` success -> current-session team existence proof
- live config backed by current-session panes -> corroborating existence proof
- `dispatch-ack` -> assignment receipt only
- agent `status`, `handoff`, `completion`, exact `hold|blocker`, or `scope-pressure` after receipt -> agent activity/start evidence
- current-session agent tool activity -> corroborating activity evidence
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
- Runtime observation may sharpen agent-start evidence, lifecycle evidence, stale/ghost classification, and bottleneck observation.
- If runtime blocks lawful workflow continuation, corrective ownership returns to `team-lead` plus the active workflow owner.

## Proactive Team-Composition Reassessment
At every phase transition, agent handoff convergence, major checkpoint, or handoff/completion synthesis, `team-lead` MUST apply `Monitoring Sequence` reassessment before re-dispatch. Synthesis is the reliable trigger because it occurs at every phase transition and agent handoff convergence.

Required reassessment questions:
- does each active or standby agent have a defined upcoming role in the remaining frozen work?
- are parallel-fit opportunities in remaining work currently collapsed onto one agent under CLAUDE.md `[PARALLEL]`?
- are agents preserving state without an ongoing role, and is that state reconstructable from artifacts?
- are there downstream-phase prep activities that are independent of current-phase work and can start in parallel through fresh agent dispatch now?
- do current agent charters still match the frozen route, phase, proof, and acceptance burden?

Downstream-phase prep examples include tester scenario design plus test-infrastructure decision, reviewer checklist preparation, integration test scaffolding, validator expectation-source consolidation, and documentation-prep surfaces that do not depend on unfinished implementation output.

Rules:
- Phase boundaries gate execution, not prep.
- Agents without a defined upcoming role MUST be released through `lifecycle-control` shutdown when their state is reconstructable from preserved artifacts.
- Preserving an agent just in case without explicit cost basis is a `team-runtime hygiene defect`.
- Failing to dispatch independent downstream prep that can run in parallel now is a `bottleneck defect`.
- Waiting for the user to identify team-composition defects is itself a defect. This includes parallel collapse, idle agent preservation, missed parallel-fit, missed downstream-prep parallel-fit, and agent-charter mismatch.

## Stall-Without-Progress Rule
When an agent has sent `dispatch-ack` but no further signal (`status`, `handoff`, `completion`, exact `hold|blocker`, `scope-pressure`, or `idle_notification`) arrives for materially longer than the assigned work would normally stay silent, treat it as `STALL-WITHOUT-PROGRESS`, not deep work by default.

Operational thresholds:
- bounded task: dispatch-ack plus 30 minutes of silence
- multi-track task: dispatch-ack plus 60 minutes of silence
- re-check window after a status nudge: 5 minutes
- longer thresholds require explicit basis recorded in planning

Corrective protocol:
1. Send one bounded status nudge through `lifecycle-control` or explicit status-request `SendMessage`.
2. If no response arrives within the re-check window, dispatch a replacement with the original assignment plus stall context, redistribute queued work, or send `lifecycle-control` shutdown to release runtime.
3. Report the stall and replacement/shutdown decision in the next user-facing surface as `next action`, not as silent in-flight work.

Waiting for the user to identify agent stalls is itself a monitoring defect. The thresholds are guidelines; the mandate is proactive detect-and-route-around.

## Agent Lifecycle Rules
- Prefer shutdown when closeout is active, hard memory pressure exists, context exhaustion risk is real, or recurrence is clearly absent.
- Prefer standby when near-term reuse is concrete and context reuse is still valuable.
- Do not bypass runtime-capacity or overlap guards by forcing new fan-out while pressure or orphan residue remains unresolved.
- Historical continuity artifacts are not automatic shutdown targets.
