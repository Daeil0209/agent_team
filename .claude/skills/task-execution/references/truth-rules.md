---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
DELETE-PENDING-COMPLIANCE-HOOK-REVIEW: true
---

# task-execution: Truth Rules

> DELETE-PENDING-COMPLIANCE-HOOK-REVIEW: this file is a thin pointer reference scheduled for deletion per `claude_doc/governance-audit-2026-05-27/promotion/promotion-catalog.md` P4.4 (B-19 finding). Content is canonically owned by the surfaces cited in the body below; this file remains in place only because the following live citations sit outside the Phase 4-7 Wave 2 remaining-patches packet WRITE-SCOPE:
> - `.claude/reference/reporting-prohibition-law.md:65` (Detail Owners pointer — file is PROTECTED-CURTAIN-SURFACE; citation update requires validator pre-approval + user notification per `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection`).
> - `.claude/skills/agent-team-lead/SKILL.md:72` (Owning Skills pointer).
> - `.claude/skills/task-execution/SKILL.md:174` (Step 3 Dispatch Truth pointer; SKILL.md:40 Reference Map already covers the full canonical lookup chain, so :174 can be dropped without loss).
>
> Pre-deletion requirements: update the 3 citers above to point directly at the canonical owners cited in the body, then delete this file. The 3 citation updates are OPEN-SURFACES handed off to team-lead for separate dispatch.

Runtime-state vocabulary, runtime truth classification, dispatch-pending/ack/start labels, recovery classification, and canonical evidence mapping live at `.claude/skills/session-boot/references/runtime-state-detail.md` `## Canonical Runtime-State Model` and `## Agent Work States`.
Dispatch-ack receipt semantics, completion transport semantics, one-state-signal envelope, and task-scoped tool identity requirements live at `.claude/skills/task-execution/references/message-classes.md` `### Receipt Event Contract`, `### Transport Payload`, and `### Assignment Delivery Contract`.
User-facing dispatch status exception lives at `.claude/reference/reporting-prohibition-law.md`; reporting-law-excepted dispatch status cites the narrowest proven truth label from the canonical owners above.

Dispatch-creation truth (member-created semantics) canonically owned at `.claude/skills/task-execution/references/runtime-dispatch-law.md` `## Team Runtime Shape`; consume that section for team-scoped Agent success → member-created → assignment-grade SendMessage flow.

## Resolve Next Owner And Action
- Active runtime-state, dispatch, ack, recovery, or work-state question consumes the named canonical owner above.
- `member-created` or `TeamCreate` next-action question consumes `.claude/skills/task-execution/references/runtime-dispatch-law.md` `## Team Runtime Shape`.
