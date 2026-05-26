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
- Use silent tracking or owner-surface repair when the procedure has a recoverable path.
- User-facing hook warnings are exceptional and must not become progress gates.
- Use `permissionDecision: "deny"` only for reserved hard-deny dangers or exact runtime actor/tool impossibilities that would corrupt delivery or runtime truth.
- Hard deny is reserved for secrets/credentials exposure, destructive recursive
deletion, `.claude` governance shell mutation or wholesale overwrite,
runtime/team-state corruption, exact task-state corruption, read-only reference
mutation, and interpreter-based mutation of protected filesystem surfaces that
bypasses structured edit surfaces.
- Procedure gaps, planning/self-verification order gaps, packet-quality gaps, review-tool absence, output-root instructions, and recoverable completion defects are not hard-deny causes unless they directly create one of those reserved dangers.
- Hook scripts specify prohibitions, not allow-lists. (`settings.json` `permissions.allow` is the Claude Code permission system layer, structurally separate from hook script behavior governed by this section.) Default for any unspecified shell or tool action is allow; deny only specific reserved dangers using narrow, target-scoped checks (outside-workspace targets, protected relative paths, catastrophic system targets, governance shell mutation, secrets/credentials surfaces). A broad "deny unless approved" pattern is an over-broad-blocking defect candidate.
- Over-broad hook blocking is repaired at the hook surface by narrowing the prohibition. Never substitute agent-side adherence rules, user re-confirmation flows, allow-list arming, or descriptive-pattern arming for prohibition narrowing — those move friction onto the user without removing the over-broad block and recreate the same bottleneck.
- Do not add a new hook when adherence to an existing doctrine, skill, or role
surface is the real fix.
- Treat `claude_doc/<work-name>/` as a protected work-artifact carrier per `.claude/reference/environment-output-root-filesystem-law.md`; hook-side deletion, write-rejection, move, or other interference against `claude_doc/` is an over-broad-blocking defect candidate unless the action is explicit user-approved teardown.
- Every hook script must be classified as active, dependency, absorbed, legacy, or
runtime artifact.
- Every active `settings.json` hook command must carry an explicit `timeout`.
  Timeout is a bottleneck guard, not a substitute for making hook logic small.

## Active Hooks
These files are wired directly from `../settings.json`.

- `agent-activity-monitor.sh`
- `assistant-response-curtain-gate.sh`
- `compliance-supervisor.sh`
- `permission-request-gate.sh`
- `reporting-curtain-envelope-gate.sh`
- `session-end.sh`
- `session-start.sh`
- `sv-gate.sh`
- `sv-tracker.sh`
- `tmux-kill-block.sh`
- `track-runtime-lifecycle.sh`
- `track-worker-transport.sh`
- `user-prompt-gate.sh`
- `worker-lifecycle-sync.sh`

## Legacy Hooks
These hook scripts remain in `./` for traceability.
- Their bodies are file-level no-op with `exit 0` at top.
- Their comment blocks point to the disable basis per `.claude/reference/work-runtime-boundary-law.md` `## Runtime Boundary Rules`.
- Positive-pattern doctrine-shape enforcement is owned by the lane trio: `Skill(governance-modification)`, `Skill(self-verification)`, and `Skill(review-verification)` named lenses.
- Downstream reviewer and validator independent gates remain intact.
- Their `settings.json` matchers were removed in the same governance patch.
- The Hook-Last Review Ledger does not list legacy hooks because a disabled body cannot fulfill a "Protected failure" claim.
- Each file is preserved for traceability and potential future narrowing to a negative-only filter.

- `dispatch-proof-gate.sh`
- `dispatch-sizing-gate.sh`
- `runtime-entry-gate.sh`
- `spawn-prompt-screen-safety.sh`
- `task-completed-gate.sh`
- `task-created-gate.sh`
- `task-start-gate.sh`
- `validate-task-target.sh`

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
Blocking hook/settings runtime-enforcement expansion also requires explicit
operator approval before activation; the ledger record names the approval basis.

| Hook | Protected failure | Narrowness and recovery record |
| --- | --- | --- |
| `agent-activity-monitor.sh` | live agent activity, heartbeat, browser proof activity, and runtime pressure signals becoming invisible or stale | Activity/runtime state surface only, with a narrow Playwright proof edge; recover through status read, monitoring, reroute, or session-runtime recovery rather than assuming progress. |
| `user-prompt-gate.sh` | prompt-derived delete approval, closeout intent, and boot-complete marker becoming stale or invisible | UserPromptSubmit only; no `additionalContext`, no status/stall recovery context, and no hard-deny. Silently resets or records user-approved delete roots, syncs explicit closeout/cancel state, and closes the boot marker only when procedure-state is ready. Recover through explicit closeout cancellation, owner skill routing, or claim narrowing. |
| `permission-request-gate.sh` | repeat prompts for bounded structured edits that normal PreToolUse gates already allowed | PermissionRequest-only auto-allow surface; non-matching requests fall back to Claude Code permission handling. |
| `sv-gate.sh` | browser proof without current planning basis | Narrow Playwright proof edge only; use silent tracking when denial would prevent ledger repair; recover through work-planning or claim narrowing. |
| `tmux-kill-block.sh` | active-session instability from tool-issued `tmux kill-*` commands | Bash-only hard-deny for exact tool-issued `tmux kill-*` command forms. Recover through per-member `SendMessage` `shutdown_request` selected by the runtime cleanup owner or `Skill(session-closeout)` Runtime Teardown Preflight followed by `TeamDelete`. |
| `worker-lifecycle-sync.sh` | teammate idle, completion, pending permission, pending dispatch, scope-pressure, or blocker signals becoming invisible or over-authoritative | TeammateIdle only; writes hook-maintained runtime state files when runtime state has a new lead-relevant idle or cleanup fact. It does not inject stdout context and does not hard-deny. Recover through reuse, structured shutdown, blocker resolution, packet correction, or claim narrowing. |
| `track-worker-transport.sh` | worker-originated transport, completion, blocker, and cooperative shutdown evidence becoming invisible or stale | PostToolUse SendMessage only; records transport state and, after a worker-originated `shutdown_response`, removes runtime roster state without `tmux kill-*`. Tool-issued `tmux kill-*` routes to hard-deny runtime-boundary law. |
| `compliance-supervisor.sh` | `.claude` governance mutation, wholesale overwrite, catastrophic primitives, runtime/team-state corruption, secrets exposure, hook-runtime artifact misplacement, non-developer retained-scope violation, or protected-filesystem bypass | Mutation-capable tools plus explicit Bash secret-read commands only; hard-deny categories and recovery live in `Compliance Supervisor Boundaries` below. |
| `reporting-curtain-envelope-gate.sh` | upward state-class SendMessage envelope discipline violations (lane putting MESSAGE-CLASS header plus receiver-required detail in message body instead of canonical no-detail envelope per `.claude/skills/task-execution/references/message-classes.md` `### Transport Payload` and `.claude/reference/reporting-prohibition-law.md`); structural complement to identity-layer IR-3 Curtained Communication (lane roles) and team-lead identity attribute (i) Curtained communication. Approval basis: 2026-05-25 operator directive ("진행해" after diagnosis confirmed governance-text patches alone insufficient; observed repeated post-patch violation across 5+ patch waves). | PreToolUse SendMessage only; narrow matcher on `MESSAGE-CLASS: <upward state class>` (dispatch-ack, status, scope-pressure, completion, hold\|blocker) as first non-empty line of message body; structured payloads (shutdown_request etc.) and downward message classes (assignment, reuse, reroute, phase-transition-control) pass through unaffected; empty/single-ASCII-space body passes through unaffected (canonical envelope). Fail-open on hook-internal error (missing jq, malformed JSON). Recover by resending with canonical envelope (summary = canonical state token, message body = empty or single ASCII space, detail in retained carrier cited by `RETAINED-OUTPUT-PATH`). |
| `assistant-response-curtain-gate.sh` | assistant-authored main response prose leakage on controllable renderable surfaces (turn-ending visible body) without explicit `REPORT-REASON` declaration; structural complement to constitutional curtain layer (`.claude/CLAUDE.md` `## Constitutional Reporting Curtain`), mapped 4-invariant detail (`.claude/reference/reporting-core-law.md` `## Constitutional 4-Invariant Detail`), identity-layer atomic-check (team-lead attribute (i); lane role IR-3), and SendMessage envelope hook. Forensic basis: `claude_doc/curtain-constitutional-fix-2026-05-26/forensic-report.md` documents 3+ prior reporting-prohibition patch waves eroded by subsequent "Consolidate/Tighten/Reduce/Sweep" commits. Approval basis: 2026-05-26 curtain-constitutional-fix-2026-05-26 (user-authorized via "독립적이면서 안전한 보완 패치를 신중하게 진행해"). | Stop event only; fail-open posture; reads assistant transcript JSON; allows when response body is empty/whitespace OR leads with valid REPORT-REASON declaration (English class names, Korean class names, or `REPORT-REASON:` cited form); blocks ONLY when non-reportable patterns (Step N process-narrative, Skill(...) loaded narration, verification packet content, Now/이제 process-continuation, Wave N status, defeater/FINDING-STATE/PROBLEM-BASIS/CONSUMED-TARGET-SURFACE composition content) detected AND no REPORT-REASON declaration present. Honest limitation: post-emission only — cannot un-emit prose already shown; serves as detection signal + force-continuation for in-session self-correction + audit trail. Recover by continuing active Procedure Plane action; resume with corrective emission shape (empty body or REPORT-REASON-declared narrow exception) next turn. |
| `session-start.sh` (Curtain Constitutional Self-Check block) | governance-text curtain surfaces silently eroded by subsequent "Consolidate/Tighten/Reduce/Sweep" commits; settings.json curtain hook wirings silently disabled; identity-layer atomic-check clauses silently removed; PROTECTED-CURTAIN-SURFACE markers silently dropped. Forensic basis: `claude_doc/curtain-constitutional-fix-2026-05-26/forensic-report.md` (a08ccf9 NET -126 lines on reporting-prohibition-law.md under "Consolidate via removal-first cleanup" banner; 99c2a2f mislabeled "Harden" but NET -25 across CLAUDE+team-lead; multiple "Tighten/Reduce/Sweep" patches net-deleting). Approval basis: 2026-05-26 curtain-constitutional-fix-2026-05-26. | SessionStart event only (appended to existing session-start.sh after Hook Health Self-Check block); mandatory (not skippable by `HOOK_HEALTH_SELF_CHECK_MODE`); checks (1) CLAUDE.md `## Constitutional Reporting Curtain` section present, (2) reporting-core-law.md `## Constitutional 4-Invariant Detail` section present, (3) modification-core-law.md `## Constitutional Curtain Protection` section present, (4) review-and-verification-core-law.md `curtain-breach` defect class present, (5) settings.json curtain envelope hook wiring present, (6) settings.json Stop curtain response hook wiring present, (7) both curtain hook scripts exist non-empty, (8) all 6 role files have identity atomic-check clause, (9) PROTECTED-CURTAIN-SURFACE markers on key text surfaces. On violation: writes to HOOK_HEALTH_LOG + VIOLATION_LOG and emits `additionalContext` to surface violation at session-start with required restoration action. Recover by restoring eroded protection per `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection`. |

## Compliance Supervisor Boundaries
- Hard-deny categories (each is an independently-actionable narrowing decision for hook design):
  - existing governance-file wholesale overwrite
  - secret/credential mutation or explicit Bash read
  - runtime/team-state overwrite
  - team runtime directory removal
  - shell mutation against `.claude`
  - non-developer worker `Write` outside its frozen `RETAINED-OUTPUT-PATH` or `claude_doc/<work-name>/` `WRITE-SCOPE`
  - interpreter-based protected-path bypass
  - protected/outside-workspace `rm` or `find`
  - catastrophic primitives
- Allow structured governance edits, new reference-file creation, and owner-procedure output-root instructions unless the narrow non-developer worker retained-root guard applies.
- Recover by narrowing the command target, using structured edit for governance content, or using non-secret/redacted evidence.

## Hook Dependencies
Active hook bootstrap dependencies are sourced or executed by settings-wired hooks. `hook-config.sh` and `hook-config-core.sh` are critical bootstrap dependencies.
Update callers in the same patch before removing any listed file.

- `hook-config.sh`: sourced by settings-wired active hooks except `permission-request-gate.sh`.
- `hook-config-core.sh`: sourced by `permission-request-gate.sh`.
- `lib/*.sh`: sourced through `hook-config.sh`, `hook-config-core.sh`, `track-runtime-lifecycle.sh`, `track-worker-transport.sh`, or `worker-lifecycle-sync.sh` when the active hook needs that library.
- `lib/*.js`: executed by active hook scripts or sourced hook libraries for JSON parsing, command parsing, or generated-command policy checks.
- `health-check.sh`: runtime helper invoked by a tracked health-check cron when active; `track-runtime-lifecycle.sh` recognizes health-check cron commands.
- `runtime-pressure-scan.sh`: runtime helper called by `health-check.sh` and legacy-disabled `runtime-entry-gate.sh`.
- `cleanup-orphan-runtime.sh`: runtime helper called by `health-check.sh` and legacy-disabled `runtime-entry-gate.sh`; it calls `runtime-pressure-scan.sh`.

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
