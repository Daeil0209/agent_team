---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-4 Owner Trigger Order; Work Execution Philosophy"
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# team-lead: Owner Trigger Order

## Purpose
Use this reference to decide which owner opens first when several triggers are active.
The goal is one executable next owner/action.
Treat procedural narration as nonterminal evidence.

Non-overlap boundary with `.claude/skills/agent-team-lead/references/pre-action-gate.md`:
- This reference owns trigger-priority selection across multiple active owner triggers, named-artifact emission, per-skill routing requirements, and same-boundary continuation rules.
- Per-segment gate fields (`WORK`, `INTENT`, `OWNER`, `REFERENCE`, `APPLIED-RULE-MAPPING`, `REPORT-ADMISSION`, `ROUTE`, `USER-FIT`, `CHANGE-FIT`, `UNCERTAINTY`) and missing-field routing live at `pre-action-gate.md`; this reference is consumed through the gate's `OWNER` field rather than restating gate fields here.

Reporting curtain inheritance:
- This reference produces Procedure Plane records only.
- Trigger order, named artifacts, consumption status, and next-owner/action are internal control facts.
- Visible boot, progress, status, trigger, artifact, or route prose requires a `.claude/reference/reporting-prohibition-law.md` narrow report exception.
- If no narrow report exception exists, continue through the selected next owner/action internally.

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

## Routing Gate
Lower-trigger work requires higher-trigger named artifact emission.
Owner execution credit requires loaded owner text with applied-rule mapping.
Reporting requires a current required artifact beyond narrative description.
Task work requires resolved session-start readiness.
Required primary skill owner execution requires actual `Skill(<skill>)` load or current same-session loaded-skill basis under the named skill's freshness rule.
Required primary skill activation requires actual skill load basis; direct `Read`, `Grep`, `Glob`, `LS`, summary, memory, or reference-map traversal of `.claude/skills/<skill>/**` is inspection only.
Reuse same-session loaded-skill basis only while the owner boundary, trigger, active work surface, proof burden, acceptance burden, claim strength, and named skill freshness rule stay satisfied.
Dispatch first loads `work-planning`, the primary sequence owner, or `Skill(task-execution)` when that owner is required and absent from the active session.
`TeamCreate`, team-scoped `Agent`, assignment-grade `SendMessage`, and structured `shutdown_request` first load `Skill(task-execution)` when the active session lacks a current `task-execution` basis.
Once loaded in a session, `Skill(task-execution)` is reused across later `work-planning` iterations and same-session dispatch moves without reload.
Boundary changes refresh `work-planning`, dispatch-entry checks, and trigger-specific reference consumption, not the `task-execution` skill load.
Direct `Read`, `Grep`, `Glob`, `LS`, summary, memory, or reference-map traversal of `.claude/skills/task-execution/**` is inspection only for this load requirement.
Phase/stage-end analyzed-result reporting, completion claim, synthesis-triggered redispatch, and user-facing positive-result claims require current `Skill(self-verification)` result verification executed in the active session on the exact outgoing claim.
Internal reasoning, narrative "self-verification-style" wording, written verification-shaped tables, defeater-style language in the draft, and direct `Read`, `Grep`, `Glob`, `LS`, summary, memory, or reference-map traversal of `.claude/skills/self-verification/**` are inspection or draft artifacts only; the actual skill must be loaded and the gate must run on the exact outgoing claim.
A previous result-verification pass is reused only while the verified surface, evidence basis, open surfaces, and claim strength remain unchanged; new scope, stronger claim, materially changed claim, out-of-loop mutation, dispatch/reuse, synthesis report, proof/acceptance change, or phase change resets the pass.
`Skill(<skill>)` loads only when the interpreted requested outcome or runtime-owned trigger creates that skill's active execution owner path.
Skill-load eligibility per `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`.
When `work-planning` is the highest active trigger, load `Skill(work-planning)` first before opening lower-trigger owner skills such as `Skill(task-execution)`. Read-class evidence tools required by `work-planning` `## Corpus Measurement Gate` stay lawful inside the work-planning boundary.

## Resolve Next Owner And Action
- A lower-trigger gap opens the higher trigger owner.
- An owner-execution-credit gap opens loaded-document consumption.
- A reporting gap opens artifact refresh.
- A dispatch gap loads `Skill(work-planning)` or the primary sequence skill owner.

## Trigger Order
Consume the highest active trigger first:
1. `Skill(session-closeout)` for explicit closeout
2. `Skill(session-boot)` for session start, boot, runtime-entry, monitoring, recovery, or unresolved session-start readiness
3. `Skill(work-planning)` when a current instruction creates, reopens, or changes a consequential work boundary
4. confirmed primary sequence skill owner
5. frozen workflow or sequence skill owner
6. `Skill(task-execution)` for assignment-grade dispatch
7. `Skill(self-verification)` for required report or redispatch gate

After the current session-start artifact is current, trigger 3 reopens trigger 2 only when trigger 2 is independently active.

## Named Artifacts
- `Skill(session-boot)` emits `runtime-ready: clean`, runtime-ready, or runtime-blocked declaration.
- `Skill(work-planning)` emits frozen-fields record.
- `Skill(review-verification)` returns internal `review_verification_packet`.
- `Skill(self-verification)` emits an internal plan-audit or result-verification record.
- `Skill(task-execution)` emits dispatch-ready packet, dispatch-pending truth, or correction route.
- `Skill(governance-modification)` emits asset-change or recurrence-hardening patch basis and post-verify result.
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
If the boundary is already complete, route the answer through `.claude/reference/reporting-prohibition-law.md` `## Report Shape`.
If an open lead-owned path exists, continue through the next owner/action in the same turn.
Interrupt work uses `.claude/skills/agent-team-lead/references/interrupt-autonomy.md`.
