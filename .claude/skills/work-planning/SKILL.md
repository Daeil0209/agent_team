---
name: work-planning
description: Freeze request fit, target, route, workflow/sequence, parallel fit, and skill basis before consequential action. Use when a new or reopened consequential boundary needs owner, scope, evidence, workflow, or skill-basis decisions.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Sharpens only its owned procedure surface.
- Fixed top-level section order after Structural Contract: Purpose, Activation Trigger, Step 0, Step 1, Step 2, Step 3, Internal Planning Record, Progress Update Surface, Post-Planning Gate, Next-Action Drive.
- Reference Map stays inside Purpose.
- Step names: Request-Fit Intake, Choose Planning Target, Q1-Q5 Work Analysis, Freeze Scope And Route.
- PRIMARY-OWNER: team-lead

## Purpose
Freeze the smallest complete plan basis before consequential action.
Own planning freeze only.
Execution, dispatch, review, proof, validation, completion reporting, and agent packets move to the named owner.

Procedure spine:
1. Freeze request fit.
2. Choose one planning target.
3. Run Q1-Q5.
4. Freeze only the fields required by the chosen target and route.
5. Open exactly one next owner/action.

Missing, vague, contradicted, or overclaimed basis blocks execution.
Output `HOLD`, blocker-clear, or reopened owner.

Boundary:
- `team-lead` owns thin instruction reading and channel opening.
- `work-planning` owns consequential freeze and target selection.
- workflow/sequence skills own their active phase after this freeze.
- `self-verification` owns `SV-PLAN` and `SV-RESULT`.
- `task-execution` owns host-authorized dispatch and packet truth.
- the planning record is internal carry-forward, not the agent packet.

### Reference Map
Load only the reference whose trigger is active.
Triggered references are mandatory before positive route freeze.
- `references/planning-targets.md`: target definitions, required basis, and target-switch rules.
- `references/reference-use.md`: reference-driven planning and source-deviation risk.
- `references/evidence-tier.md`: authority, benchmarks, and model-prior downgrade risk.
- `references/deliverable-defaults.md`: proof, review, validation, user burden, and acceptance defaults by deliverable type.
- `references/parallel-fit.md`: independent/sequential/interdependent discrimination, bottleneck defects, and serial basis.
- `references/team-runtime-fit.md`: team-agent runtime fit and standalone fallback-evidence boundary.
- `references/execution-readiness.md`: packet, proof, setup, lifecycle, parallel, and acceptance readiness.
- `references/planning-record-fields.md`: field values, conditional fields, record template, `not-applicable` bases, serial reasons, and bounded corrections.
- `references/cross-continuity.md`: same-session patches, confirmed corrections, recurrence barriers, decisions, contracts, lane changes, sibling outputs, and acceptance changes.
- `references/codex-advisory.md`: Codex MCP advisory trigger, packet, team-lead adjudication, fail-open, and authority/footprint limits.

If a needed reference cannot be loaded, freeze `HOLD`, blocker-clear, or reopened owner.

## Activation Trigger
Load after Priority 0 (`agents/team-lead.md`) classifies the turn as consequential.
Also load for reopened delegated lane boundary freeze.
Run before the first consequential tool call, artifact read, workspace discovery, external lookup, mutation, dispatch, reuse, or consequential report on a new or reopened boundary.
Counting evidence is actual `Skill(work-planning)` load plus required freeze.
Non-counting context includes Priority 0 text, progress, task-plan UI, route notes, Codex calls, and outside draft fields.

Unknown, scope-changing, route-shaping, or burden-sizing corpus discovery and file/line/byte counts are consequential discovery.
For exhaustive, full-corpus, whole-folder, governance audit/review, or unknown-corpus work, freeze bounded corpus measurement as the first action before route, staffing, or dispatch-readiness freeze.
Measurement basis must include file count, line or byte scale, semantic surface inventory, and high-touch or critical-surface notes sufficient to judge burden and parallel fit.
Run only that measurement action.
Then reopen or complete `work-planning` from the measured basis.
Do not freeze `team-dispatch-readiness-plan`, `AGENT-MAP`, `PARALLEL-GROUPS`, or dispatch-ready `NEXT-CONSEQUENTIAL-ACTION` from unmeasured material burden.
Known-owner lookup/status that does not diagnose, audit, analyze, route, dispatch, mutate, or size burden stays outside planning.

Planning belongs at boundary creation, not every internal correction.
Inside an active workflow phase, same-artifact correction/review/revision loops stay with the active workflow owner when all boundaries stay unchanged:
- phase
- canonical artifact
- frozen owner map
- deliverable shape
- staffing shape
- proof/acceptance chain
- user requirement

The active workflow owner governs that iteration.

Keep these outside planning unless they assign, reopen, or change consequential work:
- true `answer-only`
- narrow `SV-only audit`
- `notification-only carry-forward`
- governance relearning limited to known-owner lookup/status through `Read`/`Grep` with no diagnostic, audit, analytical, route, dispatch, mutation, or stronger-claim output
- receipt-only, control-only, lifecycle-only, phase-transition-only, or clarification-only messages

This exclusion ends when the message assigns, reopens, or changes consequential work.
It also ends when the work needs Bash/status/listing, discovery/measurement, route, dispatch, mutation, or a stronger claim.
Artifact judgment or analysis result ends the exclusion when it moves a boundary-change axis.

## Step 0: Request-Fit Intake
Freeze these before route judgment:
- intent
- `SEMANTIC-INTENT-BASIS`
- deliverable
- coverage and exhaustiveness
- primary user
- reference use
- burden cues
- proof
- defaults
- blockers
- request-bound packet fields

`CONCRETE-DELIVERABLE` and `PRIMARY-USER` drive deliverable type, delivery shape, defaults, and type triggers.
`DERIVED-DEFAULTS` drives receiver job, consumption path, decisive proof surface, and request-bound packet fields.

Full intake is mandatory when semantic intent, reference use, corrected intent, delivery burden, user-surface proof, or original wording affects execution.
The user-defined work scope is binding.
Samples, spot-checks, representative review, or finding-count quotas require explicit scope basis.
If artifact boundaries are unknown, freeze discovery as a planning fact and next owner/action before exploration.

## Step 1: Choose Planning Target
Choose one primary target before Q1-Q5.
Valid targets: `request-fit-plan`, `route-plan`, `lead-local-plan`, `team-dispatch-readiness-plan`, `workflow-sequence-plan`, `blocker-clear-plan`, `delegated-lane-plan`.
The selected target's required basis is binding.

Load `references/planning-targets.md` when target choice is unclear.
Also load it for material:
- target switching
- required basis
- lead-local legitimacy
- team-dispatch readiness
- workflow/sequence ownership
- blocker-clear scope
- delegated-lane boundary scope

Boundary-change axes: owner/phase, surface/artifact, deliverable, proof/acceptance chain, route/dispatch shape, staffing/parallel shape, skill basis, user requirement.
An axis moves when the next lawful action needs a different frozen value for that axis than the current boundary.
Movement test:
- owner/phase: owner lane, workflow phase, or sequence owner changes.
- surface/artifact: target artifact, user surface, or consumed source changes.
- deliverable: output kind, content contract, or scope baseline changes.
- proof/acceptance chain: proof burden, acceptance owner, or verdict identity changes.
- route/dispatch shape: lead-local, workflow, task-execution, team-runtime, or agent path changes.
- staffing/parallel shape: lane split, agent count, merge owner, or parallel grouping changes.
- skill basis: material non-lane-core skill basis changes.
- user requirement: explicit user constraint, priority, burden, or scope changes.
Same-boundary correction is valid only when every axis cites the current frozen value.
A moved axis reopens planning at that boundary.
Frozen boundary means the current binding values for these axes plus the selected planning target and required basis.
It updates only through reopened `work-planning` or owner-local correction that preserves every axis.

## Step 2: Q1-Q5 Work Analysis
Before scope freeze, answer:
1. What is the real purpose, including the user concern signal and anti-goal when expressed?
2. What work type or types are present?
3. What governing workflow, sequence, or methodology owns each type?
4. Are streams local single-surface, independent, sequential, or interdependent?
5. Which supporting skills are needed inside each stream?

Hold when purpose, `SEMANTIC-INTENT-BASIS`, work type, owner, workflow/sequence, surface count, or skill basis cannot be named truthfully.

Parallel law:
- See `references/parallel-fit.md` for independent/sequential/interdependent discrimination, burden basis, bottleneck-defect rule, and serial-basis evidence.
- Additional-agent dispatch freezes team-agent runtime; absent runtime means later `task-execution` starts with `TeamCreate` per CLAUDE.md `[PARALLEL]`.

User-surface law:
- If truthful proof or acceptance needs a missing user-facing surface or tool path, freeze a bounded discovery/setup owner or blocker.
- Use source-only evidence only when it truthfully matches the user-facing proof surface.

## Step 3: Freeze Scope And Route
Freeze only what the selected planning target requires.
See `references/planning-record-fields.md` for field values, conditional fields, `not-applicable` rules, serial reasons, bounded corrections, and the record template.

Always freeze:
- `REQUEST-FIT-BASIS`
- `SEMANTIC-INTENT-BASIS`
- `REQUEST-BOUND-PACKET-FIELDS`
- `ACTION-CLASS`
- `ROUTING-SIGNAL`
- `NEXT-CONSEQUENTIAL-ACTION`
- `DISPATCH-BLOCKERS`

Freeze when material:
- governance depth: `PROJECT-TIER`, `ACTIVE-REQUEST-TIER`, `TIER-RAISE-REASON`
- workflow/sequence: `ACTIVE-WORKFLOW`, `ACTIVE-SEQUENCE`
- analysis/critique/judgment: `CLAIM-CEILING`
- lead-local: `LEAD-LOCAL-WORK-ITEMS`, `LEAD-LOCAL-REQUIRED-SKILLS`
- team-routed/ambiguous/dispatch-capable: `AGENT-MAP`, `PARALLEL-GROUPS`, `LANE-REQUIRED-SKILLS-MAP`, `SKILL-RECOMMENDATIONS`, `EXECUTION-READINESS-BASIS`
- Codex advisory: `CODEX-ADVISORY-BASIS`

Codex advisory law:
- Apply `references/codex-advisory.md` after draft route fields exist when an advisory trigger fires (including `ACTIVE-WORKFLOW: dev-workflow`, reference-risk triggers, and pre-escalation confirmation review for non-destructive, non-security, non-operator-policy-choice user-question candidates).
- The reference owns adjudication, fail-open, accepted/rejected acknowledgment, and continuation-without-blocker rules; unrecorded required or triggered advisory basis leaves `work-planning` incomplete.

Hard stops:
- `NEXT-CONSEQUENTIAL-ACTION` names the first local item, workflow owner, sequence owner, `task-execution`, blocker-clear move, authorization request, or `HOLD`.
- Planning opens one next owner/action before execution, dispatch, or reporting.
- Route, staffing, parallelism, and dispatch option lists to the user are invalid when doctrine and evidence can choose the best route.
- Required measurement missing from exhaustive, full-corpus, whole-folder, governance audit/review, or unknown-corpus work blocks `team-dispatch-readiness-plan`, `AGENT-MAP`, `PARALLEL-GROUPS`, and dispatch-ready `NEXT-CONSEQUENTIAL-ACTION`.
- `PARALLEL-GROUPS: none` is invalid for multi-surface or unmeasured material corpus work unless a measured dependency or serial-burden basis proves serial stronger than parallel.
- Lane-core skills are not listed in packet `REQUIRED-SKILLS`.
- Lane ownership lazy-loads them.
- Use `[]` when no additional non-lane-core skill is required.
- Agent-boundary transfer uses `task-execution` packet translation, not this internal record.
- New consequential item, surface, owner map, hidden step, route ambiguity, or stronger claim reopens `work-planning` only when it changes the frozen boundary.
- A same-phase same-artifact workflow iteration is not new when every boundary named in Activation Trigger remains unchanged.

Use `references/execution-readiness.md` when packet, proof, setup, lifecycle, parallel, or acceptance readiness is at risk.

## Internal Planning Record
Populate the internal record from `references/planning-record-fields.md`.
Hold it in current-turn context only.
Expose only plain next action, blocker, or owner/action truth.
Write continuity only when a continuity owner requires it.
Agent packets use `task-execution` translation.

## Progress Update Surface
Follow `team-lead/references/output-surface-law.md`.
Planning progress is silent while the next owner/action can run in the same segment.
If execution is stopped, emit one plain line naming blocker, required user action, explicit status answer, or next owner/action.
Keep the planning record internal.

## Post-Planning Gate
After planning:
1. Open exactly one next owner/action.
2. If `ACTIVE-WORKFLOW` or a non-`not-applicable` `ACTIVE-SEQUENCE` is set, open the owner named by `NEXT-CONSEQUENTIAL-ACTION`.
3. The named owner must be loaded and run to its named outcome when absent/stale/wrong-boundary, or consumed (and rerun to outcome if stale) when current, before lead-local action, `task-execution`, user reporting, phase movement, or mutation.
4. Source lookup, remembered procedure text, advisory input, or unchecked owner summary does not satisfy named-owner consumption.
5. `team-routing candidate` or `ambiguous-route` opens `task-execution`.
6. Load `self-verification` in `SV-PLAN` mode only for an explicit plan-audit target or disputed frozen-plan readiness.
7. If the frozen target, route, readiness basis, or next action is missing, vague, contradicted, or unconsumed, reopen `work-planning`.

## Next-Action Drive
- A completed freeze opens `NEXT-CONSEQUENTIAL-ACTION`.
- A workflow or sequence freeze opens the named workflow or sequence owner.
- A team-routed or ambiguous route opens `task-execution`.
- A missing freeze field reopens `work-planning`.
- A blocker-clear plan opens the named blocker-clear move.
- `HOLD` records planning owner, blocker, and next safe evidence step.
