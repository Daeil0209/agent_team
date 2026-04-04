---
name: session-boot
description: Boot and session-start procedures for team-lead session initialization.
user-invocable: false
---

## Activation

Load this skill at session start when the boot sequence has not yet completed. The UserPromptSubmit hook provides a "BOOT SEQUENCE NOT YET COMPLETE" reminder as the loading trigger. After boot and session-start complete, this skill is no longer needed for subsequent operations.

Core monitoring, dispatch, and lifecycle procedures remain in the always-loaded `team-session-sequences` skill.

## Boot Sequence

The `Boot Sequence` is the bounded activation path for explicit team-runtime sessions.
In this global agent-team environment, it is the mandatory startup path.
Run it automatically after the minimal continuity anchor. Skip only when the operator explicitly and directly requests no-runtime startup or immediate closeout in the current message.

### Required order

1. Reset only startup-volatile control residue before continuity interpretation.
   Clear only startup-local stop residue that should never survive a fresh session, but do not purge previous logs, current-project auto memory, or explicit closeout intent at boot.
2. Read inherited continuity state from the active project root first, including `<repo>/.claude/session-state.md` when present.
   Treat repo-local continuity documents as continuity input, not as proof that inherited runtime logs still describe the live session. Treat `$HOME/.claude` as a runtime control surface, not as the project continuity owner or repository-evidence surface.
3. Re-check planning continuity only when the imminent runtime work depends on that plan.
   If `execution_plan.md` or an equivalent planning artifact exists, verify that it is still valid before fan-out.
4. Create or confirm the session team runtime before production work begins.
5. Confirm any runtime-required routing or plugin layer is available before worker fan-out.
   Treat routing-layer availability as conditional on the actual runtime.
6. Boot Sequence does not register periodic monitoring. Memory pressure is checked internally (threshold: 80%) before worker fan-out. No `CronCreate` or external health-check script is required during boot.

### Boot speed requirements

- Minimize boot round-trips. Execute the following in ONE parallel tool-call turn:
  1. Read the repo-local continuity file (`<repo>/.claude/session-state.md`)
  2. `ToolSearch` for `TeamCreate` schema (`select:TeamCreate`)
  3. Check team existence (`ls $HOME/.claude/teams/*/config.json`)
- In the next turn, call `TeamCreate` if no team config exists, then respond to the user's original message immediately.
- Boot is invisible infrastructure. Do not output boot-status reports or startup summaries unless the user explicitly asks. The user expects a direct reply to their message.
- After boot completes, the user's first message MUST be answered. Do not treat boot completion as the response.

### Boot constraints

- No production fan-out before the `Boot Sequence` is complete.
- Do not confuse `TeamCreate` with `TaskCreate`.
- If the runtime does not use explicit team orchestration, skip only the steps that are truly runtime-specific and still complete continuity establishment.
- Do not start `Boot Sequence` only to inspect the repository. In this environment, use it to arm the agent-team runtime, not to produce repository summaries.
- Previous setup logs and project auto memory are stale carryover by default, not authoritative planning inputs, unless the current task explicitly reopens them as evidence.
- When continuity is empty, stale, or contradictory and repo context must be rebuilt, use a verified branch-discovery step from the active repo root before any cross-branch comparison.
- Apply the same root-local startup rule to the active repo, clone, or worktree. Do not guess continuity or repo paths from team names, prior sessions, or remembered directories.
- Do not assume `main`, `master`, or any other branch exists just because it is common elsewhere or appears in stale carryover. Verify actual heads first, then compare only existing refs.
- Treat a missing branch ref as repository topology information, not as an operational error that needs recovery action.
- If the user explicitly ends the session while the explicit runtime is only partially booted, do not complete `Boot Sequence` just to tear it down. Enter `Closeout Sequence` directly and dismantle the partial runtime.

## Session-Start Sequence

The `Session-Start Sequence` applies at fresh start, resume, and pause-return.

### Required checks

1. Establish active context and inherited state.
   Default startup scope is minimal: read repo-local continuity first, establish the active project root, decide whether explicit team runtime is needed, then stop unless continuity is missing, contradictory, or the user explicitly asks for deeper repository analysis.
   If `<repo>/.claude/session-state.md` exists and is readable, treat that read as sufficient startup context. Do not reconstruct repo context at startup in the normal case.
   In this environment, that minimal startup anchor should immediately flow into `Boot Sequence` runtime activation. Startup completion should be expressed as agent-team startup readiness, not as a repository-context summary.
2. Identify incomplete work, active blockers, current ownership, and pending acceptance gates.
3. Verify plan validity.
   If the current plan is inconsistent, stale, missing, or no longer matches the active request, re-run planning before implementation fan-out.
4. Reconfirm current-runtime workers and remembered workers separately.
   For workers that are actually live in the current runtime, decide reuse, standby, or shutdown.
   For remembered previous-session workers carried only through continuity, decide whether the continuity note still matters, but do not send runtime lifecycle messages unless that worker is confirmed live again in the current runtime.
5. Reconfirm current management mode and runtime mode.
   Decide internally whether explicit team runtime is actually required for the next work phase.
   If unfinished governance optimization or compression is the active topic at fresh start, resume, or pause-return, do not treat inherited continuity, remembered review, or partial draft intent as edit-readiness. For high-traffic shared surfaces such as `CLAUDE.md`, `agents/team-lead.md`, `skills/team-governance-sequences/SKILL.md`, `skills/team-session-sequences/SKILL.md`, runtime hooks, or `settings.json`, the resumed packet must keep `SESSION-REVALIDATION: current-session-repo`, `BASELINE-ANCHOR: captured`, `SOURCE-MEANING-INVENTORY: explicit`, `DESTINATION-OWNER-MAP: explicit`, and `CHANGE-BOUNDARY: <bounded intended delta>` before editing resumes.
6. Make the initial owner map explicit enough to avoid drift.
7. When explicit runtime activation becomes necessary later, rely on the runtime-entry gate to audit runtime hygiene before `TeamCreate` or new worker fan-out. Do not run memory-pressure or orphan-runtime scans during `Session-Start Sequence` by default.

### Startup boundaries

- Do not inspect commit history, compare branches, or probe `main` versus `master` during startup unless continuity is missing or contradictory, or the user explicitly asks for repository analysis.
- Do not inspect current branch, dirty state, or general repository status during startup unless continuity is missing or contradictory, or the user explicitly asks for repository analysis.
- Do not enumerate optional project-local `.claude/skills`, `.claude/hooks`, or `.claude/settings.json` as part of startup unless continuity or the active task explicitly depends on them.
- Do not run repo-context reconstruction during startup when the repo-local continuity file exists and is readable.
- If repo context must be rebuilt, keep it bounded to repo root and verified heads. Do not escalate into branch-to-branch diff, merge-base, or broad repository status checks during startup by default.
- Do not emit startup repository summaries, branch reports, or wide tables unless the user explicitly asked for them or the next visible action depends on them.
- Default startup completion should be a short readiness line or the exact blocking activation step, not a state bulletin.
- Do not enumerate project-root paths, inherited continuity warnings, previous-session advisory codes such as `S-32`, cron job ids, cron cadence restatements, or cron expiration metadata in the default startup completion unless the operator explicitly asked for that detail or one of those items is the current blocker.
- Do not end startup with `continuity established`, `previous session state is weak`, or similar repository-summary framing. End with agent-team readiness or the exact next activation step instead.
- Do not tell the user that `TeamCreate` will happen later if this environment is in normal startup mode. `TeamCreate` is part of the automatic boot path here.

### Session-state discipline

- Update `.claude/session-state.md` on every major task completion, major decision, stage transition, key configuration change, or material ownership change.
- Do not wait until termination to restore session continuity state.
