---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/session-boot/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
auto-inject: false
---
# Session-Boot Reference
Load only for the explicit session-boot runtime-detail triggers below.
This is normally a mid-run or resume/recovery reference, not a clean-startup reference.

Load when the active session-boot owner must decide one of these: boot-window tool limit, startup continuity, current-session runtime truth, cleanup state, stale state, stall state, runtime pressure, compaction recovery, dispatch-state recovery, or monitoring classification.
This reference classifies runtime readiness, recovery, monitoring, and cleanup truth.
It is the canonical owner for runtime-state vocabulary and runtime truth classification; monitoring lookup references cite this owner for those terms.

Load this reference only when runtime state, recovery state, monitoring state, cleanup obligation, or runtime-dependent next action can change the next owner/action.
Boot narration, reassurance, status reports, and unrelated detail inspection stay outside this reference.

This reference never grants user-facing prose exceptions.
All detail checks stay under the already-active `.claude/reference/reporting-prohibition-law.md` gate and remain Procedure Plane evidence unless that law grants a narrow report exception.
Runtime detail can change runtime classification, cleanup decision, recovery owner, or next action; status, progress, summary, and boot-completion prose permission remains owned by reporting-prohibition law.

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
- Runtime Integrity Defect Classification
- Runtime Integrity Detection Triggers
- Per-Class Reconciliation Action
- Operator-Approval Gate
- Runtime Integrity Reporting
- Runtime Cleanup Rules
- Resolve Next Owner And Action

## Boot Window And Startup Rules
- `Boot Sequence` is first for lead-session boot; its team-agent runtime branch is only for explicit runtime readiness, recovery, or entry gating.
- Dispatch-runtime creation, member creation, assignment send, and reuse consume this reference only as runtime-readiness or recovery evidence after the dispatch route is frozen by its owning trigger. Standalone `Agent` is not team-runtime dispatch.
- During boot, allow only continuity reads, runtime-shape discovery, and read-only path probes needed to classify runtime readiness.
- Active `Boot Sequence` closes before delegated fan-out.
- Use current-session authorities first: workspace-root `.runtime/procedure-state.json`, `SessionStart` snapshot lines, hook logs, task records, and agent handoffs.
- Fresh-task isolation stays active during startup. Inherited continuity can reveal blockers or residue; prior goals reopen only through current-session authority.
- If runtime is only partially booted and session end becomes explicit, hand directly to `session-closeout`.

## Session-Start Recovery
- `Session-Start Sequence` always runs; `Boot Sequence` is the conditional explicit-runtime branch on top.
- Shared continuity read is reused when both run.
- Default startup scope is narrow: continuity, active root, runtime need, then return to the next owner unless contradiction or current request demands more.
- If explicit team-agent runtime becomes necessary later, re-enter through the runtime-readiness gate, then return its classification as runtime evidence instead of improvising fan-out.
- Compaction-triggered recovery must re-read open work, team channel, roster, and cleanup truth from current-session authorities before consequential dispatch.

## Team-Lead Entry Trigger Detail
`agents/team-lead.md` owns the decision to enter `session-boot`; this reference owns the runtime-state detail behind that decision.

`team-lead` MUST open `session-boot` and run Boot Sequence to its runtime-ready, runtime-required, recovery-required, or runtime-blocked outcome as the first consequential action before runtime-dependent consequential action when any of these conditions holds:
- session entry still has boot incomplete
- explicit team-runtime activation is needed
- current-runtime monitoring or recovery is materially active
- compaction recovery must reconstruct open work, team channel, roster, cleanup truth, or dispatch state before consequential work resumes
- current-session team registration without live panes is compaction recovery; classify recovery-required instead of creating a second runtime

Current-runtime monitoring or recovery is materially active when workspace-root `.runtime/procedure-state.json` has `teamRuntimeState: active` and any agent has live, standby, hold, stale, unresolved startup, stale dispatch, recovery, or monitoring state affecting the next consequential step.

The `session-start.sh` hook can detect active runtime from a runtime snapshot. Hook observation is evidence only; `team-lead` still enters `session-boot` when the active-runtime condition holds.

Failure to enter `session-boot` when the condition holds is a procedure violation. It suppresses `Monitoring Sequence` proactive team-composition reassessment and can allow ghost agents, stale agents, idle holds, or missing-completion agents to accumulate without reuse, recovery, or cleanup.

## Agent Work States
- `ACTIVE`: valid `dispatch-ack` accepted and started the current assignment execution block and no closing transport has followed.
- `STANDBY`: valid `completion` was received for that assignment execution block; the exact teammate is eligible for reuse when ownership fit and context fit remain truthful.
- Shutdown-pending, removed, blocked, stale, validation-waiting, and residue are runtime or routing classifications, not additional team-lead managed lane work states.

Canonical rule:
- `dispatch-ack` is the `ACTIVE` no-objection acceptance and work-start signal, not progress, quality, completion, or acceptance evidence.
- `dispatch pending` is not `agent started`.
- `agent started` needs agent-side activity, progress, or other started-work evidence.
- `completion` is the `STANDBY` tracking signal, not acceptance evidence.

## Runtime Signals (Not Governance States)
- `idle_notification` is an observation signal, not a lifecycle transition.
- `permission_request` proves the agent is still active but blocked on permission.
- completion records `STANDBY` through valid `completion`.
- observed single-agent collapse in nominal parallel work is a distribution-planning defect, not local runtime authority to rebalance staffing.
- when a workflow is active, runtime signals classify agent/runtime truth only; phase advancement and checkpoint clearance stay with the active workflow owner.

## Supervisor Decisions On Turn-Ended Signals
After completion-grade output, governing control records `STANDBY`.
If immediate work exists, send `assignment`, `reuse`, or `reroute` as new bounded work.
If no immediate work exists, send nothing.
Shutdown uses structured `shutdown_request` and confirmed shutdown or termination evidence.
Validation waiting keeps the teammate in `STANDBY` while the validation route resolves.

## Message-First Runtime Cleanup Rule
- Runtime cleanup is message-first when the cleanup decision requires agent-side behavior.
- Completion creates `STANDBY` and a synthesis obligation; removal requires a cleanup, reuse-failure, release-gate, or closeout basis.
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
- When hook policy enforces tracked health monitoring, missing monitoring is runtime-blocked evidence here.
- Team existence alone is not runtime-ready evidence when health monitoring is required by hook policy.
- Standalone `Agent` calls are synchronous host calls outside team-agent runtime; live roster membership, team mailbox state, `dispatch-ack` debt, later `SendMessage` addressability, and health-cron duty require team-agent runtime evidence. They support fallback evidence only when the route truth allows non-runtime evidence.
- Literal cadence and stale thresholds belong to `.claude/hooks/lib/hook-policy.sh`; this reference cites that owner instead of restating numeric values.
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
- Observational stale signals require runtime-truth and side-effect-evidence inspection before tool-phase hang, non-working state, or team-infrastructure defect classification.

## Runtime-Pressure Rule
- Treat non-current `parent-session-id` agents as orphan residue, not live production agents.
- Hard runtime pressure or unresolved orphan residue blocks new fan-out.
- Routine orphan scans report residue. Explicit recovery owns cleanup.
- Orphan recovery preserves closeout authority and message-first cleanup decisions for the current live session.

## Procedure-State Schema
Canonical structured runtime truth lives in workspace-root `.runtime/procedure-state.json`.
Internal procedure scaffolding stays in internal context for the current cycle.

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

Workflow-owned phase fields extend the same runtime surface; workflow authority stays single-owner.

## Canonical Runtime-State Model
Semantic ownership split:
- this reference owns runtime-state vocabulary
- `agents/team-lead.md` owns lead obligations against that vocabulary
- `.claude/skills/task-execution/references/assignment-packet.md` and `.claude/skills/task-execution/references/message-classes.md` own packet schemas that consume it
- hooks enforce and record it without becoming alternate doctrine owners

Canonical classes:
- lane work state: `ACTIVE`, `STANDBY`
- cleanup or routing classification: `SHUTDOWN-PENDING`, `blocked`, `stale`, `validation-waiting`, `residue`
- runtime recovery classification: `dispatch-pending-no-ack`, `dispatch-ack-no-start`, `ack-late`, `working-permission-pending`, `working-transport-missing`, `working-blocked`, `not-working-awaiting-cleanup`, `active-stall`, `unclaimed-dispatch-failure`, `pipeline-ready-idle`
- team runtime state: `active`, `inactive`
- team dispatch state: `none`, `pending`, `claimed`

Runtime recovery classification meanings:
- `dispatch-pending-no-ack`: assignment send evidence exists and the target lacks valid `dispatch-ack`.
- `dispatch-ack-no-start`: `dispatch-ack` accepted the assignment but no same-segment activity evidence exists; same-assignment execution follow-up required.
- `ack-late`: `dispatch-ack` arrived after follow-up or stale suspicion and must be reconciled with current assignment truth.
- `working-permission-pending`: target is active and blocked on permission.
- `working-transport-missing`: side-effect or activity evidence exists but required Communication Plane transport is missing.
- `working-blocked`: target reported `hold|blocker` or equivalent active blocker.
- `not-working-awaiting-cleanup`: target is not active and cleanup or replacement truth remains unresolved.
- `active-stall`: target is `ACTIVE` but lacks expected progress or side-effect evidence after the governed follow-up window.
- `unclaimed-dispatch-failure`: dispatch or task evidence exists but no live target lawfully claimed the assignment.
- `pipeline-ready-idle`: target is available for new bounded work after prior truth is reconciled.

Canonical evidence mapping:
- dispatch-runtime creation success -> current-session team existence proof
- live config backed by current-session panes -> corroborating existence proof
- live pane proof must use the active team runtime's pane/session identity, not the default tmux server by habit
- named team runtime death requires evidence beyond default tmux-server absence
- inbox growth, read/unread state, send success, config residue, and hook-emitted idle notices are not agent-originated progress
- `dispatch-ack` -> `ACTIVE` no-objection assignment acceptance and work-start tracking signal only
- agent `status`, `completion`, exact `hold|blocker`, or `scope-pressure` after receipt -> agent activity/start evidence
- current-session agent tool activity or assigned-surface mtime/diff in the dispatch window -> corroborating activity/side-effect evidence
- `permission_request` -> active-but-permission-blocked evidence
- `completion` -> `STANDBY` tracking signal plus completion-grade carrier for synthesis
- structured `shutdown_request` -> shutdown intent evidence; shutdown becomes authoritative only through live-roster absence, termination evidence, or hook/runtime shutdown evidence

## Hook-Maintained Ledger Surfaces
These are hook-maintained mirrors, not alternate semantic owners. They can corroborate the runtime-truth ladder above; cleanup vocabulary stays with the canonical owner, and absence of a ledger entry is not evidence by itself.

| Ledger surface | Corroborates which truth-ladder row | Absence behavior |
|---|---|---|
| `WORKER_TRANSPORT_LEDGER` | agent-originated progress, completion-grade message receipt | absence is not completion absence; consult message body and lane evidence |
| `WORKER_DISPATCH_ACK_PENDING_FILE` | `dispatch pending` awaiting `dispatch-ack` | absence after `dispatch pending` triggers receipt follow-up via `.claude/skills/task-execution/references/dispatch-recovery.md`, not silent stale classification |
| `IDLE_DECISION_PENDING_FILE` | legacy or exceptional turn-ended state not yet synchronized to canonical transport | activity requires completion transport, standby ledger, and live runtime evidence |
| `WORKER_IDLE_NOTICE_FILE` | most recent `TeammateIdle` evidence | activity requires positive evidence beyond missing idle marker |
| `STANDBY_FILE` | completion-derived `STANDBY` tracking signal | absence is not authority to require cleanup; consult completion transport |
| `TEAM_RUNTIME_ACTIVE_FILE` | `team exists` (current-session team-runtime registration) | absence is not team-existence proof; dispatch-runtime creation is decided by `.claude/skills/task-execution/references/runtime-dispatch-law.md` |
| `KILL_LIST` | observed teardown intent on listed agents | absence is not agent-still-live evidence; consult live process-backed roster |

The canonical hook-policy ownership for these ledger surfaces lives in `.claude/hooks/MANIFEST.md`.

## Workflow Continuity Bridge
- `session-boot` observes runtime for active workflows; workflow progression stays with the workflow owner.
- `team-lead` plus the active workflow owner still own phase advancement, checkpoint resolution, redistribution, synthesis, and completion claims.
- Runtime observation sharpens agent-start evidence, cleanup evidence, stale/ghost classification, and bottleneck observation when material.
- If runtime blocks lawful workflow continuation, corrective ownership returns to `team-lead` plus the active workflow owner with exact next owner/action or `HOLD`.

## Proactive Team-Composition Reassessment
At phase transition, agent completion convergence, major checkpoint, or completion synthesis, `team-lead` applies `Monitoring Sequence` reassessment only when current-runtime monitoring or recovery is materially active, or when remaining frozen work can reuse, release, redistribute, or reassign active or standby agents.
Synthesis is a trigger test for material team-composition risk, not automatic reassessment ceremony.

Required reassessment questions:
- does each active or standby agent have a defined upcoming role in the remaining frozen work?
- are parallel-fit opportunities in remaining work currently collapsed onto one agent under `.claude/reference/work-execution-core-law.md` `[PARALLEL]`?
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
- Waiting for the user to identify monitoring-detectable defects (parallel collapse, idle agent preservation, missed parallel-fit, missed downstream-prep parallel-fit, agent-charter mismatch, or agent stall) is itself a defect; non-destructive runtime recovery is team-lead owned.

## Stall-Without-Progress Rule
`dispatch-pending-no-ack` is missing assignment acceptance: trigger same-assignment receipt follow-up immediately in the same monitoring turn.
`dispatch-ack` with no same-segment agent-start evidence is `dispatch-ack-no-start`: trigger same-assignment execution follow-up immediately in the same monitoring turn.
Parallel dispatch is active monitoring, not passive waiting.
Running-group reporting requires every intended target to be past `dispatch-pending-no-ack` and `dispatch-ack-no-start`.
Recover the affected target and keep unaffected independent targets moving.

After agent-start evidence exists, choose the shortest task-specific re-check interval.
For quick checks, use same-turn or minute-scale follow-up.
The 30-minute bounded-task and 60-minute multi-track windows are upper caps, not default waits.
Longer waits require an explicit planning basis.

Corrective protocol:
1. For `dispatch-pending-no-ack` or `dispatch-ack-no-start`, send exactly one same-assignment receipt or execution follow-up through `SendMessage`, then wait for response, permission, blocker, completion, or assigned-surface activity until the frozen re-check window.
2. Reuse proceeds through assignment-grade work; shutdown proceeds through structured `shutdown_request`.
3. Keep additional assignment/correction packets out of a silent inbox.
4. At the re-check window, inspect current response and activity/side-effect evidence. Preserve active agents in lane execution. When both response and activity evidence are absent after missing ACK or no-start follow-up, classify the target as dead-or-unavailable for the current assignment, then dispatch a replacement with the original assignment plus stall context, redistribute queued work, or send structured `shutdown_request` to release runtime.
5. Keep stall, follow-up, replacement, redistribution, and shutdown decision internal while recovery can continue. Report only when `.claude/reference/reporting-prohibition-law.md` grants a narrow report exception; status-answer content follows that law's `## Report Shape`.

Re-check windows are owner-selected monitoring bounds; the mandate is proactive detect-and-route-around. Team-lead chooses among routine nudge, replacement, redistribution, or shutdown of stalled teammates when doctrine and evidence determine the route.

## Runtime Integrity Defect Classification
Runtime-integrity defect domains are classified separately and reconciled to one consistent live state.
The hook helper `runtime_integrity_classify` covers Domain 1 and Domain 2 Classes A-F from process, config, pane, socket, UI, and task-store evidence.
Domain 3 Classes G-I are team-lead or session-boot monitoring classifications from `SendMessage`, retained-output, mailbox, and idle evidence.
Domain 3 is not hook auto-cleanup evidence.

### Domain 1: Agent Operation (process/config/pane parity)
- Class A: a live claude process whose `--team-name <team>` and `--agent-id <id>` are not present in `~/.claude/teams/<team>/config.json` members.
- Class B: a `config.json` member entry whose `tmuxPaneId` is missing, references a non-existent pane, or references a pane with no descendant claude process.
- Class C: a live tmux pane that has no descendant claude process under its `pane_pid`.
- Class D: an orphan `/tmp/tmux-$(id -u)/claude-swarm-*` socket file whose `tmux -L <name> list-sessions` returns no live server.

### Domain 2: UI Synchronization (display ↔ governance parity)
- Class E: Claude Code teammate UI displays a member that is absent from `config.json` because UI reads live process inventory and `config.json` records the governance-tracked roster only; UI ≠ governance roster is the surfaced defect.
- Class F: `TaskList` host response returns a task id that is absent from `~/.claude/tasks/<team>/<id>.json` on-disk store; highwatermark-only id without persisted record is the surfaced defect.
- UI/host display state is read-only evidence; governance reconciliation flows from disk truth (`config.json`, `~/.claude/tasks/<team>/`, live process inventory) to a single resolved state.

### Domain 3: Messaging And Communication (channel completeness)
- Class G: a teammate produced work-product evidence on disk (verdict, completion artifact, retained-output) without sending the canonical completion-class `SendMessage` back to `team-lead`; disk-only completion is incomplete completion handoff per `.claude/skills/task-execution/references/completion-handoff.md`.
- Class H: a teammate received an assignment-grade `SendMessage`, marked it `read: true`, then idled without sending `dispatch-ack`, `scope-pressure`, `hold|blocker`, or any progress class; mailbox-consumed-without-channel-response is missing receipt.
- Class I: a `SendMessage` succeeds at the inbox-write surface but the receiver process is non-responsive (idle without further turn execution) for the bounded receipt window; inbox-arrival ≠ teammate work-trigger is the surfaced defect.

## Runtime Integrity Detection Triggers
- Compaction resume opens runtime-integrity classification before consequential dispatch, reuse, assignment-grade `SendMessage`, or `TeamCreate`.
- Active hook output, session state, runtime ledger, or dispatch preflight evidence of missing runtime marker after auto-recovery failure opens runtime-integrity classification.
- Pre-dispatch readiness check that finds stale `tmuxPaneId` for a frozen target opens runtime-integrity classification.
- UI display count ≠ `config.json` member count opens Domain 2 classification.
- Missing teammate completion `SendMessage` after retained-output appears on disk opens Domain 3 classification.
- Two or more sequential teammate idle notifications without `dispatch-ack` or work product opens Domain 3 classification.

## Per-Class Reconciliation Action
- Class A: re-attach the live process to the roster by team-scoped `Agent` re-spawn under a fresh live name when the lane is still required; otherwise terminate the live process by `kill <pid>` after explicit operator approval.
- Class B: remove the dead member entry from `config.json`; re-spawn the lane via team-scoped `Agent` when the lane is still required by the frozen route.
- Class C: classify the pane as dead-pane residue, remove the associated config entry after proof, and re-spawn the lane when still required.
- Class C `tmux kill-*` pane termination remains unavailable; cleanup proceeds through config-entry removal, lane re-spawn, cooperative `shutdown_request`, or non-tmux owner recovery.
- Closeout-owned teardown and hook-owned shutdown-response handling stay inside their own owner paths.
- Class C cleanup still uses config-entry removal, lane re-spawn, cooperative `shutdown_request`, or non-tmux owner recovery.
- Class D: unlink the orphan socket file only after confirming `tmux -L <name> list-sessions` fails; never unlink a socket whose server responds.
- Class E: bring UI and governance roster into parity by either re-attaching the live process via Class A action or removing the surplus live process via approved `kill <pid>`; UI count must equal `config.json` member count post-reconciliation.
- Class F: discard the phantom task id; treat retained-output disk evidence as evidence for the affected work surface only; route away from `TaskUpdate` on the phantom id.
- Class G: team-lead consumes the on-disk retained-output as production evidence only, opens missing completion-transport recovery or keeps the surface open, and records `completion-via-disk-only` as Domain 3 defect evidence for downstream `Skill(governance-modification)` patch consideration.
- Class H: team-lead sends one bounded receipt-follow-up `SendMessage`; persistent missing receipt after follow-up routes to Class I.
- Class I: team-lead sends one bounded execution-follow-up `SendMessage`; persistent unresponsive teammate after follow-up routes to replacement spawn, structured shutdown, or `HOLD` per `.claude/skills/task-execution/references/dispatch-recovery.md`.

## Operator-Approval Gate
- Class A `kill <pid>` and Class E `kill <pid>` are non-tmux force cleanup and require explicit operator approval before execution.
- Class C `tmux kill-*` pane termination is unavailable as cleanup action.
- Class I structured `shutdown_request` is cooperative runtime cleanup after the required follow-up and absent response/activity evidence.
- Class I structured `shutdown_request` executes inside `session-boot` or `task-execution` recovery; operator approval enters only when the path escalates to non-tmux force cleanup.
- Class B `config.json` member-entry removal, Class C config-entry cleanup after dead-pane proof, Class D socket unlink, Class F phantom-id discard, Class G disk-completion consumption, and Class H receipt-follow-up are non-destructive runtime hygiene and execute inside `session-boot` or `task-execution` recovery without user prompts.

## Runtime Integrity Reporting
- Classification, per-class action plan, and applied-reconciliation record are internal Procedure Plane evidence.
- Class A and Class E force cleanup surface as a `HOLD` with exact `kill <pid>` action plus approval request per `.claude/reference/reporting-prohibition-law.md`.
- Class C `tmux kill-*` pane termination surfaces as prohibited command selection and routes back to cooperative cleanup or non-tmux owner recovery.
- Domain 2 reconciliation result surfaces as a status answer when the user explicitly references a UI display ≠ governance roster mismatch per `.claude/reference/reporting-prohibition-law.md`.
- Completed automatic non-destructive reconciliation stays internal unless `.claude/reference/reporting-prohibition-law.md` grants a narrow exception for a status answer.

## Runtime Cleanup Rules
- Choose shutdown when closeout is active, hard memory pressure exists, context exhaustion risk is real, or recurrence is clearly absent.
- Choose standby when near-term reuse is concrete and context reuse is still valuable.
- Runtime-capacity or overlap guards require pressure or orphan residue resolution before new fan-out.
- Historical continuity artifacts are not automatic shutdown targets.

## Resolve Next Owner And Action
- Runtime-ready state returns to the frozen next owner/action.
- Runtime-required classification returns to the frozen next owner/action as runtime evidence.
- Runtime recovery need opens `session-boot` recovery.
- Missing receipt or start evidence opens one bounded follow-up and re-check.
- Stale or silent target after re-check opens replacement, redistribution, structured shutdown, or `HOLD`.
- Bottleneck or missed downstream-prep parallel-fit opens boundary-change correction through `team-lead`.
- Cleanup need opens structured shutdown, reuse, recovery, or `session-closeout`.
- Hard runtime pressure opens explicit recovery before new fan-out.
