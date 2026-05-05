---
name: team-session-sequences
description: Session-sequence index and lead-side dispatch/detail lookup for the Claude team runtime. Boot and closeout runtime spines belong to session-boot and session-closeout.
user-invocable: false
PRIMARY-OWNER: team-lead
---

## Structural Contract
- Fixed owner pattern for future skill growth:
  1. `Sequence Activation Discipline`
  2. named sequence sections
  3. `Required order` / `Required checks` / `Required actions` blocks
  4. sequence-specific constraints, gates, and state rules
- New top-level lifecycle names require explicit governance review.
- Keep exact sequence names stable when they are already referenced by doctrine, agents, settings, or hooks.
- Expand the owning sequence section rather than appending detached sidecar procedure blocks.
- Structural connectivity is immutable.
- New session-runtime rules must stay attached to an owning sequence or gate block.
- Session doctrine attaches to an owning sequence or gate block.
- Keep long packet tables, sizing rules, shard/merge detail, and handoff field catalogs in direct files under `references/`.
- Keep the mandatory trigger, owner, and stop rule in this spine.
- PRIMARY-OWNER: team-lead

# Team Session Sequences

Index session-level sequence names and lead-side dispatch detail when a sequence is materially active.
Runtime spine, closeout spine, packet schema, message law, and lifecycle truth stay with their owning skills.

Use the exact lifecycle names defined in `.claude/CLAUDE.md`:
- `Boot Sequence` (on-demand: session-boot skill)
- `Session-Start Sequence` (on-demand: session-boot skill)
- `Monitoring Sequence`
- `Closeout Sequence` (on-demand: session-closeout skill)

Use these procedures when the corresponding sequence is materially in play.

## Sequence Activation Discipline

- When a session sequence is materially active, name that sequence explicitly in control updates.
- Keep the current phase, checkpoint, or blocking step visible enough that the next update can be interpreted against the same active sequence.
- Active sequence switches require an explicit sequence transition.
- Defined session procedures follow the owning rule for optionality.
- Build plans, owner maps, and sequencing decisions from loaded doctrine and owner-local procedure files.
- If the governing procedure cannot be pointed to cleanly, keep the lane on `HOLD` until the procedure basis is explicit.

### Reference Map

Load trigger-specific files directly from `SKILL.md`.
- `references/pre-dispatch-verification.md`: consequential dispatch readiness index and risk-tier record map.
- `references/task-decomposition.md`: split basis, child packet boundary, done condition, and return-form discipline.
- `references/dispatch-packet-compliance.md`: session-side controlled-value fields and lane-specific presence-required fields.
- `references/agent-load-guard.md`: focused dispatch sizing bounds and overload exception.
- `references/dispatch-execution-contract.md`: background/foreground runtime execution, request-fit ordering, phase intent, and mixed-purpose prompt boundaries.
- `references/parallel-shard-merge.md`: parent packet freeze, shard fan-out, merge owner, and integrated output routing.
- `references/upward-handoff.md`: consequential upward handoff block fields and monotonic lane-owned state rules.
- `references/monitoring-lifecycle-detail.md`: runtime signals, lifecycle decisions, manifest gate, health-check, stale response, runtime pressure, and task identity detail.

## Mode Split

Canonical runtime decision rules live in `.claude/skills/session-boot/SKILL.md` `Mode Split`.
Closeout state rules live in `.claude/skills/session-closeout/SKILL.md`.

There are two operating cases:

1. Lead-managed session without explicit team runtime
- Use lead-local work only when the frozen route allows it.
- Treat standalone `Agent` results, if already present, as fallback evidence rather than lane dispatch.
- Configured lane team-runtime delegation requires explicit team runtime.
- Skip `TeamCreate` only for a frozen lead-local route with no additional-agent work.
- Skip session cron registration only when no active team runtime exists.

2. Explicit team-runtime session
- Use the full `Boot Sequence`.
- Team lifecycle, `SendMessage`, monitoring rules, and closeout cleanup all apply.
- Recurring health-check registration is conditional on the active runtime policy or tracked runtime configuration.

Use explicit team runtime when active runtime policy, existing live runtime, or frozen route needs shared team coordination.
The lead-managed no-runtime case remains lawful when no shared team runtime is needed.
Standalone-agent results remain fallback evidence only; they are not configured lane dispatch.
Neither case is valid when team mailbox, shared task state, lifecycle monitoring, or sustained teammate coordination is required.

When the current runtime is ambiguous, the lead must resolve that ambiguity before production fan-out.


## Boot Sequence

> On-demand: see `session-boot` skill. Loaded at session start via hook trigger.

## Session-Start Sequence

> On-demand: see `session-boot` skill. Loaded at session start via hook trigger.

## Monitoring Sequence

The `Monitoring Sequence` general procedure is owned by `.claude/skills/session-boot/SKILL.md`.
Canonical lifecycle vocabulary is owned by `.claude/skills/session-boot/references/runtime-state-detail.md`.
Use `references/monitoring-lifecycle-detail.md` for lead-side runtime-signal, lifecycle, manifest, health-check, stale-response, runtime-pressure, and task-identity detail.

Hard surface:
- Runtime signals are observation evidence, not governance state or completion proof.
- Agent lifecycle is message-first.
- Completion requests a governing decision.
- Auto-standby, replacement, or removal requires a governing decision.
- Reuse is preferred only when workload, availability, context fit, owner safety, and frozen parallel shape support it.
- Manifest-dependent execution needs pre-dispatch manifest review and explicit write scope before fan-out.

### Pre-Dispatch Readiness Pointer

Do not run a separate readiness gate from this surface.
Planning-level readiness stays with `.claude/skills/work-planning/references/execution-readiness.md`.
Assignment packet preflight stays with `.claude/skills/task-execution/references/assignment-packet.md`.
Use `references/pre-dispatch-verification.md` only as a non-authoritative index to those owners.
The dispatch readiness index preserves goal alignment, alternative routing, agent-charter fit, scope boundary, prior-analysis handoff, prerequisite completeness, and failure path coverage as required readiness meaning.

### Task Decomposition Protocol

When work spans a broad file set, decompose before dispatch using `references/task-decomposition.md`.
Also decompose when work needs both investigation and judgment.
Also decompose when work crosses multiple categories or otherwise risks overload.
Every child dispatch must carry split basis, child boundary, excluded boundary, done condition, and return form.
Those fields must support merge, reroute, or hold decisions without memory.

### Dispatch Packet Compliance

Before sending a dispatch, verify structured fields against the target lane role.
Verify them against the lane-core skill.
Verify them against the `task-execution` packet contract.
Verify them against `references/dispatch-packet-compliance.md`.
Cross-lane base schema stays with `.claude/skills/task-execution/references/assignment-packet.md`.
Common message classes, field format, and packet preflight stay with `.claude/skills/task-execution/references/message-classes.md`.
Lane-specific packet additions are owned by the target lane-core skill and lane-detail reference.
Lane role documents remain always-loaded identity, boundary, and stop-condition spines.
Hooks can warn or guard runtime integrity.
Hooks are not the primary owner of normal packet behavior.

### Agent Load Guard

Each dispatch must stay focused and single-purpose.
Each dispatch must stay within the sizing bounds in `references/agent-load-guard.md`.
If a dispatch exceeds those bounds, decompose before sending.
Single-agent critical path requires frozen serial basis.

### Dispatch execution contract

Apply `references/dispatch-execution-contract.md` before assignment-grade dispatch or reuse.
Keep request-fit packet -> deliverable shape -> phase intent -> staffing choice in that order.
Mixed-purpose prompts split by owner.
Split research, main-body draft, merge-compress, final acceptance, review, and validation verdict into their owning prompts.
Preserve downstream review/proof/validation ownership explicitly in developer or implementation packets.

### Parallel Shard And Merge Protocol

When one parent task is split across multiple agents, freeze the parent packet before full fan-out.
Freeze one explicit `MERGE-OWNER` before full fan-out.
Apply `references/parallel-shard-merge.md`.
Shards must be non-overlapping at the active work surface.
Merge is its own phase-intent.
Route one authoritative integrated output forward.
Acceptance lanes receive the authoritative integrated output.

### Task identity rule
Use `references/monitoring-lifecycle-detail.md` for task identity, agent communication, and peer challenge detail.
Hard rule: task ids, agent names, and agent-scoped communication are distinct.
Task identity comes from task evidence, not guessed agent identity.

### Consequential Upward Handoff Block

For consequential upward runtime-lane reports, `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion` must satisfy `.claude/skills/task-execution/references/completion-handoff.md` first.
`references/upward-handoff.md` adds the session-readable lane block and monotonic state rules.
Exact `MESSAGE-CLASS: hold|blocker` uses the blocker-native fields in `.claude/skills/task-execution/references/message-classes.md`.
Include enough context for team-lead to correct, replan, continue independent lanes, or report a true blocker.
Missing required fields block synthesis.
Preserve lane-owned state monotonically.
Strengthened state requires a fresh explicit owning-lane report or stronger evidence on the same lane surface.

### Health-check standard
Use `references/monitoring-lifecycle-detail.md` for health-check and cron detail.
`hook-config.sh` owns literal cadence/threshold values.
Monitoring text references configured values instead of copying them.

### Stale-response rule
Use `references/monitoring-lifecycle-detail.md` for stale-response detail.
Stale signals are observational only.
Repeated stale or error-loop behavior requires reroute, resize, replacement, or re-plan rather than silent hope.

### Runtime-pressure rule
Use `references/monitoring-lifecycle-detail.md` for runtime-pressure detail.
Session-closeout authority and message-first lifecycle decisions require current live-agent basis.

## Closeout Sequence

> On-demand: see `session-closeout` skill. Loaded when explicit session end is detected via hook trigger.
