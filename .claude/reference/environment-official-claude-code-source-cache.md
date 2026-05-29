---
doc-type: reference-cache
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Environment Configuration Philosophy; Work Execution Philosophy official behavior alignment; skill/reference consumption"
captured: 2026-05-21
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# Official Claude Code Source Cache

## Purpose
Use this cached source map when checking whether local agent-team governance follows Claude Code's documented configuration and team-operation model.
Not always-loaded context. Refresh from official docs when current product behavior is decision-relevant, a source is contradicted, or cached behavior is stale.

## Resolve Next Owner And Action
- A current-product-behavior dependency opens official-document refresh.
- A contradicted cached fact opens official-document refresh.
- An unavailable current source downgrades the dependent claim to `UNVERIFIED` and continues non-dependent work; blocker-routing is valid only when exact current official behavior is required for the active deliverable and refresh cannot recover it.
- A lane needing official-source facts receives packetized relevant facts from `team-lead`.

## Consumer And Ownership
- Primary consumer: `team-lead`.
- Use only for official-document alignment checks, governance design reviews, and disputes where current Claude Code behavior matters.
- `CLAUDE.md` cites this cache as evidence location only; the cache is not part of always-on top doctrine.
- Lane agents do not consume this section by default. `team-lead` packetizes only the relevant official-source facts when a lane needs them.

## Source Map
## Agent Teams
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
- Agent teams add coordination overhead and context use; each teammate has its own context window, and token use scales with teammate count.
- Official team runtime resources are stored outside the project governance docs, including team config under `~/.claude/teams/{team-name}/config.json` and task lists under `~/.claude/tasks/{team-name}/`.
- Team cleanup is lead-owned; active teammates must be drained or shut down first.
- Current limitations include no nested teams, fixed lead, one team per session, task-status lag, slow shutdown, and in-process teammate resume/rewind gaps.

Governance implications:
- Constraint reports from a teammate are lead coordination input, not final completion; `.claude/skills/task-execution/references/message-classes.md` `## Upward Message Classes` owns the operative rule when this implication affects routing.
- Team runtime routing must preserve official limitations instead of hiding them behind local procedure labels; `.claude/skills/task-execution/references/runtime-dispatch-law.md` `## Team Runtime Shape` owns the operative rule when this implication affects dispatch.

## Agent Definition Files
Source: https://code.claude.com/docs/en/sub-agents

Cached facts:
- Agent definition files use YAML frontmatter followed by Markdown prompt content.
- Required frontmatter fields are `name` and `description`.
- Supported fields include `tools`, `disallowedTools`, `model`, `permissionMode`, `maxTurns`, `skills`, `initialPrompt`, `memory`, `effort`, `background`, `isolation`, and `color`.
- Project-level definitions live under `.claude/agents/`.
- Definitions from supported scopes are available to agent teams; when spawning a teammate, the teammate uses configured tools/model and receives the definition body as additional instructions.
- `initialPrompt` is auto-submitted when an agent runs as the main session through `--agent` or the `agent` setting.
- Agent-team teammate startup instructions must live in the definition body or spawn/assignment prompt.
- The `skills` frontmatter field preloads full skill content into the agent context at startup.
- When a subagent definition is used as a teammate, `skills` and `mcpServers` frontmatter do not apply to that teammate path; teammates load skills and MCP servers from project/user settings like a normal session.
- Team coordination tools remain available to teammates even when the subagent definition restricts ordinary tools.

Governance implications:
- Do not preload agent-specific skills through agent frontmatter when context footprint matters; prefer on-demand agent-specific skill loading in role instructions.
- Tool allowlists and disallowlists belong in agent frontmatter when they define role capability.
- Do not treat subagent `skills` or `mcpServers` frontmatter as a reliable teammate-runtime contract.

## Skills
Source: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview
Source: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices
Source: https://code.claude.com/docs/en/skills

Cached facts:
- A skill is a directory with `SKILL.md` containing YAML frontmatter and Markdown instructions.
- Skills are appropriate when repeated playbooks, checklists, or multi-step procedures would otherwise bloat `CLAUDE.md`.
- Unlike `CLAUDE.md`, a skill body loads only when used.
- Skill metadata is visible for discovery; full `SKILL.md` content loads when triggered; supporting resources load when required.
- Supporting files such as reference files, examples, or scripts keep `SKILL.md` focused and avoid loading large reference material until needed.
- Official documentation says to keep `SKILL.md` under 500 lines and move detailed reference material into separate files.
- `user-invocable: false` hides a skill from direct slash-command use while keeping it available as background knowledge when relevant.
- Invoked skill content stays in conversation context and can be carried through compaction within token budgets.
- Claude Code custom skills are filesystem-based and separate from Claude.ai/API skill uploads.
- Custom commands have been merged into skills. Existing `.claude/commands/` files still work, but official docs prefer skills because they support additional features such as supporting files.
- If a skill and command share a name, the skill takes precedence.

Governance implications:
- Use `user-invocable: false` for governance skills that are model-invoked rather than user-facing commands.
- Do not treat absence of `.claude/commands/` as a defect when the project uses equivalent skills.

## Hooks
Source: https://code.claude.com/docs/en/hooks

Cached facts:
- Hooks run configured handlers at Claude Code lifecycle events and tool events.
- Hook handler types include `command`, `http`, `mcp_tool`, `prompt`, and `agent`, with supported types varying by event.
- Command hook processes receive event JSON on stdin.
- Hook outputs can block or provide feedback depending on event type and output shape.
- Command hooks execute shell commands automatically with the user's environment permissions.
- Some hook events have no decision control.
- `PostToolUse` and async hooks cannot prevent the triggering action that already completed.
- Official security documentation emphasizes reviewing hook commands, sanitizing inputs, quoting variables, blocking path traversal, and using absolute paths.
- Hook changes in settings can require review/reload behavior before they affect an active session.

Governance implications:
- Hooks are valid for deterministic guardrails and runtime feedback, but they carry security and operational risk; `.claude/CLAUDE.md` `## 8. Environment Configuration Philosophy` and `.claude/reference/work-runtime-boundary-law.md` own operative hook-last rules when this implication affects hook governance.

## Memory, Rules, And Settings
Source: https://code.claude.com/docs/en/memory
Source: https://code.claude.com/docs/en/settings

Cached facts:
- `CLAUDE.md` and auto memory are context, not enforced configuration.
- Project instructions live at `./CLAUDE.md` or `./.claude/CLAUDE.md`.
- Long `CLAUDE.md` files consume context and reduce adherence; official documentation favors concise, specific, structured instructions.
- Official troubleshooting says `CLAUDE.md` files over 200 lines can reduce adherence.
- `.claude/rules/` can split instructions and scope them to paths.
- `@path` imports are an organization mechanism; imported files load into context at launch with the importing `CLAUDE.md`.
- `settings.json` is the official mechanism for technical configuration such as permissions, environment, hooks, and sandbox behavior.
- Settings priority is managed, command-line, local, project, then user.
- Array settings merge across scopes with de-duplication instead of whole-array replacement.

Governance implications:
- Do not claim `@imports` reduce launch context footprint; use them for organization, not lazy loading.
- Do not claim `CLAUDE.md` prose alone hard-enforces a behavior; use settings, permissions, sandbox, or hooks for technical enforcement.
- Keep project-shared team standards in `.claude/` project scope and machine-specific experimentation in local scope.
- Treat `.claude/rules/` as an official capability fact only; this repository has no live `.claude/rules/` owner surface unless a structural governance change introduces that directory and its consumption path.

## Use Rule
When a governance patch claims official-document alignment, cite the relevant source section from this cache in the internal basis.
If exact current wording matters, refresh from the official URL before making the claim.
