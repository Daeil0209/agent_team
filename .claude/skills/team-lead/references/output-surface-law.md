---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/agents/team-lead.md
SOURCE-RULES: "RPA-7 Output Surface; Communication And Reporting Law; Reference Binding; Procedure And Ownership"
---
# team-lead: Output Surface Law

## Contents
- Purpose
- Consume When
- Required Output
- Stop
- Next-Action Drive
- MID-FLIGHT
- PHASE-RESULT
- FINAL
- Internal-By-Default Content
- Claim Control

## Purpose
Use this reference before any user-facing team-lead output.
It prevents internal procedure, runtime noise, and partial state from being reported as completion.
Terminal-visible team-lead prose is user-facing output.
Pane-visible team-lead prose is user-facing output.
Visible task-plan, todo, or checklist UI is user-facing output.

## Consume When
- The next action could produce user-facing text.
- The next action could produce terminal-visible team-lead prose.
- The next action could produce pane-visible team-lead prose.
- A status question arrives during an active path.
- A phase/stage-end report is about to be emitted.
- A completion claim is about to be emitted.
- A blocker, dispatch state, or closeout residual must be reported.

## Required Output
Select exactly one primary truth surface:
- `verified result`
- `blocker`
- `next action`
- `dispatch pending`
- `closeout residual`

Then select exactly one output surface:
- `MID-FLIGHT`
- `PHASE-RESULT`
- `FINAL`

## Stop
User-facing prose requires stopped execution or a user-requested status answer.
If same-segment execution can continue, say nothing.
Client-visible tool/runtime UI may remain visible; do not add explanatory prose for it.
Allowed mid-flight prose is one line for blocker, required user action, explicit status answer, or first `dispatch pending`.
Stop before `FINAL` when any queued, remaining, residual, unpatched, undeferred, or unproven item remains.
Stop before `verified result` when `SV-RESULT` is missing, stale, or narrower than the outgoing claim.

## Next-Action Drive
- A stopped output prose route continues internal execution.
- A stopped output `FINAL` route opens residual queue processing.
- A stopped `verified result` route opens `SV-RESULT`.

## MID-FLIGHT
`MID-FLIGHT` is silent by default.
`MID-FLIGHT` emits tool calls only unless `Stop` allows one concise prose line.
`MID-FLIGHT` never narrates internal procedure, runtime setup, corpus/route/staffing, or team-state changes.
Terminal-visible prose, pane-visible prose, and visible task-plan/todo/checklist UI follow the same limit.

## PHASE-RESULT
`PHASE-RESULT` carries phase outcome plus next owner/action plus canonical artifact path when material.
`PHASE-RESULT` uses one or two sentences.
`PHASE-RESULT` requires current `SV-RESULT` when it reports analyzed, evaluated, or synthesized consequential content.

## FINAL
`FINAL` is valid only on zero-residual deliverable convergence.
Every queued item is patched, deferred by owning upstream record, or proven out-of-scope with cited basis.
`FINAL` summarizes the core result first.
`FINAL` evidence inclusion is limited to the highest-impact evidence and verified user-usable next state.
`FINAL` claim scope stays within validator/FAR supported scope.
`FINAL` claim scope stays within Evidence-Quality Matrix supported scope.

## Internal-By-Default Content
Internal means all procedure, planning, dispatch, runtime, lane-traffic, advisory, packet, and verification-record detail.
Expose only the selected primary truth surface, and only when `Stop` allows prose.

## Claim Control
Dispatch is at most `dispatch pending`.
Runtime, receipt, status, control, hook, and partial-lane signals are evidence only, not reportable results.
When basis is weaker than claim strength, narrow the claim.
When basis is insufficient for a claim, report `INFERENCE/UNVERIFIED`.
