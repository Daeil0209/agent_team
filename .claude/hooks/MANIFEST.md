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
- Constitutionally-protected reporting-curtain hooks are the narrow exception to the negative-only filter: they may block controllable renderable-surface leakage enumerated by `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection`; this exception does not authorize ordinary packet-quality, planning-order, or positive-pattern hooks.
- Procedure gaps, planning/self-verification order gaps, packet-quality gaps, review-tool absence, output-root instructions, and recoverable completion defects are not hard-deny causes unless they directly create one of those reserved dangers.
- Hook scripts specify prohibitions, not allow-lists. (`settings.json` `permissions.allow` is the Claude Code permission system layer, structurally separate from hook script behavior governed by this section.) Default for any unspecified shell or tool action is allow; deny only specific reserved dangers using narrow, target-scoped checks (outside-workspace targets, protected relative paths, catastrophic system targets, governance shell mutation, secrets/credentials surfaces). A broad "deny unless approved" pattern is an over-broad-blocking defect candidate.
- Over-broad hook blocking is repaired at the hook surface by narrowing the prohibition. Never substitute agent-side adherence rules, user re-confirmation flows, allow-list arming, or descriptive-pattern arming for prohibition narrowing — those move friction onto the user without removing the over-broad block and recreate the same bottleneck.
- Do not add a new hook when adherence to an existing doctrine, skill, or role
surface is the real fix.
- Treat `claude_doc/<work-name>/` as a protected work-artifact carrier per `.claude/reference/environment-output-root-filesystem-law.md`; hook-side deletion, write-rejection, move, or other interference against `claude_doc/` is an over-broad-blocking defect candidate unless the action is explicit user-approved teardown.
- Before using a hook ledger `claude_doc/...` citation as current proof, verify that the carrier exists or is reconstructed from Git in the current review.
- Classify a missing carrier as `ledger-only-surviving-evidence`.
- Treat `ledger-only-surviving-evidence` as a historical approval or forensic label only; prove current behavior from live hook body, `settings.json` wiring, protected-surface lists, or Git-verifiable reconstruction.
- Every hook script must be classified as active, dependency, absorbed, legacy, or
runtime artifact.
- Every active `settings.json` hook command must carry an explicit `timeout`.
  Timeout is a bottleneck guard, not a substitute for making hook logic small.

## Carrier Citation Status
This status table prevents stale work-artifact citations in this manifest from being mistaken for current evidence.

| Carrier path | Current status | Claim ceiling |
| --- | --- | --- |
| `claude_doc/governance-audit-2026-05-27/meetings/team-lead-essence-discipline/draft-r2.md` | Git-tracked work artifact, currently deleted from the working tree; reconstructable from Git history | Historical approval label only until restored or reconstructed from Git; verify current posture through live hook body and `settings.json` wiring. |
| `claude_doc/curtain-constitutional-fix-2026-05-26/forensic-report.md` | Missing from the working tree; not present in the current Git index; no matching Git history found by current review | Historical forensic label only; verify current curtain protection through live protected-surface list, live hook body, and `settings.json` wiring. |

Protected hook scripts can embed the same carrier labels in comments or recovery text. Do not edit those protected script surfaces from this ledger; until a constitutional protected-surface gate authorizes that mutation, apply this table's claim ceiling when those embedded labels are reviewed.

## Active Hooks
These files are wired directly from `../settings.json`.

- `agent-activity-monitor.sh`
- `compliance-supervisor.sh`
- `permission-request-gate.sh`
- `pre-consequential-action-skill-verification-gate.sh` — PreToolUse on Edit/MultiEdit/Write/SendMessage/Bash; assignment-grade SendMessage packet quality stays with task-execution preflight and governed packet carriers under one-line rendered-envelope transport; advisory-only on .claude/* mutation Skill(governance-modification) load evidence (Branch 1, not compliance proof) AND Bash test/proof/validation pattern routing (Branch 3) pending sv-tracker/actor-discrimination integration; carve-outs (codex/read-equivalent/diagnostic) preserved on advisory branches. Approval basis: team-meeting `team-lead-essence-discipline` r2 4/4 critic CONSENT (carrier: claude_doc/governance-audit-2026-05-27/meetings/team-lead-essence-discipline/draft-r2.md) + Hook-Last review, narrowed by Hook-Last over-broad-blocking correction.
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
operator approval before activation; user-decision-risk hook/settings design
choices open decision support before approval-basis presentation only when no
§1-§8-compliant reversible path is derivable; the ledger record names the
approval basis.

| Hook | Protected failure | Narrowness and recovery record |
| --- | --- | --- |
| `agent-activity-monitor.sh` | live agent activity, heartbeat, browser proof activity, and runtime pressure signals becoming invisible or stale | Activity/runtime state surface only, with a narrow Playwright proof edge; recover through status read, monitoring, reroute, or session-runtime recovery rather than assuming progress. |
| `user-prompt-gate.sh` | prompt-derived delete approval, closeout intent, report-detail expansion preference, and boot-complete marker becoming stale or invisible | UserPromptSubmit only; no `additionalContext`, no status/stall recovery context, and no hard-deny. Silently resets or records user-approved delete roots, records the current real user turn's `reportDetailRequest` as `explicit-detail-request` or `default-concise` in workspace procedure state, syncs explicit closeout/cancel state, and closes the boot marker only when procedure-state is ready. Recover through explicit closeout cancellation, owner skill routing, or claim narrowing. |
| `permission-request-gate.sh` | repeat prompts for bounded structured edits to non-protected governance document surfaces that normal PreToolUse gates already allowed | PermissionRequest-only auto-allow surface; constitutionally-protected reporting-curtain surfaces and non-matching requests fall back to Claude Code permission handling. |
| `sv-gate.sh` | browser proof without current planning basis | Narrow Playwright proof edge only; use silent tracking when denial would prevent ledger repair; recover through work-planning or claim narrowing. |
| `sv-tracker.sh` | Skill load host-result display reaching a surface governed by `.claude/reference/reporting-prohibition-law.md` | PostToolUse Skill only; records session skill markers and emits `suppressOutput` for recognized Skill invocations, accepting both `tool_input.skill` and `tool_input.name` input shapes. Model-side skill content remains available; report admission and non-reportable skill-load narration stay owned by `.claude/reference/reporting-prohibition-law.md`. |
| `tmux-kill-block.sh` | active-session instability from tool-issued `tmux kill-*` commands | Bash-only hard-deny for exact tool-issued `tmux kill-*` command forms. Recover through per-member `SendMessage` `shutdown_request` selected by the runtime cleanup owner or `Skill(session-closeout)` Runtime Teardown Preflight followed by `TeamDelete`. |
| `worker-lifecycle-sync.sh` | teammate idle, completion, pending permission, pending dispatch, scope-pressure, or blocker signals becoming invisible or over-authoritative | TeammateIdle only; writes hook-maintained runtime state files when runtime state has a new lead-relevant idle or cleanup fact. It does not inject stdout context and does not hard-deny. Recover through reuse, structured shutdown, blocker resolution, packet correction, or claim narrowing. |
| `track-worker-transport.sh` | worker-originated transport, completion, blocker, and cooperative shutdown evidence becoming invisible or stale | PostToolUse SendMessage only; records transport state and, after a worker-originated `shutdown_response`, removes runtime roster state without `tmux kill-*`. Tool-issued `tmux kill-*` routes to hard-deny runtime-boundary law. |
| `compliance-supervisor.sh` | `.claude` governance mutation, wholesale overwrite, catastrophic primitives, runtime/team-state corruption, secrets exposure, hook-runtime artifact misplacement, non-developer retained-scope violation, or protected-filesystem bypass | Mutation-capable tools plus explicit Bash secret-read commands only; hard-deny categories and recovery live in `Compliance Supervisor Boundaries` below. |
| `reporting-curtain-envelope-gate.sh` | SendMessage rendered-envelope leakage through `summary`, non-assignment `message`, or rendered assignment packet fields; structural complement to identity-layer IR-3 Curtained Communication (lane roles) and team-lead identity attribute (i) Curtained communication. Approval basis: 2026-05-25 operator directive ("진행해" after diagnosis confirmed governance-text patches alone insufficient; observed repeated post-patch violation across 5+ patch waves) + 2026-05-28 protected-surface validator PASS and explicit user authorization. | PreToolUse SendMessage only; enforces the rendered-envelope classes owned by `.claude/skills/task-execution/references/message-classes.md` and the non-reportable content admission owned by `.claude/reference/reporting-prohibition-law.md`. Uses `.claude/hooks/lib/hook-json-helpers.js` `parseInput()` through Node to inspect decoded `tool_input.summary` and `tool_input.message`. Receiver-required detail remains in governed packet carriers, retained carriers, task state, shutdown requests, or evidence artifacts. Fail-open on hook-internal error. Recover violations through the canonical envelope or retained-carrier pointer path. |
| `pre-consequential-action-skill-verification-gate.sh` | RC-B self-rule blind spot detection at runtime composition moment + RC-D role-separation packet-quality ownership at SendMessage assignment-grade moment + RC-I lead-internal-aid boundary detection at Bash test-pattern moment + RC-G surface-pattern-matching detection at .claude/* mutation moment. Approval basis: team-meeting `team-lead-essence-discipline` r2 4/4 critic CONSENT (developer T14+T18 / researcher T15+T19 / reviewer-shard-a T16 / reviewer-shard-b T17) + per-S 16-row INVARIANT matrix + Hook-Last review (this ledger row). Carrier: `claude_doc/governance-audit-2026-05-27/meetings/team-lead-essence-discipline/draft-r2.md`. | PreToolUse on Edit/MultiEdit/Write/SendMessage/Bash with 5-second timeout; fail-open posture on hook-internal error. Branch 1 (governance mutation on `.claude/*`) is advisory-only and cannot be cited as runtime proof of Skill(governance-modification) compliance. Branch 2 performs no assignment-body inspection because rendered assignment transport now exposes only one carrier/task-state pointer line; `DISPATCH-AUTHORIZATION-BASIS` and packet-field quality stay with task-execution packet preflight, governed packet carriers, receiving-owner packet correction, and review/self-verification. Branch 3 (Bash test/proof/validation pattern detection) advisory-only pending actor-discrimination integration. Active hard-deny remains absent on positive-pattern or packet-shape compliance gaps. |
| `session-start.sh` (Curtain Constitutional Self-Check block) | governance-text curtain surfaces silently eroded by subsequent "Consolidate/Tighten/Reduce/Sweep" commits; settings.json constitutional curtain hook wirings silently disabled; identity-layer protected local curtain restatement components silently removed; PROTECTED-CURTAIN-SURFACE markers silently dropped. Forensic basis: `claude_doc/curtain-constitutional-fix-2026-05-26/forensic-report.md` (a08ccf9 NET -126 lines on reporting-prohibition-law.md under "Consolidate via removal-first cleanup" banner; 99c2a2f mislabeled "Harden" but NET -25 across CLAUDE+team-lead; multiple "Tighten/Reduce/Sweep" patches net-deleting). Approval basis: 2026-05-26 curtain-constitutional-fix-2026-05-26. | SessionStart event only (appended to existing session-start.sh after Hook Health Self-Check block); mandatory (not skippable by `HOOK_HEALTH_SELF_CHECK_MODE`); checks (1) CLAUDE.md `## Constitutional Reporting Curtain` section present, (2) reporting-core-law.md `## Constitutional 4-Invariant Detail` section present, (3) modification-core-law.md `## Constitutional Curtain Protection` section present, (4) review-and-verification-core-law.md `curtain-breach` defect class present, (5) settings.json constitutional curtain wiring present for SendMessage envelope gate and Skill-result suppression only, (6) constitutional curtain hook scripts exist non-empty, (7) all 6 role files carry the protected local curtain restatement components (`PROTECTED-CURTAIN-SURFACE`, canonical curtain owner pointer, reporting-prohibition-law pointer, and `Atomic-check:`), (8) PROTECTED-CURTAIN-SURFACE markers on key text surfaces. On violation: writes to HOOK_HEALTH_LOG + VIOLATION_LOG and emits `additionalContext` to surface violation at session-start with required repair/realignment action. Recover by repairing or realigning eroded protection per `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection`; do not assume HEAD-text restoration unless semantic loss is proven. |

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
- Canonical INPUT_JSON Pattern: hook node scripts that parse stdin tool input through the standard `INPUT_JSON="$INPUT" node ...` bash wrapper use `parseInput()` from `lib/hook-json-helpers.js` instead of inline `try { JSON.parse(process.env.INPUT_JSON || "{}") } catch {}` boilerplate per Wave 4 Batch H P6.2 consolidation. Consumer pattern: pass `HOOK_JSON_HELPERS="$HOOK_LIB_DIR/hook-json-helpers.js"` env var alongside `INPUT_JSON`, then `require(process.env.HOOK_JSON_HELPERS).parseInput()` in the node script.
- INPUT_JSON Consumer Inventory (post-Wave-4 Batch H closure per W4-CX-2 refinement):
  - **Fully migrated to `parseInput()` (11 hooks)**: `agent-activity-monitor.sh`, `compliance-supervisor.sh` (lines :6 short session_id + :1115 heredoc), `permission-request-gate.sh`, `reporting-curtain-envelope-gate.sh`, `session-end.sh`, `session-start.sh`, `sv-gate.sh`, `sv-tracker.sh`, `track-runtime-lifecycle.sh` (lines :49 short tool_name + :59 Agent heredoc + :180 TeamCreate/TeamDelete heredoc), `track-worker-transport.sh` (lines :29 + :90), `user-prompt-gate.sh`, `worker-lifecycle-sync.sh` (lines :10 + :230).
  - **Not migration-feasible — different parse pattern**: `pre-consequential-action-skill-verification-gate.sh` (uses shell extraction for `tool_name`; assignment packet-quality inspection is intentionally inactive under one-line rendered-envelope transport), `tmux-kill-block.sh` (reads stdin JSON and parses `tool_input.command` through Python `json.load` + `shlex` for the reserved session-stability hard-deny). These hooks intentionally do not use the node `parseInput()` helper; record each as `rejected:non-applicable:different-parse-pattern`.
  - **Other lib utilities (do not consume INPUT_JSON)**: `health-check.sh` (reads from CONFIG_FILE not INPUT_JSON). Not in P6.2 consumer scope.
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
