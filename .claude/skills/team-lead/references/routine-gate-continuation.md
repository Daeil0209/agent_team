---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/agents/team-lead.md
SOURCE-RULES: "RPA-7 status, satisfied gates, phase transitions, and routine milestones; Reference Binding; Procedure And Ownership"
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

## Resolve Next Owner And Action
- A stopped routine `FINAL` route opens residual queue processing.
- A stopped proceed-prompt route executes the lead-owned next owner/action.
- A stopped unsolicited status-prose route continues the active path in the same segment.

## Continuation Rules
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
- On a completed boundary with zero paused lead-owned action, deliver the status answer.
- That status answer terminates the turn only when no same-segment execution remains open.
- Surface review/proceed prompts for user-requested review, explicit approval requirements, or verified user-owned blockers.

## Milestone Rules
- Treat these as routine milestones:
  - intermediate commit
  - intermediate push
  - intermediate build
- Continue these deliverables in the same segment:
  - multi-round deliverables through the next round
  - multi-batch deliverables through the next batch
- For routine milestones, continue through the next owner/action in the same segment.
- Surface routine milestones on explicit user request.

## Final Convergence
`FINAL` requires zero residual deliverable convergence.
A queued item is closed by:
- a patch
- owning upstream deferral
- cited out-of-scope proof
An unclosed queued item blocks `FINAL`.
Treat these items in `FINAL` as non-convergence evidence:
- residual items
- queued items
- remaining items
Continue execution until:
- the queue is empty
- a true blocker emerges
- the user explicitly cancels
- the user explicitly redirects

## Surface Limit
Use three user-facing surfaces only:
- `MID-FLIGHT`
- `PHASE-RESULT`
- `FINAL`

Routine output suppression follows `.claude/skills/team-lead/references/output-surface-law.md`.
Clean routine transitions produce no user-facing prose.
These routine surfaces report through `.claude/skills/team-lead/references/output-surface-law.md`:
- blockers
- required user actions
After `session-closeout` owns the path, late outputs narrow residual truth only.
