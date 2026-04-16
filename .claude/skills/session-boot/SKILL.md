---
name: session-boot
description: "Session runtime operations including boot, monitoring, and worker lifecycle for team-lead."
user-invocable: false
PRIMARY-OWNER: team-lead
---

## Structural Contract
- Fixed section order: Activation, Boot Sequence, Session-Start Sequence, Sequence Activation Discipline, Mode Split, Monitoring Sequence
- PRIMARY-OWNER: team-lead
- Structural changes require governance review.

## Activation

Load this skill at session start when the boot sequence has not yet completed. The UserPromptSubmit hook provides a "BOOT SEQUENCE NOT YET COMPLETE" reminder as the loading trigger.

This skill also contains monitoring, dispatch, and lifecycle procedures for the active session runtime.

An explicit `session-boot` skill load is also the observed completion point for clearing lead-local boot reminders when no explicit team runtime has started yet. That observation is a boot-state marker only. It does not authorize delegated runtime entry by itself; `TeamCreate` and runtime-entry governance still own worker-runtime activation.

## Boot Sequence

The `Boot Sequence` is the bounded activation path for explicit team-runtime sessions.
Required only when the current request genuinely benefits from an explicit agent team — do not auto-start a team by habit.
The main session completes `Boot Sequence` before entering team-based MWEC, `work-planning`, or `task-execution` for explicit team-runtime work.
Team governance is still the default even when explicit runtime is not activated; this sequence decides whether the current task can remain lead-local or must escalate into full runtime.

### Required order

1. Reset startup-volatile control residue. Do not purge previous logs, current-project auto memory, or explicit closeout intent at boot. Legacy handoff files under `$HOME/.claude/handoffs/` are not expected; if found, absorb their content into continuity state and remove them as a one-time migration step.
2. Read inherited continuity state from the effective continuity surface.
   Current migration path: treat `./.claude/state/procedure-state.json` plus `./.claude/session-state.md` as the current-session authority. If the workspace-local continuity file is absent, fall back to `$HOME/.claude/session-state.md` as a legacy migration mirror only. Treat continuity as carry-forward input, not as proof that inherited runtime logs still describe the live session. Treat `$HOME/.claude` as a runtime control surface and continuity mirror during migration, not as the project procedure authority.
3. Re-check planning continuity only when the imminent runtime work depends on that plan.
   If `execution_plan.md` or an equivalent planning artifact exists, verify that it is still valid before fan-out.
4. If explicit team runtime is needed under the current runtime decision, create or confirm the session team runtime before delegated production work begins.
5. Confirm any runtime-required routing or plugin layer is available before worker fan-out.
   Treat routing-layer availability as conditional on the actual runtime.
6. Boot Sequence does not register periodic monitoring. Memory pressure is checked internally (threshold: 80%) before worker fan-out. No `CronCreate` or external health-check script is required during boot.
   During the active boot window, only the minimal boot-infrastructure tool surface is exempt from fresh-turn planning enforcement: continuity reads and runtime-shape discovery (`Read`, `Grep`, `Glob`, `ToolSearch`, `TaskList`, `TaskGet`, `TaskOutput`, `TeamCreate`, `TeamDelete`, `WebFetch`, `WebSearch`) plus read-only path probes (`Bash(pwd)`, `Bash(echo $HOME)`). Consequential production work, worker dispatch, task-state tools, and ordinary execution remain gated until boot finishes and the normal planning path resumes. Loading `session-boot` may clear the reminder state, but it must not close this boot-infrastructure window before those bounded tool calls run.

### Boot speed requirements

- **Path resolution**: The Read and Glob tools require literal absolute paths — shell variables like `$HOME` are not expanded. Before constructing Read or Glob paths, confirm the actual `$HOME` value from the shell environment context. Prefer the `SessionStart` hook output if it already provided `Home directory: ...`; otherwise use prior Bash results. Never assume a default like `/root/`. Only if `$HOME` is still unknown should you add `echo $HOME` to the parallel Bash calls and defer the path-based calls to the next turn.
- Prefer the `SessionStart` hook's `Team runtime snapshot: ...` lines as the first source of truth for whether team configs exist and whether any live panes are already attached. Do not re-check that state with Bash when the hook already provided it.
- Minimize boot round-trips. When the `SessionStart` hook already provided both `Home directory: ...` and `Team runtime snapshot: ...`, execute the following in ONE parallel tool-call turn:
  1. Read the effective continuity file (`./.claude/session-state.md` preferred; `$HOME/.claude/session-state.md` legacy fallback only when workspace continuity is unavailable)
  2. `ToolSearch` for `TeamCreate` schema (`select:TeamCreate`)
  3. Also read `./.claude/state/procedure-state.json` in the same parallel turn. If absent, treat all phase states as null.
- Only if the startup hook did not provide a usable team-runtime snapshot, add a third call: `Glob(<literal-home>/.claude/teams/*/config.json)`. Do not fall back to Bash `ls` for this check.
- In the next turn:
  - If explicit team runtime is not needed for the current request → stop after continuity and proceed without `TeamCreate`.
  - If explicit team runtime is needed and the snapshot says no team config exists → call `TeamCreate`.
  - If the snapshot says config files exist but no live worker panes are detected (stale team from a previous session) → call `TeamDelete` first, then `TeamCreate`. Do NOT use `rm -rf` on team directories — `TeamDelete` cleans both filesystem and internal state.
  - If the snapshot says a live team config is already attached → reuse the existing team (skip `TeamCreate`).
  - If you had to use `Glob` because the snapshot was unavailable, interpret `Glob` results the same way: no files → `TeamCreate`; files present but runtime liveness still unclear → inspect only as much as needed through read-only tools, not Bash cleanup probes.
  - If `TeamCreate` fails with "Already leading team" → call `TeamDelete` first then retry `TeamCreate`.
  - Then proceed to the user's original message through the Primary Operating Loop.
- Boot is infrastructure. Do not output verbose boot-status reports unless the user explicitly asks.

### Startup Constraints

- No production fan-out before the `Boot Sequence` is complete.
- Do not confuse `TeamCreate` with `TaskCreate`. `TeamCreate` is a deliberate runtime decision, not an automatic startup reflex.
- If the runtime does not use explicit team orchestration, skip only the steps that are truly runtime-specific and still complete continuity establishment.
- Do not start `Boot Sequence` only to inspect the repository. Do not reconstruct repo context or inspect commit history/branches unless continuity is missing, contradictory, or the user explicitly requests repository analysis.
- Previous setup logs and project auto memory are stale carryover by default, not authoritative planning inputs, unless the current task explicitly reopens them as evidence.
- When continuity must be rebuilt, use a verified branch-discovery step from the active repo root. Keep bounded to repo root and verified heads. Do not escalate into branch-to-branch diff, merge-base, or broad repository status checks. Apply the same root-local startup rule to the active repo, clone, or worktree. Do not guess continuity or repo paths from team names, prior sessions, or remembered directories.
- Do not assume `main`, `master`, or any other branch name exists. Do not inspect current branch or dirty state during startup unless continuity requires it. Treat a missing branch ref as repository topology information, not an operational error.
- Do not enumerate optional project-local `.claude/skills`, `.claude/hooks`, or `.claude/settings.json` as part of startup unless continuity or the active task explicitly depends on them.
- Do not emit startup repository summaries, branch reports, or wide tables unless explicitly asked. Default startup completion: a short readiness line or the exact blocking activation step — not a state bulletin or summary framing like 'continuity established'.
- If the user explicitly ends the session while the explicit runtime is only partially booted, do not complete `Boot Sequence` just to tear it down. Enter `Closeout Sequence` directly and dismantle the partial runtime.


## Session-Start Sequence

The `Session-Start Sequence` applies at fresh start, resume, and pause-return.

Relationship to Boot Sequence: Session-Start Sequence always runs at fresh start, resume, and pause-return. Boot Sequence runs additionally when explicit team runtime is required. The continuity read in Session-Start Step 1 and Boot Step 2 are the same operation — if both run in the same session entry, perform the read once and share the result. Operationally: Session-Start Sequence always runs; Boot Sequence is the optional team-runtime branch. When both run, treat them as: (1) shared startup body = Session-Start Steps 1-7, (2) optional team-runtime branch = Boot Sequence Steps 1-6 (skipping the continuity read already performed). Do not run the continuity read twice.

### Required checks

1. Establish active context and inherited state.
   Default startup scope is minimal: read continuity state first, establish the active project root, decide whether explicit team runtime is needed, then stop unless continuity is missing, contradictory, or the user explicitly asks for deeper repository analysis.
   If the effective continuity file exists and is readable, treat that read as sufficient startup context. Do not reconstruct repo context at startup in the normal case.
   If the current request justifies an explicit team, that minimal startup anchor should flow into `Boot Sequence` runtime activation. Otherwise stop at the minimal startup anchor and proceed with the request directly.
2. Identify incomplete work, active blockers, current ownership, and pending acceptance gates.
3. Verify plan validity.
   If the current plan is inconsistent, stale, missing, or no longer matches the active request, re-run planning before implementation fan-out.
4. Reconfirm current-runtime workers and remembered workers separately.
   For workers that are actually live in the current runtime, decide reuse, standby, or shutdown.
   For remembered previous-session workers carried only through continuity, decide whether the continuity note still matters, but do not send runtime lifecycle messages unless that worker is confirmed live again in the current runtime.
5. Reconfirm current management mode and runtime mode.
   Decide internally whether explicit team runtime is actually required for the next work phase.
   If unfinished governance optimization or compression is the active topic at fresh start, resume, or pause-return, do not treat inherited continuity, remembered review, or partial draft intent as edit-readiness. For high-traffic shared surfaces such as `CLAUDE.md`, `agents/team-lead.md`, runtime hooks, or `settings.json`, the resumed packet must keep `SESSION-REVALIDATION: current-session-repo`, `BASELINE-ANCHOR: captured`, `SOURCE-MEANING-INVENTORY: explicit`, `DESTINATION-OWNER-MAP: explicit`, and `CHANGE-BOUNDARY: <bounded intended delta>` before editing resumes.
6. Make the initial owner map explicit enough to avoid drift.
7. When explicit runtime activation becomes necessary later, rely on the runtime-entry gate to audit runtime hygiene before `TeamCreate` or new worker fan-out. Do not run memory-pressure or orphan-runtime scans during `Session-Start Sequence` by default.


### Session-state discipline

- Team-lead updates the workspace-local procedure state (`./.claude/state/procedure-state.json`) as the current-session procedure authority and keeps workspace continuity mirrored into `./.claude/session-state.md`. During the active migration path, `$HOME/.claude/session-state.md` may still be written as a legacy mirror, but workspace-local state remains authoritative.
- Do not wait until termination to restore session continuity state.

## Sequence Activation Discipline

- When a session sequence is materially active, the lead should name that sequence explicitly in control updates rather than leaving the sequence state implicit.
- Keep the current phase, checkpoint, or blocking step visible enough that the next update can be interpreted against the same active sequence.
- Do not silently switch between `Boot Sequence`, `Session-Start Sequence`, `Monitoring Sequence`, and `Closeout Sequence` while the active runtime still depends on one of them.
- Do not compress a defined session procedure into a shorter convenience path. If a stage is optional, that optionality must come from the owning rule rather than from remembered habit.
- When you build a plan, owner map, or sequencing decision, derive it from the loaded doctrine and owner-local procedure files rather than from remembered habit or convenience. If the governing procedure cannot be pointed to cleanly, keep the lane on `HOLD` until the procedure basis is explicit.

## Mode Split

Team routing decisions follow `agents/team-lead.md §RPA-2 Direct vs Team Decision Checklist`. The conditions below determine whether explicit team runtime infrastructure (TeamCreate) is warranted to support that routing decision.

Activate explicit team runtime when ANY of the following applies:
(a) Team routing is required per `agents/team-lead.md §RPA-2` AND 2 or more independent work surfaces exist that can proceed simultaneously
(b) role separation between implementation, review, testing, or validation is materially needed
(c) preserved worker context across multiple tasks will materially reduce redispatch cost
Otherwise, lead-local execution is appropriate only when the direct-work conditions from `agents/team-lead.md §RPA-2` are clearly satisfied. Do not treat runtime cost or startup friction by itself as a sufficient reason to stay lead-local.

There are two operating cases:

1. Lead-managed session without explicit team runtime
- Use direct lead execution and monitoring only.
- Skip `TeamCreate` and session cron registration when the current request remains lead-local.
- Keep team governance as the decision baseline, but do not dispatch worker agents while shared runtime mechanics stay off.
- The first delegated `Agent` dispatch is the escalation boundary: activate explicit team runtime before worker creation, `SendMessage`, or shared task/runtime control.

2. Explicit team-runtime session
- Use the full `Boot Sequence`.
- Team lifecycle, `SendMessage`, monitoring rules, and closeout cleanup all apply.
- Recurring health-check registration is conditional on the active runtime policy or tracked runtime configuration; it is not the universal default startup step.

Explicit team runtime is a costed acceleration surface, not an exceptional philosophy. Routing fit decides whether the work stays lead-local or becomes team-routed; cost decides the smallest reliable staffing shape only after that routing decision is clear. When the current runtime is ambiguous, the lead must resolve that ambiguity before production fan-out.

## Monitoring Sequence

The `Monitoring Sequence` is continuous during active delegated operation.

### Monitoring responsibilities

- Track lane health, no-progress risk, ownership drift, stalled workers, and merge collisions.
- Use direct lead oversight and event-driven monitoring as the primary path during explicit team runtime.
- Add periodic health monitoring only when the active runtime policy or tracked runtime configuration actually enables a health-check cron.
- In single-primary automation mode, also track runtime pressure: available memory, swap headroom, orphan session workers, and stale tmux socket residue.
- Treat unattended no-progress lanes as management defects.
- Watch for false efficiency signals: saving a worker while creating serial waiting, merge backlog, or repeated redispatch is a management defect, not a cost win.
- Keep diagnostic and evidence-gathering work routed to the delegated evidence lane rather than letting the main lead absorb reproduction or root-cause work by convenience.
- Use bidirectional coordination actively during monitoring: acknowledge worker reports, request clarification or partial results when needed, answer bounded worker questions, and keep control changes explicit rather than assuming silent understanding.

### Worker lifecycle states

See `reference.md` `§Worker Lifecycle States` for state definitions.

### Runtime signals (not governance states)

See `reference.md` `§Runtime Signals (Not Governance States)` for signal definitions and defect classifications.

### Worker identity rule

- If multiple workers of the same capability may exist concurrently, assign unique worker names at dispatch time.
- Standby, shutdown, stale tracking, and reuse decisions must refer to those concrete worker names rather than to the generic capability label alone.

### Supervisor decisions on idle_notification

See `reference.md` `§Supervisor Decisions on idle_notification` for the decision matrix.

### Message-first lifecycle rule

See `reference.md` `§Message-First Lifecycle Rule` for the complete lifecycle protocol.

### Cost rule

See `reference.md` `§Cost Rule` for reuse vs. redispatch heuristics.

### Health-check standard

See `reference.md` `§Health-Check Standard` for cron cadence, thresholds, and classification criteria.

### Stale-response rule

See `reference.md` `§Stale-Response Rule` for stale-handling guidance.

### Runtime-pressure rule

See `reference.md` `§Runtime-Pressure Rule` for orphan cleanup and pressure-handling specifications.
