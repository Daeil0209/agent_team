---
name: session-boot
description: "Lead-session boot, runtime-entry gates, monitoring, lifecycle interpretation, and recovery for team-lead; not assignment-grade dispatch."
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Inherits `CLAUDE.md`, the active owner role, and the common inheritance floor in `CLAUDE.md` `Priority And Ownership`. This skill may sharpen its owned procedure or specialist surface, but it must not weaken that floor or the owning role's stop conditions.
- Fixed section order: `Activation` -> `Boot Sequence` -> `Session-Start Sequence` -> `Sequence Activation Discipline` -> `Mode Split` -> `Monitoring Sequence`
- PRIMARY-OWNER: team-lead
- This file owns the runtime spine only. State tables, lifecycle mappings, boot-window detail, compaction recovery detail, and schema detail belong in `references/runtime-state-detail.md`.
- Assignment-grade `TeamCreate`, standalone `Agent` dispatch, team-scoped agent launch, and assignment-grade reuse belong to `task-execution` after `work-planning` and `SV-PLAN`.
- Structural changes require governance review.
### Reference Map
- `references/runtime-state-detail.md`: boot-window, startup, runtime-state, lifecycle, monitoring, stall, and recovery detail.

## Activation
Load this skill at the main session's fresh start, resume, or pause-return so `Session-Start Sequence` runs as the always-on baseline. `Boot Sequence` runs additionally when boot is incomplete, explicit runtime entry is required, or active delegated runtime still needs monitoring, dispatch-state observation, lifecycle interpretation, or runtime recovery.

Answer-only text that needs no tool may remain light. Any consequential tool work waits until boot evidence exists.

An explicit `session-boot` load may clear lead-local boot reminders when no explicit team runtime has started yet. That observation is a boot-state marker only. It does not authorize delegated runtime entry by itself.
This skill returns only runtime-ready, runtime-blocked, monitoring-required, or lifecycle-control-needed. It must not silently execute assignment-grade dispatch.

## Boot Sequence
`Boot Sequence` is the bounded entry path for lead-session boot and explicit team-agent runtime readiness. Run the team-agent runtime branch only for runtime readiness, recovery, or entry gating required by the current request or frozen route. Do not auto-start a team by habit.

Complete lead-session boot before delegated production work, `task-execution`, or agent fan-out begins.

Official runtime limits are boot facts, not preferences: agent teams require explicit runtime availability, one lead owns one team for that session, teammates do not spawn nested teams, and resume/rewind may not restore in-process teammates. If any limit affects the next consequential step, classify it during boot/recovery instead of discovering it after dispatch.

### Required order
1. Reset startup-volatile control residue without purging valid continuity or explicit closeout intent.
2. Read inherited continuity from the effective current-session authority.
3. Re-check planning continuity only when the imminent runtime work depends on that plan.
4. Resolve whether an existing explicit team-agent runtime can be reused, recovered, or rejected, or whether a new `TeamCreate` move must return to `task-execution`.
5. Confirm runtime-required routing or plugin surfaces only when the chosen runtime branch depends on them.
6. Keep the boot window narrow until runtime entry is resolved; no production fan-out or ordinary execution before boot closes.

See `references/runtime-state-detail.md` `Boot Window And Startup Rules` for tool-surface limits, path resolution, snapshot preference, fallback discovery, and startup constraints.

## Session-Start Sequence
`Session-Start Sequence` always runs at fresh start, resume, and pause-return whenever this skill is loaded — that is the default for the main session. `Boot Sequence` is the optional explicit-runtime branch on top of it. If both run, the continuity read is shared rather than repeated.

### Required checks
1. Establish active context and inherited state with minimal startup scope.
2. Identify incomplete work, active blockers, current ownership, and pending acceptance gates.
3. Verify current plan validity before implementation fan-out.
4. Distinguish live current-runtime agents from remembered continuity agents.
5. Resolve current management mode and runtime mode for the next work phase.
6. Make the initial owner map explicit enough to avoid drift.
7. If explicit team-agent runtime becomes necessary later, use the runtime-entry gate first, then return to `task-execution` for `TeamCreate` or team-scoped agent fan-out when dispatch is still lawful.

See `references/runtime-state-detail.md` `Session-Start Recovery` for compaction-triggered recovery, startup isolation, and session-state discipline.

## Sequence Activation Discipline
- Name the active session sequence when it is materially active.
- Keep the current phase, checkpoint, or blocking step visible enough that the next update can be interpreted against the same sequence.
- Do not silently switch between `Boot Sequence`, `Session-Start Sequence`, `Monitoring Sequence`, and `Closeout Sequence`.
- Do not compress a defined session procedure into a convenience path. If the governing procedure basis is not explicit, keep the lane on `HOLD`.

## Mode Split
Two agent-execution modes must stay separate:
- `standalone Agent`: a synchronous host call that returns to the lead, with no `TeamCreate`, no team mailbox, no `dispatch-ack`, and no health-cron duty.
- `team-agent runtime`: `TeamCreate` plus team-scoped `Agent` calls using `team_name`, with task/mailbox coordination and monitoring.

Require the explicit team-agent runtime path only when the frozen route needs shared team runtime, not merely because any additional-agent move is authorized. At least one runtime-specific condition must be true:
- the frozen route names team-agent runtime, team-scoped launch, shared mailbox/task state, or monitoring continuity
- role separation across multiple coordinated turns needs shared runtime coordination
- preserved agent context across multiple tasks materially reduces redispatch cost
- teammates need direct inter-agent communication, shared task claiming, competing-hypothesis challenge, or independent cross-layer coordination that a single returned subagent result cannot preserve

This requirement does not execute `TeamCreate`. It makes the runtime need explicit so `task-execution` can perform the lawful dispatch move after the required planning and verification gates.

Preserved agent context is a cost signal only. It must not collapse frozen independent work surfaces, `PARALLEL-GROUPS`, or required role separation into a single-agent bottleneck.

Otherwise use standalone `Agent` or lead-local only when the frozen route, ownership boundaries, and proof/acceptance separation allow it. Runtime cost or startup friction alone is never enough reason to avoid required team runtime.

The first team-scoped agent launch or shared-runtime assignment message is the runtime escalation boundary. Satisfy the runtime-entry gate before that boundary if the work no longer remains lead-local or standalone. If current-session team runtime is absent, `task-execution` owns the resulting `TeamCreate` move.

## Monitoring Sequence
`Monitoring Sequence` is continuous during active delegated operation.

### Monitoring responsibilities
- Track lane health, no-progress risk, ownership drift, stalled agents, merge collisions, and runtime pressure.
- Monitor canonical team/runtime truth classes without collapsing receipt-level dispatch into agent-start evidence.
- Runtime signals classify agent/runtime truth only; they do not authorize workflow progression, checkpoint resolution, or completion claims.
- When a governing workflow such as `dev-workflow` is active, monitor runtime in service of the active phase cursor only. Phase advancement, redistribution, synthesis, and completion claims stay with `team-lead` plus the active workflow owner.
- Completion-grade agent outputs observed through runtime channels return to `team-lead` for synthesis and the next verification gate. Observation alone does not advance the workflow.
- After completion-grade output, interpret lifecycle obligation separately from assignment. Send or require `lifecycle-control` when no new assignment-grade packet is being sent; closeout teardown remains owned by `session-closeout`.
- If monitoring exposes bottleneck collapse, owner vacuum, repeated runtime churn, missing agent-start evidence, or stalled phase consumption, surface workflow continuity pressure and return corrective ownership to `team-lead` plus the active workflow owner.
- If nominal parallel work collapses onto one agent strongly enough to create a schedule bottleneck, classify it as a distribution-planning defect and return corrective ownership to `team-lead -> work-planning reopen`.
- At every phase transition, agent handoff convergence, major checkpoint, or handoff/completion synthesis, proactively reassess team composition and downstream-prep parallel fit. Use `references/runtime-state-detail.md` `Proactive Team-Composition Reassessment` for the full question set, release rule, bottleneck-defect rule, and non-reactive monitoring requirement.
- Use bidirectional coordination actively during monitoring, and keep diagnostic/evidence work on the delegated evidence lane instead of absorbing it into lead-local convenience work.
- Detect stall-without-progress proactively and route around it; do not treat silence after `dispatch-ack` as deep work by default. Use `references/runtime-state-detail.md` `Stall-Without-Progress Rule` for thresholds, one-shot nudge, replacement, shutdown, and user-surface reporting detail.

See `references/runtime-state-detail.md` for:
- `Agent Lifecycle States`
- `Runtime Signals (Not Governance States)`
- `Supervisor Decisions on Turn-Ended Signals`
- `Message-First Lifecycle Rule`
- `Cost Rule`
- `Health-Check Standard`
- `Stale-Response Rule`
- `Runtime-Pressure Rule`
- `Procedure-State Schema`
- `Workflow Continuity Bridge`
