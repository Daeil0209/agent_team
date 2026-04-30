# self-growth-sequence: Governance Architecture Map
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Use this map to choose the owner surface before drafting. Do not place a rule where it is merely convenient.

| Governance need | Primary owner surface |
|---|---|
| Shared philosophy, priority, top-level ownership, preservation law | `.claude/CLAUDE.md` |
| Team-lead trigger, route, orchestration, synthesis, reporting, interruption, self-growth adjudication | `.claude/agents/team-lead.md` |
| Detailed team-lead edge cases that would bloat the role spine | `.claude/skills/team-lead/SKILL.md` |
| Lane charter, always-loaded receipt trigger, stop rule, and lane-owned completion duty | `.claude/agents/<lane>.md` |
| Lane execution procedure, lane-local gates, and direct pointer to detail references | `.claude/skills/<lane>/SKILL.md` |
| Lane packet additions, specialist matrices, tool/proof detail, and handoff field detail | `.claude/skills/<lane>/references/*.md` |
| Packet schema, message classes, lifecycle truth, dispatch preflight, completion spine | `.claude/skills/task-execution/references/assignment-packet.md`, `.claude/skills/task-execution/references/message-classes.md`, `.claude/skills/task-execution/references/truth-rules.md`, `.claude/skills/task-execution/references/completion-handoff.md` |
| Consequential planning freeze and route basis | `.claude/skills/work-planning/SKILL.md` |
| Plan/result verification gates | `.claude/skills/self-verification/SKILL.md` |
| Session boot, runtime entry, monitoring, lifecycle interpretation | `.claude/skills/session-boot/SKILL.md` and `.claude/skills/session-boot/references/runtime-state-detail.md` |
| Closeout teardown and residual truth | `.claude/skills/session-closeout/SKILL.md` and `.claude/skills/session-closeout/references/closeout-state-detail.md` |
| Repeatable workflow or specialist methodology | owning `.claude/skills/<skill>/SKILL.md`; long lookup detail in that skill's direct `references/*.md` files when present |
| Technical enforcement, advisory guards, deterministic runtime checks | `.claude/hooks/` or `.claude/settings*.json` |
| Official-source cache or preservation traceability | `.claude/reference/` |

Reference files are lookup surfaces, not hidden always-on doctrine. A `SKILL.md` spine must keep the activation trigger, owner, stop rule, and instruction to load the direct reference file when the detailed lookup is required.
