---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/team-session-sequences/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# team-session-sequences: Monitoring And Runtime Cleanup Detail

This reference is a lead-side monitoring lookup; it consumes `.claude/skills/session-boot/references/runtime-state-detail.md` for runtime-state meaning and adds only monitoring action selection.

## Contents
- Runtime Signals
- Agent Identity Rule
- Supervisor Decisions On idle_notification
- Message-First Runtime Cleanup Rule
- Reuse Rule
- Manifest Review Gate
- Task Identity And Communication
- Health-Check Standard
- Stale Response
- Runtime Pressure
- Resolve Next Owner And Action

## Runtime Signals
- `idle_notification`: automatic runtime message indicating an agent's turn has ended. This is a technical signal, not a state transition.
- `ACTIVE`/`STANDBY` tracking-signal semantics are owned by `.claude/skills/session-boot/references/runtime-state-detail.md` `## Agent Work States`.
- Receiving `idle_notification` without a preceding completion transport from the agent is a completion failure (T2).
- Receiving completion transport marks `STANDBY` directly.

## Agent Identity Rule
- If multiple agents of the same capability can exist concurrently, assign unique agent names at dispatch time.
- Standby, shutdown, stale tracking, and reuse decisions must refer to those concrete agent names rather than to the generic capability label alone.

## Supervisor Decisions On idle_notification
Consume `.claude/skills/session-boot/references/runtime-state-detail.md` `## Supervisor Decisions On Turn-Ended Signals` for canonical `STANDBY`, new-work, no-message, shutdown, and validation-wait decisions.
Monitoring extension: when immediate work is available and preserved context is valuable, prefer `reuse` only after the canonical `## Reuse Rule` owner/context fit stays truthful; otherwise route fresh bounded work through `assignment` or `reroute`.

## Message-First Runtime Cleanup Rule
- Consume `.claude/skills/session-boot/references/runtime-state-detail.md` for canonical `ACTIVE` / `STANDBY`, completion, reuse, shutdown, and teammate-population semantics.
- Completion transport shape is owned by `.claude/skills/task-execution/references/completion-handoff.md`.
- Immediate reuse sends distinct bounded work promptly; otherwise the lane remains `STANDBY` until reuse or cleanup.
- Runtime task lists, mailbox state, and team config are runtime surfaces. Do not hand-author or repair them through project documents or shell edits.
- An agent-targeted `shutdown_request` is teammate cleanup, not evidence that the whole session is entering `Closeout Sequence`.
- Replacing a stale current-runtime agent outside closeout follows three steps:
  1. send `shutdown_request`
  2. wait for shutdown evidence or classify recovery explicitly
  3. dispatch the replacement
- Skipping directly to replacement is forbidden unless the agent is confirmed terminated or the replacement route has been frozen as recovery.
- Previous-session remembered agents are continuity artifacts, not runtime shutdown targets in a later session.

## Reuse Rule
Reuse / standby semantics canonical owner: `.claude/skills/session-boot/references/runtime-state-detail.md` `## Reuse Rule`. Lead-side monitoring-action extensions below.
- Choose `reuse` when immediate work exists and the valid live agent remains the correct owner/context.
- Treat `standby` as already set by valid `completion`; choose no message when no immediate reuse, correction, or shutdown is needed.

## Manifest Review Gate
- When execution depends on a user-provided file list, copy set, or overwrite manifest, complete review before fan-out: collapse duplicates, verify final unique write set, and make pre-execution review explicit.
- Current standard packet fields use exact English keys:
  - `TASK-CLASS: manifest-sync`
  - `MANIFEST-UNIQUE: <count>`
  - `OVERLAP-REVIEW: done`
  - `PRE-EXEC-REVIEW: done`
  - `WRITE-SCOPE: <unique target set>`
  - if sharded: `SHARD-ID: <id>` and `SHARD-SET: disjoint`
- Deterministic manifest sync or overwrite propagation is single-writer by default.
- Shard only when each shard's write scope is explicit and disjoint before the first developer dispatch.

## Task Identity And Communication
- Shared task-state creation, identity, mutation, and closure rules are owned by `.claude/skills/task-execution/references/message-classes.md` `### Assignment Delivery Contract`.
- Monitoring and task-control use exact task ids from that contract's approved identity sources.
- `task_assignment` is task-identity evidence only; the authoritative assignment packet remains the lead `SendMessage` body or retained task-execution carrier.
- Agent names and `agentId@team` values are agent identifiers only.
- Agent-scoped communication uses `SendMessage(to: "<exact-live-member-name>")` for agent control.
- Keep agent identifiers separate from task identifiers.
- A configured role label becomes a message address only when the roster contains that exact live member name.
- Treat direct user-to-teammate messages as user instructions to the receiving teammate inside that teammate's current authority and active surface.
- Treat agent-to-agent communication as challenger traffic for evidence notes, critique, clarification, or partial-result context.
- Route ownership, acceptance, routing, cleanup, task-control, and active-surface changes from direct user-to-teammate or agent-to-agent traffic through `team-lead`.
- Use carrier-pointer `SendMessage` for peer status, clarification, or partial-result notes only inside unchanged ownership, cleanup, routing, and active surface; inline peer-note detail stays in the retained carrier and the rendered body carries only the canonical envelope plus pointer.
- Free-form teammate interaction does not create agent-to-lead `MESSAGE-CLASS` authority and does not reopen a closed assignment execution block.
- After a lane sends `completion`, duplicate packet replay and already-completed confirmation are handled by `.claude/skills/task-execution/references/message-classes.md` `Receipt Event Contract`, not by free-form status or clarification.
- Authoritative downward phase packets, upward transport `MESSAGE-CLASS` vocabulary, and structured shutdown requests are owned by `.claude/skills/task-execution/references/phase-transition-control.md` and `.claude/skills/task-execution/references/message-classes.md`.
- If task output must be read later, carry the assigned task id forward explicitly instead of reconstructing it from the agent name by guesswork.

## Health-Check Standard
- Consume `.claude/skills/session-boot/references/runtime-state-detail.md` `## Health-Check Standard` for canonical health-check activation semantics, cadence/threshold owner, and direct-oversight primacy. This reference adds only the monitoring-action selection rules below for the lead-side monitoring lookup; canonical rule definitions live at the cited owner.
- In single-primary automation mode, keep the watchdog armed during standby periods. Do not pause the health-check cron merely because all agents are standby.
- Replacing the tracked health-check cron is not session closeout. For monitor rotation, record explicit rotation intent in structured runtime state first, then perform `CronDelete` and replacement `CronCreate`.
- If no tracked health-check cron is active, do not create, rotate, or narrate one by ceremony.

## Stale Response
- Consume `.claude/skills/session-boot/references/runtime-state-detail.md` `## Stale-Response Rule` for canonical stale classification, low-confidence-stale handling, and replacement criteria. This reference adds only the monitoring-action extensions below; canonical rule definitions live at the cited owner.
- Treat stale signals and idle_notification as observational only. Do not assert a specific tool-phase hang or team-infrastructure defect unless ledger evidence, dispatch behavior, runtime-pressure evidence, or explicit tool errors support it.
- Repo-local generated-output cleanup uses bounded destructive commands only inside the active repo's frozen output root per `.claude/reference/environment-output-root-filesystem-law.md` (default `claude_doc/<work-name>/`).

## Runtime Pressure
- Consume `.claude/skills/session-boot/references/runtime-state-detail.md` `## Runtime-Pressure Rule` for canonical runtime-pressure classification, hard-pressure fan-out block, and routine-orphan-scan rule. This reference adds only the monitoring-action extensions below; canonical rule definitions live at the cited owner.
- Runtime-pressure handling must not invent session closeout authority or bypass message-first cleanup decisions for current live agents.
- If orphan historical agents are detected from a previous session, do not send `shutdown_request` to those remembered agent names from the new session. Route explicit orphan-runtime recovery instead.

## Resolve Next Owner And Action
- Healthy active lane returns to monitoring.
- Reuse-fit live lane opens bounded reuse.
- Standby decision sends no message unless bounded reuse or cleanup is selected.
- Shutdown decision opens structured `shutdown_request`.
- Stale response opens investigate, wait-extension, reroute, resize, replacement, or replan.
- Manifest overlap opens pre-execution manifest correction.
- Runtime pressure opens explicit recovery before new fan-out.
- Orphan historical residue opens orphan-runtime recovery.
