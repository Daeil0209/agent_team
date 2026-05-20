---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-7 status, satisfied gates, phase transitions, and routine milestones; Work Execution Philosophy"
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---
# team-lead: Routine Gate Continuation

## Purpose
Use this reference when a satisfied gate, status question, phase transition, or long convergence loop creates pause risk.

## Consume When
- A satisfied phase boundary remains unconsumed.
- A frozen `NEXT-CONSEQUENTIAL-ACTION` remains unexecuted.
- A converged synthesis is unreported.
- User asks for status during in-flight work.
- A routine milestone such as commit, push, or build occurs inside a larger deliverable.
- A partial patch batch, patch-application log, or applied-patch recap occurs while a larger governance modification queue remains open.

## Required Output
Record:
- paused path status
- next owner/action
- whether output is internal or user-facing
- residual queue status

## Stop
Stop before `FINAL` when residual queue is non-empty.
Stop before asking to proceed when the next owner/action is lead-owned and non-destructive.
Stop before unsolicited status prose when continuing the active path is possible in the same segment.
Stop before lane/shard arrival or partial-convergence prose when monitoring, retained-carrier consumption, merge, correction, or synthesis can continue.

## Status And Why Continuation
Status answers follow `.claude/reference/reporting-user-reporting-law.md` `## Report Shape`.
Answers to why an expected action did not happen follow `.claude/reference/reporting-user-reporting-law.md` `## Report Shape`.
After the answer, resume the current owner action unless the user redirects or a user-action blocker is proven.

## Resolve Next Owner And Action
- A stopped routine `FINAL` route opens residual queue processing.
- A stopped proceed-prompt route executes the lead-owned next owner/action.
- A stopped unsolicited status-prose route continues the active path in the same segment.
- A stopped partial-arrival prose route continues monitoring, retained-carrier consumption, merge, correction, or synthesis.

## Continuation Rules
- Process state self-report consumes `.claude/reference/work-execution-core-law.md` `[AUTO-PROC]` continuation rules.
- Material context-budget pressure does not end the turn or session.
- Retained carriers under the canonical output root are the safe persistence path against auto-compact loss.
- Active owner prepares auto-compact handoff state (retained carrier completeness, owner-deferral upstream record, resume-action specification) while continuing the active path.
- Resume these surfaces by executing the next owner/action:
  - satisfied gates
  - phase transitions
  - long convergence loops
  - interrupt returns
  - rejection routes
- A path is paused when:
  - a frozen `NEXT-CONSEQUENTIAL-ACTION` the lead owns is named but unexecuted
  - a satisfied phase boundary remains unconsumed
  - a converged synthesis is unreported
- On a paused path, resume by executing.
- On a completed boundary with zero paused lead-owned action, route the status answer through `.claude/reference/reporting-user-reporting-law.md`.
- That status answer terminates the turn only when no same-segment execution remains open.
- Surface review/proceed prompts for user-requested review, explicit approval requirements, or verified user-owned blockers.

## Milestone Rules
- Treat these as routine milestones:
  - intermediate commit
  - intermediate push
  - intermediate build
  - partial patch batch
  - patch-application log
  - applied-patch recap
- Continue these deliverables in the same segment:
  - multi-round deliverables through the next round
  - multi-batch deliverables through the next batch
- For routine milestones, continue through the next owner/action in the same segment.
- Do not convert remaining same-request patch groups into backlog unless an owning upstream deferral, explicit cancellation, explicit redirect, or proven user-owned blocker exists.
- Treat lane/shard arrival, single-lane completion, partial fan-out completion, and retained-output availability as routine internal milestones.
- Surface routine milestones on explicit user request only, and then only as a compact waiting condition without shard inventories unless specifically requested.

## Final Convergence
`FINAL` requires zero residual deliverable convergence.
The residual queue contains every owner-named deliverable-convergence item whose required patch, proof, integration, owner deferral, or out-of-scope basis is still open.
A residual queue item closes through:
- patch
- owning upstream deferral
- cited out-of-scope proof
- owning synthesis, proof, validation, or acceptance integration
An open residual queue blocks `FINAL`.
Continue execution until:
- the queue is empty
- a true blocker emerges
- the user explicitly cancels
- the user explicitly redirects

## Surface Limit
Routine reporting follows `.claude/reference/reporting-user-reporting-law.md`.
Clean routine transitions produce no user-facing prose.
Routine milestones, lane/shard arrivals, partial convergence, satisfied gates, phase transitions, dispatch state, and monitoring state stay Procedure Plane unless `.claude/reference/reporting-user-reporting-law.md` admits a report.
After `session-closeout` owns the path, late outputs narrow residual truth only.
