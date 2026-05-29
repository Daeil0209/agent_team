---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Environment Configuration Philosophy"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# 8. Environment Configuration Core Law
## Reference Map
- `.claude/reference/environment-official-claude-code-source-cache.md`: load when official Claude Code behavior, documented team-runtime behavior, or source freshness is decision-relevant.
- `.claude/reference/environment-runtime-footprint-continuity.md`: load when hook footprint, generated continuity files, agent-team runtime overhead, or runtime-footprint claims are material.
- `.claude/reference/work-runtime-boundary-law.md`: load when hook/settings enforcement, runtime signal, tool signal, external capability, or runtime-owned surface boundaries affect the execution path.
- `.claude/reference/modification-minimal-governance-change-law.md`: load when governance-text patch selection is material to hook, settings, runtime, or tool-capability changes.
- `.claude/reference/environment-output-root-filesystem-law.md`: load when project output-root placement, generated files, source edits, governance edits, or filesystem boundaries are material.
- `Skill(tool-acquisition)`: load when current toolset limits, missing tool path, or bounded setup materially blocks the active owner path.
- `Skill(external-tool-bridge)`: load when tool recovery requires external API, MCP, auth, quota, credential, paid, persistent-service, or external bridge work.
- `Skill(task-execution)` -> `references/message-classes.md`: consume through active `Skill(task-execution)` when shared task-list identity, structured `shutdown_request`, Communication Plane runtime-cleanup transport, or termination proof affects runtime cleanup truth.
- `Skill(task-execution)` -> `references/runtime-dispatch-law.md`: consume through active `Skill(task-execution)` when lane-member cleanup, reuse-before-cleanup, structured shutdown routing, or active-team runtime cleanup affects the next owner/action.

## Runtime Boundary Law
- Runtime state, including team runtime state, is runtime-owned and stays out of project governance documents.
- `[HOOK-LAST]` hooks are last-resort runtime guards.
- Team-lead coordination, shared task lists, teammate messaging, and team cleanup follow Claude Code agent-team behavior.
- Shared task-list creation, identity, mutation, and closure rules are owned by `.claude/skills/task-execution/references/message-classes.md` `### Assignment Delivery Contract`.
- Generic Claude Code in-progress, owner, or assignee task-row mutation patterns do not apply.
- Teammate work uses independent Claude Code session context and task-specific packets.
- Cooperative `shutdown_request` to a live process-backed teammate is routine runtime cleanup when `task-execution`, `session-boot`, or `session-closeout` owns a cleanup basis.
- `tmux kill-*` command forms are categorical hard-deny runtime surfaces.
- Cleanup after a blocked `tmux kill-*` selection uses cooperative shutdown, session-closeout, or non-tmux owner recovery.
- Non-tmux forceful runtime termination such as `kill <pid>` requires explicit operator approval and the narrow runtime cleanup owner.
- Hook-owned shutdown-response handling records cooperative cleanup evidence and runtime roster state without `tmux kill-*`.
- Agent-authored shell teardown routes to forceful runtime termination law, and closeout truth stays with `session-closeout`.

## Resolve Next Owner And Action
- Official Claude Code behavior, documented team-runtime behavior, or source freshness dependence opens `.claude/reference/environment-official-claude-code-source-cache.md` or official-source refresh.
- Hook, settings, runtime signal, tool signal, external capability, or runtime-owned boundary gaps open `.claude/reference/work-runtime-boundary-law.md`.
- Missing tool path or current-toolset gap that materially blocks the active owner path opens `Skill(tool-acquisition)`; external bridge risk opens `Skill(external-tool-bridge)`.
- Output placement, generated-file, source-edit, governance-edit, or filesystem-boundary gaps open `.claude/reference/environment-output-root-filesystem-law.md`.
- Runtime cleanup using structured communication opens active `Skill(task-execution)` consumption of `references/message-classes.md` and `references/runtime-dispatch-law.md`.
- Teardown truth opens `Skill(session-closeout)`.
- A current owner/action for settings, hook, runtime-enforcement, or governance asset change opens `Skill(governance-modification)`.
