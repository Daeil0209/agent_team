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
- `permission-request-gate.sh`
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
These hook scripts remain in `./` for traceability but their bodies are file-level no-op (`exit 0` at top, with a 9-line comment block pointing to the disable basis) per `.claude/reference/runtime-boundary-law.md` `## Runtime Boundary Rules` (negative-only-filter doctrine — positive-pattern doctrine-shape enforcement is owned by the lane trio: `Skill(governance-change)` + `Skill(self-verification)` + `Skill(review-verification)` named lenses, plus downstream reviewer/validator independent gates). Their `settings.json` matchers were removed in the same governance-change patch. The Hook-Last Review Ledger does not list legacy hooks because a disabled body cannot fulfill a "Protected failure" claim. Each file is preserved for traceability and potential future narrowing to a negative-only filter.

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

| Hook | Protected failure | Narrowness and recovery record |
| --- | --- | --- |
| `agent-activity-monitor.sh` | live agent activity, heartbeat, browser proof activity, and runtime pressure signals becoming invisible or stale | Activity/runtime state surface only, with a narrow Playwright proof edge; recover through status read, monitoring, reroute, or session-runtime recovery rather than assuming progress. |
| `user-prompt-gate.sh` | prompt-derived delete approval, closeout intent, and boot-complete marker becoming stale or invisible | UserPromptSubmit only; no `additionalContext`, no status/stall recovery context, and no hard-deny. Silently resets or records user-approved delete roots, syncs explicit closeout/cancel state, and closes the boot marker only when procedure-state is ready. Recover through explicit closeout cancellation, owner skill routing, or claim narrowing. |
| `permission-request-gate.sh` | repeat prompts for bounded structured edits that normal PreToolUse gates already allowed | PermissionRequest-only auto-allow surface; non-matching requests fall back to Claude Code permission handling. |
| `sv-gate.sh` | browser proof without current planning basis | Narrow Playwright proof edge only; use silent tracking when denial would prevent ledger repair; recover through work-planning or claim narrowing. |
| `worker-lifecycle-sync.sh` | teammate idle, completion, pending permission, pending dispatch, scope-pressure, or blocker signals becoming invisible or over-authoritative | TeammateIdle only; adds suppressed runtime context only when runtime state has a new lead-relevant idle or cleanup fact. It does not hard-deny. Recover through reuse, structured shutdown, blocker resolution, packet correction, or claim narrowing. |
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
