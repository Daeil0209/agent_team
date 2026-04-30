# Hook Manifest

## Purpose
This directory contains Claude Code runtime guardrails for the active project.
Hooks are the last enforcement layer. Doctrine, skills, role contracts, and
truthful procedure execution remain the primary control surfaces.

## Operating Rules
- Keep active hooks narrow, observable, and owner-specific.
- Prefer warning or tracking output when the procedure can recover without
blocking.
- Use `permissionDecision: "deny"` only for clear unsafe, wrong-owner,
destructive, or procedure-breaking actions.
- Hard deny is reserved for secrets/credentials exposure, destructive or
unapproved deletion, `.claude` governance shell mutation or wholesale overwrite,
runtime/team-state corruption, exact task-state corruption, read-only reference
mutation, and interpreter-based filesystem mutation that bypasses structured
edit surfaces.
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
This ledger is the current hook-owned review record for active blocking guardrails.
It is not runtime-cost proof. Update it whenever an active hook adds a broader
matcher, new hard deny, or higher-frequency blocking path.

Broad `settings.json` matchers are tolerated only when the script performs the
narrow semantic match internally and reports a lawful recovery path. If a
legitimate lane action is blocked, treat that as a `[BLOCK-AS-DEFECT]` candidate
before adding more hook logic.

| Hook | Protected failure | Narrowness and recovery record |
| --- | --- | --- |
| `agent-activity-monitor.sh` | live agent activity, heartbeat, and runtime pressure signals becoming invisible or stale | Activity/runtime state surface only; recover through status read, monitoring, reroute, or session-runtime recovery rather than assuming progress. |
| `permission-request-gate.sh` | unsafe permission approval on protected governance, runtime, or secret-adjacent surfaces | PermissionRequest-only surface; recover through structured edit, explicit approval, or the owning procedure. |
| `task-start-gate.sh` | consequential work starting without required procedure/runtime state | Broad tool matcher, narrow procedure-state checks inside script; recover by opening the missing owner instead of retrying the tool. |
| `sv-gate.sh` | consequential mutation, dispatch, redispatch, or report path bypassing current SV gate | High-risk tools only; warning is preferred when denial would prevent ledger repair; recover by running the current `self-verification` target or narrowing the claim. |
| `runtime-entry-gate.sh` | team-runtime dispatch before session boot/runtime-entry basis is valid | Runtime/dispatch tools only; recover through `session-boot` or lawful non-runtime path. |
| `dispatch-sizing-gate.sh` | oversized or mixed-purpose agent packet creating overload or hidden merge risk | `Agent` only; recover by decomposition or route freeze before dispatch. |
| `dispatch-proof-gate.sh` | agent dispatch without enough proof, acceptance, or packet basis | `Agent` only; recover through `work-planning`, `self-verification`, or `task-execution` packet repair. |
| `task-created-gate.sh` | task creation without the minimum bounded-scope and completion coordinates | TaskCreate surface only; recover by creating a bounded task packet with subject, scope coordinate, and completion coordinate. |
| `task-completed-gate.sh` | task completion claim without completion-grade evidence or unresolved-debt handling | Task completion surface only; recover by updating evidence/open-surface state or leaving the task incomplete. |
| `validate-task-target.sh` | task tool actions against wrong, stale, or weakly identified task/output target | Task tool surface only; recover by using the exact task id or preferred output-read path. |
| `compliance-supervisor.sh` | `.claude` governance shell mutation, protected reference mutation, destructive cleanup, disallowed output roots, hook-runtime artifacts, or interpreter-based filesystem bypass | Mutation-capable tools only; recover through structured edit, approved cleanup, or repo-root project output paths. |

## Support Scripts
These files are not necessarily wired directly, but active hooks call or source
them. They must not be removed unless their callers are updated in the same
patch.

- `hook-config.sh`
- `hook-config-core.sh`
- `cleanup-orphan-runtime.sh`
- `runtime-pressure-scan.sh`
- `health-check.sh`
- `mark-force-stop.sh`
- `lib/*.sh`
- `lib/generated-command-policy.js`

## Absorbed Scripts
Absorbed scripts must not remain as runnable top-level hook surfaces. Their
current behavior belongs to the active owner named here.

- `sync-worker-lifecycle-state.sh` -> `worker-lifecycle-sync.sh`
- `cleanup-terminated-panes.sh` -> `worker-lifecycle-sync.sh`
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
