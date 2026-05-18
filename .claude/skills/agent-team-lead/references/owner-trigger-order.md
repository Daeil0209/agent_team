---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-2 Owner Trigger Order; Reference Binding; Procedure And Ownership"
---
# team-lead: Owner Trigger Order

## Purpose
Use this reference to decide which owner opens first when several triggers are active.
The goal is one executable next owner/action.
Treat procedural narration as nonterminal evidence.

Reporting curtain inheritance:
- This reference produces Procedure Plane records only.
- Trigger order, named artifacts, consumption status, and next-owner/action are internal control facts.
- They do not authorize boot, progress, status, trigger, artifact, or route prose.
- Visible prose remains blocked unless `.claude/reference/user-reporting-law.md` admits a report.

## Consume When
- A named owner skill or sequence trigger is active.
- The route can enter planning, workflow, sequence, task-execution, dispatch, mutation, self-verification, or reporting.
- A previous owner outcome is stale, missing, or only narrated.
- The user challenges whether work is actually progressing.

## Required Output
Record the highest active trigger and its named artifact:
- `TRIGGER`
- `OWNER`
- `REQUIRED-REFERENCE`
- `APPLIED-RULE-MAPPING`
- `NAMED-ARTIFACT`
- `CONSUMPTION-STATUS`
- `NEXT-OWNER-ACTION`

## Stop
Stop before lower-trigger work until a higher trigger emits its named artifact.
Stop before owner execution credit until loaded owner text has applied-rule mapping.
Stop before reporting when the required artifact is stale or only described narratively.
Stop before task work when session-start readiness is unresolved.
Stop before dispatch when `work-planning`, primary sequence owner, or `Skill(task-execution)` is required but absent from the active session.
Stop before `TeamCreate`, team-scoped `Agent`, assignment-grade `SendMessage`, or structured `shutdown_request` when the active session has not loaded `Skill(task-execution)`.
Once loaded in a session, `Skill(task-execution)` is reused across later `work-planning` iterations and same-session dispatch moves without reload; only the `Skill(task-execution)` Activation rule classifies the existing basis stale or wrong-boundary and authorizes another load.
Direct reference inspection of `.claude/skills/task-execution/**` does not satisfy this load requirement.
Stop before phase/stage-end analyzed-result reporting, completion claim, synthesis-triggered redispatch, or any user-facing positive-result claim when the outgoing claim is not covered by current `Skill(self-verification)` result verification executed in the active session.
Internal reasoning, narrative "self-verification-style" wording, written verification-shaped tables, defeater-style language in the draft, or direct reference inspection of `.claude/skills/self-verification/**` does not satisfy this load requirement; the actual skill must be loaded and the gate must run on the exact outgoing claim.
A previous result-verification pass is reused only while the verified surface, evidence basis, open surfaces, and claim strength remain unchanged; new scope, stronger claim, materially changed claim, out-of-loop mutation, dispatch/reuse, synthesis report, proof/acceptance change, or phase change resets the pass.
Stop before loading or opening a lower-trigger owner skill (such as `Skill(task-execution)`) when `work-planning` is the highest active trigger; open only `Skill(work-planning)` first. Read-class evidence tools required by `work-planning` `## Corpus Measurement Gate` are not lower-trigger tools and stay lawful inside the work-planning boundary.

## Resolve Next Owner And Action
- A stopped lower-trigger route opens the higher trigger owner.
- A stopped owner-execution-credit route opens loaded-document consumption.
- A stopped reporting route opens artifact refresh.
- A stopped dispatch route loads `Skill(work-planning)` or the primary sequence skill owner.

## Trigger Order
Consume the highest active trigger first:
1. `Skill(session-closeout)` for explicit closeout
2. `Skill(session-boot)` for session start, boot, runtime-entry, monitoring, recovery, or unresolved session-start readiness
3. `Skill(work-planning)` when a current instruction creates, reopens, or changes a consequential work boundary
4. confirmed primary sequence skill owner
5. frozen workflow or sequence skill owner
6. `Skill(task-execution)` for assignment-grade dispatch
7. `Skill(self-verification)` for required report or redispatch gate

After the current session-start artifact is current, trigger 3 does not reopen trigger 2 unless trigger 2 is independently active.

## Named Artifacts
- `Skill(session-boot)` emits `runtime-ready: clean`, runtime-ready, or runtime-blocked declaration.
- `Skill(work-planning)` emits frozen-fields record.
- `Skill(review-verification)` returns internal `review_verification_packet`.
- `Skill(self-verification)` emits an internal plan-audit or result-verification record.
- `Skill(task-execution)` emits dispatch-ready packet, dispatch-pending truth, or correction route.
- `Skill(governance-change)` emits asset-change or recurrence-hardening patch basis and post-verify result.
- `Skill(session-closeout)` emits closeout residual truth or teardown completion.

## Artifact Discipline
Skill load is availability only.
Loaded owner text becomes execution evidence only through applied-rule mapping.
Applied-rule mapping names action, stop, evidence, owner, or next-action effect.
Tool output is artifact only when the owner defines it as artifact.
Narrative claims of completed owner work are procedural failure.
Owner rerun triggers:
- only narrative claim exists
- target, corpus, route, patch design, or diff changed

## Same-Boundary Continuation
Same-boundary iterations consume the frozen boundary.
Keep ordinary same-boundary correction inside the frozen boundary.
Reopen planning when owner, phase, deliverable shape, proof chain, acceptance chain, staffing shape, or user requirement changes.

## Status And Interruption
Status questions expose stalled execution.
If the boundary is already complete, route the answer through `.claude/reference/user-reporting-law.md` `## Report Shape`.
If an open lead-owned path exists, continue through the next owner/action in the same turn.
Interrupt work uses `.claude/skills/agent-team-lead/references/interrupt-autonomy.md`.
