---
name: team-session-sequences
description: Session-sequence index and lead-side dispatch/detail lookup for the Claude team runtime. Use for team-lead sequence naming, dispatch compliance, monitoring detail lookup, shard merge, and upward handoff detail; not as the boot or closeout runtime spine.
user-invocable: false
PRIMARY-OWNER: team-lead
---

## Structural Contract
- Inherits `CLAUDE.md`, the active owner role, and the common inheritance floor in `CLAUDE.md` `Priority And Ownership`. This skill may sharpen its owned procedure or specialist surface, but it must not weaken that floor or the owning role's stop conditions.

- Fixed owner pattern for future skill growth:
  1. `Sequence Activation Discipline`
  2. named sequence sections
  3. `Required order` / `Required checks` / `Required actions` blocks
  4. sequence-specific constraints, gates, and state rules
- Do not add new top-level lifecycle names without explicit governance review.
- Keep exact sequence names stable when they are already referenced by doctrine, agents, settings, or hooks.
- Expand the owning sequence section rather than appending detached sidecar procedure blocks.
- Structural connectivity is immutable: new session-runtime rules must remain attached to an owning sequence or gate block rather than appearing as free-floating doctrine.
- Keep long packet tables, sizing rules, shard/merge detail, and handoff field catalogs in direct files under `references/`; keep the mandatory trigger, owner, and stop rule in this spine.
- PRIMARY-OWNER: team-lead

# Team Session Sequences

This skill indexes session-level sequence names and owns lead-side session dispatch detail when a sequence is materially active. It does not own the runtime spine, closeout spine, canonical packet schema, common message law, or lifecycle truth.

Use the exact lifecycle names defined in `.claude/CLAUDE.md`:
- `Boot Sequence` (on-demand: session-boot skill)
- `Session-Start Sequence` (on-demand: session-boot skill)
- `Monitoring Sequence`
- `Closeout Sequence` (on-demand: session-closeout skill)

These procedures are mandatory when the corresponding sequence is materially in play.

## Sequence Activation Discipline

- When a session sequence is materially active, the lead should name that sequence explicitly in control updates rather than leaving the sequence state implicit.
- Keep the current phase, checkpoint, or blocking step visible enough that the next update can be interpreted against the same active sequence.
- Do not silently switch between `Boot Sequence`, `Session-Start Sequence`, `Monitoring Sequence`, and `Closeout Sequence` while the active runtime still depends on one of them.
- Do not compress a defined session procedure into a shorter convenience path. If a stage is optional, that optionality must come from the owning rule rather than from remembered habit.
- When you build a plan, owner map, or sequencing decision, derive it from the loaded doctrine and owner-local procedure files rather than from remembered habit or convenience. If the governing procedure cannot be pointed to cleanly, keep the lane on `HOLD` until the procedure basis is explicit.

### Reference Map

Load these files directly from `SKILL.md` when their trigger is active. Do not route through an intermediate `reference.md`.
- `references/pre-dispatch-verification.md`: consequential dispatch self-verification gate and risk-tier abbreviation rules.
- `references/task-decomposition.md`: split basis, child packet boundary, done condition, and return-form discipline.
- `references/dispatch-packet-compliance.md`: session-side controlled-value fields and lane-specific presence-required fields.
- `references/agent-load-guard.md`: focused dispatch sizing bounds and overload exception.
- `references/dispatch-execution-contract.md`: background/foreground runtime execution, request-fit ordering, phase intent, and forbidden mixed-purpose prompts.
- `references/parallel-shard-merge.md`: parent packet freeze, shard fan-out, merge owner, and integrated output routing.
- `references/upward-handoff.md`: consequential upward handoff block fields and monotonic lane-owned state rules.
- `references/monitoring-lifecycle-detail.md`: runtime signals, lifecycle decisions, manifest gate, health-check, stale response, runtime pressure, and task identity detail.

## Mode Split

Canonical runtime decision rules live in `.claude/skills/session-boot/SKILL.md` `Mode Split`; closeout state rules live in `.claude/skills/session-closeout/SKILL.md`. This section is the session-sequence index and dispatch-detail surface and must not diverge from those owners.

There are two operating cases:

1. Lead-managed session without explicit team runtime
- Use lead-local work or lawful standalone `Agent` dispatch only when the frozen route allows it; do not treat this case as configured lane team-runtime delegation.
- Skip `TeamCreate` and session cron registration when they are not part of the active runtime.

2. Explicit team-runtime session
- Use the full `Boot Sequence`.
- Team lifecycle, `SendMessage`, monitoring rules, and closeout cleanup all apply.
- Recurring health-check registration is conditional on the active runtime policy or tracked runtime configuration; it is not the universal default startup step.

Explicit team runtime is required only when the active runtime policy, existing live runtime, or frozen route needs shared team coordination. The lead-managed no-runtime or standalone-agent case remains lawful when no team mailbox, shared task state, lifecycle monitoring, or sustained teammate coordination is required.

When the current runtime is ambiguous, the lead must resolve that ambiguity before production fan-out.


## Boot Sequence

> On-demand: see `session-boot` skill. Loaded at session start via hook trigger.

## Session-Start Sequence

> On-demand: see `session-boot` skill. Loaded at session start via hook trigger.

## Monitoring Sequence

The `Monitoring Sequence` general procedure is owned by `.claude/skills/session-boot/SKILL.md`. Canonical lifecycle vocabulary is owned by `.claude/skills/session-boot/references/runtime-state-detail.md`. Use `references/monitoring-lifecycle-detail.md` for lead-side runtime-signal, lifecycle, manifest, health-check, stale-response, runtime-pressure, and task-identity detail.

Hard surface:
- Runtime signals are observation evidence, not governance state or completion proof.
- Agent lifecycle is message-first; completion requests a governing decision and does not authorize auto-standby, replacement, or removal.
- Reuse is preferred only when workload, availability, context fit, owner safety, and frozen parallel shape support it.
- Manifest-dependent execution needs pre-dispatch manifest review and explicit write scope before fan-out.

### Pre-Dispatch Self-Verification Gate

This is enforcement of the canonical `self-verification` `SV-PLAN` at the dispatch boundary; it is not a substitute for `self-verification`. Before consequential dispatch, run the gate in `references/pre-dispatch-verification.md`. Low-risk dispatch may use the reduced gate named there; medium/high-risk dispatch must use the full gate and high-risk dispatch records the basis in the packet. Do not abbreviate except for an owning runtime-policy emergency with the abbreviated basis recorded.

### Task Decomposition Protocol

When work spans more than 5 files, needs both investigation and judgment, crosses multiple categories, or otherwise risks overload, decompose before dispatch using `references/task-decomposition.md`. Every child dispatch must carry split basis, child boundary, excluded boundary, done condition, and return form clearly enough that merge, reroute, or hold decisions do not depend on memory.

### Dispatch Packet Compliance

Before sending a dispatch, verify structured fields against the target lane role, lane-core skill, `task-execution` packet contract, and `references/dispatch-packet-compliance.md`. That reference is the canonical session-side controlled-value and presence-field owner. Cross-lane base schema, common message classes, field format, and packet preflight remain owned by `.claude/skills/task-execution/references/assignment-packet.md` and `.claude/skills/task-execution/references/message-classes.md`; lane-specific packet additions are owned by the target lane-core skill and lane-detail reference. Lane role documents remain always-loaded identity, boundary, and stop-condition spines. Hooks may warn or guard runtime integrity, but they are not the primary owner of normal packet behavior.

### Agent Load Guard

Each dispatch must stay focused, single-purpose, and within the sizing bounds in `references/agent-load-guard.md`. If a dispatch exceeds those bounds, decompose before sending; do not convert agent overload into a single-agent critical path by convenience.

### Dispatch execution contract

Apply `references/dispatch-execution-contract.md` before assignment-grade dispatch or reuse. Keep request-fit packet -> deliverable shape -> phase intent -> staffing choice in that order. Mixed-purpose prompts are invalid; especially do not combine research plus main-body draft, broad research plus merge-compress, draft plus final acceptance review, or review plus validation verdict in one agent prompt. Preserve downstream review/proof/validation ownership explicitly in developer or implementation packets.

### Parallel Shard And Merge Protocol

When one parent task is split across multiple agents, freeze the parent packet and one explicit `MERGE-OWNER` before full fan-out; apply `references/parallel-shard-merge.md`. Shards must be non-overlapping at the active work surface, and merge is its own phase-intent. Route one authoritative integrated output forward; do not make acceptance lanes perform an implicit merge.

### Task identity rule
Use `references/monitoring-lifecycle-detail.md` for task identity, agent communication, and peer challenge detail. Hard rule: task ids, agent names, and agent-scoped communication are distinct; do not reconstruct task identity from agent identity by guesswork.

### Consequential Upward Handoff Block

For consequential upward runtime-lane reports with `MESSAGE-CLASS: handoff`, `MESSAGE-CLASS: completion`, or exact `MESSAGE-CLASS: hold|blocker`, require one authoritative handoff block using `references/upward-handoff.md`. Missing required handoff fields make the report synthesis-invalid: consume it as blocker/open-surface evidence or request a corrected report, not as completion. Preserve lane-owned state monotonically; do not strengthen it without a fresh explicit owning-lane report or stronger evidence on the same lane surface.

### Health-check standard
Use `references/monitoring-lifecycle-detail.md` for health-check and cron detail. Hard rule: `hook-config.sh` owns literal cadence/threshold values; monitoring text references configured values instead of copying them.

### Stale-response rule
Use `references/monitoring-lifecycle-detail.md` for stale-response detail. Hard rule: stale signals are observational only; repeated stale or error-loop behavior requires reroute, resize, replacement, or re-plan rather than silent hope.

### Runtime-pressure rule
Use `references/monitoring-lifecycle-detail.md` for runtime-pressure detail. Hard rule: orphan or non-current runtime residue does not create session-closeout authority or bypass message-first lifecycle decisions for current live agents.

## Closeout Sequence

> On-demand: see `session-closeout` skill. Loaded when explicit session end is detected via hook trigger.
