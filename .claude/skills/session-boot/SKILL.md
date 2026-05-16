---
name: session-boot
description: "Run lead-session boot, runtime-readiness gates, monitoring, lifecycle interpretation, and recovery. Use when team runtime readiness, session-start recovery, monitoring, or runtime lifecycle truth is active."
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Sharpens only its owned runtime surface.
- Fixed top-level section order after Structural Contract: `Activation` -> `Boot Sequence` -> `Session-Start Sequence` -> `Sequence Activation Discipline` -> `Mode Split` -> `Monitoring Sequence` -> `Resolve Next Owner And Action`.
- Reference Map stays inside Structural Contract.
- PRIMARY-OWNER: team-lead
- Owns the runtime spine only.
- Runtime-state tables, lifecycle mappings, boot-window detail, compaction recovery detail, monitoring detail, and schema detail belong in `references/runtime-state-detail.md`.
- Dispatch-runtime execution preflight belongs to `task-execution`; this skill only classifies runtime readiness, monitoring, recovery, and lifecycle truth.
### Reference Map
- `references/runtime-state-detail.md`: active-runtime observation, recovery, lifecycle, stale/stall, runtime-pressure, compaction-recovery, and monitoring detail only for the explicit triggers named below.
- Routine startup does not consume this reference unless the minimal gate detects material runtime detail.

Runtime-detail triggers:
- startup or resume must inspect current-session continuity, runtime snapshot, roster, lifecycle state, stale state, dispatch state, or recovery state
- active delegated runtime must classify monitoring, lifecycle-control need, stall, stale, runtime-pressure, compaction recovery, dispatch-state recovery, or runtime recovery
- a `SessionStart`, hook, task, runtime ledger, agent handoff, or `.runtime/procedure-state.json` signal changes the next session-boot owner/action

Runtime-detail non-triggers:
- clean startup with no runtime state, no recovery state, no monitoring state, and no consequential action needing runtime truth
- answer-only turns that need no tool, no runtime truth, and no boot artifact
- curiosity, reassurance, or narration about boot status

Runtime-detail load decision:
1. If current request or frozen route requires delegated runtime, classify runtime readiness; load `references/runtime-state-detail.md` only when existing runtime state, recovery state, monitoring state, lifecycle state, or dispatch state can change the next owner/action.
2. If current-session runtime evidence exists (`.runtime/procedure-state.json`, `SessionStart`, hook signal, task state, runtime ledger, inbox/handoff, or live roster evidence), decide whether that evidence is clean, active, stale, blocked, lifecycle-pending, or recovery-relevant.
3. If the evidence is clean and cannot change the next owner/action, do not load the reference.
4. If the evidence can change owner/action, load the reference and classify exactly one of runtime-ready, runtime-required, runtime-blocked, monitoring-required, recovery-required, or lifecycle-control-needed.

Runtime-detail consumption stays inside the Procedure Plane.
It never weakens the already-active User Surface Gate and never admits boot, monitoring, route, or runtime prose.

## Activation
Load at the main session's fresh start, resume, pause-return, or active-runtime recovery/monitoring re-entry.
Session boot is loaded after the Startup Contract's first User Surface Gate application.
Before any boot, resume, or monitoring prose, preserve and apply that already-active gate.
Do not re-consume or narrate `.claude/reference/user-reporting-law.md` during clean startup.
If the gate was not applied before this skill loaded, stop visible prose and route the defect to the active team-lead startup owner before boot narration.
For fresh consequential instructions, run the minimal session gate before `work-planning`; the canonical order is `session-boot` minimal gate -> `work-planning` -> `task-execution`.
The minimal gate checks only whether runtime, recovery, monitoring, lifecycle, compaction, or dispatch-state evidence is material to the next action.
When none is material, record `runtime-ready: clean` internally and open `work-planning`; do not load `references/runtime-state-detail.md`, do not inspect runtime ledgers, and do not emit boot prose.
Run `Session-Start Sequence` as the baseline.
Run `Boot Sequence` when boot is incomplete.
Run it when explicit runtime-readiness classification, monitoring, dispatch-state observation, lifecycle interpretation, or runtime recovery is required.
Every boot information check remains internal unless `.claude/reference/user-reporting-law.md` admits a report.
Boot checks can change runtime owner/action; they cannot create boot, status, progress, or summary prose permission.
If boot evidence and visible-prose pressure conflict, keep boot evidence internal and continue the Procedure Plane path.

Answer-only text that needs no tool can remain light.
Consequential tool work waits until boot evidence exists.

An explicit `session-boot` load can clear lead-local boot reminders when no explicit team runtime has started yet.
Treat that observation as a boot-state marker only.
Delegated runtime execution still returns to `task-execution`.
Return only runtime-ready, runtime-required, runtime-blocked, monitoring-required, recovery-required, or lifecycle-control-needed.
Runtime-ready and clean boot outcomes are internal move-out facts unless they create a blocker, required user action, or explicit status answer.
Do not emit boot summaries before opening the next owner/action that can run in the same segment.

## Boot Sequence
`Boot Sequence` is the bounded entry path for lead-session boot and explicit team-agent runtime readiness.
Run the team-agent runtime branch only for runtime readiness, recovery, or entry gating required by the current request or frozen route.
Classify runtime-ready, runtime-required, runtime-blocked, monitoring-required, or recovery-required here.
Dispatch-runtime creation, member creation, assignment send, and reuse execute only through `task-execution`.

Complete lead-session boot before delegated production work, `task-execution`, or delegated fan-out begins.

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
4. Resolve whether existing explicit team-agent runtime is ready, absent, recoverable, or rejected.
5. If runtime creation or member reattach is needed, return that runtime-required or recovery-required classification to `task-execution`.
6. Confirm runtime-required routing or plugin surfaces only when the chosen runtime branch depends on them.
7. Keep the boot window narrow until runtime readiness is classified.
8. No production fan-out or ordinary execution before boot closes.

See `references/runtime-state-detail.md` `Boot Window And Startup Rules` for tool-surface limits, path resolution, snapshot preference, fallback discovery, and startup constraints.
See `.claude/skills/task-execution/references/runtime-dispatch-law.md` for dispatch-runtime creation, member creation, assignment send, and reuse preflight.

## Session-Start Sequence
`Session-Start Sequence` always runs at fresh start, resume, and pause-return when this skill is loaded.
That is the default for the main session.
`Boot Sequence` is the conditional explicit-runtime branch on top.
If both run, share the continuity read instead of repeating it.

### Required checks
1. Establish active context and inherited state with minimal startup scope.
2. Identify incomplete work, active blockers, current ownership, and pending acceptance gates.
3. Verify current plan validity before implementation fan-out.
4. Distinguish live process-backed runtime agents from remembered continuity or config-residue agents.
5. Resolve current management mode and runtime mode for the next work phase.
6. Make the initial owner map explicit enough to avoid drift.
7. If explicit team-agent runtime becomes necessary later, use the runtime-readiness gate first.
8. Then return to `task-execution` for dispatch-runtime execution when dispatch is still lawful.

See `references/runtime-state-detail.md` `Session-Start Recovery` for compaction-triggered recovery, startup isolation, and runtime-state discipline.

## Sequence Activation Discipline
- Record the active session sequence in the internal continuity carrier when it is materially active.
- Record the current phase, checkpoint, or blocking step in the owning internal carrier: continuity record, task state, runtime ledger, retained note, or recovery record.
- Do not use boot, phase, checkpoint, continuity, or sequence names as pane-visible progress prose; visible output follows `.claude/reference/user-reporting-law.md` only.
- Sequence switches require an explicit active-sequence transition in the internal carrier.
- Defined session procedures follow the owning basis or stay on `HOLD`.

## Mode Split
Two agent-execution modes must stay separate:
- `standalone Agent`: legacy or fallback host evidence only; not configured lane dispatch.
- `team-agent runtime`: coordinated teammate execution with shared task/mailbox coordination and monitoring.

Require the explicit team-agent runtime path when the frozen route is parallel-fit, names `PARALLEL-GROUPS`, or needs shared team runtime.
At least one runtime-specific condition must be true:
- the frozen route is parallel-fit or names `PARALLEL-GROUPS`
- the frozen route names team-agent runtime, shared mailbox/task state, or monitoring continuity
- role separation across multiple coordinated turns needs shared runtime coordination
- preserved agent context across multiple tasks materially reduces redispatch burden
- teammates need direct inter-agent communication, shared task claiming, competing-hypothesis challenge, or independent cross-layer coordination
- a single returned subagent result cannot preserve the needed coordination

This requirement records runtime need only; `task-execution` performs lawful dispatch after required planning and verification gates.

Preserved agent context is a reuse signal only.
Frozen independent work surfaces, `PARALLEL-GROUPS`, and required role separation keep their staffing shape.

Otherwise stay lead-local only when frozen route, ownership boundaries, and proof/acceptance separation allow it.
Required team runtime stands despite runtime friction.

The first dispatch-runtime execution move is the runtime escalation boundary; assignment starts only through assignment-grade `SendMessage`.
Satisfy the runtime-readiness gate before that boundary if the work no longer remains lead-local or standalone.
If runtime is needed and current-session runtime is absent or not ready, return that classification to `task-execution`.

## Monitoring Sequence
`Monitoring Sequence` is the active-runtime re-entry path during delegated operation.

### Monitoring responsibilities
- Track lane health, no-progress risk, ownership drift, stalled agents, merge collisions, and runtime pressure.
- Monitor canonical team/runtime truth classes without collapsing receipt-level dispatch into agent-start evidence.
- Runtime signals classify agent/runtime truth only.
- Workflow progression, checkpoint resolution, and completion claims stay with their owning procedure.
- When a governing workflow such as `dev-workflow` is active, monitor runtime in service of the active phase cursor only.
- Phase advancement, redistribution, synthesis, and completion claims stay with `team-lead` plus the active workflow owner.
- Completion-grade agent outputs observed through runtime channels return to `team-lead` for synthesis and the next verification gate.
- Workflow advancement requires owning-procedure synthesis.
- After completion-grade output, record `STANDBY` and keep synthesis, validation, reuse, or cleanup as the next owner/action.
- Reuse uses assignment-grade bounded work; standby follows completion; shutdown uses structured `shutdown_request`.
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
- Use `references/runtime-state-detail.md` `Stall-Without-Progress Rule` for classification, one-shot follow-up, frozen re-check window, replacement, shutdown, and user-surface reporting detail.

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

## Resolve Next Owner And Action
- Runtime-ready returns to the frozen next owner/action.
- Runtime-required classification opens `task-execution`.
- Monitoring risk opens `team-lead` plus the active workflow owner.
- Bottleneck collapse opens `work-planning`.
- Lifecycle obligation opens lifecycle control.
- Closeout intent opens `session-closeout`.
- Runtime-blocked reports `HOLD` with owner, blocker, and next safe evidence step.
