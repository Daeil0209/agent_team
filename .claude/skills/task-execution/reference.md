---
name: task-execution-reference
PRIMARY-OWNER: team-lead
auto-inject: false
---
# task-execution — Communication Contract
Compact round4 reference for common inter-agent packet law.

## Common Message Law
- `work-planning` produces the full frozen plan internally.
- `task-execution` translates that frozen basis into worker-facing packets.
- Workers never receive the full internal planning record.
- One worker, one execution segment, one primary downward message class.
- `status` is progress only.
- `handoff|completion` is positive-state reporting only.
- `scope-pressure` is the structured objection path when the packet is directionally valid but unsafe as written.
- `hold|blocker` is the blocked path when truthful execution cannot continue even with a narrow packet correction.

## Downward Assignment Base Packet
Assignment-grade means any `Agent` dispatch or `SendMessage` that assigns, reroutes, or reuses bounded work for a worker. Lifecycle control, phase-transition control, and status probes are not assignment-grade.

Every assignment-grade worker packet carries:
- `MESSAGE-CLASS`
- `WORK-SURFACE`
- `CURRENT-PHASE`
- `REQUIRED-SKILLS`
- `TASK-ID` when task tracking is active

`REQUIRED-SKILLS` is not optional decoration. It is the worker-facing skill-load contract derived from the frozen planning basis or the active workflow owner's phase-local refinement.
- `team-lead` may load any skill locally when the frozen local path requires it.
- worker lanes must load their lane core skill plus packet `REQUIRED-SKILLS`.
- if `REQUIRED-SKILLS` is missing, contradictory, or too weak to keep the lane-owned path truthful, do not improvise a hidden skill plan inside the worker; raise `scope-pressure` or `hold|blocker`.
- active workflow owners may refine `REQUIRED-SKILLS` only inside the already frozen lane map, deliverable shape, and proof/acceptance chain.
- if a proposed refinement would create a new lane, new independent surface, or changed acceptance/proof owner, it is not packet-local refinement; reopen `work-planning` first.

Use assignment-grade packets for:
- new assignment
- reroute
- bounded reuse

If a worker is receiving new bounded work in the same execution segment, carry any needed workflow phase context inside the assignment packet instead of sending a separate standalone control packet.

## Request-Bound Conditional Packet Fields
When truthful lane execution depends on the original request shape, the assignment packet must also carry:
- `REQUEST-INTENT`
- `CORE-QUESTION`
- `REQUIRED-DELIVERABLE`
- `PRIMARY-AUDIENCE`
- `EXCLUDED-SCOPE`

When exact instruction wording materially affects acceptance, decision-fit, or request-fit review, the packet must additionally carry:
- `USER-INSTRUCTION-VERBATIM`
- `USER-INSTRUCTION-AMENDMENTS`

When planning or the active workflow already froze methodology guidance for the lane, the packet should also carry:
- `SKILL-RECOMMENDATIONS`

Do not leave these request-fit or methodology fields only in linked-path references when the receiving lane must use them to plan, verify, or judge the assigned surface truthfully.

When frozen governance depth materially changes staffing, checkpoint, review, proof, or acceptance burden for the receiving lane, the assignment packet must also carry:
- `PROJECT-TIER`
- `ACTIVE-REQUEST-TIER`
- `TIER-RAISE-REASON`

`PROJECT-TIER` is the floor. `ACTIVE-REQUEST-TIER` may stay at that floor or raise above it for the current request, but the packet must not silently rewrite the project floor.
Tier may avoid unnecessary over-governance, but it must never be used to downshift decisive user-surface proof or acceptance integrity.

When proof or acceptance depends on the real user-facing surface rather than source-state alone, the packet must also make that surface explicit:
- `USER-SURFACE`
- `USER-SURFACE-PROOF-PATH`
- `TOOL-REQUIREMENT` when one exact truthful tool is already frozen
- `SURFACE-EQUIVALENCE-BASIS` when the frozen proof path is not the obvious native/default tool for that surface

`USER-SURFACE` names what the user actually experiences: browser interaction, rendered page-read document, office document, spreadsheet runtime, PDF reader surface, HWP/HWPX reader/editor surface, operator console, or another concrete user-consumed surface. Do not force tester or validator to rediscover that surface from gist.
`TOOL-REQUIREMENT` is not a convenience preference field. Keep assignments method-neutral by default and freeze an exact tool only when the user explicitly requires it, the active workflow already froze it for bounded cost/risk reasons, or no equivalent truthful path exists.
If the exact tool is not yet frozen, the packet may instead freeze a bounded discovery/setup objective:
- `TOOL-DISCOVERY-GOAL`
- `TOOL-DISCOVERY-BOUNDARY`
- `TOOL-VERIFICATION-STANDARD`
- `TOOL-CLEANUP-EXPECTATION`

This keeps the assignment autonomy-preserving without allowing vague or unbounded tool hunting.
For browser-ui proof or acceptance, an exact `TOOL-REQUIREMENT` and the full bounded discovery/setup bundle are alternatives at dispatch time. Do not force both unless the workflow truly needs both.

`USER-RUN-PATH` and `BURDEN-CONTRACT` are conditional delivery-contract fields, not universal tester/validator burden. Freeze them only when launch path, operator burden, runnable workflow burden, or explicit delivery experience is materially part of proof or acceptance. Rendered static surfaces may omit them when user-visible usefulness is still provable without run-path burden; completion gates may treat omitted values as `not-applicable` only when no run-path or burden contract was part of the frozen proof or acceptance surface.
Tester/validator completion status fields such as `PROOF-SURFACE-MATCH`, `RUN-PATH-STATUS`, `CORE-WORKFLOW-STATUS`, `INTERACTION-COVERAGE-STATUS`, and `BURDEN-STATUS` stay explicit; use `not-applicable` instead of omission when a status axis was not part of the frozen surface.

`DECISION-SURFACE` is a conditional validator arbitration field. Keep it explicit when the decisive acceptance surface materially differs from the validator execution surface or when the verdict must reconcile more than one candidate acceptance surface. When `VALIDATION-SURFACE` already names the single decisive user-facing acceptance surface for the bounded acceptance path, `DECISION-SURFACE` may inherit from `VALIDATION-SURFACE`.
`ENV-BASIS` and `SCENARIO-SCOPE` are conditional runtime-context fields for tester proof, not universal rendered-proof burden. Freeze them when proof depends on executable/runtime variability, environment basis, or bounded interaction scope. Rendered static page-read or visual proof may omit them when `PROOF-TARGET`, `PROOF-EXPECTATION`, and `PROOF-SURFACE` already bind the truthful proof path.

When the assigned surface is office-format, page-read, or other rendered human-facing material where reader-visible usefulness is part of acceptance, keep the rendered chain explicit instead of implying it:
- `developer/document-automation -> tester -> reviewer -> validator` when risk is meaningful
- rendered evidence supports human-visible usefulness only; it does not replace wording, logic, request-fit, proof, or verdict ownership
- if the current toolchain cannot truthfully exercise the decisive user surface, freeze one bounded next step only: explicit tool discovery/acquisition/setup via `external-tool-bridge` or the appropriate setup owner, or `hold|blocker`. Do not quietly downgrade to source-only checking.

Use lifecycle control separately. Lifecycle control does not carry new work.

## Downward Lifecycle Control Packet
Use a structured lifecycle control packet when team-lead resolves post-completion or runtime lifecycle state for a worker and no new bounded work is being assigned.

This control packet is:
- not an assignment-grade work packet
- not workflow phase control
- valid only when the worker is not also receiving a new assignment-grade packet in the same execution segment

Carry:
- `MESSAGE-CLASS: lifecycle-control`
- `LIFECYCLE-DECISION`
- `DECISION-BASIS`

Workers acknowledge receipt when the lifecycle decision materially affects their active assignment, standby readiness, or shutdown path.
Team-lead sends lifecycle control explicitly after worker completion, reuse decision, or runtime teardown coordination when the lifecycle edge must be recorded truthfully.

Termination form for `LIFECYCLE-DECISION: shutdown` specifically:
- A free-text lifecycle-control message with `LIFECYCLE-DECISION: shutdown` is a record of the decision; it does NOT actually terminate the worker process. Workers respond to it with `control-ack` and remain alive.
- To actually terminate the worker, send the structured shutdown protocol via `SendMessage` with `message: {"type": "shutdown_request"}`. The worker replies with `{"type": "shutdown_response", "approve": true|false}`; on approve, the worker process exits and the harness emits a `teammate_terminated` event.
- Use the free-text `lifecycle-control` form only when the decision is `reuse`, `standby`, or `hold-for-validation` — those do not need protocol-level termination, only a lifecycle-edge record.
- `TeamDelete` succeeds only after every teammate is confirmed terminated; do not treat `control-ack` of a text shutdown as proof of termination.

## Downward Phase-Transition Control Packet
Use a structured phase-transition control packet when a workflow owner advances the shared phase and affected workers must update coordination context, standby readiness, or immediate next-phase coordination without receiving a brand-new bounded assignment yet.

This control packet is:
- not a replacement for assignment-grade assignment when new bounded work is being assigned
- not a lifecycle-control substitute
- not valid as a broadcast shortcut when individual worker impact differs
- valid only when the affected worker is not also receiving a new assignment-grade packet in the same execution segment

Carry:
- `MESSAGE-CLASS: phase-transition-control`
- `PREVIOUS-PHASE`
- `NEXT-PHASE`
- `FEATURE`
- `CONTEXT-ANCHOR`
- `DELIVERY-CONSTRAINT`
- `GATE-STATUS`
- `ACTIVE-WORKERS`
- `BLOCKING-ISSUES`

Workers acknowledge receipt when their active assignment, standby readiness, or immediate next-phase coordination is affected.
Team-lead or the active workflow owner may send this control packet only after the workflow phase cursor is truthfully advanced.

## Upward Message Classes
- `dispatch-ack`
  - receipt only
  - first upward message on fresh assignment receipt
  - use the minimal receipt spine when those fields are available:
    - `MESSAGE-CLASS: dispatch-ack`
    - `TASK-ID`
    - `WORK-SURFACE`
    - `ACK-STATUS: accepted`
    - `PLANNING-BASIS: loading`
  - if intake or worker-local planning immediately discovers a blocker, send a separate `hold|blocker`; do not stuff blocker text into `dispatch-ack`
- `control-ack`
  - receipt only for structured control packets such as `phase-transition-control` or `lifecycle-control`
  - not an assignment receipt
  - not progress, not completion, not proof of closure
- `status`
  - internal progress only
  - not completion, not lifecycle, not proof of closure
- `scope-pressure`
  - structured objection to workload, ownership split, hidden prerequisite, missing critical field, or burden contract
  - use when the worker should not absorb the packet as written, but the right next step may still be packet correction or replanning
  - must include:
    - `PRESSURE-TYPE`
    - `WHY-CURRENT-PACKET-FAILS`
    - `SMALLEST-SAFE-BOUNDARY`
    - `RECOMMENDED-NEXT-LANE`
    - `REPLAN-REQUIRED`
- `handoff|completion`
  - completion-grade candidate only
  - requires converged lane-owned work
  - synthesis-ready only when the lane report includes `OUTPUT-SURFACE`, `EVIDENCE-BASIS`, `OPEN-SURFACES`, and `RECOMMENDED-NEXT-LANE`
- `hold|blocker`
  - required when ambiguity, missing authority, blocked environment, or missing decisive basis prevents truthful execution
  - use as a separate blocked message class after receipt or intake when the lane cannot continue truthfully
  - when emitting the blocked class, use the exact literal `MESSAGE-CLASS: hold|blocker`; do not downgrade it to bare `hold` or bare `blocker`
  - use this instead of downgrading to source-only or code-only checks when the decisive user surface cannot be truthfully exercised
  - should include:
    - `BLOCKER-TYPE`
    - `BLOCKER-BASIS`
    - `SAFE-NEXT-STEP`

## Common Completion Result Spine
Every `handoff|completion` report must include:
- `OUTPUT-SURFACE`
- `EVIDENCE-BASIS`
- `OPEN-SURFACES`
- `RECOMMENDED-NEXT-LANE`
- `PLANNING-BASIS: loaded`
- `SV-PLAN-VERIFY: done`
- `SELF-VERIFICATION: converged`
- `CONVERGENCE-PASS`
- `REQUESTED-LIFECYCLE`

Lane docs may require bounded additions, but they must not weaken or replace this common result spine.
`REQUESTED-LIFECYCLE` does not itself clear lifecycle debt. Team-lead still owes explicit lifecycle control. A runtime owner may allow one narrow same-surface follow-on before that control is sent only when the prior completion already made a non-reuse requested lifecycle explicit, the next dispatch targets a distinct concrete worker, and the unresolved lifecycle debt stays visible.

When the lane claims user-surface proof or user-surface acceptance on an executed surface, the completion-grade report must also keep the exercised method explicit:
- `USER-SURFACE-PROOF-METHOD`
- `TOOL-PATH-USED`
- `TOOL-EXECUTION-EVIDENCE`

Do not compress `real browser interaction`, `rendered/runtime reader proof`, or other decisive user-surface work into vague surface claims without naming the concrete proof method and execution evidence actually used.

## Common Lane Handoff Law
- Every worker handoff is an upward lane report, not a replacement for the frozen global plan.
- Report only lane-local execution truth: the surface actually examined or changed, the decisive evidence basis, open surfaces, and the narrowest truthful next-lane recommendation.
- `RECOMMENDED-NEXT-LANE` may narrow the plausible next owner, but it does not freeze routing. Team-lead still owns synthesis, redispatch, closeout, and acceptance routing.
- If the truthful next step would change owner, phase, deliverable shape, staffing shape, proof surface, or acceptance chain, do not disguise that as ordinary completion; raise `scope-pressure` or `hold|blocker`.
- If any required procedure state for completion-grade reporting is not true yet, use `MESSAGE-CLASS: hold|blocker` instead of formatting the report as completion-ready.

## Truth Rules
- `Agent` or assignment-grade `SendMessage` success = `dispatch pending`
- `dispatch-ack` = receipt only
- `control-ack` = control receipt only
- `worker started` requires worker-side action or worker-originated progress beyond receipt
- user-facing output may report only the narrowest proven state

## Scope-Pressure Canonical Use
Use `scope-pressure` when the packet is directionally related to the right work but unsafe to absorb as written.

Canonical `PRESSURE-TYPE` values:
- `missing-critical-field`
- `boundary-too-wide`
- `hidden-prerequisite`
- `owner-split`
- `phase-split`
- `parallel-split-needed`
- `acceptance-burden-mismatch`
- `proof-surface-mismatch`
- `decision-surface-mismatch`
- `deliverable-shape-mismatch`

Use `parallel-split-needed` when nominally parallel or independently staffable work lets 2+ independent tasks or surfaces collapse onto one worker strongly enough that the worker becomes the schedule bottleneck.
Use `boundary-too-wide` when the packet already exceeds the smallest truthful lane-owned boundary even before throughput evidence accumulates.

Replanning law:
- `REPLAN-REQUIRED: yes` when the objection changes owner, phase, work-surface decomposition, staffing shape, acceptance chain, proof surface, or deliverable shape.
- `REPLAN-REQUIRED: no` only when one bounded packet correction can preserve the same frozen owner, phase, deliverable, and acceptance chain.
- Single-worker overload inside intended parallel work is a serious distribution-planning defect. Represent it as `PRESSURE-TYPE: parallel-split-needed` with `REPLAN-REQUIRED: yes`; do not downgrade it to packet correction.
- If the worker cannot state a smallest safe boundary, default to `hold|blocker` instead of vague `scope-pressure`.

## Lane-Specific Additions
The common base packet is extended by lane-specific required fields:
- `developer`: change and acceptance boundary
- `researcher`: question and evidence boundary
- `reviewer`: review and acceptance boundary
- `tester`: proof and scenario boundary
- `validator`: verdict and expectation boundary

Each lane's role document owns its exact assignment additions and any lane-specific completion extras beyond the common result spine.

For the closed enumerated value tables enforced by hooks (e.g. `RESEARCH-MODE`, `BENCHMARK-MODE`, `PLAN-STATE`, `ACCEPTANCE-RISK`, `PROOF-OWNER`, `PREREQ-STATE`, `REVIEW-STATE`, `TEST-STATE`, `VERDICT`), see `.claude/skills/team-session-sequences/SKILL.md` `### Dispatch Packet Compliance`. That section is the canonical lane-specific enumeration owner; this file owns the cross-lane base schema.
