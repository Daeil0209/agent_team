---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
---

# task-execution: Truth Rules
- team-agent runtime creation success = `team exists`
- team-scoped `Agent` success = `member-created`; it is not `dispatch pending` and creates no `dispatch-ack` debt
- assignment-grade `SendMessage` success with open executable task state when tracking is active = `assignment-sent-no-ack` (`dispatch pending`)
- open executable task state means `pending`, `in_progress`, or equivalent open state; it excludes completed, closed, cancelled, missing, and unknown ids
- standalone `Agent` success, if encountered as legacy, fallback, or accidental host evidence, = fallback evidence only, not team-runtime `dispatch pending`, live roster membership, lifecycle state, or later `SendMessage` addressability
- `dispatch-ack` = receipt only, not start/progress/work evidence
- `control-ack` = control receipt only
- Task-scoped tools require exact task id and current task state from `TaskList`, `TaskGet` on a confirmed existing id, a returned `TaskCreate` or `TaskUpdate` result, the `task_assignment` packet, or the task file itself; never infer task id or openness from phase order, agent role, next numeric value, or same-batch tool intent.
- `agent started` requires agent-side action or agent-originated progress beyond receipt
- if team-agent operation is frozen and canonical team-existence evidence is absent, the next consequential action is `TeamCreate`; team-scoped `Agent` launch creates `member-created` only after team existence is proven, and assignment-grade `SendMessage` creates `dispatch pending` only after exact live member addressability is proven
- user-facing reporting is admitted only by `.claude/reference/user-reporting-law.md`; any admitted report cites only the narrowest proven state

## Resolve Next Owner And Action
- `team exists` opens missing member creation or assignment messaging to an existing live member.
- `member-created` opens assignment-grade `SendMessage`; it is not a running, ack-pending, or work-started state.
- `dispatch pending` opens receipt reconciliation through `session-boot`.
- `dispatch-ack` opens lane work or receipt recovery.
- `agent started` opens lane execution monitoring.
- Fallback standalone evidence opens team-lead bounded-evidence synthesis only.
- Missing team-existence evidence opens `TeamCreate` through `task-execution`.
- Unknown task state opens task-state verification before dispatch truth.
- `.claude/reference/user-reporting-law.md` governs whether a user report exists; narrow proven state governs any admitted report claim.
