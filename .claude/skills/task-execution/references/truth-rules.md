---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
DELETE-PENDING-COMPLIANCE-HOOK-REVIEW: true
---

# task-execution: Truth Rules

> DELETE-PENDING-COMPLIANCE-HOOK-REVIEW: this file is a thin pointer reference scheduled for deletion per `claude_doc/governance-audit-2026-05-27/promotion/promotion-catalog.md` P4.4 (B-19 finding). Content is canonically owned by the surfaces cited in the body below. All 4 prior live citations have been cleared:
> - `.claude/skills/agent-team-lead/SKILL.md:72` (Wave 3 Batch F-1) — rewritten to drop the truth-rules.md half (message-classes.md retained as canonical message-class truth owner).
> - `.claude/skills/task-execution/SKILL.md:174` (Wave 3 Batch F-2) — redundant bullet removed because SKILL.md:40 Reference Map already covers the full canonical lookup chain via message-classes.md + runtime-state-detail.md + runtime-dispatch-law.md + reporting-prohibition-law.md.
> - `.claude/skills/task-execution/references/runtime-dispatch-law.md:115` (Wave 2+3 Correction F-1) — `per truth-rules.md` clause dropped; the rule "assignment-grade `SendMessage` is for bounded assignment, reroute, or reuse against an open executable task" is self-contained, and the immediately following bullet (line 116) already cites `message-classes.md` `### Assignment Delivery Contract` as the canonical owner.
> - `.claude/reference/reporting-prohibition-law.md:65` (task 41 L1) — Detail Owners pointer redirected to canonical owners directly: `.claude/skills/task-execution/references/message-classes.md` `### Receipt Event Contract` and `### Transport Payload` (state-token canonical envelope) + `.claude/skills/session-boot/references/runtime-state-detail.md` `## Canonical Runtime-State Model` and `## Agent Work States` (runtime-state vocabulary). Constitutional Curtain Protection 4-step procedure applied (Step 1 active dispatch + Step 2 validator pre-approval + Step 3 user notification + Step 4 absence-of-objection per task 41 packet).
>
> Final state: ZERO incoming citations from `.claude/*`; file is fully orphan. Pre-deletion requirements satisfied. Final deletion blocked only by compliance-supervisor.sh hook policy (`USER_APPROVED_DELETE_ROOTS_FILE` authorization required for governance-restricted file rm). Pending operator action: add `.claude/skills/task-execution/references/truth-rules.md` to `$USER_APPROVED_DELETE_ROOTS_FILE` then `rm .claude/skills/task-execution/references/truth-rules.md`.

Runtime-state vocabulary, runtime truth classification, dispatch-pending/ack/start labels, recovery classification, and canonical evidence mapping live at `.claude/skills/session-boot/references/runtime-state-detail.md` `## Canonical Runtime-State Model` and `## Agent Work States`.
Dispatch-ack receipt semantics, completion transport semantics, one-state-signal envelope, and task-scoped tool identity requirements live at `.claude/skills/task-execution/references/message-classes.md` `### Receipt Event Contract`, `### Transport Payload`, and `### Assignment Delivery Contract`.
User-facing dispatch status exception lives at `.claude/reference/reporting-prohibition-law.md`; reporting-law-excepted dispatch status cites the narrowest proven truth label from the canonical owners above.

Dispatch-creation truth (member-created semantics) canonically owned at `.claude/skills/task-execution/references/runtime-dispatch-law.md` `## Team Runtime Shape`; consume that section for team-scoped Agent success → member-created → assignment-grade SendMessage flow.

## Resolve Next Owner And Action
- Active runtime-state, dispatch, ack, recovery, or work-state question consumes the named canonical owner above.
- `member-created` or `TeamCreate` next-action question consumes `.claude/skills/task-execution/references/runtime-dispatch-law.md` `## Team Runtime Shape`.
