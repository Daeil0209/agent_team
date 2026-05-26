---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
DELETE-PENDING-COMPLIANCE-HOOK-REVIEW: true
---

# task-execution: Truth Rules

> DELETE-PENDING-COMPLIANCE-HOOK-REVIEW: this file is a thin pointer reference scheduled for deletion per `claude_doc/governance-audit-2026-05-27/promotion/promotion-catalog.md` P4.4 (B-19 finding). Content is canonically owned by the surfaces cited in the body below. 2 of the 3 prior live citations were cleared in Wave 3 Batch F (`agent-team-lead/SKILL.md:72` rewritten to drop the truth-rules.md half; `task-execution/SKILL.md:174` removed because SKILL.md:40 Reference Map already covers the canonical lookup chain). The remaining citation lives at:
> - `.claude/reference/reporting-prohibition-law.md:65` (Detail Owners pointer — file is PROTECTED-CURTAIN-SURFACE; citation update requires validator pre-approval + user notification per `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection`; explicitly deferred per Wave 3 packet `### Batch F` `DEFER reporting-prohibition-law.md:65` clause).
>
> Pre-deletion requirements: update the remaining PROTECTED-CURTAIN-SURFACE citer under the constitutional gates above, then delete this file. The single citation update is an OPEN-SURFACE handed off to team-lead for separate dispatch under the protection gates.

Runtime-state vocabulary, runtime truth classification, dispatch-pending/ack/start labels, recovery classification, and canonical evidence mapping live at `.claude/skills/session-boot/references/runtime-state-detail.md` `## Canonical Runtime-State Model` and `## Agent Work States`.
Dispatch-ack receipt semantics, completion transport semantics, one-state-signal envelope, and task-scoped tool identity requirements live at `.claude/skills/task-execution/references/message-classes.md` `### Receipt Event Contract`, `### Transport Payload`, and `### Assignment Delivery Contract`.
User-facing dispatch status exception lives at `.claude/reference/reporting-prohibition-law.md`; reporting-law-excepted dispatch status cites the narrowest proven truth label from the canonical owners above.

Dispatch-creation truth (member-created semantics) canonically owned at `.claude/skills/task-execution/references/runtime-dispatch-law.md` `## Team Runtime Shape`; consume that section for team-scoped Agent success → member-created → assignment-grade SendMessage flow.

## Resolve Next Owner And Action
- Active runtime-state, dispatch, ack, recovery, or work-state question consumes the named canonical owner above.
- `member-created` or `TeamCreate` next-action question consumes `.claude/skills/task-execution/references/runtime-dispatch-law.md` `## Team Runtime Shape`.
