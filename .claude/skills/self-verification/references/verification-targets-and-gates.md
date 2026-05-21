---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/self-verification/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---
# Self-Verification Reference
Load only after `Skill(self-verification)` triggers a detailed target profile, challenge lens, evidence calibration, harness/proof check, synthesis claim check, material same-lane self-certification risk, or expanded output record.
For material defect, removal, cross-surface governance, or patch-worthiness detail, record the next review judgment: `owner-local-sufficient:<basis>`, `Skill(review-verification):<bounded-question>`, `Skill(governance-modification):<governance-modification-basis>`, redispatch, or report.
`Skill(review-verification):<bounded-question>` consumes `.claude/skills/review-verification/references/governance-review-gates.md`.

## Contents
- Target Profiles
- Reference Load Triggers
- Challenge Lens Catalog
- Plan-Audit Detailed Gate
- Result-Verification Detailed Gate
- Analysis Claim Verification
- Artifact Claim Verification
- Behavior And Harness Proof
- Synthesis Verification
- Lead-Local Completion Discipline
- Evidence And Claim Strength Calibration
- Verification Output Detail

## Target Profiles
Use these profiles inside `plan-audit` or `result-verification`; do not create a third verification mode.

| Profile | Use when | Typical mode |
|---|---|---|
| `plan-route` | an explicit plan-audit target or disputed frozen route, first action, dispatch readiness, lane/skill basis, blocker-clear path, or lead-local permission is being verified | `plan-audit` |
| `analysis-claim` | diagnosis, consistency analysis, risk analysis, recommendation, causal claim, or tradeoff judgment is being verified | `result-verification`; if it becomes action basis, reopen `work-planning` before action |
| `synthesis` | two or more agent outputs, evidence families, documents, verdicts, or prior decisions are merged into one conclusion | `result-verification` |
| `artifact-change` | doctrine, skill, agent, hook, code, config, reference, or produced artifact was modified | `result-verification`; use `plan-audit` only when the change plan itself is disputed |
| `proof-harness` | behavior, data, state, runtime, user-surface, generated artifact, or retained evidence proves a claim | `result-verification` |
| `handoff-report` | completion, user-facing report, closure claim, or redispatch basis is being formed | `result-verification` |
| `anti-self-certification` | same-lane positive closure, acceptance-grade claim, materially risky result, or convenient conclusion needs defeater-first counter-bias and owner-separation checks | both |

If more than one profile applies, use all material profiles. If profile choice changes owner, surface, deliverable, proof basis, or acceptance chain, reopen `work-planning`.

## Reference Load Triggers
Load this reference when any condition below is true:
- routine plan-route is not a load trigger; load `Skill(self-verification)` in `plan-audit` mode only for an explicit plan-audit target or disputed frozen-plan readiness
- analysis, diagnosis, risk assessment, recommendation, or causal reasoning is material to the claim
- result depends on external reference, code inference, document comparison, artifact inspection, or official/source evidence
- data, state, behavior, implementation design, domain meaning, or proof harness is part of the claim
- a governance, skill, agent, hook, code, config, or reference artifact was changed
- a user-facing completion, handoff, acceptance-grade claim, or redispatch basis is being reported
- two or more agent outputs or evidence sources are synthesized
- same-lane positive closure, acceptance-grade claim, materially risky result, or a conclusion convenient for the current actor is being verified
- evidence is partial, conflicting, unstored, not user-surface, or weaker than the claim
- lead-local work involves launch, runtime, smoke test, process spawn, generated artifact, screenshot/log/report, or operator-surface simulation

When a trigger fires, using only the compact spine is insufficient for positive convergence. The actor must identify plausible defeaters before confirmation. If the reference cannot be consulted, use `HOLD`, `INFERENCE/UNVERIFIED`, or reopen the owner that can supply the missing basis.

## Challenge Lens Catalog
Use every lens that materially applies to the target. Omission of an applicable triggered lens is verification failure.

- Request-fit lens: what did the user actually ask for, forbid, de-prioritize, or emphasize?
- Semantic-fit lens: what user concern, anti-goal, failure history, active philosophy section or keyword, target intent, or priority order shaped the request?
- Acceptance-fit lens: what acceptance surface matters?
- Result-fit lens: does the current plan/result satisfy the explicit request, frozen semantic intent, material target intent, and acceptance surface?
- Claim/evidence lens: what is the exact claim, what evidence supports it, what evidence would defeat it, and what residual uncertainty remains?
- Counter-bias lens: if this conclusion is convenient for the current actor, what alternative explanation, overlooked evidence, owner-separation need, acceptance downgrade, or disconfirming test would a skeptical independent lane raise?
- Requirement/rationale lens: why must this item exist, what parent need or self-derived decision justifies it, what assumption makes it valid, and what breaks if it is removed?
- Review-routing lens: which next review judgment fits the produced result: `owner-local-sufficient:<basis>`, `Skill(review-verification):<bounded-question>`, `Skill(governance-modification):<governance-modification-basis>`, redispatch, report, or `HOLD`?
- Detailed-design/mechanism lens: which lower-level unit, input, output, state transition, data flow, control flow, algorithm, interface, dependency, timing constraint, and error path make the intended behavior happen?
- Data/domain engineering lens: what business meaning, bounded context, producer, consumer, source of truth, lifecycle, lineage, transformation, cardinality, required/omitted state, invariant, CRUD/process coverage, and data-quality rule make this data valid and useful?
- Software development lens: are module boundaries cohesive, coupling controlled, contracts explicit, configuration and concurrency/idempotency risks handled, and errors observable and recoverable?
- Harness/proof lens: what replaceable dependency boundary, driver, stub, fake, fixture, seed data, simulator, instrumentation, oracle, report, retained CI artifact, telemetry field, or user-surface exercise proves the mechanism across normal, edge, and failure paths?
- Failure/risk lens: what are the most plausible failure modes, missing controls, missing feedback, off-nominal paths, misuse paths, severity, likelihood, detectability, and required mitigations?

## Plan-Audit Detailed Gate
When exception-only `plan-audit` is loaded before consequential action, verify:
- `REQUEST-FIT-BASIS`, `SEMANTIC-INTENT-BASIS`, `DERIVED-DEFAULTS`, `REQUEST-BOUND-PACKET-FIELDS`, and `ACTION-CLASS` are present and coherent
- material `TARGET-INTENT-BASIS` is present before existing-artifact, governance, artifact-change, review, proof, validation, or patch-worthiness claims
- top-level `team-lead` plans carry `TEAM-LEAD-WORK-PLAN` rows for material phase, owner, action, stop/evidence, review/verification judgment, iteration, and termination
- if the `work-planning` reference-use trigger fired, citation or deviation basis is present in `REQUEST-FIT-BASIS` and any material request-bound packet fields before this detail gate opens
- top-level `team-lead` plans also carry coherent `ROUTING-SIGNAL`, `NEXT-CONSEQUENTIAL-ACTION`, `EXECUTION-READINESS-BASIS`, and mandatory `ACTIVE-WORKFLOW` or `ACTIVE-SEQUENCE` basis when applicable
- `NEXT-CONSEQUENTIAL-ACTION` names the first frozen local item, workflow/sequence owner, `Skill(task-execution)` when activation basis is absent/stale/wrong-boundary, loaded `task-execution` consumption with current same-session basis, exact authorization request, exact blocker-clear move, or `HOLD`
- readiness does not require the next owner to rediscover material packet schema, request-bound fields, lane skills, user-surface proof, tool/setup, run-path, environment, lifecycle, parallel grouping, proof owner, acceptance owner, or next action
- routes eligible to enter `task-execution` have coherent `AGENT-MAP`, `PARALLEL-GROUPS`, `LANE-REQUIRED-SKILLS-MAP`, and `SKILL-RECOMMENDATIONS` under `work-planning` mandatory and `not-applicable` rules
- `PARALLEL-GROUPS` burden basis must be measured or cited.
- File-count alone, guessed, or pre-`work-planning` basis is not valid.
- Missing material measurement opens `reopen-work-planning` or `HOLD`.
- consequential top-level plans have coherent `CODEX-INDEPENDENT-REVIEW-BASIS` when configured independent-review trigger handling is required or frozen
- `ACTIVE-WORKFLOW: dev-workflow` must show configured independent-review trigger handling as `triggered:*`, `fail-open:*`, or `skipped:no-material-independent-review-trigger:<basis>` when that review basis is required or frozen
- configured independent-review risk triggers from `Skill(codex-independent-review)` make `skipped:*` invalid; use `triggered:*` or `fail-open:*` when any material trigger applies
- `CODEX-INDEPENDENT-REVIEW-BASIS: triggered:*` requires active team-lead adjudication of every valid configured-review point.
- Accept requires field/value change.
- Reject requires grounded rationale.
- Codex output alone is not the basis.
- team-agent runtime routes do not depend on lead-only conversation history or implied upstream decisions instead of packet fields, task/workflow state, or cited artifacts
- delegated lane-local plans verify received assignment packet, owned work surface, required skills, first lane action, and stop condition
- team-lead workspace discovery, repository search, file reads, runtime probing, or external lookup is the frozen `NEXT-CONSEQUENTIAL-ACTION` or a verified `LEAD-LOCAL-WORK-ITEMS` entry
- phase-local skill refinement remains explainable as a refinement of the frozen phase purpose rather than a replacement for it

Reject and reopen when a plan hides a route-replan condition as packet correction, serializes unaffected independent surfaces by convenience, tries unauthorized additional-agent dispatch, treats progress/task-plan UI/skill-name/skill-read as completed planning, or depends on implied remainder.

## Result-Verification Detailed Gate
Before consequential reporting, handoff, closure claim, synthesis-triggered redispatch, or completion-style language, verify:
- the exact verified surface
- concise verification basis
- open surfaces and unverified items
- whether the result is produced, synthesized, inferred, or externally evidenced
- whether the current analysis/evaluation/synthesis report draft or exact outgoing consequential claim is covered by this `Skill(self-verification)` result-verification run; prior analysis, memory, checklist language, or inline "self-verification-style" reasoning does not qualify
- whether the result matches request fit, semantic intent, material target intent, detailed mechanism, data/domain meaning, lifecycle/lineage, interface contracts, proof evidence, and unresolved failure modes when those surfaces are part of the claim
- whether final prose strengthens the claim beyond the verified surface
- whether final prose exceeds Evidence-Quality Matrix supported scope, `FROZEN-CONTRACT-STATUS`, or retained `OPEN-SURFACES` state when those artifacts are material
- whether generated artifacts, logs, reports, traces, screenshots, coverage, binaries, images, or datasets have retained identity evidence rather than console-memory-only observation

If evidence is weaker than the claim, narrow the claim, downgrade to `INFERENCE/UNVERIFIED`, or `HOLD`.

## Analysis Claim Verification
For AI analysis, diagnosis, consistency review, risk analysis, causal explanation, recommendation, or design judgment:
- separate observation, inference, judgment, and recommendation
- cite or name the evidence surface that supports each controlling claim
- actively search for the strongest contrary interpretation or evidence that would defeat the conclusion
- record `Skill(governance-modification):<governance-modification-basis>` when the verified produced result requires governance asset change or recurrence-barrier hardening
- record `Skill(review-verification):<bounded-question>` when the verified produced result needs material defect labels, removal judgments, cross-surface governance judgments, or patch recommendations
- record `owner-local-sufficient:<basis>` when the active owner can correct, narrow, route, or report the produced result without extra review
- For governance audit, doctrine cleanup, or defect-sweep results, `owner-local-sufficient:<basis>` can close only evidence-only candidate discovery or lane-local first-pass classification; binding filtering, final rejection, promotion, ranking, prioritization, correction-priority, removal, patch-worthiness, patch-readiness, or patch/no-patch selection records `Skill(review-verification):<bounded-question>`.
- after `review-verification` returns, verify only whether the outgoing claim matches that review packet
- mark partial coverage as partial instead of generalizing to the whole system
- do not treat fluent explanation, internal confidence, or repeated wording as evidence
- when reference material exists, verify that the conclusion follows the reference rather than a convenient substitute
- if the analysis becomes the basis for action, reopen `work-planning` before action; use `plan-audit` only when the action plan itself is disputed

Analysis is verified only at the strength of its evidence. It justifies `next action`, `HOLD`, or a bounded recommendation without proving final acceptance.

## Artifact Claim Verification
For changed doctrine, skills, agents, hooks, code, configs, references, or produced artifacts, self-verification verifies the outgoing claim surface, not the full governance review.
- Verify that the reported scope matches the frozen request and changed artifact identity.
- Verify that the claim is backed by retained evidence, live paths, or current diff.
- Verify that unresolved review, proof, or acceptance surfaces remain open instead of being reported as closed.
- For design-intent, owner-boundary, information-preservation, cross-reference, duplicate-doctrine, or patch-worthiness judgment outside an active `Skill(governance-modification)` patch loop, record `Skill(review-verification):<bounded-question>` and consume `.claude/skills/review-verification/references/governance-review-gates.md`; inside that loop, return to its `REVIEW-VERIFICATION-NEED` gate.

A result that passes claim-strength but lacks the required next review judgment is not converged.

## Behavior And Harness Proof
For behavior, runtime, data, state, generated artifact, or user-surface claims, the proof path must be explainable as:
`mechanism -> replaceable boundary -> harness -> oracle -> retained evidence`.

Rules:
- if any link is missing, narrow the claim, reopen planning, or `HOLD`
- name the smallest truthful harness level that proves the behavior without losing required realism
- end-to-end proof is not a substitute for missing unit, integration, state-machine, fixture, or interface-contract proof when those are the sharper evidence path
- stateful or order-dependent mechanisms require named states, transitions, preconditions, invariants, and a proof strategy that can exercise valid, invalid, and boundary sequences
- user-facing proof must match the real user surface
- when the frozen deliverable is a source/read document, source/read inspection is the real surface
- otherwise, source-only or indirect evidence supports diagnosis only
- retained evidence must identify artifacts by path, report, log, screenshot, trace, output id, or equivalent stable surface when the claim depends on them
- visual or rendered user-surface claims require retained evidence identity for capture scope, route/page/screen-state coverage, glyph sanity, and inspected defect classes.
- Screenshot existence, DOM text, or source text alone is not enough.

## Synthesis Verification
Synthesized conclusions do not inherit verification automatically.

Self-verification-specific synthesis duties:
- if synthesis selects governance asset change or recurrence-barrier hardening as next owner/action, record `Skill(governance-modification):<governance-modification-basis>` and verify that route.
- route finding promotion to `Skill(review-verification):<bounded-question>` before any `confirmed-defect`, removal, or patch-worthiness claim leaves this skill.
- for governance audit or defect-sweep candidate maps, verify candidate-map integrity, lane-local candidate-state preservation, and proposed review target, then route binding filtering, final rejection, promotion, ranking, prioritization, correction-priority, removal, patch-worthiness, patch-readiness, or patch/no-patch selection to `Skill(review-verification):<bounded-question>`.
- if the synthesis points to redispatch, run result verification on the synthesized result before re-dispatch.
- if synthesis touches existing-artifact integrity, apply design-intent verification before reporting a positive result.

Shared synthesis discipline (consume only completion-grade evidence, reconcile conflicts, preserve common finding classes, preserve open surfaces, cap claim strength at the weakest unresolved surface, keep final wording inside Evidence-Quality Matrix scope) is owned by `.claude/skills/review-verification/references/governance-review-gates.md` `## Synthesis And Finding-Promotion Review`.

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
- `INFERENCE/UNVERIFIED` when the conclusion is plausible but evidence is indirect, partial, unstored, source-only for a non-source user-surface claim, or weaker than the claim
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

## Resolve Next Owner And Action
- `verified-result` returns to the requesting owner for truthful reporting or next action.
- `narrow-to-verified-scope` returns narrowed claim wording to the requesting owner.
- `INFERENCE/UNVERIFIED` opens evidence gathering, claim narrowing, or truthful report by active owner.
- `HOLD` opens blocker reporting with owner and blocker.
- `reopen-work-planning` opens `work-planning`.
- Produced-result governance asset change or recurrence-barrier hardening opens `Skill(governance-modification)`.
- Material defect, removal, cross-surface governance, or patch-worthiness gap opens `Skill(review-verification):<bounded-question>`.
- Synthesis verification gap opens conflict reconciliation before reporting or redispatch.
- Lead-local verification resource debt opens cleanup or explicit blocker before closure.
