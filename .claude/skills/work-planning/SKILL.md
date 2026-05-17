---
name: work-planning
description: Freeze request fit, route, workflow, parallel fit, and skill basis before consequential action.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Sharpens only its owned procedure surface.
- Fixed top-level section order starts after Structural Contract.
- Section 1 is Purpose.
- Section 2 is Activation Trigger.
- Section 3 is Step 0.
- Section 4 is Step 1.
- Section 5 is Step 2.
- Section 6 is Step 3.
- Section 7 is Internal Planning Record.
- Section 8 is Progress Update Surface.
- Section 9 is Post-Planning Gate.
- Section 10 is Resolve Next Owner And Action.
- Reference Map stays inside Purpose.
- Step names: Request-Fit Intake, Choose Planning Target, Q1-Q5 Work Analysis, Freeze Scope And Route.
- PRIMARY-OWNER: team-lead

## Purpose
Freeze the smallest complete plan basis before consequential action.
Own planning freeze only.
Execution, dispatch, review, proof, validation, user-facing final reporting, and agent packets move to the named owner.

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
Load every listed reference whose trigger is active.
Triggered references are mandatory before positive route freeze.
- `references/planning-targets.md`: target definitions, required basis, and target-switch rules.
- `references/boundary-gates.md`: activation scope, corpus measurement, boundary axes, hard stops, and post-planning gates.
- `references/reference-use.md`: reference-based planning and source-deviation risk.
- `references/evidence-tier.md`: authority, benchmarks, and model-prior downgrade risk.
- `references/deliverable-defaults.md`: proof, review, validation, user burden, and acceptance defaults by deliverable type.
- `references/parallel-fit.md`: independent/sequential/interdependent discrimination, bottleneck defects, serial basis, and the active concurrent-agent cap.
- `references/team-runtime-fit.md`: team-agent runtime fit and standalone fallback-evidence boundary.
- `references/execution-readiness.md`: packet, proof, setup, cleanup, parallel, and acceptance readiness.
- `references/planning-record-fields.md`: field values, conditional fields, record template, `not-applicable` bases, serial reasons, and bounded corrections.
- `references/governance-depth.md`: project/request tier classification, governance-depth fields, and scaling guardrails.
- `references/cross-continuity.md`: same-session patches, confirmed corrections, recurrence barriers, decisions, contracts, lane changes, sibling outputs, and acceptance changes.
- `references/codex-independent-review.md`: configured independent-review trigger, packet, team-lead adjudication, fail-open, and authority/footprint limits.

If a needed reference cannot be loaded, freeze `HOLD`, blocker-clear, or reopened owner.

## Activation Trigger
`team-lead` loads `Skill(work-planning)` when the current instruction creates, reopens, or changes a consequential work boundary.
`material` follows `CLAUDE.md` Core Laws 1; consequential boundary changes are tested through `references/boundary-gates.md` Boundary-Change Axes.
Session start routes to `Skill(session-boot)`.
Answer-only, known-owner status, notification-only, receipt-only, cleanup-only, phase-transition-only, and clarification-only messages stay outside `work-planning` unless they assign, reopen, or change consequential work.
Active runtime, recovery, monitoring, cleanup, or unresolved session-start readiness routes to `Skill(session-boot)`.
Also load for reopened delegated lane boundary freeze.
Run before the first consequential tool call, artifact read, workspace discovery, external lookup, mutation, dispatch, reuse, or consequential report on a new or reopened boundary.
`work-planning` activation and freeze are proven only by actual `Skill(work-planning)` load plus the required freeze.
Priority 0 text, progress, task-plan UI, route notes, Codex calls, and outside draft fields are context only; they do not prove `work-planning` activation or freeze.
Use `references/boundary-gates.md` for activation scope, corpus measurement, same-boundary exclusions, boundary axes, hard stops, and post-planning gates.
For exhaustive, full-corpus, whole-folder, or unknown-corpus work, freeze bounded corpus measurement first.
Governance audit/review uses the bounded corpus measurement rule.
Governance defect judgment routes through `review-verification`.
Governance removal judgment routes through `review-verification`.
Preservation analysis routes through `review-verification`.
Unmeasured material burden blocks dispatch-ready planning.
Same-boundary correction stays with the active owner.
A moved boundary-change axis reopens `work-planning`.

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
- `DERIVED-DEFAULTS`
- blockers
- request-bound packet fields

`CONCRETE-DELIVERABLE` and `PRIMARY-USER` determine deliverable type, delivery shape, defaults, and type triggers.
`DERIVED-DEFAULTS` determine receiver job, consumption path, decisive proof surface, and request-bound packet fields.

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

Use `references/boundary-gates.md` for boundary-change axes.
A moved axis reopens planning at that boundary.
Frozen boundary means the current binding values for every axis plus the selected planning target and required basis.
Frozen boundary updates only through reopened `work-planning`.
Frozen boundary also updates through owner-local correction that preserves every axis.

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
- Load `references/parallel-fit.md` before freezing any `AGENT-MAP` or `PARALLEL-GROUPS`.
- Apply the active concurrent-agent cap from `references/parallel-fit.md` before dispatch-ready freeze.
- A freeze that exceeds that cap is invalid before dispatch and reopens this step for shard merging, sub-batching, or sequential phasing.
- Additional-agent dispatch freezes the team-agent runtime route basis; runtime creation or reuse execution is decided later by `task-execution` from `runtime-dispatch-law.md`.

User-surface law:
- If truthful proof or acceptance needs a missing user-facing surface or tool path, freeze a bounded discovery/setup owner or blocker.
- Use source-only evidence only when it truthfully matches the user-facing proof surface.

## Step 3: Freeze Scope And Route
Freeze only what the selected planning target requires.
See `references/planning-record-fields.md` for field values, conditional fields, `not-applicable` rules, serial reasons, bounded corrections, and the record template.
Load `references/planning-record-fields.md` before freezing `AGENT-MAP`, `PARALLEL-GROUPS`, `EXECUTION-READINESS-BASIS`, or any other dispatch-ready field.
Missing applied `planning-record-fields.md` basis blocks dispatch-ready planning.

Always freeze:
- `REQUEST-FIT-BASIS`
- `SEMANTIC-INTENT-BASIS`
- `DERIVED-DEFAULTS`
- `REQUEST-BOUND-PACKET-FIELDS`
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
- team-routed/ambiguous/dispatch-capable: `AGENT-MAP`, `PARALLEL-GROUPS`, `LANE-REQUIRED-SKILLS-MAP`, `SKILL-RECOMMENDATIONS`
- Configured independent review: `CODEX-INDEPENDENT-REVIEW-BASIS`

Configured independent-review detail stays in `references/codex-independent-review.md`.
Hard-stop detail stays in `references/boundary-gates.md`.
Parallel dispatch-cap detail and the active concurrent-agent cap stay in `references/parallel-fit.md`, but any freeze containing `AGENT-MAP` or `PARALLEL-GROUPS` must record the applied cap basis on this surface before dispatch can open.
Planning opens one next owner/action before execution, dispatch, or reporting.
Route, staffing, parallelism, and dispatch option lists to the user are invalid when doctrine and evidence can choose the best route.

Use `references/execution-readiness.md` when packet, proof, setup, cleanup, parallel, or acceptance readiness is at risk.

## Internal Planning Record
Populate the internal record from `references/planning-record-fields.md`.
Hold it in current-turn context only.
Expose only plain next action, blocker, or owner/action truth.
Write continuity only when a continuity owner requires it.
Agent packets use `task-execution` translation.

## Progress Update Surface
Follow `.claude/reference/user-reporting-law.md`.
Planning progress is silent while the next owner/action can run in the same segment.
Planning measurement, setup, and dispatch preparation are progress; execute the owner action without tool-adjacent prose.
Do not expose internal planning or dispatch-preparation detail while the next owner can run.
If execution is stopped, emit only a report admitted by `.claude/reference/user-reporting-law.md`.
Keep the planning record internal.

## Post-Planning Gate
After planning, apply `references/boundary-gates.md` Post-Planning Gate.
Open exactly one next owner/action.
Reopen `work-planning` when the frozen target, route, readiness basis, or next action is missing, vague, contradicted, or unconsumed.

## Resolve Next Owner And Action
- A completed freeze opens `NEXT-CONSEQUENTIAL-ACTION`.
- A workflow or sequence freeze opens the named workflow or sequence owner.
- A team-routed or ambiguous route opens `task-execution`.
- A missing freeze field reopens `work-planning`.
- A blocker-clear plan opens the named blocker-clear move.
- `HOLD` records planning owner, blocker, and next safe evidence step.
