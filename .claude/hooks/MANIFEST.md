---
doc-type: hook-governance-ledger
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Core Laws 5 [HOOK-LAST]; Reference Binding; governance-change hook/settings owner"
LOAD-POLICY: on-demand hook governance ledger
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---
# Hook Manifest

## Purpose
This directory contains Claude Code runtime guardrails for the active project.
Hooks are the last enforcement layer. Doctrine, skills, role contracts, and
truthful procedure execution remain the primary control surfaces.

## Operating Rules
- Keep active hooks narrow, observable, and surface-specific.
- Use silent tracking or owner-surface repair when the procedure has a recoverable path.
- User-facing hook warnings are exceptional and must not become progress gates.
- Use `permissionDecision: "deny"` only for reserved hard-deny dangers or exact runtime actor/tool impossibilities that would corrupt delivery or runtime truth.
- Hard deny is reserved for secrets/credentials exposure, destructive recursive
deletion, `.claude` governance shell mutation or wholesale overwrite,
runtime/team-state corruption, exact task-state corruption, read-only reference
mutation, and interpreter-based mutation of protected filesystem surfaces that
bypasses structured edit surfaces.
- Procedure gaps, planning/self-verification order gaps, packet-quality gaps, review-tool absence, output-root instructions, and recoverable completion defects are not hard-deny causes unless they directly create one of those reserved dangers.
- Hooks specify prohibitions, not allow-lists. Default for any unspecified shell or tool action is allow; deny only specific reserved dangers using narrow, target-scoped checks (outside-workspace targets, protected relative paths, catastrophic system targets, governance shell mutation, secrets/credentials surfaces). A broad "deny unless approved" pattern is an over-broad-blocking defect candidate.
- Over-broad hook blocking is repaired at the hook surface by narrowing the prohibition. Never substitute agent-side adherence rules, user re-confirmation flows, allow-list arming, or descriptive-pattern arming for prohibition narrowing — those move friction onto the user without removing the over-broad block and recreate the same bottleneck.
- Do not add a new hook when adherence to an existing doctrine, skill, or role
surface is the real fix.
- Treat `claude_doc/<work-name>/` as a protected work-artifact carrier per `.claude/reference/output-root-and-filesystem-law.md`; hook-side deletion, write-rejection, move, or other interference against `claude_doc/` is an over-broad-blocking defect candidate unless the action is explicit user-approved teardown.
- Every hook script must be classified as active, support, absorbed, legacy, or
runtime artifact.
- Every active `settings.json` hook command must carry an explicit `timeout`.
  Timeout is a bottleneck guard, not a substitute for making hook logic small.

## Active Hooks
These files are wired directly from `../settings.json`.

- `agent-activity-monitor.sh`
- `compliance-supervisor.sh`
- `dispatch-proof-gate.sh`
- `dispatch-sizing-gate.sh`
- `permission-request-gate.sh`
- `runtime-entry-gate.sh`
- `session-end.sh`
- `session-start.sh`
- `spawn-prompt-screen-safety.sh`
- `sv-gate.sh`
- `sv-tracker.sh`
- `task-completed-gate.sh`
- `task-created-gate.sh`
- `task-start-gate.sh`
- `track-runtime-lifecycle.sh`
- `track-worker-transport.sh`
- `user-prompt-gate.sh`
- `validate-task-target.sh`
- `worker-lifecycle-sync.sh`

## Hook-Last Review Ledger
This ledger is the current manifest review record for active blocking guardrails.
Do not treat it as runtime-footprint proof. Update it whenever an active hook adds a broader
matcher, new hard deny, or higher-frequency blocking path.

Broad `settings.json` matchers are tolerated only when the script narrows them
to exact marker, tool-shape, or parseable packet-field conditions and emits a
lawful recovery path. If a
legitimate lane action is blocked, treat that as an over-broad-blocking defect candidate
before adding more hook logic.

MCP tools are not broadly hook-blocked by default. Configured independent-review tools have one narrow
pre-`work-planning` warning edge: pre-planning external-review output is not
`CODEX-INDEPENDENT-REVIEW-BASIS` and cannot authorize route, proof, acceptance, dispatch, or
mutation. Playwright has one narrow browser user-surface proof edge for planning/self-verification
preflight. Broader `mcp__*` matcher expansion requires this ledger's Hook-Last
review before activation.

| Hook | Protected failure | Narrowness and recovery record |
| --- | --- | --- |
| `agent-activity-monitor.sh` | live agent activity, heartbeat, browser proof activity, and runtime pressure signals becoming invisible or stale | Activity/runtime state surface only, with a narrow Playwright proof edge; recover through status read, monitoring, reroute, or session-runtime recovery rather than assuming progress. |
| `user-prompt-gate.sh` | prompt-derived delete approval, closeout intent, and boot-complete marker becoming stale or invisible | UserPromptSubmit only; no `additionalContext`, no status/stall recovery context, and no hard-deny. Silently resets or records user-approved delete roots, syncs explicit closeout/cancel state, and closes the boot marker only when procedure-state is ready. `runtime-entry-gate.sh` can deny new `Agent` while explicit closeout state is active. Recover through explicit closeout cancellation, owner skill routing, or claim narrowing. |
| `permission-request-gate.sh` | repeat prompts for bounded structured edits that normal PreToolUse gates already allowed | PermissionRequest-only auto-allow surface; non-matching requests fall back to Claude Code permission handling. |
| `task-start-gate.sh` | active team runtime dispatch/reuse without session-boot basis, unaddressable team-agent dispatch, worker first-receipt bypass, closed-task replay, non-completion task-row mutation, invalid worker task closure, or teardown intent without the owning closeout path | Broad core/Web matcher plus narrow Codex/Playwright MCP edges; `TeamDelete` with active closeout state passes through without shutdown-order blocking. Lead-addressed `ack`/`completion` screen hygiene runs before worker-session recognition: the visible state signal is one header/preview `ack task <id>` / `completion task <id>`, and message/body slots are blank or whitespace-only. Worker receipt hard-deny is limited to tools that are not a first upward outcome while receipt is pending; `scope-pressure` and `hold\|blocker` remain open escape paths. Completion also requires immediate same-task `TaskUpdate(status=completed)` runtime closure and blocks same-task post-completion replay. This hook preserves Communication Plane detail in assignment/task/retained carriers and blocks screen-polluting receipt text. Reporting leakage is governed by `.claude/reference/user-reporting-law.md` and retained-carrier discipline. Recover through `session-boot`, strict first receipt, addressable team-member dispatch, `session-closeout`, owner correction, or narrowed result truth. |
| `sv-gate.sh` | browser proof without current planning basis | Narrow Playwright proof edge only; use silent tracking when denial would prevent ledger repair; recover through work-planning or claim narrowing. |
| `runtime-entry-gate.sh` | team-runtime dispatch before session boot/runtime-entry basis is valid, `SendMessage` to a non-roster target that would ghost-dispatch, or non-closeout `TeamDelete` before current-session live process-backed teammates terminate | Runtime/dispatch tools only; task bookkeeping is owned by task-state hooks. `SendMessage` hard-deny is limited to exact non-delivery risk, and `TeamDelete` live-teammate hard-deny applies only outside active closeout state. Recover through `session-boot`, exact live member name, current-session team-scoped Agent creation, `session-closeout`, or a frozen lead-local non-agent path. |
| `dispatch-sizing-gate.sh` | exact duplicate live target spawn (task-state corruption), oversized packet, mixed-purpose agent packet, or hidden merge risk | `Agent` only; hard-deny live target name collision (would corrupt task-state). Standby overlap, cleanup-pending replacement, and recoverable packet gaps warn (not deny) per `[HOOK-LAST]` and the over-broad-blocking rule; route through packet repair, cleanup/reuse recovery, or lane `hold\|blocker`. Cleanup-pending downgrade rationale: pending cleanup decisions are recoverable completion defects, not corruption-class danger. |
| `dispatch-proof-gate.sh` | assignment proof, acceptance, packet-basis gaps, or screen-polluting completion detail becoming invisible before dispatch | `Agent` plus assignment-grade `SendMessage`; screen-polluting completion-detail requests hard-deny, contract gaps warn, generic packet-floor gaps log warning, free-form non-assignment notes exit without warning, and packet repair stays with `task-execution`. |
| `spawn-prompt-screen-safety.sh` | spawn prompt violations of `message-classes.md` Team Member Startup Recognition becoming live agent startup leakage | `Agent` only; hard-deny is limited to direct startup-leak primes, with per-spawn audit logging. Recovery follows the owner rule: member creation uses role plus screen-safety only; assignment/control transport happens after member creation. |
| `task-created-gate.sh` | task creation without a usable subject or description | TaskCreate surface only; hard-denies only empty subject or description because that would create an unusable task-state row. Recover by creating a task packet with non-empty subject and description. Bounded-scope and completion coordinates remain non-blocking owner instructions unless a stricter owner requires them. |
| `task-completed-gate.sh` | task completion claim without identity, completion-grade transport, task match, required procedure markers, minimum evidence, cleanup truth, or claimed user-surface proof basis | Task completion surface only; closure-critical gaps block completion; non-blocking quality hints warn; recover by updating evidence/open-surface state or leaving the task incomplete. |
| `worker-lifecycle-sync.sh` | teammate idle, completion, pending permission, pending dispatch, scope-pressure, or blocker signals becoming invisible or over-authoritative | TeammateIdle only; adds suppressed runtime context only when runtime state has a new lead-relevant idle or cleanup fact. It does not hard-deny. Recover through reuse, structured shutdown, blocker resolution, packet correction, or claim narrowing. |
| `validate-task-target.sh` | task mutation against wrong, stale, inferred, or weakly identified task target | Task mutation surface only; hard-denies `TaskUpdate`/`TaskStop` on missing, stale, or agent-reference task ids. Read-only task lookup/output is not hooked here. Recover by using an exact task id from `TaskList`, `task_assignment`, or returned task mutation evidence. |
| `compliance-supervisor.sh` | `.claude` governance mutation, wholesale overwrite, catastrophic primitives, runtime/team-state corruption, secrets exposure, hook-runtime artifact misplacement, non-developer retained-scope violation, or protected-filesystem bypass | Mutation-capable tools plus explicit Bash secret-read commands only; hard-deny categories and recovery live in `Compliance Supervisor Boundaries` below. |

## Compliance Supervisor Boundaries
- Hard-deny existing governance-file wholesale overwrite, secret/credential mutation or explicit Bash read, runtime/team-state overwrite, team runtime directory removal, shell mutation against `.claude`, non-developer worker `Write` outside its frozen `RETAINED-OUTPUT-PATH` or `claude_doc/<work-name>/` WRITE-SCOPE, interpreter-based protected-path bypass, protected/outside-workspace `rm` or `find`, and catastrophic primitives.
- Allow structured governance edits, new reference-file creation, and owner-procedure output-root instructions unless the narrow non-developer worker retained-root guard applies.
- Recover by narrowing the command target, using structured edit for governance content, or using non-secret/redacted evidence.

## Hook Dependencies
Active hooks call or source these files. `hook-config.sh` and `hook-config-core.sh` are critical bootstrap dependencies.
Update callers in the same patch before removing any listed file.

- `hook-config.sh`
- `hook-config-core.sh`
- `cleanup-orphan-runtime.sh`
- `runtime-pressure-scan.sh`
- `health-check.sh`
- `lib/*.sh`
- `lib/*.js`

## Absorbed Scripts
Absorbed scripts must not remain as runnable top-level hook surfaces. Their
current behavior belongs to the active owner named here.

- `sync-worker-lifecycle-state.sh` -> `worker-lifecycle-sync.sh`
- `cleanup-terminated-panes.sh` -> retired; routine hooks flag ghosts, while teardown and recovery owners decide cleanup
- `teammate-quality-gate.sh` -> `worker-lifecycle-sync.sh`

## Runtime Artifacts
Runtime output must not become repository policy or appear under `hooks/`.
Route tool-produced files to repository-root
`projects/<project-folder>/.runtime/<tool>/...`
unless the user or active project config names a stricter output folder.

- `.playwright-mcp/`
- `*.png`

## Operational Logs
Hook-managed operational logs live in `~/.claude/logs/` (runtime-owned
operational state, not task-created output). All current hook code writes log
state under that directory.
