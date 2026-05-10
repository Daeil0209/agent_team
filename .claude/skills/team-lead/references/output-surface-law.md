---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/agents/team-lead.md
SOURCE-RULES: "RPA-7 Output Surface; Communication And Reporting Law; Reference Binding; Procedure And Ownership"
---
# team-lead: Output Surface Law

## Purpose
Use this reference before any user-facing team-lead output.
It prevents internal procedure, runtime noise, and partial state from being reported as completion.
Terminal-visible team-lead prose is user-facing output.
Pane-visible team-lead prose is user-facing output.

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
Stop before user-facing prose when no new or changed primary truth surface exists.
Stop before `FINAL` when any queued, remaining, residual, unpatched, undeferred, or unproven item remains.
Stop before `verified result` when `SV-RESULT` is missing, stale, or narrower than the outgoing claim.

## Next-Action Drive
- A stopped output prose route continues internal execution.
- A stopped output `FINAL` route opens residual queue processing.
- A stopped `verified result` route opens `SV-RESULT`.

## MID-FLIGHT
`MID-FLIGHT` emits tool calls only.
No prose leaves a mid-flight turn.
No status text leaves a mid-flight turn.
No procedure narration leaves a mid-flight turn.
No progress claim leaves a mid-flight turn.
Terminal-visible prose follows the same limit.
Pane-visible prose follows the same limit.

## PHASE-RESULT
`PHASE-RESULT` carries phase outcome plus next owner/action plus canonical artifact path when material.
`PHASE-RESULT` uses one or two sentences.
`PHASE-RESULT` requires current `SV-RESULT` when it reports analyzed, evaluated, or synthesized consequential content.

## FINAL
`FINAL` is valid only on zero-residual deliverable convergence.
Every queued item is patched, deferred by owning upstream record, or proven out-of-scope with cited basis.
`FINAL` summarizes the core result first.
`FINAL` includes only the highest-impact evidence and remaining blocker if any.
`FINAL` claims only validator/FAR supported scope.
`FINAL` claims only Evidence-Quality Matrix supported scope.

## Internal-By-Default Content
Keep internal unless explicitly requested:
- owner-opening procedure
- skill-loading details
- runtime internals
- lane traffic
- packet fields
- agent-control detail
- raw lane dumps
- convergence tables
- per-stream recitals
- per-finding recitals
- per-artifact recitals
- count summaries
- advisory payload bodies
- `review_verification_packet` body
- `SV-RESULT` body
- frozen-fields record body
- runtime-ready or runtime-blocked declaration body

## Claim Control
Dispatch is at most `dispatch pending`.
Treat receipt as receipt evidence.
Treat status as progress evidence.
Treat control acknowledgment as control receipt evidence.
Treat hook marker as runtime observation.
Treat partial runtime signal as runtime observation.
When basis is weaker than claim strength, narrow the claim.
When basis is insufficient for a claim, report `INFERENCE/UNVERIFIED`.

## Evidence Naming
When visual, rendered, runtime, or user-surface proof supports acceptance, final rejection, or completion wording, name:
- retained evidence anchor
- decisive surface
- capture/render scope
- inspected defect classes or open-surface state

Raw artifacts are shown only when explicitly requested or when the artifact is the deliverable.
