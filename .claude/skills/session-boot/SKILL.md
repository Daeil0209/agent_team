---
name: session-boot
description: "Session runtime operations including boot, monitoring, and worker lifecycle for team-lead."
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Fixed section order: `Activation` -> `Boot Sequence` -> `Session-Start Sequence` -> `Sequence Activation Discipline` -> `Mode Split` -> `Monitoring Sequence`
- PRIMARY-OWNER: team-lead
- This file owns the runtime spine only. State tables, lifecycle mappings, boot-window detail, compaction recovery detail, and schema detail belong in `reference.md`.
- Structural changes require governance review.

## Activation
Load this skill at the main session's fresh start, resume, or pause-return so `Session-Start Sequence` runs as the always-on baseline. `Boot Sequence` runs additionally when boot is incomplete, explicit runtime entry is required, or active delegated runtime still needs monitoring, dispatch-state observation, lifecycle interpretation, or runtime recovery.

An explicit `session-boot` load may clear lead-local boot reminders when no explicit team runtime has started yet. That observation is a boot-state marker only. It does not authorize delegated runtime entry by itself.

## Boot Sequence
`Boot Sequence` is the bounded entry path for explicit team runtime. Run it only when the current request materially benefits from explicit team orchestration. Do not auto-start a team by habit.

Complete boot before delegated production work, `task-execution`, or worker fan-out begins.

### Required order
1. Reset startup-volatile control residue without purging valid continuity or explicit closeout intent.
2. Read inherited continuity from the effective current-session authority.
3. Re-check planning continuity only when the imminent runtime work depends on that plan.
4. Reuse, create, or replace explicit team runtime only when the runtime decision requires it.
5. Confirm runtime-required routing or plugin surfaces only when the chosen runtime branch depends on them.
6. Keep the boot window narrow until runtime entry is resolved; no production fan-out or ordinary execution before boot closes.

See `reference.md` `Boot Window And Startup Rules` for tool-surface limits, path resolution, snapshot preference, fallback discovery, and startup constraints.

## Session-Start Sequence
`Session-Start Sequence` always runs at fresh start, resume, and pause-return whenever this skill is loaded — that is the default for the main session. `Boot Sequence` is the optional explicit-runtime branch on top of it. If both run, the continuity read is shared rather than repeated.

### Required checks
1. Establish active context and inherited state with minimal startup scope.
2. Identify incomplete work, active blockers, current ownership, and pending acceptance gates.
3. Verify current plan validity before implementation fan-out.
4. Distinguish live current-runtime workers from remembered continuity workers.
5. Resolve current management mode and runtime mode for the next work phase.
6. Make the initial owner map explicit enough to avoid drift.
7. If explicit runtime becomes necessary later, use the runtime-entry gate before `TeamCreate` or new worker fan-out.

See `reference.md` `Session-Start Recovery` for compaction-triggered recovery, startup isolation, and session-state discipline.

## Sequence Activation Discipline
- Name the active session sequence when it is materially active.
- Keep the current phase, checkpoint, or blocking step visible enough that the next update can be interpreted against the same sequence.
- Do not silently switch between `Boot Sequence`, `Session-Start Sequence`, `Monitoring Sequence`, and `Closeout Sequence`.
- Do not compress a defined session procedure into a convenience path. If the governing procedure basis is not explicit, keep the lane on `HOLD`.

## Mode Split
Activate explicit team runtime when at least one is true:
- team routing is already required and 2 or more independent work surfaces can proceed simultaneously
- role separation between implementation, review, testing, or validation is materially needed
- preserved worker context across multiple tasks materially reduces redispatch cost

Preserved worker context is a cost signal only. It must not collapse frozen independent work surfaces, `PARALLEL-GROUPS`, or required role separation into a single-worker bottleneck.

Otherwise remain lead-local only when the direct-work conditions from `agents/team-lead.md` are clearly satisfied. Runtime cost or startup friction alone is never enough reason to stay lead-local.

The first delegated `Agent` or shared-runtime `SendMessage` is the runtime escalation boundary. Activate explicit runtime before that boundary if the work no longer remains lead-local.

## Monitoring Sequence
`Monitoring Sequence` is continuous during active delegated operation.

### Monitoring responsibilities
- Track lane health, no-progress risk, ownership drift, stalled workers, merge collisions, and runtime pressure.
- Monitor canonical team/runtime truth classes without collapsing receipt-level dispatch into worker-start evidence.
- Runtime signals classify worker/runtime truth only; they do not authorize workflow progression, checkpoint resolution, or completion claims.
- When a governing workflow such as `dev-workflow` is active, monitor runtime in service of the active phase cursor only. Phase advancement, redistribution, synthesis, and completion claims stay with `team-lead` plus the active workflow owner.
- Completion-grade worker outputs observed through runtime channels return to `team-lead` for synthesis and the next verification gate. Observation alone does not advance the workflow.
- If monitoring exposes bottleneck collapse, owner vacuum, repeated runtime churn, missing worker-start evidence, or stalled phase consumption, surface workflow continuity pressure and return corrective ownership to `team-lead` plus the active workflow owner.
- If nominal parallel work collapses onto one worker strongly enough to create a schedule bottleneck, classify it as a distribution-planning defect and return corrective ownership to `team-lead -> work-planning reopen`.
- Use bidirectional coordination actively during monitoring, and keep diagnostic/evidence work on the delegated evidence lane instead of absorbing it into lead-local convenience work.

See `reference.md` for:
- `Worker Lifecycle States`
- `Runtime Signals (Not Governance States)`
- `Supervisor Decisions on Turn-Ended Signals`
- `Message-First Lifecycle Rule`
- `Cost Rule`
- `Health-Check Standard`
- `Stale-Response Rule`
- `Runtime-Pressure Rule`
- `Procedure-State Schema`
- `Workflow Continuity Bridge`
