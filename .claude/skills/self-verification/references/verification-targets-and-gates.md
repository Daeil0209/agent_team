---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false
---
# Self-Verification Reference
Load only when `self-verification/SKILL.md` triggers a detailed target profile, challenge lens, evidence calibration, harness/proof check, synthesis check, material same-lane self-certification risk, or expanded output record.

## Auto-inject
false - this file is binding detail when loaded, not always-loaded context.

## Contents
- Target Profiles
- Reference Load Triggers
- Challenge Lens Catalog
- SV-PLAN Detailed Gate
- SV-RESULT Detailed Gate
- Analysis Claim Verification
- Artifact Change Verification
- Behavior And Harness Proof
- Synthesis Verification
- Lead-Local Completion Discipline
- Evidence And Claim Strength Calibration
- Verification Output Detail

## Target Profiles
Use these profiles inside `SV-PLAN` or `SV-RESULT`; do not create a third SV mode.

| Profile | Use when | Typical mode |
|---|---|---|
| `plan-route` | frozen route, first action, dispatch readiness, lane/skill basis, blocker-clear path, or lead-local permission is being verified | `SV-PLAN` |
| `analysis-claim` | diagnosis, consistency analysis, risk analysis, recommendation, causal claim, or tradeoff judgment is being verified | `SV-RESULT` unless it authorizes action |
| `synthesis` | two or more agent outputs, evidence families, documents, verdicts, or prior decisions are merged into one conclusion | `SV-RESULT` |
| `artifact-change` | doctrine, skill, agent, hook, code, config, reference, or produced artifact was modified | `SV-RESULT`, with `SV-PLAN` before modification when consequential |
| `proof-harness` | behavior, data, state, runtime, user-surface, generated artifact, or retained evidence proves a claim | `SV-RESULT` |
| `handoff-report` | completion, user-facing report, closure claim, or redispatch basis is being formed | `SV-RESULT` |
| `anti-self-certification` | same-lane positive closure, acceptance-grade claim, materially risky result, or convenient conclusion needs stronger counter-bias and owner-separation checks | both |

If more than one profile applies, use all material profiles. If profile choice changes owner, surface, deliverable, proof basis, or acceptance chain, reopen `work-planning`.

## Reference Load Triggers
Load this reference when any condition below is true:
- routine plan-route `SV-PLAN` is not a load trigger by itself; load for `SV-PLAN` only when the compact spine cannot prove route readiness or a material non-routine trigger below affects the route
- analysis, diagnosis, risk assessment, recommendation, or causal reasoning is material to the claim
- result depends on external reference, code inference, document comparison, artifact inspection, or official/source evidence
- data, state, behavior, implementation design, domain meaning, or proof harness is part of the claim
- a governance, skill, agent, hook, code, config, or reference artifact was changed
- a user-facing completion, handoff, acceptance-grade claim, or redispatch basis is being reported
- two or more agent outputs or evidence sources are synthesized
- same-lane positive closure, acceptance-grade claim, materially risky result, or a conclusion convenient for the current actor is being verified
- evidence is partial, conflicting, unstored, not user-surface, or weaker than the claim
- lead-local work involves launch, runtime, smoke test, process spawn, generated artifact, screenshot/log/report, or operator-surface simulation

When a trigger fires, using only the compact spine is insufficient for positive convergence. If the reference cannot be consulted, use `HOLD`, `INFERENCE/UNVERIFIED`, or reopen the owner that can supply the missing basis.

## Challenge Lens Catalog
Use every lens that materially applies to the target. Omission of an applicable triggered lens is verification failure.

- Request-fit lens: what did the user actually ask for, forbid, de-prioritize, or emphasize; what burden or failure history shaped the request; what acceptance surface matters; would the current plan/result still satisfy the request if read literally?
- Claim/evidence lens: what is the exact claim, what evidence supports it, what evidence would defeat it, and what residual uncertainty remains?
- Counter-bias lens: if this conclusion is convenient for the current actor, what alternative explanation, overlooked evidence, owner-separation need, or acceptance downgrade would a skeptical independent lane raise?
- Requirement/rationale lens: why must this item exist, what parent need or self-derived decision justifies it, what assumption makes it valid, and what breaks if it is removed?
- Detailed-design/mechanism lens: which lower-level unit, input, output, state transition, data flow, control flow, algorithm, interface, dependency, timing constraint, and error path make the intended behavior happen?
- Data/domain engineering lens: what business meaning, bounded context, producer, consumer, source of truth, lifecycle, lineage, transformation, cardinality, optionality, invariant, CRUD/process coverage, and data-quality rule make this data valid and useful?
- Software development lens: are module boundaries cohesive, coupling controlled, contracts explicit, configuration and concurrency/idempotency risks handled, and errors observable and recoverable?
- Harness/proof lens: what replaceable dependency boundary, driver, stub, fake, fixture, seed data, simulator, instrumentation, oracle, report, retained CI artifact, telemetry field, or user-surface exercise proves the mechanism across normal, edge, and failure paths?
- Failure/risk lens: what are the most plausible failure modes, missing controls, missing feedback, off-nominal paths, misuse paths, severity, likelihood, detectability, and required mitigations?

## SV-PLAN Detailed Gate
Before authorizing consequential action, verify:
- `REQUEST-FIT-BASIS`, `REQUEST-BOUND-PACKET-FIELDS`, and `ACTION-CLASS` are present and coherent
- if `work-planning` triggered `REFERENCE-USE`, citation presence and specificity were checked in the compact spine before this detail gate opens
- top-level `team-lead` plans also carry coherent `ROUTING-SIGNAL`, `NEXT-CONSEQUENTIAL-ACTION`, `EXECUTION-READINESS-BASIS`, and mandatory `ACTIVE-WORKFLOW` or `ACTIVE-SEQUENCE` basis when applicable
- `NEXT-CONSEQUENTIAL-ACTION` names the first frozen local item, workflow/sequence owner, `task-execution`, exact authorization request, exact blocker-clear move, or `HOLD`
- readiness does not require the next owner to rediscover material packet schema, request-bound fields, lane skills, user-surface proof, tool/setup, run-path, environment, lifecycle, parallel grouping, proof owner, or acceptance owner
- routes that may enter `task-execution` have coherent `AGENT-MAP`, `PARALLEL-GROUPS`, `LANE-REQUIRED-SKILLS-MAP`, and `SKILL-RECOMMENDATIONS` under `work-planning` mandatory and `not-applicable` rules
- team-agent runtime routes do not depend on lead-only conversation history or implied upstream decisions instead of packet fields, task/workflow state, or cited artifacts
- delegated lane-local plans verify received assignment packet, owned work surface, required skills, first lane action, and stop condition
- team-lead workspace discovery, repository search, file reads, runtime probing, or external lookup is the frozen `NEXT-CONSEQUENTIAL-ACTION` or a verified `LEAD-LOCAL-WORK-ITEMS` entry
- phase-local skill refinement remains explainable as a refinement of the frozen phase purpose rather than a replacement for it

Reject and reopen when a plan hides a route-replan condition as packet correction, serializes unaffected independent surfaces by convenience, tries unauthorized additional-agent dispatch, treats progress/task-plan UI/skill-name/skill-read as completed planning, or depends on implied remainder.

## SV-RESULT Detailed Gate
Before consequential reporting, handoff, closure claim, synthesis-driven redispatch, or completion-style language, verify:
- the exact verified surface
- concise verification basis
- open surfaces and unverified items
- whether the result is produced, synthesized, inferred, or externally evidenced
- whether the current analysis/evaluation/synthesis report draft or exact outgoing consequential claim is covered by this `SV-RESULT`; prior analysis, memory, checklist language, or inline "SV-style" reasoning does not qualify
- whether the result matches request fit, detailed mechanism, data/domain meaning, lifecycle/lineage, interface contracts, proof evidence, and unresolved failure modes when those surfaces are part of the claim
- whether final prose strengthens the claim beyond the verified surface
- whether generated artifacts, logs, reports, traces, screenshots, coverage, binaries, images, or datasets have retained identity evidence rather than console-memory-only observation

If evidence is weaker than the claim, narrow the claim, downgrade to `INFERENCE/UNVERIFIED`, or `HOLD`.

## Analysis Claim Verification
For AI analysis, diagnosis, consistency review, risk analysis, causal explanation, recommendation, or design judgment:
- separate observation, inference, judgment, and recommendation
- cite or name the evidence surface that supports each controlling claim
- identify the strongest contrary interpretation or evidence that would defeat the conclusion
- mark partial coverage as partial instead of generalizing to the whole system
- do not treat fluent explanation, internal confidence, or repeated wording as evidence
- when reference material exists, verify that the conclusion follows the reference rather than a convenient substitute
- if the analysis becomes the basis for action, run `SV-PLAN` or reopen `work-planning` before action

Analysis is verified only at the strength of its evidence. It may justify `next action`, `HOLD`, or a bounded recommendation without proving final acceptance.

## Artifact Change Verification
For changes to doctrine, skills, agents, hooks, code, configs, references, or produced artifacts, verify:
- scope matches the frozen request and does not reopen excluded options
- declared design intent is preserved: Structural Contract, fixed section order, priority hierarchy, owner boundaries, authoring principles, protected local restatements, and section purpose
- the change strengthens what was weak without weakening what was already correct
- moved, compressed, replaced, or removed meaning remains reconstructable through source meaning, destination owner, and bounded change scope
- live cross-references still resolve
- the WHY of the change is anchored in inline rationale, commit/session patch record, or the change packet's failure-mode/recurrence tag
- no duplicate doctrine was added when adherence to an existing owner-local rule was the real fix

A result that passes claim-strength but fails design intent is not converged.

## Behavior And Harness Proof
For behavior, runtime, data, state, generated artifact, or user-surface claims, the proof path must be explainable as:
`mechanism -> replaceable boundary -> harness -> oracle -> retained evidence`.

Rules:
- if any link is missing, narrow the claim, reopen planning, or `HOLD`
- name the smallest truthful harness level that proves the behavior without losing required realism
- end-to-end proof is not a substitute for missing unit, integration, state-machine, fixture, or interface-contract proof when those are the sharper evidence path
- stateful or order-dependent mechanisms require named states, transitions, preconditions, invariants, and a proof strategy that can exercise valid, invalid, and boundary sequences
- user-facing proof must match the real user surface; source-only or indirect evidence may support diagnosis but not user-surface proof
- retained evidence must identify artifacts by path, report, log, screenshot, trace, output id, or equivalent stable surface when the claim depends on them

## Synthesis Verification
Synthesized conclusions do not inherit verification automatically.

Before positive synthesis:
- consume only completion-grade or otherwise evidence-bearing surfaces, not receipt/status/progress signals
- reconcile conflicts between agent outputs, evidence families, prior decisions, and sibling artifacts
- preserve open surfaces instead of flattening them into a clean conclusion
- keep claim strength limited to the weakest material unresolved surface
- if the synthesis points to redispatch, run `SV-RESULT` on the synthesized result before re-dispatch
- if synthesis touches existing-artifact integrity, apply design-intent verification before reporting a positive result

If agent outputs conflict, coverage is partial, or the synthesized conclusion outruns the evidence surface, narrow to verified scope, downgrade to `INFERENCE/UNVERIFIED`, or `HOLD`.

## Lead-Local Completion Discipline
When team-lead initiates lead-local verification or a "run-it-myself" check such as launch script execution, server polling, smoke testing, browser opening, operator action simulation, artifact rendering, or generated-output inspection:
- verification must run through to the user-facing acceptance surface or stop on an explicit blocker
- partial evidence must be labeled `INFERENCE/UNVERIFIED`, not reported as a verified result
- if a process is spawned, verification is not complete until the relevant surface is confirmed and spawned processes/resources are cleaned up, or an explicit blocker names the partial evidence and next action
- cleanup claims require enough detail to know what resource was opened and what evidence shows it is closed or not applicable
- if the check reveals a new owner, new surface, hidden consequential step, stronger claim, or changed acceptance chain, reopen `work-planning`

## Evidence And Claim Strength Calibration
Use the narrowest truthful result:
- `verified-result` only when the verified surface supports the claim and no material open surface blocks the conclusion
- `narrow-to-verified-scope` when part of the result is proven but broader wording would overclaim
- `INFERENCE/UNVERIFIED` when the conclusion is plausible but evidence is indirect, partial, unstored, source-only for a user-surface claim, or weaker than the claim
- `HOLD` when material evidence, owner, scope, proof, acceptance, or contradiction prevents truthful progress
- `reopen-work-planning` when scope, route, owner, proof basis, acceptance chain, or next action is invalidated

Do not use optimistic wording to bridge from partial evidence to completion. If claim strength exceeds evidence strength, the claim is wrong even when the likely outcome is favorable.

## Verification Output Detail
Use the compact `SKILL.md` output format for ordinary gates. When a reference trigger is active, add only the material fields below to the internal record:
```
SELF-VERIFICATION-DETAIL:
TARGET-PROFILES:
CHALLENGE-LENSES:
REQUEST-FIT-STATUS:
DEFEATERS:
COUNTER-BIAS-BASIS:
DATA-MEANING-BASIS:
DETAIL-DESIGN-BASIS:
HARNESS-PROOF-BASIS:
SYNTHESIS-BASIS:
ARTIFACT-IDENTITY-BASIS:
RISK-BASIS:
SKILL-BASIS-STATUS:
OWNER-SEPARATION-STATUS:
```

This detail block is internal handoff only. Do not expose it to the user unless the user explicitly requests the internal verification trace.
