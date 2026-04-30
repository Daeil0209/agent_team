---
doc-type: reference-cache
PRIMARY-OWNER: team-lead
captured: 2026-04-29
LOAD-POLICY: on-demand reference only
---
# Official Claude Code Reference Cache

## Purpose
Use this cached source map when checking whether local agent-team governance follows Claude Code's documented configuration and team-operation model.
This file is not always-loaded context. Refresh from official docs only when behavior may have changed, a source is contradicted, or a decision depends on current product behavior.

## Consumer And Ownership
- Primary consumer: `team-lead`.
- Use only for official-document alignment checks, governance design reviews, and disputes where current Claude Code behavior matters.
- `CLAUDE.md` may cite this cache as evidence location, but the cache is not part of always-on top doctrine.
- Lane agents do not load this file by default. `team-lead` packetizes only the relevant official-source facts when a lane needs them.

## Source Map
### Agent Teams
Source: https://code.claude.com/docs/en/agent-teams

Cached facts:
- Agent teams are enabled through `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`.
- Agent teams are experimental and have known limitations around session resumption, task coordination, and shutdown behavior.
- The lead creates the team, spawns teammates, coordinates work, synthesizes findings, and attempts cleanup.
- The lead handles team coordination, task assignment, and delegation from natural-language user instructions.
- Teammates are full independent Claude Code sessions and can be messaged or redirected.
- Teammates load project context and assignment prompt, but not the lead's conversation history.
- Agent teams support shared task lists; tasks can be assigned by lead or claimed by teammates, and task dependencies can block claiming until prerequisites complete.
- Complex or risky teammate work can require plan approval before implementation; the lead approves or rejects the plan.
- Strong team-use cases are parallel research/review, new independent modules or features, competing-hypothesis debugging, and cross-layer coordination.
- Poor team-use cases include sequential work, same-file edits, and dependency-heavy tasks where coordination overhead exceeds parallel value.
- Agent teams add coordination overhead and use significantly more tokens than a single session; each teammate has its own context window, and token costs scale with teammate count.
- Official team runtime resources are stored outside the project governance docs, including team config under `~/.claude/teams/{team-name}/config.json` and task lists under `~/.claude/tasks/{team-name}/`.
- Team cleanup is lead-owned; active teammates must be drained or shut down first.
- Current limitations include no nested teams, fixed lead, one team per session, task-status lag, slow shutdown, and in-process teammate resume/rewind gaps.

Governance implications:
- Team-lead orchestration, corrected assignment packets, teammate messaging, and re-dispatch after constraints are consistent with documented agent-team operation.
- Constraint reports from a teammate should be consumed by the lead as coordination input, not as final completion.
- Parallel or independent work should be represented as team work when the task shape benefits from multiple perspectives or concurrent execution.
- Assignment packets must not rely on lead-only conversation history because teammates do not inherit it.
- Team runtime routing must preserve official limitations instead of hiding them behind local procedure labels.
- Project-local continuity notes such as `.claude/session-state.md` must not be treated as official agent-team runtime config, task list, mailbox, or cleanup state.

### Agent Definition Files
Source: https://code.claude.com/docs/en/sub-agents

Cached facts:
- Agent definition files use YAML frontmatter followed by Markdown prompt content.
- Required frontmatter fields are `name` and `description`.
- Supported fields include `tools`, `disallowedTools`, `model`, `permissionMode`, `maxTurns`, `skills`, `initialPrompt`, `memory`, `effort`, `background`, `isolation`, and `color`.
- Project-level definitions live under `.claude/agents/`.
- Definitions from supported scopes are available to agent teams; when spawning a teammate, the teammate uses configured tools/model and receives the definition body as additional instructions.
- The `skills` frontmatter field preloads full skill content into the agent context at startup.
- When a subagent definition is used as a teammate, `skills` and `mcpServers` frontmatter do not apply to that teammate path; teammates load skills and MCP servers from project/user settings like a normal session.
- Team coordination tools remain available to teammates even when the subagent definition restricts ordinary tools.

Governance implications:
- Keep role files focused because their Markdown body is instruction context for the teammate.
- Do not preload lane-core skills through agent frontmatter when context cost matters; prefer on-demand lane-core skill loading in role instructions.
- Tool allowlists and disallowlists belong in agent frontmatter when they define role capability.
- Do not treat subagent `skills` or `mcpServers` frontmatter as a reliable teammate-runtime contract.

### Skills
Source: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview
Source: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices
Source: https://code.claude.com/docs/en/skills

Cached facts:
- A skill is a directory with `SKILL.md` containing YAML frontmatter and Markdown instructions.
- Skills are appropriate when repeated playbooks, checklists, or multi-step procedures would otherwise bloat `CLAUDE.md`.
- Unlike `CLAUDE.md`, a skill body loads only when used.
- Skill metadata is visible for discovery; full `SKILL.md` content loads when triggered; supporting resources load only as needed.
- Supporting files such as reference files, examples, or scripts keep `SKILL.md` focused and avoid loading large reference material until needed.
- Official guidance says to keep `SKILL.md` under 500 lines and move detailed reference material into separate files.
- `user-invocable: false` hides a skill from direct slash-command use while keeping it available as background knowledge when relevant.
- Invoked skill content stays in conversation context and may be carried through compaction within token budgets.
- Claude Code custom skills are filesystem-based and separate from Claude.ai/API skill uploads.
- Custom commands have been merged into skills. Existing `.claude/commands/` files still work, but skills are recommended because they support additional features such as supporting files.
- If a skill and command share a name, the skill takes precedence.

Governance implications:
- Move detailed procedure and source notes out of always-loaded doctrine into on-demand skills or reference files.
- Keep high-frequency role and lane-core skills concise; put detailed edge-case mechanics into direct reference files such as `references/*.md` rather than nested lookup chains.
- Use `user-invocable: false` for governance skills that should be model-invoked rather than user-facing commands.
- Do not treat absence of `.claude/commands/` as a defect when the project uses equivalent skills.

### Plugins
Source: https://code.claude.com/docs/en/plugins

Cached facts:
- Plugins package and share Claude Code extensions such as skills, agents, commands, hooks, settings, and MCP servers.
- Plugins are useful for reusable or distributed extension bundles.

Governance implications:
- Plugin packaging is an optional distribution/reuse mechanism, not a required single-project governance structure.
- Treat plugin absence as a future packaging option unless the deliverable explicitly requires reuse across projects or users.

### Hooks
Source: https://code.claude.com/docs/en/hooks

Cached facts:
- Hooks run configured commands at Claude Code lifecycle events and tool events.
- Hook outputs can block or provide feedback depending on event type and output shape.
- Hooks execute shell commands automatically with the user's environment permissions.
- Some hook events cannot block execution; `PostToolUse` feedback happens after the tool already ran.
- Official security guidance emphasizes reviewing hook commands, sanitizing inputs, quoting variables, blocking path traversal, and using absolute paths.
- Hook changes in settings may require review/reload behavior before they affect an active session.

Governance implications:
- Hooks are valid for deterministic guardrails and runtime feedback, but they carry security and operational risk.
- Hooks should not replace agent-team judgment, planning, role ownership, or positive execution discipline.
- Use hooks for last-resort blocking of prohibited actions or runtime integrity checks, not for normal task routing.

### Memory, Rules, And Settings
Source: https://code.claude.com/docs/en/memory
Source: https://code.claude.com/docs/en/settings

Cached facts:
- `CLAUDE.md` and auto memory are context, not enforced configuration.
- Project instructions may live at `./CLAUDE.md` or `./.claude/CLAUDE.md`; `AGENTS.md` is not read unless imported from `CLAUDE.md`.
- Long `CLAUDE.md` files consume context and reduce adherence; official guidance favors concise, specific, structured instructions.
- `.claude/rules/` can split instructions and scope them to paths.
- `@path` imports are an organization mechanism; imported files load into context at launch with the importing `CLAUDE.md`.
- `settings.json` is the official mechanism for technical configuration such as permissions, environment, hooks, and sandbox behavior.
- Settings priority is managed, command-line, local, project, then user.

Governance implications:
- Keep always-on doctrine concise and move repeatable procedures into skills or scoped rules.
- Do not claim `@imports` reduce launch context cost; use them for organization, not lazy loading.
- Do not claim `CLAUDE.md` prose alone hard-enforces a behavior; use settings, permissions, sandbox, or hooks for technical enforcement.
- Keep project-shared team standards in `.claude/` project scope and machine-specific experimentation in local scope.

## Use Rule
When a governance patch claims official-document alignment, cite the relevant source section from this cache in the internal basis. If exact current wording matters, refresh from the official URL before making the claim.
