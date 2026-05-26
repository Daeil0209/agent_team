---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# task-execution: Truth Rules
Runtime-state vocabulary, runtime truth classification, dispatch-pending/ack/start labels, recovery classification, and canonical evidence mapping live at `.claude/skills/session-boot/references/runtime-state-detail.md` `## Canonical Runtime-State Model` and `## Agent Work States`.
Dispatch-ack receipt semantics, completion transport semantics, one-state-signal envelope, and task-scoped tool identity requirements live at `.claude/skills/task-execution/references/message-classes.md` `### Receipt Event Contract`, `### Transport Payload`, and `### Assignment Delivery Contract`.
User-facing dispatch status exception lives at `.claude/reference/reporting-prohibition-law.md`; reporting-law-excepted dispatch status cites the narrowest proven truth label from the canonical owners above.

Dispatch-creation truth (member-created semantics) canonically owned at `.claude/skills/task-execution/references/runtime-dispatch-law.md` `## Team Runtime Shape`; consume that section for team-scoped Agent success → member-created → assignment-grade SendMessage flow.

## Resolve Next Owner And Action
- Active runtime-state, dispatch, ack, recovery, or work-state question consumes the named canonical owner above.
- `member-created` or `TeamCreate` next-action question consumes `.claude/skills/task-execution/references/runtime-dispatch-law.md` `## Team Runtime Shape`.
