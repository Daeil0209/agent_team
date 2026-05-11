---
name: session-boot
description: "Run lead-session boot, runtime-entry gates, monitoring, lifecycle interpretation, and recovery. Use when team runtime readiness, session-start recovery, monitoring, or runtime lifecycle truth is active."
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Sharpens only its owned runtime surface.
- Fixed top-level section order after Structural Contract: `Activation` -> `Boot Sequence` -> `Session-Start Sequence` -> `Sequence Activation Discipline` -> `Mode Split` -> `Monitoring Sequence` -> `Next-Action Drive`.
- Reference Map stays inside Structural Contract.
- PRIMARY-OWNER: team-lead
- Owns the runtime spine only.
- State tables, lifecycle mappings, boot-window detail, compaction recovery detail, and schema detail belong in `references/runtime-state-detail.md`.
- Assignment-grade `TeamCreate`, team-scoped agent launch, assignment-grade reuse, and fallback standalone result classification belong to `task-execution` after `work-planning`.
### Reference Map
- `references/runtime-state-detail.md`: boot-window, startup, runtime-state, lifecycle, monitoring, stall, and recovery detail.

## Activation
Load at the main session's fresh start, resume, or pause-return.
Run `Session-Start Sequence` as the baseline.
Run `Boot Sequence` when boot is incomplete.
Run it when explicit runtime entry, monitoring, dispatch-state observation, lifecycle interpretation, or runtime recovery is required.

Answer-only text that needs no tool can remain light.
Consequential tool work waits until boot evidence exists.

An explicit `session-boot` load can clear lead-local boot reminders when no explicit team runtime has started yet.
Treat that observation as a boot-state marker only.
Delegated runtime entry still returns to `task-execution`.
Return only runtime-ready, runtime-blocked, monitoring-required, or lifecycle-control-needed.
Runtime-ready and clean boot outcomes are internal move-out facts unless they create a blocker, required user action, or explicit status answer.
Do not emit boot summaries before opening the next owner/action that can run in the same segment.

## Boot Sequence
`Boot Sequence` is the bounded entry path for lead-session boot and explicit team-agent runtime readiness.
Run the team-agent runtime branch only for runtime readiness, recovery, or entry gating required by the current request or frozen route.
Start a team only when runtime readiness, recovery, or frozen route requires it.

Complete lead-session boot before delegated production work, `task-execution`, or agent fan-out begins.

Official runtime limits are boot facts, not preferences.
Agent teams require explicit runtime availability.
One lead owns one team for that session.
Nested team spawning stays outside teammate authority.
Resume/rewind can fail to restore in-process teammates.
If any limit affects the next consequential step, classify it during boot/recovery.
Classify runtime limits before dispatch.

### Required order
1. Reset startup-volatile control residue without purging valid continuity or explicit closeout intent.
2. Read inherited continuity from the effective current-session authority.
3. Re-check planning continuity only when the imminent runtime work depends on that plan.
4. Resolve whether existing explicit team-agent runtime can be reused, recovered, or rejected.
5. If new `TeamCreate` is needed, return that move to `task-execution`.
6. Confirm runtime-required routing or plugin surfaces only when the chosen runtime branch depends on them.
7. Keep the boot window narrow until runtime entry is resolved.
8. No production fan-out or ordinary execution before boot closes.

See `references/runtime-state-detail.md` `Boot Window And Startup Rules` for tool-surface limits, path resolution, snapshot preference, fallback discovery, and startup constraints.

## Session-Start Sequence
`Session-Start Sequence` always runs at fresh start, resume, and pause-return when this skill is loaded.
That is the default for the main session.
`Boot Sequence` is the optional explicit-runtime branch on top.
If both run, share the continuity read instead of repeating it.

### Required checks
1. Establish active context and inherited state with minimal startup scope.
2. Identify incomplete work, active blockers, current ownership, and pending acceptance gates.
3. Verify current plan validity before implementation fan-out.
4. Distinguish live process-backed runtime agents from remembered continuity or config-residue agents.
5. Resolve current management mode and runtime mode for the next work phase.
6. Make the initial owner map explicit enough to avoid drift.
7. If explicit team-agent runtime becomes necessary later, use the runtime-entry gate first.
8. Then return to `task-execution` for `TeamCreate` or team-scoped agent fan-out when dispatch is still lawful.

See `references/runtime-state-detail.md` `Session-Start Recovery` for compaction-triggered recovery, startup isolation, and runtime-state discipline.

## Sequence Activation Discipline
- Name the active session sequence when it is materially active.
- Keep the current phase, checkpoint, or blocking step visible enough that the next update can be interpreted against the same sequence.
- Sequence switches require an explicit active-sequence transition.
- Defined session procedures follow the owning basis or stay on `HOLD`.

## Mode Split
Two agent-execution modes must stay separate:
- `standalone Agent`: legacy or fallback host evidence only; not configured lane dispatch.
- `team-agent runtime`: `TeamCreate` plus team-scoped `Agent` calls using `team_name`, with task/mailbox coordination and monitoring.

Require the explicit team-agent runtime path when the frozen route is parallel-fit, names `PARALLEL-GROUPS`, or needs shared team runtime.
At least one runtime-specific condition must be true:
- the frozen route is parallel-fit or names `PARALLEL-GROUPS`
- the frozen route names team-agent runtime, team-scoped launch, shared mailbox/task state, or monitoring continuity
- role separation across multiple coordinated turns needs shared runtime coordination
- preserved agent context across multiple tasks materially reduces redispatch burden
- teammates need direct inter-agent communication, shared task claiming, competing-hypothesis challenge, or independent cross-layer coordination
- a single returned subagent result cannot preserve the needed coordination

This requirement records runtime need only; `task-execution` performs lawful dispatch after required planning and verification gates.

Preserved agent context is a reuse signal only.
Frozen independent work surfaces, `PARALLEL-GROUPS`, and required role separation keep their staffing shape.

Otherwise stay lead-local only when frozen route, ownership boundaries, and proof/acceptance separation allow it.
Required team runtime stands despite runtime friction.

The first team-scoped agent launch or shared-runtime assignment message is the runtime escalation boundary.
Satisfy the runtime-entry gate before that boundary if the work no longer remains lead-local or standalone.
If runtime is needed and no current-session team registration exists, `task-execution` owns the resulting `TeamCreate` move.

## Monitoring Sequence
`Monitoring Sequence` is continuous during active delegated operation.

### Monitoring responsibilities
- Track lane health, no-progress risk, ownership drift, stalled agents, merge collisions, and runtime pressure.
- Monitor canonical team/runtime truth classes without collapsing receipt-level dispatch into agent-start evidence.
- Runtime signals classify agent/runtime truth only.
- Workflow progression, checkpoint resolution, and completion claims stay with their owning procedure.
- When a governing workflow such as `dev-workflow` is active, monitor runtime in service of the active phase cursor only.
- Phase advancement, redistribution, synthesis, and completion claims stay with `team-lead` plus the active workflow owner.
- Completion-grade agent outputs observed through runtime channels return to `team-lead` for synthesis and the next verification gate.
- Workflow advancement requires owning-procedure synthesis.
- After completion-grade output, interpret lifecycle obligation separately from assignment.
- Use free-text `lifecycle-control` only for non-terminating `reuse`, `standby`, or `hold-for-validation`.
- Normalize any shutdown intent to structured `SendMessage` `{"type":"shutdown_request"}`.
- Wait for confirmed termination evidence.
- Closeout teardown remains owned by `session-closeout`.
- If monitoring exposes bottleneck collapse, owner vacuum, repeated runtime churn, missing agent-start evidence, or stalled phase consumption, surface workflow continuity pressure.
- Return corrective ownership to `team-lead` plus the active workflow owner.
- If nominal parallel work collapses onto one agent strongly enough to create a schedule bottleneck, classify it as a distribution-planning defect and return corrective ownership to `team-lead -> work-planning reopen`.
- Apply Proactive Team-Composition Reassessment per `references/runtime-state-detail.md` `## Proactive Team-Composition Reassessment` (canonical trigger, full question set, release rule, bottleneck-defect rule, and non-reactive monitoring requirement).
- Use bidirectional coordination actively during monitoring.
- Keep diagnostic/evidence work on the delegated evidence lane instead of absorbing it into lead-local convenience work.
- Detect stall-without-progress proactively.
- Silence before `dispatch-ack` is a recovery target.
- Silence after `dispatch-ack` needs progress evidence or recovery handling.
- In parallel dispatch, an unacknowledged or unstarted target is a recovery target, not group-running evidence.
- Use `references/runtime-state-detail.md` `Stall-Without-Progress Rule` for thresholds, one-shot nudge, replacement, shutdown, and user-surface reporting detail.

See `references/runtime-state-detail.md` for:
- `Agent Lifecycle States`
- `Runtime Signals (Not Governance States)`
- `Supervisor Decisions on Turn-Ended Signals`
- `Message-First Lifecycle Rule`
- `Reuse Rule`
- `Health-Check Standard`
- `Stale-Response Rule`
- `Runtime-Pressure Rule`
- `Procedure-State Schema`
- `Workflow Continuity Bridge`

## Next-Action Drive
- Runtime-ready returns to the frozen next owner/action.
- Team-agent runtime creation opens `task-execution`.
- Monitoring risk opens `team-lead` plus the active workflow owner.
- Bottleneck collapse opens `work-planning`.
- Lifecycle obligation opens lifecycle control.
- Closeout intent opens `session-closeout`.
- Runtime-blocked reports `HOLD` with owner, blocker, and next safe evidence step.
