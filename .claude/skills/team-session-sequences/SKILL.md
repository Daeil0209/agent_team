---
name: team-session-sequences
description: Session-sequence index and lead-side dispatch/detail lookup for the Claude team runtime. Boot and closeout runtime spines belong to session-boot and session-closeout.
user-invocable: false
PRIMARY-OWNER: team-lead
---

## Structural Contract
- Fixed owner pattern:
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
- Fixed close section: `Next-Action Drive`

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

Canonical Sequence Activation Discipline is owned by `.claude/skills/session-boot/SKILL.md`.

### Reference Map

Load trigger-specific files directly from `SKILL.md`.
- `references/pre-dispatch-verification.md`: consequential dispatch readiness index and risk-tier record map.
- `references/task-decomposition.md`: split basis, child packet boundary, done condition, and return-form discipline.
- `references/dispatch-packet-compliance.md`: session-side controlled-value fields and lane-specific presence hints.
- `references/agent-load-guard.md`: focused dispatch sizing bounds and overload exception.
- `references/dispatch-execution-contract.md`: background/foreground runtime execution, request-fit ordering, phase intent, and mixed-purpose prompt boundaries.
- `references/parallel-shard-merge.md`: parent packet freeze, shard fan-out, merge owner, and integrated output routing.
- `references/upward-handoff.md`: consequential upward handoff block fields and monotonic lane-owned state rules.
- `references/monitoring-lifecycle-detail.md`: runtime signals, lifecycle decisions, manifest gate, health-check, stale response, runtime pressure, and task identity detail.

## Mode Split

Canonical runtime decision rules live in `.claude/skills/session-boot/SKILL.md` `Mode Split`.
Closeout state rules live in `.claude/skills/session-closeout/SKILL.md`.
When the current runtime is ambiguous, the lead resolves that ambiguity per session-boot `Mode Split` before production fan-out.


## Boot Sequence

> On-demand: see `session-boot` skill. Load when the `session-boot` owner trigger opens; hooks provide observation evidence only.

## Session-Start Sequence

> On-demand: see `session-boot` skill. Load when the `session-boot` owner trigger opens; hooks provide observation evidence only.

## Monitoring Sequence

The `Monitoring Sequence` general procedure is owned by `.claude/skills/session-boot/SKILL.md`.
Canonical lifecycle vocabulary is owned by `.claude/skills/session-boot/references/runtime-state-detail.md`.
Lead-side runtime-signal, lifecycle, manifest, health-check, stale-response, runtime-pressure, and task-identity detail are owned by `references/monitoring-lifecycle-detail.md`.

### Lead-Side Dispatch Index

This file is an index, not a second enforcement gate. Each entry below names a dispatch concern and points at its canonical owner.

- Pre-dispatch readiness — `.claude/skills/work-planning/references/execution-readiness.md` (planning-level readiness) and `.claude/skills/task-execution/references/assignment-packet.md` (packet preflight); `references/pre-dispatch-verification.md` is a non-authoritative index of goal alignment, alternative routing, agent-charter fit, scope boundary, prior-analysis handoff, prerequisite completeness, and failure-path coverage.
- Task decomposition — `references/task-decomposition.md` for split basis, child boundary, excluded boundary, done condition, and return form.
- Dispatch packet compliance — `.claude/skills/task-execution/references/{assignment-packet.md, message-classes.md}` (cross-lane schema and packet preflight); lane-specific additions are owned by the target lane-core skill and lane-detail reference; `references/dispatch-packet-compliance.md` provides session-side controlled-value lookup.
- Agent load guard — `references/agent-load-guard.md` for sizing bounds and serial-basis requirement.
- Dispatch execution contract — `references/dispatch-execution-contract.md` for request-fit-packet → deliverable-shape → phase-intent → staffing-choice ordering and mixed-purpose split discipline.
- Parallel shard and merge — `references/parallel-shard-merge.md` for parent-packet freeze, MERGE-OWNER, shard non-overlap, and integrated-output routing.
- Task identity — `references/monitoring-lifecycle-detail.md`; task ids, agent names, and agent-scoped communication are distinct, and task identity comes from task evidence, not guessed agent identity.
- Consequential upward handoff — `.claude/skills/task-execution/references/completion-handoff.md` (handoff/completion contract) and `.claude/skills/task-execution/references/message-classes.md` (blocker-native fields); `references/upward-handoff.md` adds session-readable lane block and monotonic-state rules.
- Health-check, stale-response, and runtime-pressure — `references/monitoring-lifecycle-detail.md`; `hook-config.sh` owns literal cadence/threshold values.

## Closeout Sequence

> On-demand: see `session-closeout` skill. Load when the `session-closeout` owner trigger opens; hooks provide observation evidence only.

## Next-Action Drive
- A boot trigger opens `session-boot`.
- A session-start trigger opens `session-boot`.
- A monitoring trigger opens `session-boot` Monitoring Sequence or its direct monitoring reference.
- A dispatch concern opens the canonical dispatch owner named in Lead-Side Dispatch Index.
- Ambiguous runtime mode opens `session-boot` Mode Split.
- A closeout trigger opens `session-closeout`.
- Missing canonical owner mapping opens `work-planning` or `HOLD`.
