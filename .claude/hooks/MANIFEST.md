---
doc-type: hook-governance-ledger
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Core Laws 5 [HOOK-LAST]; Reference Binding; update-upgrade-sequence hook/settings owner"
LOAD-POLICY: on-demand hook governance ledger
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
- Procedure gaps, planning/SV order gaps, packet-quality gaps, review-tool absence, output-root instructions, and recoverable handoff defects are not hard-deny causes unless they directly create one of those reserved dangers.
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
- `dispatch-stall-monitor.sh`
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

MCP tools are not broadly hook-blocked by default. Codex has one narrow
pre-`work-planning` Codex-review warning edge: pre-planning Codex output is not
`CODEX-INDEPENDENT-REVIEW-BASIS` and cannot authorize route, proof, acceptance, dispatch, or
mutation. Playwright has one narrow browser user-surface proof edge for planning/SV
preflight. Broader `mcp__*` matcher expansion requires this ledger's Hook-Last
review before activation.

| Hook | Protected failure | Narrowness and recovery record |
| --- | --- | --- |
| `agent-activity-monitor.sh` | live agent activity, heartbeat, browser proof activity, and runtime pressure signals becoming invisible or stale | Activity/runtime state surface only, with a narrow Playwright proof edge; recover through status read, monitoring, reroute, or session-runtime recovery rather than assuming progress. |
| `user-prompt-gate.sh` | prompt-derived boot, recovery, delivery, self-growth, and closeout context becoming invisible or over-authoritative | UserPromptSubmit only; routine fresh-prompt planning-required state is silent. Emits additional context only for boot, recovery, delivery, self-growth/user-correction, or explicit closeout/cancel cues. This hook does not hard-deny; `runtime-entry-gate.sh` can deny new `Agent` while explicit closeout state is active. Recover through the named owner skill, explicit closeout cancellation, or claim narrowing. |
| `permission-request-gate.sh` | repeat prompts for bounded structured edits that normal PreToolUse gates already allowed | PermissionRequest-only auto-allow surface; non-matching requests fall back to Claude Code permission handling. |
| `task-start-gate.sh` | active team runtime dispatch/reuse without session-boot basis, unaddressable team-agent dispatch, worker first-receipt bypass, screen-rendered worker transport inventory leakage, or teardown intent without the owning closeout path | Broad core/Web matcher plus narrow Codex/Playwright MCP edges; `TeamDelete` with active closeout state passes through without shutdown-order blocking. Worker receipt hard-deny is limited to pending first receipt and admits strict `dispatch-ack`, `scope-pressure`, or `hold|blocker`; screen-rendered `MESSAGE-CLASS` SendMessage envelope hard-deny is global so worker-session detection failure cannot leak counts, findings, notes, excerpts, plans, paths, or completion detail instead of retained carriers. Recover through `session-boot`, strict first receipt, retained-carrier pointer envelope, addressable team-member dispatch, `session-closeout`, owner correction, or narrowed result truth. |
| `sv-gate.sh` | browser proof without current planning basis | Narrow Playwright proof edge only; use silent tracking when denial would prevent ledger repair; recover through work-planning or claim narrowing. |
| `runtime-entry-gate.sh` | team-runtime dispatch before session boot/runtime-entry basis is valid, `SendMessage` to a non-roster target that would ghost-dispatch, or non-closeout `TeamDelete` before current-session live process-backed teammates terminate | Runtime/dispatch tools only; task bookkeeping is owned by task-state hooks. `SendMessage` hard-deny is limited to exact non-delivery risk, and `TeamDelete` live-teammate hard-deny applies only outside active closeout state. Recover through `session-boot`, exact live member name, current-session team-scoped Agent creation, `session-closeout`, or a frozen lead-local non-agent path. |
| `dispatch-sizing-gate.sh` | exact duplicate live target spawn (task-state corruption), oversized packet, mixed-purpose agent packet, or hidden merge risk | `Agent` only; hard-deny live target name collision (would corrupt task-state). Standby overlap, idle-lifecycle-pending replacement, and recoverable packet gaps warn (not deny) per `[HOOK-LAST]` and the over-broad-blocking rule; route through packet repair, lifecycle/reuse recovery, or lane `hold\|blocker`. Lifecycle-pending downgrade rationale: pending lifecycle decisions are recoverable handoff defects, not corruption-class danger. |
| `dispatch-proof-gate.sh` | assignment proof, acceptance, or packet-basis gaps becoming invisible before dispatch | `Agent` plus assignment-grade `SendMessage`; free-form assignment messages, unresolved live-target lane contracts, and reviewer/tester/validator contract gaps emit channel-clarity warnings before dispatch, generic packet-floor gaps log warning, free-form non-assignment notes exit without warning, and packet repair stays with `task-execution`. |
| `spawn-prompt-screen-safety.sh` | lead's `Agent` spawn-prompt smuggling readiness/ACK/handoff/completion/status/MESSAGE-CLASS instruction or self-description prime that conditions member agents to emit visible-pane readiness prose in violation of `message-classes.md` Team Member Startup Recognition | `Agent` only; advisory (WARN, never DENY) per `[HOOK-LAST]` last-resort principle. Always writes per-spawn audit record (`spawn-prompt-audit.log`) with `clean` or `flagged` status, violation classes, and prompt character count so verification can count clean-vs-flagged spawn rate across sessions. Flagged spawns also emit a row to the shared violation log. Recovery: lead rewrites the spawn prompt to role + screen-safety only and routes work via assignment-grade `SendMessage`. |
| `dispatch-stall-monitor.sh` | team-lead falling into passive "waiting" loop after dispatch, allowing `assignment-sent-no-ack` or `dispatch-ack-no-start` to persist beyond same-turn follow-up mandate from `session-boot/references/runtime-state-detail.md` Stall-Without-Progress Rule | PostToolUse on common team-lead inspection tools (`Read`, `Bash`, `Glob`, `Grep`, `LS`, `TaskList`, `TaskGet`, `TaskOutput`, `ToolSearch`, `Skill`); advisory (WARN to stderr, never DENY) per `[HOOK-LAST]` last-resort principle. Reads `.runtime/procedure-state.json` and emits a stall advisory naming the worker and elapsed seconds whenever `teamDispatchState=="pending"` with empty `lastClaimedWorker` exceeds 120s, or `teamDispatchState=="claimed"` with no agent-start evidence exceeds 180s. Recovery: send same-assignment receipt or execution follow-up through `SendMessage`, then proceed per Stall-Without-Progress Rule corrective protocol. Doctrine remains the authority; this hook only forces visibility so a passive monitoring loop cannot silently bypass the same-turn mandate. |
| `task-created-gate.sh` | task creation without a usable subject or description | TaskCreate surface only; hard-denies only empty subject or description because that would create an unusable task-state row. Recover by creating a task packet with non-empty subject and description. Bounded-scope and completion coordinates remain non-blocking owner instructions unless a stricter owner requires them. |
| `task-completed-gate.sh` | task completion claim without identity, completion-grade transport, task match, required procedure markers, minimum evidence, lifecycle/cleanup truth, or claimed user-surface proof basis | Task completion surface only; closure-critical gaps block completion; non-blocking quality hints warn; recover by updating evidence/open-surface state or leaving the task incomplete. |
| `worker-lifecycle-sync.sh` | teammate idle, completion, pending permission, pending dispatch, scope-pressure, or blocker signals becoming invisible or over-authoritative | TeammateIdle only; adds suppressed lifecycle context only when runtime state has a new lead-relevant idle/lifecycle fact. It does not hard-deny. Recover through lifecycle-control, blocker resolution, packet correction, or claim narrowing. |
| `validate-task-target.sh` | task mutation against wrong, stale, inferred, or weakly identified task target | Task mutation surface only; hard-denies `TaskUpdate`/`TaskStop` on missing, stale, or agent-reference task ids. Read-only task lookup/output is not hooked here. Recover by using an exact task id from `TaskList`, `task_assignment`, or returned task mutation evidence. |
| `compliance-supervisor.sh` | `.claude` governance shell mutation, wholesale overwrite of EXISTING governance content, catastrophic system primitives (mkfs/dd if=/rm -rf /), runtime/team-state corruption, secrets/credentials mutation or explicit Bash read, hook-runtime artifact misplacement, or interpreter-based protected filesystem bypass | Mutation-capable tools plus explicit Bash secret-read commands only. Pinpoint hard-deny categories: existing governance file wholesale overwrite (Write/NotebookEdit on existing `.claude/skills/*/references/` and high-traffic surfaces); credentials by basename (`.env`, `.env.*`, `credentials.json`, `*.pem`, `*.key`, `*.p12`, `*.pfx`) or workspace `secrets/`; runtime/team-state file overwrite (`.runtime/procedure-state.json` etc.); team runtime directory rm (must use `TeamDelete`); shell mutation against `.claude` paths; interpreter-based bypass of protected paths; rm/find against outside-workspace, `.claude/`, `.git/`, `.runtime/`, `references/`; catastrophic primitives. New-file creation under `references/` is allowed (creation is not rewrite). Removed allow-list gates per `[HOOK-LAST]` and the over-broad-blocking rule: governance-reference actor identity gate (structured edit produces reviewable diff; no actor allow-list needed), retired `reference.md` anti-pattern (structural concern, owner doctrine governs), worker implementation-pattern path gate (ordinary dev commands are not danger), `git reset --hard` (reversible via reflog, user-choice). Output-root instructions are owner-procedure instructions, not hard-deny. Recover through narrowing the rm/find target to a workspace-internal non-protected path, using structured edit for governance content, or using non-secret/redacted evidence. |

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
