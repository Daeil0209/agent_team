# Hook Manifest

## Purpose
This directory contains Claude Code runtime guardrails for the active project.
Hooks are the last enforcement layer. Doctrine, skills, role contracts, and
truthful procedure execution remain the primary control surfaces.

## Operating Rules
- Keep active hooks narrow, observable, and surface-specific.
- Prefer silent tracking or owner-surface repair when the procedure can recover.
- User-facing hook warnings are exceptional and must not become progress gates.
- Use `permissionDecision: "deny"` only for reserved hard-deny dangers or exact runtime actor/tool impossibilities that would corrupt delivery or runtime truth.
- Hard deny is reserved for secrets/credentials exposure, destructive recursive
deletion, `.claude` governance shell mutation or wholesale overwrite,
runtime/team-state corruption, exact task-state corruption, read-only reference
mutation, and interpreter-based filesystem mutation that bypasses structured
edit surfaces.
- Procedure gaps, planning/SV order gaps, packet-quality gaps, advisory absence, output-root preference, and recoverable handoff defects are not hard-deny causes unless they directly create one of those reserved dangers.
- Hooks specify prohibitions, not allow-lists. Default for any unspecified shell or tool action is allow; deny only specific reserved dangers using narrow, target-scoped checks (outside-workspace targets, protected relative paths, catastrophic system targets, governance shell mutation, secrets/credentials surfaces). A broad "deny unless approved" pattern is a `[BLOCK-AS-DEFECT]` candidate.
- Over-broad hook blocking is repaired at the hook surface by narrowing the prohibition. Never substitute agent-side adherence rules, user re-confirmation flows, allow-list arming, or descriptive-pattern arming for prohibition narrowing — those move friction onto the user without removing the over-broad block and recreate the same bottleneck.
- Do not add a new hook when adherence to an existing doctrine, skill, or role
surface is the real fix.
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
- `sv-gate.sh`
- `sv-tracker.sh`
- `task-completed-gate.sh`
- `task-created-gate.sh`
- `task-start-gate.sh`
- `track-runtime-lifecycle.sh`
- `track-worker-report.sh`
- `user-prompt-gate.sh`
- `validate-task-target.sh`
- `worker-lifecycle-sync.sh`

## Hook-Last Review Ledger
This ledger is the current manifest review record for active blocking guardrails.
Do not treat it as runtime-footprint proof. Update it whenever an active hook adds a broader
matcher, new hard deny, or higher-frequency blocking path.

Broad `settings.json` matchers are tolerated only when the script narrows them
to exact marker, tool-shape, or parseable packet-field conditions and reports a
lawful recovery path. If a
legitimate lane action is blocked, treat that as a `[BLOCK-AS-DEFECT]` candidate
before adding more hook logic.

MCP tools are not broadly hook-blocked by default. Codex has one narrow
pre-`work-planning` advisory warning edge: pre-planning Codex output is not
`CODEX-ADVISORY-BASIS` and cannot authorize route, proof, acceptance, dispatch, or
mutation. Playwright has one narrow browser user-surface proof edge for planning/SV
preflight. Broader `mcp__*` matcher expansion requires this ledger's Hook-Last
review before activation.

| Hook | Protected failure | Narrowness and recovery record |
| --- | --- | --- |
| `agent-activity-monitor.sh` | live agent activity, heartbeat, browser proof activity, and runtime pressure signals becoming invisible or stale | Activity/runtime state surface only, with a narrow Playwright proof edge; recover through status read, monitoring, reroute, or session-runtime recovery rather than assuming progress. |
| `user-prompt-gate.sh` | prompt-derived boot, recovery, delivery, self-growth, and closeout context becoming invisible or over-authoritative | UserPromptSubmit only; routine fresh-prompt planning-required state is silent. Emits additional context only for boot, recovery, delivery, self-growth/user-correction, or explicit closeout/cancel cues. This hook does not hard-deny; `runtime-entry-gate.sh` may deny new `Agent` while explicit closeout state is active. Recover through the named owner skill, explicit closeout cancellation, or claim narrowing. |
| `permission-request-gate.sh` | unsafe permission approval on protected governance, runtime, or secret-adjacent surfaces | PermissionRequest-only surface; recover through structured edit, explicit approval, or the owning procedure. |
| `task-start-gate.sh` | active team runtime dispatch/reuse without session-boot basis, unaddressable team-agent dispatch, or teardown intent without the owning closeout path | Broad core/Web matcher plus narrow Codex/Playwright MCP edges; procedure-preflight gaps, worker receipt gaps, and completion-message quality gaps do not hard-deny by themselves. Recover through `session-boot`, addressable team-member dispatch, `session-closeout`, owner correction, or narrowed result truth. |
| `sv-gate.sh` | browser proof without current planning basis | Narrow Playwright proof edge only; silent tracking is preferred when denial would prevent ledger repair; recover through work-planning or claim narrowing. |
| `runtime-entry-gate.sh` | team-runtime dispatch before session boot/runtime-entry basis is valid, `SendMessage` to a non-roster target that would ghost-dispatch, or `TeamDelete` before current-session live process-backed teammates terminate | Runtime/dispatch tools only; task bookkeeping is owned by task-state hooks. `SendMessage` hard-deny is limited to exact non-delivery risk, and `TeamDelete` hard-deny is limited to current-session live process-backed teammate protection. Recover through `session-boot`, exact live member name, team-scoped Agent creation, session-closeout auto-drain, or a frozen lead-local non-agent path. |
| `dispatch-sizing-gate.sh` | exact duplicate live target, lifecycle-decision pending same-target replacement, oversized packet, mixed-purpose agent packet, or hidden merge risk | `Agent` only; hard-deny live target collision and same-target lifecycle-decision pending replacement. Standby overlap and recoverable packet gaps warn, then route through packet repair, lifecycle/reuse recovery, or lane `hold\|blocker`. |
| `dispatch-proof-gate.sh` | assignment proof, acceptance, or packet-basis gaps becoming invisible before dispatch | `Agent` plus assignment-grade `SendMessage`; free-form assignment messages, unresolved live-target lane contracts, and reviewer/tester/validator contract gaps emit channel-clarity warnings before dispatch, generic packet-floor gaps log warning, free-form non-assignment notes exit without warning, and packet repair stays with `task-execution`. |
| `task-created-gate.sh` | task creation without a usable subject or description | TaskCreate surface only; hard-denies only empty subject or description because that would create an unusable task-state row. Recover by creating a task packet with non-empty subject and description. Bounded-scope and completion coordinates remain best practice unless a stricter owner requires them. |
| `task-completed-gate.sh` | task completion claim without identity, completion-grade report, task match, required procedure markers, minimum evidence, lifecycle/cleanup truth, or claimed user-surface proof basis | Task completion surface only; closure-critical gaps block completion; non-blocking quality hints warn; recover by updating evidence/open-surface state or leaving the task incomplete. |
| `worker-lifecycle-sync.sh` | teammate idle, completion, pending permission, pending dispatch, scope-pressure, or blocker signals becoming invisible or over-authoritative | TeammateIdle only; emits a changed lifecycle `systemMessage` only when runtime state has a new operator-relevant idle/lifecycle fact. It does not hard-deny. Recover through lifecycle-control, blocker resolution, packet correction, or claim narrowing. |
| `validate-task-target.sh` | task tool actions against wrong, stale, inferred, or weakly identified task/output target | Task tool surface only; hard-denies mutating task tools on missing, stale, or agent-reference task ids. Read-only task lookup/output remains non-blocking. Recover by using an exact task id from `TaskList`, `task_assignment`, or preferred output-read path. |
| `compliance-supervisor.sh` | `.claude` governance shell mutation, protected reference mutation, catastrophic system delete, runtime/team-state corruption, secrets/credentials shell deletion, hook-runtime artifacts, or interpreter-based filesystem bypass | Mutation-capable tools only; output-root preference is owner-procedure guidance, not hard-deny. Structured reference edits are allowed only for a positively identified lead session or developer worker; semantic packet completeness stays with `task-execution` and developer owner docs. Shell `rm`/`rmdir` follows pinpoint-prohibition (per `[BLOCK-AS-DEFECT]`/`[ALLOW-EXCEPT-DESTRUCT]`): catastrophic system targets (`rm -rf /` and similar) stay denied through their own narrow check; workspace-internal non-protected targets pass by default with no allow-list arming required. Pinpoint denies cover outside-workspace targets, `.claude/`, `.git/`, `references/`, `.runtime/` (runtime/team-state corruption), `secrets/`, and credential file basenames (`.env`, `.env.*`, `credentials.json`, `*.pem`, `*.key`, `*.p12`, `*.pfx`). Explicit user-arming and bounded cleanup pass-throughs remain available for governance-restricted flows. Recover through narrowing the rm target to a workspace-internal non-protected path, or use structured edit for governance/reference content. Coherence flag: secrets/credentials pattern is duplicated between the structured-edit deny case and the rm pinpoint check; future RE-HOME candidate to a shared helper. |

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
- `cleanup-terminated-panes.sh` -> retired; routine hooks report ghosts, while teardown and recovery owners decide cleanup
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

## External Legacy Artifacts
No active hook writes `~/.claude/.self-growth-log`. Treat it as a HOME-global
legacy artifact outside this hook payload, not as project policy or current
runtime state. Future self-growth evidence must use `~/.claude/logs/` or a
project-owned evidence surface. Deleting or archiving the HOME-global legacy file
requires explicit user approval because it is outside the project `.claude`
payload.
