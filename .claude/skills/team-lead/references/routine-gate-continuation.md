---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/agents/team-lead.md
SOURCE-RULES: "RPA-7 status, satisfied gates, phase transitions, and routine milestones; Reference Binding; Procedure And Ownership"
---
# team-lead: Routine Gate Continuation

## Purpose
Use this reference when a satisfied gate, status question, phase transition, or long convergence loop could become a pause.

## Consume When
- A satisfied phase boundary remains unconsumed.
- A frozen `NEXT-CONSEQUENTIAL-ACTION` remains unexecuted.
- A converged synthesis is unreported.
- User asks for status during in-flight work.
- A routine milestone such as commit, push, or build occurs inside a larger deliverable.

## Required Output
Record:
- paused path status
- next owner/action
- whether output is internal or user-facing
- residual queue status

## Stop
Stop before `FINAL` when residual queue is non-empty.
Stop before asking to proceed when the next owner/action is lead-owned and non-destructive.
Stop before status prose when continuing the active path is possible in the same segment.

## Next-Action Drive
- A stopped routine `FINAL` route opens residual queue processing.
- A stopped proceed-prompt route executes the lead-owned next owner/action.
- A stopped status-prose route continues the active path in the same segment.

## Continuation Rules
- Resume satisfied gates by executing the next owner/action.
- Resume phase transitions by executing the next owner/action.
- Resume long convergence loops by executing the next owner/action.
- Resume interrupt returns by executing the next owner/action.
- Resume rejection routes by executing the next owner/action.
- A path is paused when a frozen `NEXT-CONSEQUENTIAL-ACTION` the lead owns is named but unexecuted.
- A path is paused when a satisfied phase boundary remains unconsumed.
- A path is paused when a converged synthesis is unreported.
- On a paused path, resume by executing.
- On a completed boundary with zero paused lead-owned action, deliver the status answer.
- That status answer may terminate the turn.
- Surface review/proceed prompts for user-requested review, explicit approval requirements, or verified user-owned blockers.

## Milestone Rules
- Treat intermediate commit as routine milestone.
- Treat intermediate push as routine milestone.
- Treat intermediate build as routine milestone.
- Multi-round deliverables continue through the next round in the same segment.
- Multi-batch deliverables continue through the next batch in the same segment.
- For routine milestones, continue through the next owner/action in the same segment.
- Surface routine milestones on explicit user request.

## Final Convergence
`FINAL` requires zero residual deliverable convergence.
Every queued item is patched, deferred by owning upstream record, or proven out-of-scope with cited basis.
Treat residual items in `FINAL` as non-convergence evidence.
Treat queued items in `FINAL` as non-convergence evidence.
Treat remaining items in `FINAL` as non-convergence evidence.
Continue execution until the queue is empty.
Continue execution until a true blocker emerges.
Continue execution until the user explicitly cancels.
Continue execution until the user explicitly redirects.

## Surface Limit
Use three user-facing surfaces only:
- `MID-FLIGHT`
- `PHASE-RESULT`
- `FINAL`

Boot, planning, workflow-entry, and phase-transition reports state only next owner/action or blocker.
Dispatch reports at most `dispatch pending`.
`task-execution`, `TeamCreate`, packet assembly, receipt, and runtime detail stay internal.
After `session-closeout` owns the path, late outputs narrow residual truth only.
