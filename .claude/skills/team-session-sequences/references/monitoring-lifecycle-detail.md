---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/team-session-sequences/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
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
When an idle_notification is received with valid completion transport, team-lead records the lane as `STANDBY`.
If immediate work is available and preserved context is valuable, send `assignment`, `reuse`, or `reroute` as new bounded work.
If no immediate work is available, send nothing.
If the teammate must be terminated, send `SendMessage(to: "<agent-name>", message: {type: "shutdown_request"})` and wait for termination evidence.
If validation or correction routing is pending, keep the teammate in `STANDBY`; validation wait is a route condition, not a separate lane work state.

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
- Shared task-state creation, identity, mutation, and closure rules are owned by `.claude/skills/task-execution/references/message-classes.md` `### Shared Task State Contract`.
- Monitoring and task-control use exact task ids from that contract's approved identity sources.
- `task_assignment` is task-identity evidence only; the authoritative assignment packet remains the lead `SendMessage` body or retained task-execution carrier.
- Agent names and `agentId@team` values are agent identifiers only.
- Agent-scoped communication uses `SendMessage(to: "<exact-live-member-name>")` for agent control.
- Keep agent identifiers separate from task identifiers.
- A configured role label becomes a message address only when the roster contains that exact live member name.
- Treat direct user-to-teammate messages as user instructions to the receiving teammate inside that teammate's current authority and active surface.
- Treat agent-to-agent communication as challenger traffic for evidence notes, critique, clarification, or partial-result context.
- Route ownership, acceptance, routing, cleanup, task-control, and active-surface changes from direct user-to-teammate or agent-to-agent traffic through `team-lead`.
- Use free-form `SendMessage` for peer status, clarification, or partial-result notes only inside unchanged ownership, cleanup, routing, and active surface.
- Free-form teammate interaction does not create agent-to-lead `MESSAGE-CLASS` authority and does not reopen a closed assignment execution block.
- After a lane sends `completion`, duplicate packet replay and already-completed confirmation are handled by `.claude/skills/task-execution/references/message-classes.md` `Receipt Event Contract`, not by free-form status or clarification.
- Authoritative downward phase packets, upward transport `MESSAGE-CLASS` vocabulary, and structured shutdown requests are owned by `.claude/skills/task-execution/references/phase-transition-control.md` and `.claude/skills/task-execution/references/message-classes.md`.
- If task output must be read later, carry the assigned task id forward explicitly instead of reconstructing it from the agent name by guesswork.

## Health-Check Standard
- Consume `.claude/skills/session-boot/references/runtime-state-detail.md` for canonical health-check activation semantics.
- The configured cron cadence and stale thresholds are defined in `hook-policy.sh`; treat that file as the single literal owner.
- Direct oversight, event-triggered agent monitoring, and memory-pressure checks remain the primary lead-owned monitoring path even when no tracked health-check cron is active.
- In single-primary automation mode, keep the watchdog armed during standby periods. Do not pause the health-check cron merely because all agents are standby.
- Replacing the tracked health-check cron is not session closeout. For monitor rotation, record explicit rotation intent in structured runtime state first, then perform `CronDelete` and replacement `CronCreate`.
- If no tracked health-check cron is active, do not create, rotate, or narrate one by ceremony.

## Stale Response
- High-confidence stale: investigate quickly. Replacement requires shutdown evidence or an explicit recovery freeze.
- Low-confidence stale during long-running bash: observe, extend if justified, then escalate if the lane remains unproductive.
- Repeated stale or error-loop behavior requires reroute, resize, replacement, or re-plan.
- Treat stale signals and idle_notification as observational only. Do not assert a specific tool-phase hang or team-infrastructure defect unless ledger evidence, dispatch behavior, runtime-pressure evidence, or explicit tool errors support it.
- Repo-local generated-output cleanup uses bounded destructive commands only inside the active repo's frozen output root per `.claude/reference/environment-output-root-filesystem-law.md` (default `claude_doc/<work-name>/`).

## Runtime Pressure
- Consume `.claude/skills/session-boot/references/runtime-state-detail.md` for canonical runtime-pressure classification.
- When hard runtime pressure or unresolved orphan residue exists, stop new `Agent` fan-out until explicit recovery clears that pressure.
- Routine orphan scans report residue; they do not kill processes or rewrite team cleanup truth.
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
