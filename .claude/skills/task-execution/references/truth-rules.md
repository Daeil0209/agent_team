---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Truth Rules
- team-agent runtime creation success = `team exists`
- team-scoped `Agent` or assignment-grade `SendMessage` success with open executable task state when tracking is active = `dispatch pending`
- open executable task state means `pending`, `in_progress`, or equivalent open state; it excludes completed, closed, cancelled, missing, and unknown ids
- standalone `Agent` success, if encountered as legacy, fallback, or accidental host evidence, = fallback evidence only, not team-runtime `dispatch pending`, live roster membership, lifecycle state, or later `SendMessage` addressability
- `dispatch-ack` = receipt only, not start/progress/work evidence
- `control-ack` = control receipt only
- Task-scoped tools require exact task id and current task state from `TaskList`, `TaskGet` on a confirmed existing id, a returned `TaskCreate` or `TaskUpdate` result, the `task_assignment` packet, or the task file itself; never infer task id or openness from phase order, agent role, next numeric value, or same-batch tool intent.
- `agent started` requires agent-side action or agent-originated progress beyond receipt
- if team-agent operation is frozen and canonical team-existence evidence is absent, the next consequential action is `TeamCreate`; only after team existence is proven may team-scoped `Agent` launch or assignment-grade message create dispatch-pending state
- user-facing output may report only the narrowest proven state
