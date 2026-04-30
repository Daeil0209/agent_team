---
name: work-planning
description: Freeze request fit, planning target, route, workflow/sequence, parallel fit, and skill basis before consequential action; not for light or receipt/control-only messages.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Inherits `CLAUDE.md`, the active owner role, and the common inheritance floor in `CLAUDE.md` `Priority And Ownership`. This skill may sharpen its owned procedure surface, but it must not weaken that floor or the owning role's stop conditions.
- Fixed section order: Purpose, Activation Trigger, Step 0: Request-Fit Intake, Step 1: Choose Planning Target, Step 2: Q1-Q5 Work Analysis, Step 3: Freeze Scope And Route, Internal Planning Record, Progress Update Surface, Post-Planning Gate
- PRIMARY-OWNER: team-lead
- Structural changes require governance review.

## Purpose
Freeze the smallest complete plan basis before consequential action. This skill never executes, dispatches, reviews, tests, validates, or reports completion.

Procedure spine:
1. Freeze request fit.
2. Choose one planning target.
3. Run Q1-Q5.
4. Freeze only the fields required by the chosen target and route.
5. Open exactly one next owner, then pass through `SV-PLAN` unless a frozen workflow/sequence owner must open first.

If any required basis is missing, vague, contradicted, or stronger than evidence supports, the output is `HOLD`, blocker-clear, or reopened owner, not improvised execution.

Boundary:
- `team-lead` owns thin instruction interpretation and channel opening.
- `work-planning` owns consequential freeze and planning-target selection.
- workflow/sequence skills own their active phase after this freeze.
- `self-verification` owns `SV-PLAN` and `SV-RESULT`.
- `task-execution` owns host-authorized dispatch and packet truth.
- the planning record is internal carry-forward, never the agent-facing dispatch packet.

### Reference Map
Load only the reference whose trigger is active; triggered references are mandatory before positive route freeze.
- `references/planning-targets.md`: planning-target definitions, target-specific required basis, and target-switch rules.
- `references/reference-use.md`: reference-driven planning or source-material deviation risk.
- `references/evidence-tier.md`: external authority, benchmark evidence, or model-prior downgrade risk.
- `references/deliverable-defaults.md`: deliverable type changes proof, review, validation, user burden, or acceptance defaults.
- `references/parallel-fit.md`: independent/sequential/interdependent discrimination, bottleneck defects, and serial reasons.
- `references/team-runtime-fit.md`: standalone Agent vs team-agent runtime selection.
- `references/execution-readiness.md`: packet, proof, tool/setup, lifecycle, parallel, and acceptance readiness.
- `references/planning-record-fields.md`: allowed field values, mandatory/conditional fields, internal record template, `not-applicable` bases, serial reasons, and bounded corrections.
- `references/cross-continuity.md`: prior same-session patches, decisions, contracts, lane changes, and acceptance changes.

If a needed reference cannot be loaded, freeze `HOLD`, blocker-clear, or reopened owner instead of approving from the compact spine.

## Activation Trigger
Load after Priority 0 (`agents/team-lead.md`) classifies the turn as consequential, or when a delegated lane receives consequential lane-owned work. Run before the first consequential tool call, file read for artifact judgment, workspace discovery, external lookup, mutation, dispatch, reuse, or consequential report.

Do not load for true `answer-only`, narrow `SV-only audit`, `notification-only carry-forward`, receipt-only, control-only, lifecycle-only, phase-transition-only, or clarification-only messages unless they assign, reopen, or change consequential work.

## Step 0: Request-Fit Intake
Freeze request intent, concrete deliverable, primary user, reference use, burden cues, proof direction, derived defaults, material blockers, and request-bound packet fields before route judgment. This step is the canonical entry for CLAUDE.md `[USER-DELIVERY-FIT]`: `CONCRETE-DELIVERABLE` and `PRIMARY-USER` drive deliverable type, delivery shape, defaults, and type-specific triggers downstream.

Full intake is mandatory when reference use, corrected intent, delivery burden, user-surface proof, or original wording materially affects downstream execution. If artifact boundaries are unknown, freeze discovery as a planning fact and next owner; do not explore first by habit.

## Step 1: Choose Planning Target
Choose one primary target before Q1-Q5: `request-fit-plan`, `route-plan`, `lead-local-plan`, `team-dispatch-readiness-plan`, `workflow-sequence-plan`, `blocker-clear-plan`, or `delegated-lane-plan`. The selected target's required basis is binding.

Load `references/planning-targets.md` when target choice is not obvious from the listed targets, or when target switching, target-specific required basis, lead-local legitimacy, team-dispatch readiness, workflow/sequence ownership, blocker-clear scope, or delegated-lane scope is material. A target that changes owner, surface, proof/acceptance chain, or dispatch shape reopens planning instead of extending the pass.

## Step 2: Q1-Q5 Work Analysis
Before scope freeze, answer:
1. What is the real purpose?
2. What work type or types are present?
3. What governing workflow, sequence, or methodology owns each type?
4. Are streams local single-surface, independent, sequential, or interdependent?
5. Which supporting skills are needed inside each stream?

Hold instead of guessing when purpose, work type, owner, workflow/sequence, surface count, or skill basis cannot be named truthfully.

Parallel law:
- Count only bounded outputs that can proceed without waiting on another counted surface; ordinary substeps are not independent surfaces.
- 2+ independent bounded surfaces are parallel-fit. Serial convenience over independent implementation surfaces is a bottleneck defect unless `references/parallel-fit.md` proves a stronger serial reason.
- Additional-agent dispatch is valid only on a host-authorized active-runtime path and later `task-execution`.

User-surface law: if truthful proof or acceptance needs a user-facing surface or tool path that is missing, freeze a bounded discovery/setup owner or blocker; do not downgrade to source-only evidence by habit.

## Step 3: Freeze Scope And Route
Freeze only what the selected planning target requires. Field values, required/conditional fields, `not-applicable` rules, serial reasons, bounded correction rules, and the internal record template live in `references/planning-record-fields.md`.

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

Hard stops:
- `NEXT-CONSEQUENTIAL-ACTION` must name the first local item, workflow owner, sequence owner, `task-execution`, exact blocker-clear move, exact authorization request, or `HOLD`.
- Planning opens one next owner; it does not fall through into execution, dispatch, or reporting.
- Lane-core skills are not listed in packet `REQUIRED-SKILLS`; lane ownership lazy-loads them. Use `[]` when no additional non-lane-core skill is required.
- Agent-boundary transfer happens through `task-execution` packet translation, not by forwarding this internal record.
- Any new consequential item, surface, owner, hidden step, route ambiguity, or stronger claim reopens `work-planning`.

Use `references/execution-readiness.md` when packet, proof, tool/setup, lifecycle, parallel, or acceptance readiness could be incomplete.

## Internal Planning Record
Populate the internal record from `references/planning-record-fields.md`. Hold it in current-turn context only. Do not emit labelled fields to the user, write a continuity file by habit, or forward the full planning record as an agent packet.

## Progress Update Surface
Progress text, when needed, says only current decision, next action, or blocker in plain prose. Do not expose planning fields, packet labels, freeze lines, or internal records.

## Post-Planning Gate
After planning:
1. Open exactly one next owner.
2. If `ACTIVE-WORKFLOW` or a non-`not-applicable` `ACTIVE-SEQUENCE` is set, open the owner named by `NEXT-CONSEQUENTIAL-ACTION` before `SV-PLAN`.
3. Otherwise load `self-verification` immediately in `SV-PLAN` mode.
4. `team-routing candidate` or `ambiguous-route` must pass `SV-PLAN` before `task-execution`.
5. If the frozen target, route, readiness basis, or next action is missing, vague, or contradicted, reopen `work-planning`.
