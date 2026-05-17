---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Core Laws 1 [RULE-FORCE], [AUTO-PROC], [PROC-HABIT], [PLAN-SV]; Priority And Ownership; Channel And Procedure; Communication"
LOAD-POLICY: on-demand reference only
---
# Common Doctrine Reference: Procedure And Ownership

## Purpose
This reference gives the detailed execution rules behind `CLAUDE.md` Procedure And Ownership.
Use it to:
- classify process words as nonterminal evidence
- attach every consequential path to one truthful owner and next action

## Reporting Curtain Inheritance
This reference governs procedure movement, not report admission.
User-facing prose is owned by `.claude/reference/user-reporting-law.md`.

## Consume When
- A task moves beyond `answer-only`.
- A user asks for:
  - correction
  - mutation
  - proof
  - validation
  - completion
- These appear as process states:
  - planning
  - dispatch
  - benchmark
  - governance-change
  - interrupt
  - status
  - review
  - proof
  - validation
  - rejection handling
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
Stop before local substitution when a configured lane owns the next:
- proof function
- review function
- validation function
- implementation function
- acceptance function
Stop before dispatch when the packet would rely on lead-only conversation history.

## Resolve Next Owner And Action
- A stopped completion route opens outcome classification.
- A stopped local-substitution route opens the configured lane owner.
- A stopped dispatch route opens packet correction.
- The consuming owner must leave one next executable owner/action.
- If no next owner/action is lawful, report `HOLD`.
- The `HOLD` names:
  - owner
  - blocker
  - next safe evidence step

## Rules
- Governance documents are operating-rule surfaces, not passive surfaces.
- A rule in an active governance document is a mandatory operating rule.
- A loaded owner document rule is mandatory while that owner context is active.
- A trigger-bound reference rule is mandatory while its trigger is active.
- Do not weaken active governance rules into lower-force labels.
- If an active governance rule is unclear, route to the owning correction path instead of ignoring it.
- Violating an active governance rule is a procedural defect unless the owning rule names a lawful exception.
- Governance rules must be executable.
- Executable rules name owner when owner is material.
- Executable rules name trigger when trigger is material.
- Executable rules name stop when stop is material.
- Executable rules name evidence when evidence is material.
- Executable rules name verification when verification is material.
- Executable rules name acceptance truth when acceptance truth is material.
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
- `Change Sequence` is a standard support sequence.
- `Closeout Sequence` is a standard sequence.
- `Governance Change Sequence` is a standard sequence.
- `session-boot` owns boot readiness.
- `session-boot` owns session-start readiness.
- `session-boot` owns monitoring readiness.
- `session-boot` owns runtime-entry readiness.
- `session-boot` owns recovery readiness.
- `session-closeout` owns closeout truth.
- `governance-change` owns routine asset maintenance and recurrence-barrier hardening.
- `governance-change` owns `Change Sequence` patch mechanics.
- Reopen the last valid owner when the next owner is unclear.
- Reopen the last valid owner when the next action is unclear.
- Planning routes to execution, dispatch, owner synthesis, or `SV-RESULT`.
- Treat dispatch as nonterminal evidence.
- Treat benchmarking as nonterminal evidence.
- Treat governance-change as nonterminal evidence.
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
- `team-lead` owns intake.
- `team-lead` owns route.
- `team-lead` owns orchestration.
- `team-lead` owns synthesis.
- `team-lead` owns closeout.
- `team-lead` owns user communication.
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
- Send lead conversation facts through these surfaces when teammates need them:
  - packets
  - task state
  - workflow state
  - cited artifacts
- Handoffs carry:
  - output
  - evidence
  - blocker truth
  - open surfaces
  - next owner/action
- Receivers consume packetized upstream thinking.
