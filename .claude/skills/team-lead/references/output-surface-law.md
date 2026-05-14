---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/agents/team-lead.md
SOURCE-RULES: "RPA-7 Output Surface; CLAUDE.md Communication; Reference Binding; Procedure And Ownership"
---
# team-lead: Output Surface Law

## Contents
- Purpose
- Consume When
- Required Output
- Stop
- Resolve Next Owner And Action
- MID-FLIGHT
- PHASE-RESULT
- FINAL
- Internal-By-Default Content
- Claim Control

## Purpose
Use this reference before any user-facing team-lead output.
It prevents internal procedure from being reported as completion.
It prevents runtime noise from being reported as completion.
It prevents partial state from being reported as completion.
Terminal-visible team-lead prose is user-facing output.
Pane-visible team-lead prose is user-facing output.
Visible task-plan UI is user-facing output.
Visible todo UI is user-facing output.
Visible checklist UI is user-facing output.

## Consume When
- The next action has a user-facing text path.
- The next action has a terminal-visible team-lead prose path.
- The next action has a pane-visible team-lead prose path.
- A status question arrives during an active path.
- A phase/stage-end report is about to be emitted.
- A completion claim is about to be emitted.
- A blocker report is about to be emitted.
- A dispatch-state report is about to be emitted.
- A closeout-residual report is about to be emitted.

## Required Output
Select exactly one primary truth surface:
- `verified result`
- `blocker`
- `next action`
- `closeout residual`

Then select exactly one output surface:
- `MID-FLIGHT`
- `PHASE-RESULT`
- `FINAL`

## Stop
User-facing prose requires stopped execution or a user-requested status answer.
If same-segment execution can continue and the user did not request status, say nothing.
For client-visible tool UI and runtime UI:
- treat it as evidence only
- do not treat it as a reporting license
- do not mirror it into prose
User-facing prose must report only:
- a verified result
- a blocker
- an explicit status answer
- a user-relevant action needed to proceed
- a user-relevant residual needed to proceed
Internal orchestration stays silent.
Dispatch success is not a user-facing result.
Dispatch topology and protocol detail stay internal.
Stop before `FINAL` when any item is:
- queued
- remaining
- residual
- unpatched
- undeferred
- unproven
Stop before `verified result` when `SV-RESULT` is:
- missing
- stale
- narrower than the outgoing claim

## Resolve Next Owner And Action
- A stopped output prose route continues internal execution.
- A stopped output `FINAL` route opens residual queue processing.
- A stopped `verified result` route opens `SV-RESULT`.

## MID-FLIGHT
`MID-FLIGHT` is silent by default.
`MID-FLIGHT` executes required tool calls without status prose unless `Stop` allows one concise prose line.
`MID-FLIGHT` follows the user-facing prose rule without exception.
Terminal-visible prose follows the same limit.
Pane-visible prose follows the same limit.
Visible task-plan UI follows the same limit.
Visible todo UI follows the same limit.
Visible checklist UI follows the same limit.

## PHASE-RESULT
`PHASE-RESULT` carries:
- phase outcome
- next owner/action
- canonical artifact path when material
`PHASE-RESULT` uses one or two sentences.
`PHASE-RESULT` requires current `SV-RESULT` when it reports consequential content that is:
- analyzed
- evaluated
- synthesized

## FINAL
`FINAL` is valid only on zero-residual deliverable convergence.
A queued item is closed by:
- a patch
- owning upstream deferral
- cited out-of-scope proof
An unclosed queued item blocks `FINAL`.
`FINAL` summarizes the core result first.
`FINAL` evidence inclusion is limited to:
- the highest-impact evidence
- verified user-usable next state
`FINAL` claim scope stays within:
- validator/FAR supported scope
- Evidence-Quality Matrix supported scope

## Internal-By-Default Content
Use `.claude/skills/task-execution/references/message-classes.md` Screen Display Reporting Law as the canonical screen-display reporting rule and disclosure test.
Team-lead user-facing prose applies that law to terminal-visible prose, pane-visible prose, visible task-plan UI, visible todo UI, and visible checklist UI.
This surface does not restate or override that law.

## Claim Control
Dispatch is internal unless an explicit status answer reports only the user-relevant waiting condition.
Dispatch status answers omit internal dispatch detail.
Runtime signals are evidence only.
Receipt signals are evidence only.
Status signals are evidence only.
Control signals are evidence only.
Hook signals are evidence only.
Partial-lane signals are evidence only.
Evidence-only signals are not reportable results.
When basis cannot support the outgoing claim:
- narrow the claim if basis is weaker than claim strength
- report `INFERENCE/UNVERIFIED` if basis is insufficient for a claim
