---
doc-type: hook-governance-ledger
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Environment Configuration Philosophy; Work Execution Philosophy reference binding; `Skill(governance-modification)` hook/settings owner"
LOAD-POLICY: on-demand hook governance ledger
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# Hook Manifest

## Purpose
This directory contains Claude Code runtime guardrails for the active project.
Hooks are the last enforcement layer. Doctrine, skills, role contracts, and
truthful procedure execution remain the primary control surfaces.

## Operating Rules
- Keep active hooks narrow, observable, and surface-specific.
- Prefer execution coaching: inject `additionalContext`, record runtime state, or correct exact tool input with `updatedInput` when the event supports it.
- Use silent tracking or owner-surface repair when the procedure has a recoverable path.
- User-facing hook warnings are exceptional and must not become progress gates.
- Use `permissionDecision: "deny"` only for reserved hard-deny dangers, exact runtime actor/tool impossibilities that would corrupt delivery or runtime truth, or the observed Claude Code `SendMessage` schema failure where string `message` lacks required `summary` and cannot be corrected through `updatedInput`.
- Hard deny is reserved for secrets/credentials exposure, destructive recursive
deletion, `.claude` governance shell mutation or wholesale overwrite,
runtime/team-state corruption, exact task-state corruption, read-only reference
mutation, non-owner lane protected-filesystem bypass, and interpreter-based
mutation of protected filesystem surfaces that bypasses structured edit surfaces.
- Procedure gaps, planning/self-verification order gaps, packet-quality gaps, review-tool absence, output-root instructions, general SendMessage content-class quality, and recoverable completion defects are not hard-deny causes unless they directly create one of those reserved dangers.
- Hooks specify prohibitions, not allow-lists. Default for any unspecified shell or tool action is allow; deny only specific reserved dangers using narrow, target-scoped checks (outside-workspace targets, protected relative paths, catastrophic system targets, governance shell mutation, secrets/credentials surfaces). A broad "deny unless approved" pattern is an over-broad-blocking defect candidate.
- Over-broad hook blocking is repaired at the hook surface by narrowing the prohibition. Never substitute agent-side adherence rules, user re-confirmation flows, allow-list arming, or descriptive-pattern arming for prohibition narrowing — those move friction onto the user without removing the over-broad block and recreate the same bottleneck.
- Display-only shell output remains governed by `.claude/reference/work-runtime-boundary-law.md` `### Bash Internal Evidence Capture Contract`.
- Do not add a new hook when adherence to an existing doctrine, skill, or role
surface is the real fix.
- The `SendMessage` string-message summary guard is a backstop for the current Claude Code schema failure where string `message` requires `summary`. The state-signal coach corrects worker-to-lead `dispatch-ack`, `scope-pressure`, `hold|blocker`, or `subjob-done` attempts that would put non-space visible text in `message`; accepted non-state-signal doctrine defects route to the Communication Plane owner and post-use transport tracker.
- Treat `claude_doc/<work-name>/` as a protected work-artifact carrier per `.claude/reference/environment-output-root-filesystem-law.md`; hook-side deletion, write-rejection, move, or other interference against `claude_doc/` is an over-broad-blocking defect candidate unless the action is explicit user-approved teardown.
- Shell commands that read `.claude` as a source and write generated evidence under `claude_doc/<work-name>/` are not `.claude` governance mutation when the destination or effective mutation target resolves outside `.claude`; their terminal stdout/stderr shape remains governed by `.claude/reference/work-runtime-boundary-law.md` `### Bash Internal Evidence Capture Contract`.
- Every hook script must be classified as active, support, absorbed, or
runtime artifact.
- Every active `settings.json` hook command must carry an explicit `timeout`.
  Timeout is a bottleneck guard, not a substitute for making hook logic small.

## Active Hooks
These files are wired directly from `../settings.json`.

- `agent-activity-monitor.sh`
- `permission-request-gate.sh`
- `reporting-curtain-context.sh`
- `session-end.sh`
- `session-start.sh`
- `sendmessage-state-signal-coach.sh`
- `sv-gate.sh`
- `sv-tracker.sh`
- `tmux-kill-block.sh`
- `track-runtime-lifecycle.sh`
- `track-worker-transport.sh`
- `user-prompt-gate.sh`
- `worker-lifecycle-sync.sh`

## Hook-Last Review Ledger
This ledger records Hook-Last review for settings-wired active hooks listed in `## Active Hooks` whose behavior affects blocking, runtime state, reporting-curtain context, transport, lifecycle, or cleanup truth.
The `## Active Hooks` list is the membership source; every settings-wired active hook has a ledger row below.
Do not treat the ledger as runtime-footprint proof. Update it whenever an active hook adds a broader
matcher, new hard deny, higher-frequency blocking path, or changed context/state/transport behavior.

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
Blocking hook/settings runtime-enforcement expansion also requires explicit
operator approval before activation; the ledger record names the approval basis.

| Hook | Protected failure | Narrowness and recovery record |
| --- | --- | --- |
| `agent-activity-monitor.sh` | live agent activity, heartbeat, browser proof activity, runtime pressure signals, and terminated-agent tool calls becoming invisible, stale, or executable after supervisor kill | Activity/runtime state surface with a narrow Playwright proof edge; `[AGENT-KILL]` hard-denies non-`SendMessage` tool calls from kill-listed agents. Recover through status read, monitoring, reroute, session-runtime recovery, or permitted `SendMessage` shutdown/recovery. |
| `user-prompt-gate.sh` | prompt-derived delete approval, closeout intent, and boot-complete marker becoming stale or invisible | UserPromptSubmit only; no `additionalContext`, no status/stall recovery context, and no hard-deny. Silently resets or records user-approved delete roots, syncs explicit closeout/cancel state, and closes the boot marker only when procedure-state is ready. Recover through explicit closeout cancellation, owner skill routing, or claim narrowing. |
| `reporting-curtain-context.sh` | report-prohibition hot-path spine not being present at the highest-risk consumption moments | SessionStart/UserPromptSubmit/SubagentStart, PreToolUse Skill for `agent-team-lead`, `session-boot`, `work-planning`, `task-execution`, and `review-verification`, PostToolUse, PostToolUseFailure, PostToolBatch, and TeammateIdle inject compact `additionalContext` pointing to `.claude/reference/reporting-curtain-spine.md`, naming detailed-law escalation conditions, immediate next-continuation suppression, and avoiding admitted-report shape rules. SessionStart also reminds the `team-lead` that `agent-team-lead` and `session-boot` load before `work-planning`; hook boot markers remain runtime evidence only. TeammateIdle adds the lane-completion quiet-window continuation so wait/resume/hold prose stays classified as `REPORT-REASON:none`. PostToolUse Read of `task-execution` references adds the task-execution continuation boundary so materializing/fetching/dispatch transition prose stays classified as `REPORT-REASON:none`. PreToolUse Bash uses `permissionDecision: "allow"` with `updatedInput` only to redirect internal stdout/stderr into governed files. It does not deny, does not print user warnings, and does not claim proof of learning. Recovery remains owner-surface consumption and exact renderable-candidate mapping. |
| `session-start.sh` | boot marker, startup cleanup, runtime snapshot, name registry, and hook-health membership becoming stale or invisible | SessionStart only; records startup/procedure state, prunes stale dispatch residue, clears stale team state, refreshes name registry, and verifies settings-wired hook files. It does not hard-deny. Recover through session-boot startup recovery or hook-health repair. |
| `session-end.sh` | session residual, closeout cleanup, and runtime-owned transient truth being erased or unreported | SessionEnd only; records residual warnings; without active closeout intent clears session runtime files plus project auto-memory; with closeout hold clears runtime transients plus project auto-memory; with clean closeout clears runtime transients, closeout-intent/governance-residue markers, and project auto-memory. It does not hard-deny. Recover through `Skill(session-closeout)` or runtime residue handling. |
| `permission-request-gate.sh` | repeat prompts for bounded structured edits that normal PreToolUse gates already allowed | PermissionRequest-only auto-allow surface; non-matching requests fall back to Claude Code permission handling. |
| `sv-gate.sh` | browser proof without current planning basis | Narrow Playwright proof edge only; warn/log-only and never denies; recover through work-planning or claim narrowing. |
| `sendmessage-state-signal-coach.sh` | worker-originated `dispatch-ack`, `scope-pressure`, `hold\|blocker`, or `subjob-done` carrying a duplicated token or visible body outside the canonical state-signal slot | PreToolUse SendMessage only; uses `updatedInput` to put the token only in `summary`, replace renderable body detail with one ASCII space, and inject compact reporting-curtain spine context. It does not inspect assignment packet completeness, carrier fields, proof quality, problem-report detail, status requests, ordinary lead-to-lane packets, or non-state-signal SendMessage content. Recovery is corrected no-detail state transport execution. Operator approval basis: 2026-06-02 request to make agents comply with report prohibition and use hooks to make reporting-rule consumption occur under conditions. |
| `tmux-kill-block.sh` | active-session instability from tool-issued `tmux kill-*` commands | Bash-only hard-deny for exact tool-issued `tmux kill-*` command forms. Recover through per-member `SendMessage` `shutdown_request` selected by the runtime cleanup owner or `Skill(session-closeout)` Runtime Teardown Preflight followed by `TeamDelete`. |
| `worker-lifecycle-sync.sh` | teammate idle, subjob-done, pending permission, pending dispatch, scope-pressure, or blocker signals becoming invisible or over-authoritative | TeammateIdle only; writes hook-maintained runtime state files when runtime state has a new lead-relevant idle or cleanup fact. It records raw `subjob-done` as a candidate idle state only and does not mark standby or accept completion. It does not inject stdout context and does not hard-deny. Recover through retained-carrier acceptance, reuse, structured shutdown, blocker resolution, packet correction, or claim narrowing. |
| `track-worker-transport.sh` | worker-originated transport, subjob-done, blocker, retained-output scope, cooperative shutdown evidence, and malformed or legacy state-signal display becoming invisible or stale | PostToolUse SendMessage only; records transport state and retained-output scope from governed assignment/reuse/reroute and worker `subjob-done` messages; it refuses receipt classification when an upward state token is legacy `ack`, legacy `completion`, has a task suffix, or carries extra visible glyph content, and after a worker-originated `shutdown_response`, removes runtime roster state without `tmux kill-*`. Tool-issued `tmux kill-*` routes to hard-deny runtime-boundary law. |
| `track-runtime-lifecycle.sh` | dispatch lifecycle, permission provenance, explicit team runtime, and health-cron state becoming stale or invisible | PostToolUse lifecycle tracking for `Agent`, `TeamCreate`, `TeamDelete`, `CronCreate`, and `CronDelete`; records pending dispatch, permission provenance, runtime active state, and health-cron markers. It does not hard-deny. Recover through monitoring, dispatch recovery, or session-boot runtime recovery. |
| `sv-tracker.sh` | skill-load sequence markers becoming stale or invisible | PostToolUse Skill only; records a generic marker for each observed loaded skill, applies additional lead/session markers for selected startup and procedure skills, and clears self-growth suspected/pending state when `self-growth-sequence` loads. It does not suppress host display; assistant-authored prose control stays on reporting-law and role/skill consumed surfaces. |

## Hook Dependencies
Active hook bootstrap dependencies are sourced or executed by settings-wired hooks. `hook-config.sh` and `hook-config-core.sh` are critical bootstrap dependencies.
Update callers in the same patch before removing any listed file.

- `hook-config.sh`: sourced by settings-wired active hooks except `permission-request-gate.sh` and `tmux-kill-block.sh`.
- `hook-config-core.sh`: sourced by `permission-request-gate.sh`.
- Shared `lib/*.sh` files are active only when sourced by `hook-config.sh`, `hook-config-core.sh`, or an explicitly wired hook script.
- Unsourced `lib/*.sh` files are dormant helpers, not active hook dependencies; governance docs cite them as active only with caller evidence.
- Shared `lib/*.js` files are active only when an explicitly wired hook or sourced hook library invokes them; governance docs cite a JavaScript helper as active only with caller evidence.
- `health-check.sh`: runtime helper invoked by a tracked health-check cron when active; `track-runtime-lifecycle.sh` recognizes health-check cron commands.
- `runtime-pressure-scan.sh`: runtime helper called by `health-check.sh`.

## Absorbed Scripts
Absorbed scripts must not remain as runnable top-level hook surfaces. Their
current behavior belongs to the active owner named here.

- `sync-worker-lifecycle-state.sh` -> `worker-lifecycle-sync.sh`
- `cleanup-terminated-panes.sh` -> retired; routine hooks flag ghosts, while teardown and recovery owners decide cleanup
- `teammate-quality-gate.sh` -> `worker-lifecycle-sync.sh`

## Runtime Artifacts
Runtime output must not become repository policy or appear under `hooks/`.
Route task-created tool output to the frozen task project output root from `.claude/reference/environment-output-root-filesystem-law.md`.
Route runtime-owned state only to the runtime-owned filesystem surfaces named by `.claude/reference/work-runtime-boundary-law.md`.

- `.playwright-mcp/`
- `*.png`

## Operational Logs
Hook-managed operational logs live in `~/.claude/logs/` (runtime-owned
operational state, not task-created output). All current hook code writes log
state under that directory.
