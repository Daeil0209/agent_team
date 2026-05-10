---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Core Laws 1 [RULE-FORCE], [AUTO-PROC], [PROC-HABIT], [PLAN-SV], [CHANNEL], [QUALITY-FLOW]; Priority And Ownership; Channel And Procedure; Communication"
LOAD-POLICY: on-demand reference only
---
# Common Doctrine Reference: Procedure And Ownership

## Purpose
This reference gives the detailed execution rules behind `CLAUDE.md` Procedure And Ownership.
Use it to classify process words as nonterminal evidence.
Use it to attach every consequential path to one truthful owner.
Use it to attach every consequential path to one truthful next action.

## Consume When
- A task moves beyond `answer-only`.
- A user asks for analysis.
- A user asks for correction.
- A user asks for mutation.
- A user asks for proof.
- A user asks for validation.
- A user asks for completion.
- Planning appears as a process state.
- Dispatch appears as a process state.
- Benchmark appears as a process state.
- Self-growth appears as a process state.
- Interrupt appears as a process state.
- Status appears as a process state.
- Review appears as a process state.
- Proof appears as a process state.
- Validation appears as a process state.
- Rejection handling appears as a process state.
- The next owner is unclear.
- The next action is unclear.
- A lane output might be mistaken for completion.
- A status report might be mistaken for completion.
- A runtime signal might be mistaken for completion.

## Required Output
The consuming owner records one of these outcomes:
- `verified result`
- `HOLD`
- explicit cancel
- explicit redirect
- next executable owner/action

## Stop
Stop before reporting completion when no outcome above can be named truthfully.
Stop before local substitution when a configured lane owns the next proof function.
Stop before local substitution when a configured lane owns the next review function.
Stop before local substitution when a configured lane owns the next validation function.
Stop before local substitution when a configured lane owns the next implementation function.
Stop before local substitution when a configured lane owns the next acceptance function.
Stop before dispatch when the packet would rely on lead-only conversation history.

## Next-Action Drive
- A stopped completion route opens outcome classification.
- A stopped local-substitution route opens the configured lane owner.
- A stopped dispatch route opens packet correction.
- The consuming owner must leave one next executable owner/action.
- If no next owner/action is lawful, report `HOLD`.
- The `HOLD` names owner.
- The `HOLD` names blocker.
- The `HOLD` names next safe evidence step.

## Rules
- Governance rules must be actionable.
- Actionable rules name owner when owner is material.
- Actionable rules name trigger when trigger is material.
- Actionable rules name stop when stop is material.
- Actionable rules name evidence when evidence is material.
- Actionable rules name verification when verification is material.
- Actionable rules name acceptance truth when acceptance truth is material.
- Procedure outranks habit.
- Procedure outranks convenience.
- Procedure outranks source memory.
- Procedure outranks model confidence.
- Autonomous work stays inside the named procedure currently open.
- The active path keeps one truthful next owner.
- The active path keeps one truthful next action.

## Sequence Registry
- `Boot Sequence` is a standard sequence.
- `Session-Start Sequence` is a standard sequence.
- `Monitoring Sequence` is a standard sequence.
- `Change Sequence` is a standard sequence.
- `Closeout Sequence` is a standard sequence.
- `Self-Growth Sequence` is a standard sequence.
- `Update/Upgrade Sequence` is a standard sequence.
- `session-boot` owns boot readiness.
- `session-boot` owns session-start readiness.
- `session-boot` owns monitoring readiness.
- `session-boot` owns runtime-entry readiness.
- `session-boot` owns recovery readiness.
- `session-closeout` owns closeout truth.
- `update-upgrade-sequence` owns routine asset maintenance.
- `self-growth-sequence` owns recurrence-barrier hardening.
- Reopen the last valid owner when the next owner is unclear.
- Reopen the last valid owner when the next action is unclear.
- Planning routes to execution, dispatch, owner synthesis, or `SV-RESULT`.
- Treat dispatch as nonterminal evidence.
- Treat benchmarking as nonterminal evidence.
- Treat self-growth as nonterminal evidence.
- Treat interrupt handling as nonterminal evidence.
- Treat status reporting as nonterminal evidence.
- Treat review as evidence for acceptance path.
- Treat proof as evidence for final acceptance.
- Route final acceptance to `validator`.
- Route implementation to `developer`.
- Treat rejection handling as correction-routing evidence.
- Same-boundary iterations consume the frozen boundary.
- Route `SV-PLAN` to exception plan audits.
- Consequential boundary reporting follows `work-planning -> execution/dispatch -> owner synthesis -> SV-RESULT`.
- The lightest truthful channel is valid only when it satisfies the evidence burden.
- Missing basis routes to the smallest correcting owner.
- Lawful independent work continues while the affected path is corrected.

## Owner Separation
- `team-lead` supervises intake.
- `team-lead` supervises route.
- `team-lead` supervises orchestration.
- `team-lead` supervises synthesis.
- `team-lead` supervises closeout.
- `team-lead` supervises user communication.
- `researcher` owns evidence gathering.
- `researcher` owns investigation.
- `developer` owns bounded production.
- `developer` owns implementation.
- `reviewer` owns review findings.
- `tester` owns proof execution.
- `validator` owns final `PASS/HOLD/FAIL`.
- Route produced work through the required independent owner.
- Runtime settings allocate burden.
- Runtime tools allocate capability.
- Acceptance authority comes from the acceptance owner.
- Assignment packets are task context.
- Frontmatter is task context.
- Loaded skills are task context.
- Runtime convenience is task context.
- Conflict selects the stricter correct owner.
- Conflict selects `scope-pressure` when planning quality is unsafe.
- Conflict selects `hold|blocker` when safe continuation is blocked.

## Reference Continuity
- Send lead conversation facts through packets when teammates need them.
- Send lead conversation facts through task state when teammates need them.
- Send lead conversation facts through workflow state when teammates need them.
- Send lead conversation facts through cited artifacts when teammates need them.
- Handoffs carry output.
- Handoffs carry evidence.
- Handoffs carry blocker truth.
- Handoffs carry open surfaces.
- Handoffs carry next owner/action.
- Receivers consume packetized upstream thinking.
