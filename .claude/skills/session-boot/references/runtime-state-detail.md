---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/session-boot/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false
---
# Session-Boot Reference
Load only for the explicit session-boot runtime-detail triggers below.
This is normally a mid-run or resume/recovery reference, not a clean-startup reference.

Load when the active session-boot owner must decide one of these: boot-window tool limit, startup continuity, current-session runtime truth, cleanup state, stale state, stall state, runtime pressure, compaction recovery, dispatch-state recovery, or monitoring classification.
This reference classifies runtime readiness, recovery, monitoring, and cleanup truth. Dispatch-runtime execution preflight is owned by `.claude/skills/task-execution/references/runtime-dispatch-law.md`.

Do not load for clean startup when no runtime state, recovery state, monitoring state, cleanup obligation, or runtime-dependent next action exists.
Do not load to narrate boot progress, reassure the user, produce a status report, or inspect details unrelated to the next boot owner/action.

This reference never admits user-facing prose.
All detail checks stay under the already-active `.claude/reference/user-reporting-law.md` gate and remain Procedure Plane evidence unless that law admits a report.
Runtime detail can change runtime classification, cleanup decision, recovery owner, or next action; it cannot create status, progress, summary, or boot-completion prose permission.

## Contents
- Boot Window And Startup Rules
- Session-Start Recovery
- Team-Lead Entry Trigger Detail
- Agent Work States
- Runtime Signals (Not Governance States)
- Supervisor Decisions On Turn-Ended Signals
- Message-First Runtime Cleanup Rule
- Reuse Rule
- Health-Check Standard
- Stale-Response Rule
- Runtime-Pressure Rule
- Procedure-State Schema
- Canonical Runtime-State Model
- Hook-Maintained Ledger Surfaces
- Workflow Continuity Bridge
- Proactive Team-Composition Reassessment
- Stall-Without-Progress Rule
- Runtime Cleanup Rules
- Resolve Next Owner And Action

## Boot Window And Startup Rules
- `Boot Sequence` is first for lead-session boot; its team-agent runtime branch is only for explicit runtime readiness, recovery, or entry gating.
- Dispatch-runtime creation, member creation, assignment send, and reuse are `task-execution` moves after `work-planning`. Standalone `Agent` is not team-runtime dispatch.
- During boot, allow only continuity reads, runtime-shape discovery, and read-only path probes needed to classify runtime readiness.
- No production fan-out before boot closes.
- Use current-session authorities first: workspace-root `.runtime/procedure-state.json`, `SessionStart` snapshot lines, hook logs, task records, and agent handoffs. Do not use legacy continuity snapshot files as continuity truth.
- Fresh-task isolation stays active during startup. Inherited continuity can reveal blockers or residue, but it does not reopen prior goals by habit.
- If runtime is only partially booted and session end becomes explicit, hand directly to `session-closeout`.

## Session-Start Recovery
- `Session-Start Sequence` always runs; `Boot Sequence` is the conditional explicit-runtime branch on top.
- Shared continuity read is reused when both run.
- Default startup scope is narrow: continuity, active root, runtime need, then stop unless contradiction or current request demands more.
- If explicit team-agent runtime becomes necessary later, re-enter through the runtime-readiness gate, then return to `task-execution` for dispatch-runtime execution instead of improvising fan-out.
- Compaction-triggered recovery must re-read open work, team channel, roster, and cleanup truth from current-session authorities before consequential dispatch.

## Team-Lead Entry Trigger Detail
`agents/team-lead.md` owns the decision to enter `session-boot`; this reference owns the runtime-state detail behind that decision.

`team-lead` MUST open `session-boot` and run Boot Sequence to its runtime-ready, runtime-required, recovery-required, or runtime-blocked outcome as the first consequential action before `work-planning` or dispatch-runtime execution when any of these conditions holds:
- session entry still has boot incomplete
- explicit team-runtime activation is needed
- current-runtime monitoring or recovery is materially active
- compaction recovery must reconstruct open work, team channel, roster, cleanup truth, or dispatch state before consequential work resumes
- current-session team registration without live panes is compaction recovery; classify recovery-required instead of creating a second runtime

Current-runtime monitoring or recovery is materially active when workspace-root `.runtime/procedure-state.json` has `teamRuntimeState: active` and any agent has live, standby, hold, stale, unresolved startup, stale dispatch, recovery, or monitoring state affecting the next consequential step.

The `session-start.sh` hook can detect active runtime from a runtime snapshot, but it does not auto-load this skill. Hook observation is evidence only; it never replaces `team-lead`'s duty to enter `session-boot` when the active-runtime condition holds.

Failure to enter `session-boot` when the condition holds is a procedure violation. It suppresses `Monitoring Sequence` proactive team-composition reassessment and can allow ghost agents, stale agents, idle holds, or missing-completion agents to accumulate without reuse, recovery, or cleanup.

## Agent Work States
- `ACTIVE`: valid `dispatch-ack` was sent for the current assignment execution block and no closing transport has followed.
- `STANDBY`: valid `completion` was received for that assignment execution block; the exact teammate is eligible for reuse when ownership fit and context fit remain truthful.
- Shutdown-pending, removed, blocked, stale, validation-waiting, and residue are runtime or routing classifications, not additional team-lead managed lane work states.

Canonical rule:
- `dispatch-ack` is the `ACTIVE` tracking signal, not progress, quality, completion, or acceptance evidence.
- `dispatch pending` is not `agent started`.
- `agent started` needs agent-side activity, progress, or other started-work evidence.
- `completion` is the `STANDBY` tracking signal, not acceptance evidence.

## Runtime Signals (Not Governance States)
- `idle_notification` is an observation signal, not a lifecycle transition.
- `permission_request` proves the agent is still active but blocked on permission.
- completion records `STANDBY` through valid `completion`.
- observed single-agent collapse in nominal parallel work is a distribution-planning defect, not local runtime authority to rebalance staffing.
- when a workflow is active, runtime signals classify agent/runtime truth only; they do not advance phases or clear checkpoints.

## Supervisor Decisions On Turn-Ended Signals
After completion-grade output, governing control records `STANDBY`.
If immediate work exists, send `assignment`, `reuse`, or `reroute` as new bounded work.
If no immediate work exists, send nothing.
Shutdown uses structured `shutdown_request` and confirmed shutdown or termination evidence.
Validation waiting keeps the teammate in `STANDBY` while the validation route resolves.

## Message-First Runtime Cleanup Rule
- Runtime cleanup is message-first when the cleanup decision requires agent-side behavior.
- Completion creates `STANDBY` and a synthesis obligation; it does not authorize removal.
- Completion-grade agent transports carry the one-line pointer envelope and retained carrier required by `completion-handoff.md`.
- During active runtime, `session-boot` owns cleanup interpretation after completion-grade output when no new assignment-grade packet is being sent.
- `assignment` and `reuse` return an agent to `ACTIVE`.
- Teammate population changes only on creation and confirmed shutdown/removal.
- Closeout exception: session teardown uses the narrow closeout shutdown path from `session-closeout`.

## Reuse Rule
- New dispatch rebuilds context.
- Reuse or standby is valid only when ownership fit and context fit remain truthful.

## Health-Check Standard
- Cron-backed health monitoring runs only when a tracked health-check cron is actually active.
- When hook policy enforces tracked health monitoring, missing monitoring is runtime-blocked evidence here; the launch preflight and corrective dispatch move belong to `.claude/skills/task-execution/references/runtime-dispatch-law.md`.
- Team existence alone is not runtime-ready evidence when health monitoring is required by hook policy.
- Standalone `Agent` calls are synchronous host calls outside team-agent runtime; they do not create live roster membership, team mailbox state, `dispatch-ack` debt, later `SendMessage` addressability, or health-cron duty. They support fallback evidence only when the route truth allows non-runtime evidence.
- Literal cadence and stale thresholds belong to `.claude/hooks/lib/hook-policy.sh`; do not restate numeric values here.
- Direct oversight remains primary even without cron-backed monitoring.
- Team existence and team activity are separate questions.
- Monitor rotation is not session closeout.

## Stale-Response Rule
- High-confidence stale opens runtime-truth and side-effect-evidence inspection.
- Runtime-truth sources are `procedure-state.json`, team config, `.pending-agents`, and `.worker-*` metadata.
- Side-effect-evidence sources are `.activity-ledger` entries keyed to the target agent_id, file appearance under the frozen `RETAINED-OUTPUT-PATH`, and inbox state.
- Replacement, shutdown, and stale-classification reporting all require this inspection.
- Idle notifications, dispatch-ack presence, and inbox `read:true` alone are not stale evidence.
- Replacement additionally requires shutdown evidence or an explicit recovery freeze.
- Low-confidence stale during long-running work -> observe, extend if justified, then escalate.
- Repeated stale/error loops require reroute, resize, replacement, or re-plan.
- Observational stale signals do not by themselves prove tool-phase hang, non-working state, or team-infrastructure defect.

## Runtime-Pressure Rule
- Treat non-current `parent-session-id` agents as orphan residue, not live production agents.
- Hard runtime pressure or unresolved orphan residue blocks new fan-out.
- Routine orphan scans report residue. Explicit recovery owns cleanup.
- Orphan recovery does not create closeout authority or bypass message-first cleanup decisions for the current live session.

## Procedure-State Schema
Canonical structured runtime truth lives in workspace-root `.runtime/procedure-state.json`. Internal procedure scaffolding stays in internal context for the current cycle. Legacy continuity snapshot files are not continuity surfaces.

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
- lane work state: `ACTIVE`, `STANDBY`
- cleanup or routing classification: `SHUTDOWN-PENDING`, `blocked`, `stale`, `validation-waiting`, `residue`
- runtime recovery classification: `dispatch-pending-no-ack`, `ack-late`, `working-permission-pending`, `working-transport-missing`, `working-blocked`, `not-working-awaiting-cleanup`, `active-stall`, `unclaimed-dispatch-failure`, `pipeline-ready-idle`
- team runtime state: `active`, `inactive`
- team dispatch state: `none`, `pending`, `claimed`

Canonical evidence mapping:
- dispatch-runtime creation success -> current-session team existence proof
- live config backed by current-session panes -> corroborating existence proof
- live pane proof must use the active team runtime's pane/session identity, not the default tmux server by habit
- default tmux-server absence does not prove a named team runtime is dead
- inbox growth, read/unread state, send success, config residue, and hook-emitted idle notices are not agent-originated progress
- `dispatch-ack` -> `ACTIVE` assignment receipt and tracking signal only
- agent `status`, `completion`, exact `hold|blocker`, or `scope-pressure` after receipt -> agent activity/start evidence
- current-session agent tool activity or assigned-surface mtime/diff in the dispatch window -> corroborating activity/side-effect evidence
- `permission_request` -> active-but-permission-blocked evidence
- `completion` -> `STANDBY` tracking signal plus completion-grade carrier for synthesis
- structured `shutdown_request` -> shutdown intent evidence; shutdown becomes authoritative only through live-roster absence, termination evidence, or hook/runtime shutdown evidence

## Hook-Maintained Ledger Surfaces
These are hook-maintained mirrors, not alternate semantic owners. They can corroborate the runtime-truth ladder above; they must not invent competing cleanup vocabulary, and absence of a ledger entry is not evidence by itself.

| Ledger surface | Corroborates which truth-ladder row | Absence behavior |
|---|---|---|
| `WORKER_TRANSPORT_LEDGER` | agent-originated progress, completion-grade message receipt | absence is not completion absence; consult message body and lane evidence |
| `WORKER_DISPATCH_ACK_PENDING_FILE` | `dispatch pending` awaiting `dispatch-ack` | absence after `dispatch pending` triggers receipt follow-up via `.claude/skills/task-execution/references/dispatch-recovery.md`, not silent stale classification |
| `IDLE_DECISION_PENDING_FILE` | legacy or exceptional turn-ended state not yet synchronized to canonical transport | absence does not prove activity; consult completion transport, standby ledger, and live runtime evidence |
| `WORKER_IDLE_NOTICE_FILE` | most recent `TeammateIdle` evidence | absence is not active evidence; do not infer activity from missing idle marker |
| `STANDBY_FILE` | completion-derived `STANDBY` tracking signal | absence is not authority to require cleanup; consult completion transport |
| `TEAM_RUNTIME_ACTIVE_FILE` | `team exists` (current-session team-runtime registration) | absence is not team-existence proof; dispatch-runtime creation is decided by `.claude/skills/task-execution/references/runtime-dispatch-law.md` |
| `KILL_LIST` | observed teardown intent on listed agents | absence is not agent-still-live evidence; consult live process-backed roster |

The canonical hook-policy ownership for these ledger surfaces lives in `.claude/hooks/MANIFEST.md`.

## Workflow Continuity Bridge
- `session-boot` observes runtime for active workflows; it does not own workflow progression.
- `team-lead` plus the active workflow owner still own phase advancement, checkpoint resolution, redistribution, synthesis, and completion claims.
- Runtime observation sharpens agent-start evidence, cleanup evidence, stale/ghost classification, and bottleneck observation when material.
- If runtime blocks lawful workflow continuation, corrective ownership returns to `team-lead` plus the active workflow owner with exact next owner/action or `HOLD`.

## Proactive Team-Composition Reassessment
At phase transition, agent completion convergence, major checkpoint, or completion synthesis, `team-lead` applies `Monitoring Sequence` reassessment only when current-runtime monitoring or recovery is materially active, or when remaining frozen work can reuse, release, redistribute, or reassign active or standby agents.
Synthesis is a trigger test for material team-composition risk, not automatic reassessment ceremony.

Required reassessment questions:
- does each active or standby agent have a defined upcoming role in the remaining frozen work?
- are parallel-fit opportunities in remaining work currently collapsed onto one agent under CLAUDE.md `[PARALLEL]`?
- are agents preserving state without an ongoing role, and is that state reconstructable from artifacts?
- are there downstream-phase prep activities that are independent of current-phase work and can start in parallel through fresh agent dispatch now?
- do current agent charters still match the frozen route, phase, proof, and acceptance burden?

Downstream-phase prep examples include tester scenario design plus test-infrastructure decision, reviewer checklist preparation, integration test scaffolding, validator expectation-source consolidation, and documentation-prep surfaces that do not depend on unfinished implementation output.

Rules:
- Phase boundaries gate execution, not prep.
- Agents without a defined upcoming role MUST be released through structured `shutdown_request` when their state is reconstructable from preserved artifacts AND the surface they produced has reached the release gate from `.claude/skills/task-execution/references/completion-handoff.md` (validation chain ACCEPT, proven out-of-plan, or closeout).
- Producer-lane agents on a surface still inside the active validation chain (review -> test -> validate) remain `STANDBY` while validation routing resolves.
- Preserving an agent just in case without explicit reuse basis is a `team-runtime hygiene defect`.
- Failing to dispatch independent downstream prep that can run in parallel now is a `bottleneck defect`.
- Waiting for the user to identify team-composition defects is itself a defect. This includes parallel collapse, idle agent preservation, missed parallel-fit, missed downstream-prep parallel-fit, and agent-charter mismatch.

## Stall-Without-Progress Rule
`assignment-sent-no-ack` is dispatch pending only: trigger same-assignment receipt follow-up immediately in the same monitoring turn.
`dispatch-ack` with no same-segment agent-start evidence is `dispatch-ack-no-start`: trigger same-assignment execution follow-up immediately in the same monitoring turn.
Parallel dispatch is active monitoring, not passive waiting.
The group cannot be reported as running while any intended target is `assignment-sent-no-ack` or `dispatch-ack-no-start`.
Recover the affected target and keep unaffected independent targets moving.

After agent-start evidence exists, choose the shortest task-specific re-check interval.
For quick checks, use same-turn or minute-scale follow-up.
The 30-minute bounded-task and 60-minute multi-track windows are upper caps, not default waits.
Longer waits require an explicit planning basis.

Corrective protocol:
1. For `assignment-sent-no-ack` or `dispatch-ack-no-start`, send exactly one same-assignment receipt or execution follow-up through `SendMessage`, then wait for response, permission, blocker, completion, or assigned-surface activity until the frozen re-check window.
2. Reuse proceeds through assignment-grade work; shutdown proceeds through structured `shutdown_request`.
3. Do not stack more assignment/correction packets into a silent inbox.
4. At the re-check window, inspect current activity/side-effect evidence. Preserve active agents in lane execution; when both response and activity evidence are absent, dispatch a replacement with the original assignment plus stall context, redistribute queued work, or send structured `shutdown_request` to release runtime.
5. Keep stall, follow-up, replacement, redistribution, and shutdown decision internal while recovery can continue. Report only when `.claude/reference/user-reporting-law.md` admits a report; explicit status answers omit ack counts, target names, packet fields, and recovery mechanics unless specifically requested.

Waiting for the user to identify agent stalls is itself a monitoring defect. Re-check windows are owner-selected monitoring bounds; the mandate is proactive detect-and-route-around.
Non-destructive runtime recovery is team-lead owned.
Do not ask the user to choose among routine nudge, replacement, redistribution, or shutdown of stalled teammates.

## Runtime Cleanup Rules
- Choose shutdown when closeout is active, hard memory pressure exists, context exhaustion risk is real, or recurrence is clearly absent.
- Choose standby when near-term reuse is concrete and context reuse is still valuable.
- Do not bypass runtime-capacity or overlap guards by forcing new fan-out while pressure or orphan residue remains unresolved.
- Historical continuity artifacts are not automatic shutdown targets.

## Resolve Next Owner And Action
- Runtime-ready state returns to the frozen next owner/action.
- Runtime-required classification opens `task-execution`.
- Runtime recovery need opens `session-boot` recovery.
- Missing receipt or start evidence opens one bounded follow-up and re-check.
- Stale or silent target after re-check opens replacement, redistribution, structured shutdown, or `HOLD`.
- Bottleneck or missed downstream-prep parallel-fit opens `work-planning`.
- Cleanup need opens structured shutdown, reuse, recovery, or `session-closeout`.
- Hard runtime pressure opens explicit recovery before new fan-out.
