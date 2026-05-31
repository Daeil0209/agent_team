---
name: session-boot
description: "Run lead-session boot, runtime-readiness gates, monitoring, runtime cleanup interpretation, and recovery. Use when team runtime readiness, session-start recovery, monitoring, or runtime cleanup truth is active."
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Sharpens only its runtime procedure surface.
- Fixed top-level section order after Structural Contract: `Activation` -> `Boot Sequence` -> `Session-Start Sequence` -> `Sequence Activation Discipline` -> `Mode Split` -> `Monitoring Sequence` -> `Resolve Next Owner And Action`.
- Reference Map stays inside Structural Contract.
- Handles the runtime spine only.
- Runtime-state tables, cleanup mappings, boot-window detail, compaction recovery detail, monitoring detail, and schema detail belong in `references/runtime-state-detail.md`.
### Reference Map
- `.claude/reference/environment-configuration-core-law.md`: load when runtime readiness, session-start recovery, monitoring, cleanup interpretation, official behavior, tool capability, hook signal, or runtime footprint changes the next owner/action.
- `references/runtime-state-detail.md`: active-runtime observation, recovery, cleanup, stale/stall, runtime-pressure, compaction-recovery, and monitoring detail only for the explicit triggers named below.
- Routine startup consumes this reference only when the minimal gate detects material runtime detail.

Runtime-detail triggers:
- startup or resume must inspect current-session continuity, runtime snapshot, roster, cleanup state, stale state, dispatch state, or recovery state
- active delegated runtime must classify monitoring, cleanup need, stall, stale, runtime-pressure, compaction recovery, dispatch-state recovery, or runtime recovery
- a `SessionStart`, hook, task, runtime ledger, agent completion, or `.runtime/procedure-state.json` signal changes the next session-boot owner/action
- compaction resume, active hook/session-state evidence of missing runtime marker, or stale `tmuxPaneId` for a frozen target opens runtime-integrity classification per `references/runtime-state-detail.md` `## Runtime Integrity Detection Triggers`, `## Runtime Integrity Defect Classification`, and `## Per-Class Reconciliation Action`

Runtime-detail non-triggers:
- clean startup with no runtime state, no recovery state, no monitoring state, and no consequential action needing runtime truth
- answer-only turns that need no tool, no runtime truth, and no boot artifact
- curiosity, reassurance, or narration about boot status

Runtime-detail load decision:
1. If current request or frozen route requires delegated runtime, classify runtime readiness; load `references/runtime-state-detail.md` only when existing runtime state, recovery state, monitoring state, cleanup state, or dispatch state can change the next owner/action.
2. If current-session runtime evidence exists (`.runtime/procedure-state.json`, `SessionStart`, hook signal, task state, runtime ledger, inbox/completion, or live roster evidence), decide whether that evidence is clean, active, stale, blocked, cleanup-pending, or recovery-relevant.
3. If the evidence is clean and has no next owner/action effect, keep the reference unloaded.
4. If the evidence can change owner/action, load the reference and classify exactly one of runtime-ready, runtime-required, runtime-blocked, monitoring-required, recovery-required, or runtime-cleanup-needed.

Runtime-detail consumption stays inside the Procedure Plane.
It preserves `.claude/reference/reporting-prohibition-law.md` report-prohibition criteria and surfaces visible boot, monitoring, route, or runtime prose only through a reporting-law narrow exception.

## Activation
Load at the main session's fresh start, resume, pause-return, or active-runtime recovery/monitoring re-entry.
Session boot is loaded after the team-lead Startup Contract consumes `.claude/reference/reporting-core-law.md` and its triggered `.claude/reference/reporting-prohibition-law.md`.
Before any boot, resume, or monitoring prose, preserve and apply those already-consumed reporting references.
Clean startup preserves those reporting references without re-consuming them.
If the Startup Contract lacks consumed reporting core law and triggered reporting-prohibition law before this skill loaded, route visible prose through the active team-lead startup owner before boot narration.
The minimal gate checks only whether runtime, recovery, monitoring, cleanup, compaction, or dispatch-state evidence is material to the next action.
When none is material, record `runtime-ready: clean` internally.
Then proceed without runtime-detail reference load, runtime-ledger inspection, or boot prose.
Run `Session-Start Sequence` as the baseline.
Run `Boot Sequence` when boot is incomplete.
Run it when explicit runtime-readiness classification, monitoring, dispatch-state observation, cleanup interpretation, or runtime recovery is required.
Every boot information check remains internal unless `.claude/reference/reporting-prohibition-law.md` grants a narrow report exception.
Boot checks can change runtime owner/action; visible boot, status, progress, or summary prose routes through reporting law.
If boot evidence and visible-prose pressure conflict, keep boot evidence internal and continue the Procedure Plane path.

Answer-only text that needs no tool can remain light.
While session-boot is active, runtime-readiness, recovery, monitoring, cleanup, or dispatch-state tool work waits for the matching session-boot classification.

Record only runtime-ready, runtime-required, runtime-blocked, monitoring-required, recovery-required, or runtime-cleanup-needed.
Runtime-ready and clean boot outcomes are internal move-out facts; do not render startup-applied, ready, clean-session, or request-prompt prose unless `.claude/reference/reporting-prohibition-law.md` admits blocker or explicit-status prose.
Open the next owner/action that can run in the same segment before any reporting-law-excepted boot prose.

## Boot Sequence
`Boot Sequence` is the bounded entry path for lead-session boot and explicit team-agent runtime readiness.
Run the team-agent runtime branch only for runtime readiness, recovery, or entry gating required by the current request or frozen route.
Classify runtime-ready, runtime-required, runtime-blocked, monitoring-required, or recovery-required here.
Active `Boot Sequence` records runtime-readiness classification internally before runtime-dependent action.

`startup-volatile control residue` means startup-era runtime, hook, task, or continuity observations that are not live continuity basis unless rechecked for the current session.

Official runtime limits are boot facts, not preferences.
Agent teams require explicit runtime availability.
One lead handles one team for that session.
Nested team spawning stays outside teammate scope.
Resume/rewind can fail to restore in-process teammates.
If any limit affects the next consequential step, classify it during boot/recovery.
Classify runtime limits before runtime-dependent action proceeds.

### Required order
1. Reset startup-volatile control residue without purging valid continuity or explicit closeout intent.
2. Read inherited continuity from the effective current-session basis.
3. Re-check planning continuity only when the imminent runtime work depends on that plan.
4. Resolve whether existing explicit team-agent runtime is ready, absent, recoverable, or rejected.
5. Runtime-required or recovery-required classification is runtime evidence for the frozen next owner/action.
6. Confirm runtime-required routing or plugin surfaces only when the chosen runtime branch depends on them.
7. Keep the boot window narrow until runtime readiness is classified.
8. Active `Boot Sequence` closes before runtime-dependent action proceeds.

See `references/runtime-state-detail.md` `Boot Window And Startup Rules` for tool-surface limits, path resolution, snapshot preference, fallback discovery, and startup constraints.

## Session-Start Sequence
`Session-Start Sequence` always runs at fresh start, resume, and pause-return when this skill is loaded.
That is the default for the main session.
`Boot Sequence` is the conditional explicit-runtime branch on top.
If both run, share the continuity read instead of repeating it.

### Required checks
1. Establish active context and inherited state with minimal startup scope.
2. Identify incomplete work, active blockers, current active path, and pending acceptance gates.
3. Verify runtime-relevant continuity validity before runtime-dependent action.
4. Distinguish live process-backed runtime agents from remembered continuity or config-residue agents.
5. Resolve current management mode and runtime mode for the next work phase.
6. Make the initial owner map explicit enough to avoid drift.
7. If explicit team-agent runtime becomes necessary later, use the runtime-readiness gate first.
8. Then return runtime classification to the frozen next owner/action when the route remains lawful.

See `references/runtime-state-detail.md` `Session-Start Recovery` for compaction-triggered recovery, startup isolation, and runtime-state discipline.

## Sequence Activation Discipline
- A sequence is `materially active` when its state can change the next owner, next action, blocker, recovery, monitoring, cleanup, or dispatch truth.
- Record the active session sequence in the internal continuity carrier when it is materially active.
- Record the current phase, checkpoint, or blocking step in the matching internal carrier: continuity record, task state, runtime ledger, retained note, or recovery record.
- Keep boot, phase, checkpoint, continuity, and sequence names internal as procedure state; visible output follows `.claude/reference/reporting-prohibition-law.md` only.
- Sequence switches require an explicit active-sequence transition in the internal carrier.
- Defined session procedures follow the governing basis or blocker-routing after internal recovery is exhausted.

## Mode Split
Two agent-execution modes must stay separate:
- `standalone Agent`: legacy or fallback host evidence only; not configured lane dispatch or lane work.
- `team-agent runtime`: coordinated teammate execution with shared task/mailbox coordination and monitoring.

Require the explicit team-agent runtime path when the frozen route is parallel-fit, names `PARALLEL-GROUPS`, or needs shared team runtime.
Each runtime-specific condition below independently requires team-agent runtime when true.
Each true runtime-specific condition independently preserves the team-agent runtime requirement.
At least one runtime-specific condition must be true:
- the frozen route is parallel-fit or names `PARALLEL-GROUPS`
- the frozen route names team-agent runtime, shared mailbox/task state, or monitoring continuity
- role separation across multiple coordinated turns needs shared runtime coordination
- preserved agent context across multiple tasks materially reduces redispatch burden
- teammates need direct inter-agent communication, shared task claiming, competing-hypothesis challenge, or independent cross-layer coordination
- a single returned subagent result is insufficient to preserve the needed coordination

This requirement records runtime need only; session-boot emits runtime evidence for the already frozen route.

Preserved agent context is a reuse signal only.
Frozen independent work surfaces, `PARALLEL-GROUPS`, and required role separation keep their staffing shape.

Otherwise stay lead-local only when frozen route, route boundaries, and proof/acceptance separation allow it.
Required team runtime stands despite runtime friction.

The first dispatch-runtime execution move is the runtime escalation boundary; assignment starts only through assignment-grade `SendMessage`.
Satisfy the runtime-readiness gate before that boundary if the work no longer remains lead-local or evidence-only standalone.
If runtime is needed and current-session runtime is absent or not ready, return that classification as runtime evidence.

## Monitoring Sequence
`Monitoring Sequence` is the active-runtime re-entry path during delegated operation.

### Monitoring responsibilities
- Track lane health, no-progress risk, route drift, stalled agents, merge collisions, and runtime pressure.
- Monitor canonical team/runtime truth classes without collapsing receipt-level dispatch into agent-start evidence.
- Runtime signals classify agent/runtime truth only.
- Runtime health checks, socket-drop checks, carrier-presence checks, roster reads, and missing-file checks stay as internal recovery evidence; `Bash` command shape follows `.claude/reference/work-runtime-boundary-law.md` `### Bash Internal Evidence Capture Contract`, and the owner does not narrate the check, hook denial, retry, or interim classification.
- Workflow progression, checkpoint resolution, and completion claims stay with their governing procedure.
- When a governing workflow such as `dev-workflow` is active, monitor runtime in service of the active phase cursor only.
- Phase advancement, redistribution, synthesis, and completion claims stay with `team-lead` plus the active workflow owner.
- Completion-grade agent outputs observed through runtime channels return to `team-lead` for synthesis and the next verification gate.
- Workflow advancement requires governing-procedure synthesis.
- Completion-grade → `STANDBY` → synthesis/validation/reuse/cleanup transitions and structured `shutdown_request` semantics: canonical source `references/runtime-state-detail.md`; consume that source for the rule body before action selection.
- Closeout teardown remains with `session-closeout`.
- If monitoring exposes bottleneck collapse, owner vacuum, repeated runtime churn, missing agent-start evidence, or stalled phase consumption, surface workflow continuity pressure.
- Return corrective path to `team-lead` plus the active workflow path.
- If nominal parallel work collapses onto one agent strongly enough to create a schedule bottleneck, classify it as a distribution-planning defect and return corrective path to `team-lead` for boundary-change correction.
- Apply Proactive Team-Composition Reassessment per `references/runtime-state-detail.md` `## Proactive Team-Composition Reassessment` (canonical trigger, full question set, release rule, bottleneck-defect rule, and non-reactive monitoring requirement).
- Use bidirectional coordination actively during monitoring.
- Keep diagnostic/evidence work on the delegated evidence lane instead of absorbing it into lead-local convenience work.
- Detect stall-without-progress proactively per `references/runtime-state-detail.md` `## Stall-Without-Progress Rule` (classification, one-shot follow-up, frozen re-check window, replacement, shutdown, and user-surface reporting detail).

See `references/runtime-state-detail.md` for:
- `Agent Work States`
- `Runtime Signals (Not Governance States)`
- `Supervisor Decisions on Turn-Ended Signals`
- `Message-First Runtime Cleanup Rule`
- `Reuse Rule`
- `Health-Check Standard`
- `Stale-Response Rule`
- `Runtime-Pressure Rule`
- `Procedure-State Schema`
- `Workflow Continuity Bridge`

## Resolve Next Owner And Action
- Runtime-ready returns to the frozen next owner/action.
- Runtime-required classification returns to the frozen next owner/action as runtime evidence.
- Monitoring risk opens `team-lead` plus the active workflow owner.
- Bottleneck collapse opens boundary-change correction through `team-lead`.
- Cleanup obligation opens structured shutdown, reuse, recovery, or `session-closeout`.
- Closeout intent opens `session-closeout`.
- Runtime-blocked records blocker-routing with owner, blocker, exhausted runtime recovery basis, and next safe owner/action.
