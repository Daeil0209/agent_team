---
name: work-planning
description: Freeze request fit, route, workflow, parallel fit, and skill basis before consequential action.
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Sharpens only its procedure surface.
- Fixed top-level section order starts after Structural Contract.
- Section 1 is Purpose.
- Section 2 is Activation Trigger.
- Section 3 is Step 0.
- Section 4 is Step 1.
- Section 5 is Step 2.
- Section 6 is Step 3.
- Section 7 is Step 4.
- Section 8 is Internal Planning Record.
- Section 9 is Progress Update Surface.
- Section 10 is Post-Planning Gate.
- Section 11 is Resolve Next Owner And Action.
- Reference Map stays inside Purpose.
- Step names: Request-Fit Intake, Choose Planning Target, Q1-Q5 Work Analysis, Build Team-Lead Work Plan, Freeze Scope And Route.

## Purpose
Freeze the smallest complete plan basis before consequential action.
Run planning freeze only.
Execution, dispatch, review, proof, validation, user-facing final reporting, and agent packets move to the named owner.

Procedure spine (Steps 0-4):
1. Freeze request fit. (Step 0)
2. Choose one planning target. (Step 1)
3. Run Q1-Q5. (Step 2)
4. Build the team-lead work plan, including termination plan. (Step 3)
5. Freeze only the fields required by the chosen target, route, and work plan. (Step 4)

Post-planning handoff: open the first next owner/action from that work plan per `## Post-Planning Gate`.

Missing, vague, contradicted, or overclaimed basis blocks execution.
Output `HOLD`, blocker-clear, or reopened owner.

Boundary:
- `team-lead` handles thin instruction reading and channel opening.
- `work-planning` handles consequential freeze and target selection.
- workflow/sequence skills handle their active phase after this freeze.
- `Skill(self-verification)` handles the producer outbound gate for produced work-product coverage and review-verification convergence.
- `task-execution` handles frozen dispatch and packet truth.
- the planning record is internal carry-forward, not the agent packet.

### Reference Map
Load every listed reference whose trigger is active.
Triggered references are mandatory before positive route freeze.
- `.claude/reference/design-definition-core-law.md`: load when freezing request fit, deliverable, user burden, completion shape, or user-surface closure basis.
- `.claude/reference/detailed-design-core-law.md`: load when freezing target intent, design boundary, existing-artifact basis, design drift, or current-session continuity basis.
- `.claude/reference/work-execution-core-law.md`: load when freezing route, next owner/action, parallel fit, escalation basis, skill/reference basis, or execution readiness.
- `.claude/reference/judgment-core-law.md`: load when freezing proof owner, validation owner, acceptance owner, final-arbitration risk, or independent-lane separation.
- `references/planning-targets.md`: target definitions, required basis, and target-switch rules.
- `references/boundary-gates.md`: activation scope, corpus measurement, boundary axes, hard routing gates, and post-planning gates.
- `references/reference-use.md`: reference-based planning and source-deviation risk.
- `references/evidence-tier.md`: coverage, benchmarks, and model-prior downgrade risk.
- `references/deliverable-defaults.md`: proof, review, validation, user burden, and acceptance defaults by deliverable type.
- `references/parallel-fit.md`: independent/sequential/interdependent discrimination, bottleneck defects, serial basis, and the active concurrent-agent cap.
- `references/team-runtime-fit.md`: team-agent runtime fit and standalone fallback-evidence boundary.
- `references/execution-readiness.md`: packet, proof, setup, cleanup, parallel, and acceptance readiness.
- `references/planning-record-fields.md`: field values, conditional fields, record template, `not-applicable` bases, serial reasons, and bounded corrections.
- `references/governance-depth.md`: project/request tier classification, governance-depth fields, and scaling guardrails.
- `references/cross-continuity.md`: same-session patches, confirmed corrections, recurrence barriers, decisions, contracts, lane changes, sibling outputs, and acceptance changes.
- `Skill(codex-independent-review)` at `.claude/skills/codex-independent-review/SKILL.md`: configured independent-review skill, common contract lookup, `WP-CONSULT` route-freeze handling, team-lead adjudication, fail-open, and coverage/footprint limits.

Unavailable needed references route to `HOLD`, blocker-clear, or reopened owner.

## Activation Trigger
`team-lead` loads `Skill(work-planning)` when the current instruction creates, reopens, or changes a consequential work boundary.
`material` follows `.claude/CLAUDE.md` `## 3. Work Execution Philosophy`; consequential boundary changes are tested through `references/boundary-gates.md` Boundary-Change Axes.
Session start routes to `Skill(session-boot)`.
Answer-only, known-owner status, notification-only, receipt-only, cleanup-only, phase-transition-only, and clarification-only messages stay outside `work-planning` unless they assign, reopen, or change consequential work.
Active runtime, recovery, monitoring, cleanup, or unresolved session-start readiness routes to `Skill(session-boot)`.
Also load for reopened delegated lane boundary freeze.
Run before the first consequential tool call, artifact read, workspace discovery, external lookup, mutation, dispatch, reuse, or consequential report on a new or reopened boundary.
`work-planning` activation and freeze are proven by actual `Skill(work-planning)` load plus the required freeze, or by current same-session loaded `work-planning` basis when every boundary-change axis per `references/boundary-gates.md` remains unchanged.
Pre-action gate fields, progress notes, task-plan UI, route notes, Codex calls, and outside draft fields are context only; actual `Skill(work-planning)` load plus required freeze proves activation or freeze.
Use `references/boundary-gates.md` for activation scope, corpus measurement, same-boundary exclusions, boundary axes, hard routing gates, and post-planning gates.
For exhaustive, full-corpus, whole-folder, or unknown-corpus work, freeze bounded corpus measurement first.
Governance audit/review uses the bounded corpus measurement rule.
Governance defect, removal, and preservation judgment is planned as bounded review/verification rows.
Synthesized-result judgment goes through `Skill(self-verification)` first.
Governance patch design and mutation go through `Skill(governance-modification)` and its `REVIEW-VERIFICATION-NEED` only after a current review basis verifies governance asset-change or recurrence-barrier need.
Unmeasured material burden blocks dispatch-ready planning.
Same-boundary correction stays with the active owner.
A moved boundary-change axis reopens `work-planning`.

## Step 0: Request-Fit Intake
Freeze these before route judgment:
- requested interaction type and intended outcome
- `SEMANTIC-INTENT-BASIS`
- `COMPLETION-STOP-CONDITION`
- `CONCRETE-DELIVERABLE`
- coverage and exhaustiveness
- `PRIMARY-USER`
- reference use
- burden cues
- proof
- `DERIVED-DEFAULTS`
- blockers
- request-bound packet fields

`CONCRETE-DELIVERABLE` and `PRIMARY-USER` determine deliverable type, delivery shape, defaults, and type triggers.
`DERIVED-DEFAULTS` determine receiver job, consumption path, decisive proof surface, and request-bound packet fields.

Full intake is mandatory when semantic intent, original or corrected wording, reference use, delivery burden, user-surface proof, concern signal, anti-goal, priority order, or completion stop condition affects route class, owner choice, or next action.
The user-defined work scope is binding.
Samples, spot-checks, representative review, or finding-count quotas require explicit scope basis.
For exhaustive, full-corpus, whole-folder, or governance-audit work, samples, waves, and priority tiers are order controls only unless the user explicitly narrows scope.
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
- workflow/sequence route
- blocker-clear scope
- delegated-lane boundary scope

Use `references/boundary-gates.md` for boundary-change axes.
A moved axis reopens planning at that boundary.
Frozen boundary means the current binding values for every axis plus the selected planning target and required basis.
Frozen boundary updates only through reopened `work-planning`.
Frozen boundary also updates through skill-local correction that preserves every axis.

## Step 2: Q1-Q5 Work Analysis
Before scope freeze, answer:
1. What is the real purpose and completion stop condition, including the user concern signal and anti-goal when expressed?
2. What work type or types are present?
3. What governing workflow, sequence, or methodology handles each type?
4. Are streams local single-surface, independent, sequential, or interdependent?
5. Which supporting skills are needed inside each stream?

Hold when purpose, `SEMANTIC-INTENT-BASIS`, work type, owner, workflow/sequence, surface count, or skill basis lacks truthful naming basis.

Parallel law:
- See `references/parallel-fit.md` for independent/sequential/interdependent discrimination, burden basis, bottleneck-defect rule, and serial-basis evidence.
- Load `references/parallel-fit.md` before freezing `ACTIVE-CONCURRENT-AGENT-CAP`, `AGENT-MAP`, or `PARALLEL-GROUPS`.
- Load `references/team-runtime-fit.md` before freezing any route that considers `Agent` tool use, configured lane work, assignment-grade work, reuse, teammate coordination, independent specialist-fit surfaces, or additional-agent routing.
- Classify considered `Agent` tool use, independent specialist-fit surfaces, or additional-agent routing through `references/team-runtime-fit.md` before route freeze: assignment-grade or lane work freezes team-agent runtime route; lawful evidence-only standalone use freezes a lead-local evidence purpose with no lane-state promise.
- Freeze `ACTIVE-CONCURRENT-AGENT-CAP` before `AGENT-MAP` or `PARALLEL-GROUPS` when additional-agent routing is possible.
- Apply the active concurrent-agent cap from `references/parallel-fit.md` before dispatch-ready freeze.
- A freeze that exceeds that cap is invalid before dispatch and reopens this step for shard merging, sub-batching, or sequential phasing.
- Additional-agent dispatch freezes the team-agent runtime route basis; runtime creation or reuse execution is decided later by `task-execution` from `runtime-dispatch-law.md`.
- Dispatch-ready planning is invalid when independent specialist-fit, parallel-fit, configured lane work, or additional-agent routing is present without a frozen team-runtime route basis; lawful lead-local evidence-only standalone use is valid only when none of those team-runtime disqualifiers is active.

User-surface law:
- If truthful proof or acceptance is blocked by a missing user-facing surface or tool path, freeze one bounded next step: `Skill(tool-acquisition)` for local discovery/setup, `Skill(external-tool-bridge)` for external bridge risk, the named setup owner, or blocker with bounded discovery/setup fields.
- Use source-only evidence only when it truthfully matches the user-facing proof surface.

## Step 3: Build Team-Lead Work Plan
Before freeze, `team-lead` builds the work plan it will execute or route.
The work plan names each material phase, owner, action, stop/evidence, verification/review need, iteration or re-entry condition, and termination plan.
Each material phase names the opened closure unit it closes; category, pattern, theme, summary, wave, batch, priority, or work-item rows are valid as organization or follow-on mapping unless the frozen phase opened that row as its own closure unit.
The work plan names the upstream reviewed, verified, synthesized, validated, rejected, open, blocker, or correction-ready basis each material phase consumes or passes forward.
For each material phase, `team-lead` records the review/verification judgment as `owner-local-sufficient:<basis>`, `Skill(self-verification):<target>`, `Skill(review-verification):<caller-and-question>`, independent lane review/proof/validation, or `HOLD:<basis>`.
Place each conditional owner at its material trigger point; place `Skill(governance-modification)` only when the plan's current next owner/action is governance asset change or confirmed recurrence-barrier hardening.
Keep governance audit, candidate discovery, defect promotion, and proposal-only rows with planning, review, verification, or the active procedure owner.
`Skill(self-verification)` verifies the produced work-product surface set from `team-lead` or a lane through PASS-1 coverage and PASS-2 review-verification before reporting, governance-asset `Skill(governance-modification)`, or redispatch.
`Skill(review-verification)` runs inside `Skill(self-verification)` Step 3 for the produced work-product surface set and returned PASS-2 packet.
`Skill(review-verification)` runs under `Skill(governance-modification)` for governance patch design, consumed owner surface, mutation readiness, and material post-change coherence.
The plan names a practical termination path derived from the user's instruction.
The termination path names only deliverable closure, lawful owner deferral, or `HOLD` with truthful blocker as terminal states.
Lead-authored waves, batches, samples, priority tiers, category rows, pattern rows, theme rows, summaries, or work-item rows satisfy organization, ordering, or follow-on execution only; they do not replace a finer opened closure unit or permit phase closure without preserving source-unit coverage.
Governance defect or removal audits keep corpus inspection, review-promotion, and lead synthesis as separate rows; patch scope adds a separate governance-modification patch-loop row.

## Step 4: Freeze Scope And Route
Freeze only what the selected planning target requires.
See `references/planning-record-fields.md` for field values, conditional fields, `not-applicable` rules, serial reasons, bounded corrections, and the record template.
Load `references/planning-record-fields.md` before freezing `AGENT-MAP`, `PARALLEL-GROUPS`, `EXECUTION-READINESS-BASIS`, or any other dispatch-ready field.
Missing applied `planning-record-fields.md` basis blocks dispatch-ready planning.

Always freeze:
- `REQUEST-FIT-BASIS`
- `SEMANTIC-INTENT-BASIS`
- `TARGET-INTENT-BASIS`
- `COMPLETION-STOP-CONDITION`
- `DERIVED-DEFAULTS`
- `REQUEST-BOUND-PACKET-FIELDS`
- `TEAM-LEAD-WORK-PLAN`
- `ACTION-CLASS`
- `ROUTING-SIGNAL`
- `EXECUTION-READINESS-BASIS`
- `NEXT-CONSEQUENTIAL-ACTION`
- `DISPATCH-BLOCKERS`

Freeze when material:
- governance depth from `references/governance-depth.md`: `PROJECT-TIER`, `ACTIVE-REQUEST-TIER`, `TIER-RAISE-REASON`
- workflow/sequence: `ACTIVE-WORKFLOW`, `ACTIVE-SEQUENCE`
- analysis/critique/judgment: `CLAIM-CEILING`
- lead-local: `LEAD-LOCAL-WORK-ITEMS`, `LEAD-LOCAL-REQUIRED-SKILLS`
- team-routed/ambiguous/dispatch-capable: `ACTIVE-CONCURRENT-AGENT-CAP`, `AGENT-MAP`, `PARALLEL-GROUPS`, `LANE-REQUIRED-SKILLS-MAP`, `SKILL-RECOMMENDATIONS`
- Configured independent review: `CODEX-INDEPENDENT-REVIEW-BASIS`

Configured independent-review detail stays in `Skill(codex-independent-review)` at `.claude/skills/codex-independent-review/SKILL.md`.
Hard routing gate detail stays in `references/boundary-gates.md`.
Parallel dispatch-cap detail stays in `references/parallel-fit.md`, but any freeze containing `AGENT-MAP` or `PARALLEL-GROUPS` must record `ACTIVE-CONCURRENT-AGENT-CAP` on this surface before dispatch can open.
Planning opens the first next owner/action from `TEAM-LEAD-WORK-PLAN` before execution, dispatch, or reporting.
Team-routed or ambiguous dispatch opens `Skill(task-execution)` activation per the activation rule at `.claude/skills/task-execution/SKILL.md` `## Activation`.
Route, staffing, parallelism, and dispatch option lists to the user are invalid when doctrine and evidence can choose the best route.

Use `references/execution-readiness.md` when packet, proof, setup, cleanup, parallel, or acceptance readiness is at risk.

## Internal Planning Record
Populate the internal record from `references/planning-record-fields.md`.
Hold it in current-turn context only.
Expose only plain next action, blocker, or owner/action truth.
Write continuity only when a continuity owner requires it.
Agent packets use `task-execution` translation.

## Progress Update Surface
Follow `.claude/reference/reporting-prohibition-law.md`.
Planning progress is silent while the next owner/action can run in the same segment.
Planning measurement, setup, and dispatch preparation are progress; execute the owner action without tool-adjacent prose.
Internal planning and dispatch-preparation detail stay internal while the next owner can run.
Blocked execution emits only a report granted a narrow exception by `.claude/reference/reporting-prohibition-law.md`.
Keep the planning record internal.

## Post-Planning Gate
After planning, apply `references/boundary-gates.md` Post-Planning Gate.
Open the first next owner/action from `TEAM-LEAD-WORK-PLAN`.
Reopen `work-planning` when the frozen target, route, readiness basis, or next action is missing, vague, contradicted, or unconsumed.

## Resolve Next Owner And Action
- A completed freeze opens `NEXT-CONSEQUENTIAL-ACTION`.
- A workflow or sequence freeze opens the named workflow or sequence owner.
- A team-routed or ambiguous route opens `Skill(task-execution)` only when no current same-session loaded `task-execution` basis exists.
- A team-routed or ambiguous route opens loaded `task-execution` consumption when the same-session `task-execution` basis exists.
- A missing freeze field reopens `work-planning`.
- A blocker-clear plan opens the named blocker-clear move.
- `HOLD` records planning owner, blocker, and next safe evidence step.
