---
name: work-planning
description: Freeze request fit, target, route, workflow/sequence, parallel fit, and skill basis before consequential action. Excludes light or receipt/control-only messages.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Sharpens only its owned procedure surface.
- Fixed section order: Purpose, Activation Trigger, Step 0, Step 1, Step 2, Step 3, Internal Planning Record, Progress Update Surface, Post-Planning Gate.
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
5. Open exactly one next owner.

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
- `references/cross-continuity.md`: same-session patches, decisions, contracts, lane changes, and acceptance changes.
- `references/codex-advisory.md`: Codex MCP advisory trigger, packet, forced acknowledgment, fail-open, and authority/footprint limits.

If a needed reference cannot be loaded, freeze `HOLD`, blocker-clear, or reopened owner.

## Activation Trigger
Load after Priority 0 (`agents/team-lead.md`) classifies the turn as consequential.
Also load for delegated lane-owned planning or a reopened lane boundary.
Run before the first consequential tool call, artifact read, workspace discovery, external lookup, mutation, dispatch, reuse, or consequential report on a new or reopened boundary.
Counting evidence is actual `Skill(work-planning)` load plus required freeze.
Non-counting context includes Priority 0 text, progress, task-plan UI, route notes, Codex calls, and outside draft fields.

Corpus discovery, file/line/byte counts, and burden sizing are consequential discovery.
Freeze that discovery here.
Run only that action.
Then reopen or complete `work-planning` from the measured basis.

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

Full intake is mandatory when reference use, corrected intent, delivery burden, user-surface proof, or original wording affects execution.
The user-defined work scope is binding.
Samples, spot-checks, representative review, or finding-count quotas require explicit scope basis.
If artifact boundaries are unknown, freeze discovery as a planning fact and next owner before exploration.

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
- delegated-lane scope

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
1. What is the real purpose?
2. What work type or types are present?
3. What governing workflow, sequence, or methodology owns each type?
4. Are streams local single-surface, independent, sequential, or interdependent?
5. Which supporting skills are needed inside each stream?

Hold when purpose, work type, owner, workflow/sequence, surface count, or skill basis cannot be named truthfully.

Parallel law:
- Count only bounded outputs independent of another counted surface.
- Ordinary substeps are not independent surfaces.
- 2+ independent bounded surfaces are parallel-fit.
- Serial convenience over independent specialist-fit work surfaces is a bottleneck defect unless `references/parallel-fit.md` proves stronger serial basis.
- Additional-agent dispatch freezes team-agent runtime; absent runtime means later `task-execution` starts with `TeamCreate`.
- Standalone `Agent` is not lane dispatch.

User-surface law:
- If truthful proof or acceptance needs a missing user-facing surface or tool path, freeze a bounded discovery/setup owner or blocker.
- Use source-only evidence only when it truthfully matches the user-facing proof surface.

## Step 3: Freeze Scope And Route
Freeze only what the selected planning target requires.
See `references/planning-record-fields.md` for field values, conditional fields, `not-applicable` rules, serial reasons, bounded corrections, and the record template.

Always freeze:
- `REQUEST-FIT-BASIS`
- `REQUEST-BOUND-PACKET-FIELDS`
- `ACTION-CLASS`
- `ROUTING-SIGNAL`
- `NEXT-CONSEQUENTIAL-ACTION`
- `DISPATCH-BLOCKERS`

Freeze when material:
- governance depth: `PROJECT-TIER`, `ACTIVE-REQUEST-TIER`, `TIER-RAISE-REASON`
- workflow/sequence: `ACTIVE-WORKFLOW`, `ACTIVE-SEQUENCE`
- lead-local: `LEAD-LOCAL-WORK-ITEMS`, `LEAD-LOCAL-REQUIRED-SKILLS`
- team-routed/ambiguous/dispatch-capable: `AGENT-MAP`, `PARALLEL-GROUPS`, `LANE-REQUIRED-SKILLS-MAP`, `SKILL-RECOMMENDATIONS`, `EXECUTION-READINESS-BASIS`
- Codex advisory: `CODEX-ADVISORY-BASIS`

Codex advisory law:
- Load `references/codex-advisory.md` after actual `Skill(work-planning)` load and draft route fields.
- Required attempt for `ACTIVE-WORKFLOW: dev-workflow`.
- Load for the reference risk triggers.
- Before user-decision escalation that is not destructive, security, or policy, run Codex confirmation review with canonical `doctrine_read_paths`.
- A configurable unknown routes to best default, parameter, assumption/open question, or owner evidence path.
- If parameterization preserves data and architecture, use the configurable path.
- Without a team-lead-verified true blocker from Codex, continue through best default, parameter, assumption/open question, or owner evidence route.
- Outcomes are accepted/rejected acknowledgment or fail-open.
- Silent skip reopens planning.
- Codex returns advice or fail-open; Claude owns block, lane, dispatch, and acceptance decisions.

Hard stops:
- `NEXT-CONSEQUENTIAL-ACTION` names the first local item, workflow owner, sequence owner, `task-execution`, blocker-clear move, authorization request, or `HOLD`.
- Planning opens one next owner before execution, dispatch, or reporting.
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
Expose only plain next action, blocker, or owner truth.
Write continuity only when a continuity owner requires it.
Agent packets use `task-execution` translation.

## Progress Update Surface
Progress text, when needed, says only current decision, next action, or blocker in plain prose.
Keep planning fields, packet labels, freeze lines, and internal records internal.

## Post-Planning Gate
After planning:
1. Open exactly one next owner.
2. If `ACTIVE-WORKFLOW` or a non-`not-applicable` `ACTIVE-SEQUENCE` is set, open the owner named by `NEXT-CONSEQUENTIAL-ACTION`.
3. `team-routing candidate` or `ambiguous-route` opens `task-execution`.
4. Load `self-verification` in `SV-PLAN` mode only for an explicit plan-audit target or disputed frozen-plan readiness.
5. If the frozen target, route, readiness basis, or next action is missing, vague, or contradicted, reopen `work-planning`.
