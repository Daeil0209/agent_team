# Work-Planning Record Fields
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
auto-inject: false

Use this file when field-level semantics, allowed values, the internal planning record, `not-applicable` bases, serial reasons, or bounded correction rules are material.
Field floors are route-relevant, not universal ceremony.
Record `not-applicable:<consumer-cite-or-basis>` instead of dropping a field; an explicit cited consumer-absence basis is required before treating any listed mandatory field as not-required.

`PROJECT-TIER`, `ACTIVE-REQUEST-TIER`, and `TIER-RAISE-REASON` field semantics are produced by `governance-depth.md` and consumed here.

## Contents
- Allowed Values
- Internal Planning Record Template
- Resolve Next Owner And Action

## Allowed Values
- `ACTION-CLASS` must be one of `lead-local`, `team-routed`, `workflow-owner`, `sequence-owner`, `authorization-request`, `blocker-clear`, or `hold`.
- `ROUTING-SIGNAL` must be one of `lead-local candidate`, `team-routing candidate`, `ambiguous-route`, `workflow-owner`, `sequence-owner`, `authorization-request`, `blocker-clear`, or `hold`.
- No `ACTION-CLASS` or `ROUTING-SIGNAL` value represents standalone `Agent` as a work route.
- Lawful standalone `Agent` evidence use records as `lead-local candidate` with an evidence-only `LEAD-LOCAL-WORK-ITEMS` basis.
- Any route needing configured lane work, assignment-grade work, receipt, reuse, monitoring, or completion handoff records `team-routing candidate` or `ambiguous-route`.
- `DISPATCH-BLOCKERS` must be `[]`, `blocked:<owner-and-basis>`, or `authorization-required:<basis>`.
- `EXECUTION-READINESS-BASIS` must be `ready:<basis>`, `blocked:<owner-and-basis>`, or `not-applicable:<basis>` when required.
- `CODEX-INDEPENDENT-REVIEW-BASIS` is the compatibility field for configured independent-review handling and must be `skipped:<basis>`, `triggered:accepted=<n>;rejected=<n>;dropped=<n>`, or `fail-open:<reason>`.

- `REQUEST-FIT-BASIS` is mandatory for consequential plans and must preserve the verbatim user instruction wording (or a cited path:line basis when the user instruction is canonically retained in a session-bound retained carrier) plus `CONCRETE-DELIVERABLE`, `PRIMARY-USER`, proof direction, blocker truth, and triggered reference-use citation or deviation basis.
- `SEMANTIC-INTENT-BASIS` is mandatory for consequential plans and must bridge request intent, user concern signal, user anti-goal, user-stated quality cues, active philosophy section or keyword with direct owner/action/stop/evidence/routing/burden effect, target governance/design intent, priority order, route class, owner choice, and next action.
- `TARGET-INTENT-BASIS` is mandatory when the plan judges, modifies, migrates, reduces, reports on, reviews, proves, validates, or dispatches work for an existing artifact or existing-governance surface.
- `TARGET-INTENT-BASIS` is mandatory when a target artifact, program, report, document, governance surface, proof path, acceptance path, or downstream lane needs target purpose or protected outcome.
- `TARGET-INTENT-BASIS` records cited design intent, applicable core-law axes, target purpose, material solution-structure or scope-boundary basis, affected owner surfaces, drift stop, or `not-applicable:<basis>` allowed by `.claude/reference/detailed-design-core-law.md`.
- `COMPLETION-STOP-CONDITION` is mandatory for consequential plans and must derive from the user instruction, deliverable type, proof/acceptance defaults, and active workflow or sequence exit law.
- It names the smallest practical closure condition a reasonable owner can verify, the evidence that proves closure, and the condition that keeps the owner open or routes `HOLD`.
- Valid terminal states are deliverable closure, explicit user-accepted deferral, lawful owner deferral under `[USER-DELIVERY-FIT]`, or `HOLD` with truthful blocker.
- Lead-authored wave, batch, sample, priority tier, context limit, runtime limit, turn limit, response-length limit, or tool-call pressure is not a terminal state.
- `TEAM-LEAD-WORK-PLAN` is mandatory for consequential plans and must name the material phases, owner for each phase, action, stop/evidence, verification or review need, iteration or re-entry condition, and termination plan.
- `TEAM-LEAD-WORK-PLAN` is authored by `team-lead` and carries the procedure that `team-lead` will execute, route, monitor, synthesize, verify, and close.
- `TEAM-LEAD-WORK-PLAN` derives from the user instruction and chosen route; `COMPLETION-STOP-CONDITION` supplies its final closure row.
- Each phase row records the opened closure unit its stop/evidence closes; category, pattern, theme, summary, wave, batch, priority, or work-item rows are valid as organization or follow-on mapping only, unless the frozen phase opened that row as its own closure unit.
- Each phase row carries `UPSTREAM-DECISION-BASIS` as the material reviewed, verified, synthesized, validated, rejected, open, blocker, or correction-ready basis it consumes, passes forward, supersedes, or marks `not-applicable:<basis>`.
- Each phase row records the review/verification judgment as `owner-local-sufficient:<basis>`, `Skill(self-verification):<target>`, `Skill(review-verification):<caller-and-question>`, independent lane owner, or `HOLD:<basis>`.
- Place `Skill(governance-modification)` only at a planned governance asset-change row or confirmed recurrence-barrier hardening row.
- Place `Skill(review-verification)` inside `Skill(self-verification)` Step 3 when the produced work-product surface set needs PASS-2 critical review.
- Place `Skill(review-verification)` under `Skill(governance-modification)` as the review engine for governance patch design, consumed owner surface, mutation readiness, and material post-change coherence.
- A complete `TEAM-LEAD-WORK-PLAN` carries only trigger-backed owner rows and makes the termination row executable.
- A complete `TEAM-LEAD-WORK-PLAN` keeps every `SCOPE-BASELINE` row open until covered, explicitly user-accepted as deferred/out-of-scope, lawfully owner-deferred, or blocked by a truthful `HOLD`.
- Governance defect or removal audit plans keep review-promotion rows distinct from lead synthesis rows.
- Governance patch plans keep the governance-modification change loop open until every same-request `patch-ready` row is applied, lawfully deferred, rejected by current review basis, or blocked by truthful `HOLD`.
- `DERIVED-DEFAULTS` is mandatory for consequential plans and must name deliverable type, receiver job, consumption path, decisive proof surface, and triggered type-specific owner surfaces or `not-applicable:<basis>`.
- `CLAIM-CEILING` is mandatory when the route includes analysis, critique, governance judgment, review, validation, defect audit, or patch-worthiness judgment; use one allowed value from `.claude/skills/task-execution/references/assignment-packet.md` `CLAIM-CEILING` allowed-values enumeration.
- Governance defect or removal audits assigned to reviewer lanes default to `evidence-only candidates`; `patch-worthiness classification` requires team-lead `Skill(review-verification)` promotion basis.
- `REQUEST-BOUND-PACKET-FIELDS` is mandatory as `[]` or the exact request-bound fields that `task-execution` must carry into downstream assignment packets.
- When the frozen request, plan, MVP, release, or phase contains one or more promised features, workflows, surfaces, controls, data expectations, artifacts, or reader/operator outcomes, `REQUEST-BOUND-PACKET-FIELDS` must include row-granular `SCOPE-BASELINE`, `ACTIVE-SLICE`, `DEFERRED-SURFACES`, and applicable `CORE-WORKFLOW-CLOSURE` rows for executable user-facing software.
- Baseline rows name proofable feature, workflow, surface, control, data, artifact, or reader/operator expectations; module, epic, or screen labels are parent headings only.
- Implemented artifacts cannot be used later to invent the completion scope.
- Multi-wave routes record per-wave `SCOPE-BASELINE` against the frozen deliverable scope.
- Multi-wave routes record the `SCOPE-BASELINE` union state as `full-coverage`, `partial-with-deferral`, or `partial-with-HOLD`.
- Deliverable-scope delta from a wave's `SCOPE-BASELINE` records under `DEFERRED-SURFACES` with named owner-deferral upstream record path or `HOLD` with cited blocker.
- `partial-with-deferral` is valid only when every deferred surface has explicit user acceptance, user-stated boundary, or `[USER-DELIVERY-FIT]` lawful owner-deferral basis.
- Lead-authored wave, batch, sample, priority tier, resource pressure, or planning convenience cannot create `partial-with-deferral`.
- `partial-with-deferral` does not satisfy deliverable completion for the originally requested scope unless the user explicitly accepts the narrowed scope.
- Missing multi-wave `SCOPE-BASELINE` union record blocks wave-2-onward dispatch-ready freeze.
- Missing multi-wave `SCOPE-BASELINE` union record blocks wave-PASS framed as deliverable-completion in user-facing reports.
- Wave PASS cannot redefine deliverable scope as that wave's `SCOPE-BASELINE`.
- Multi-wave routes classify each wave's system-damage potential as `safe`, `cautionary`, or `risky`.
- Wave ordering places `safe` first, `cautionary` next, `risky` last.
- For `risky` waves, team-lead prepares positive-effect and negative-effect analysis before user-selection.
- User-selection on `risky` waves is operator-policy-choice per `.claude/reference/work-execution-core-law.md` `[NO-NEEDLESS-ASK]`.
- When `DERIVED-DEFAULTS` names a receiver job, consumption path, or decisive proof surface for downstream review, proof, validation, or acceptance, `REQUEST-BOUND-PACKET-FIELDS` must include `TARGET-INTENT-BASIS`, `USER-SURFACE`, and `USER-SURFACE-PROOF-PATH`.
- When plan, design, or workflow state freezes Receiver-Surface Contract, Consumption Chain, Boundary Register, or Evidence-Quality Matrix, `REQUEST-BOUND-PACKET-FIELDS` must preserve their cited identities for `task-execution` packet basis.
- When reference-use triggers and downstream lanes depend on it, `REQUEST-BOUND-PACKET-FIELDS` must preserve cited reference identities or `DEVIATION-FROM-REFERENCE` basis. Downstream reference-use identity belongs inside `REQUEST-BOUND-PACKET-FIELDS`.
- `PROJECT-TIER` is mandatory when the project has already been tiered or the current plan explicitly sizes governance depth.
- `ACTIVE-REQUEST-TIER` is mandatory whenever `PROJECT-TIER` is present on a consequential `team-lead` plan.
- `TIER-RAISE-REASON` is mandatory whenever `PROJECT-TIER` is present; record `stay` explicitly when no material raise signal exists.
- `ACTIVE-WORKFLOW` is mandatory when one named workflow governs the path.
- `ACTIVE-SEQUENCE` is mandatory when one named primary sequence governs the path; use `not-applicable:<basis>` when no primary sequence governs the path but a sequence candidate was considered.
- If both `ACTIVE-WORKFLOW` and `ACTIVE-SEQUENCE` are present, `NEXT-CONSEQUENTIAL-ACTION` must name which owner opens first and why.
- `ACTION-CLASS` is mandatory for consequential plans and must use one of the allowed immediate action families above.
- `ROUTING-SIGNAL`, `NEXT-CONSEQUENTIAL-ACTION`, and `DISPATCH-BLOCKERS` are mandatory for consequential `team-lead` plans.
- `LEAD-LOCAL-WORK-ITEMS` is mandatory when `ROUTING-SIGNAL` is `lead-local candidate`.
- `LEAD-LOCAL-REQUIRED-SKILLS` is mandatory when `ROUTING-SIGNAL` is `lead-local candidate` and the acting subject needs any non-owner skill to complete the frozen local path truthfully.
- `ACTIVE-CONCURRENT-AGENT-CAP` is mandatory when additional-agent routing is possible, host-authorized, team-routed, ambiguous-route, or dispatch-capable; cap rules (active value, cap basis enumeration, user-maximum preservation, default host-safe ceiling) live canonically at `.claude/skills/work-planning/references/parallel-fit.md`.
- `AGENT-MAP` and `PARALLEL-GROUPS` are mandatory when routing is team-routed or becomes team-routed after one named blocker-clear move.
- `AGENT-MAP` and `PARALLEL-GROUPS` are mandatory when additional-agent routing is host-authorized.
- When `AGENT-MAP` or `PARALLEL-GROUPS` is not mandatory but `task-execution` consumes the route, record `not-applicable:<basis>` instead of leaving the field blank.
- Valid `not-applicable` bases for `AGENT-MAP` or `PARALLEL-GROUPS` are limited to a dispatch-owned blocker-clear move or an ambiguous dispatch route kept dispatch-owned before authorized agent dispatch.
- Authorized agent dispatch requires concrete `AGENT-MAP` and `PARALLEL-GROUPS`.
- `LANE-REQUIRED-SKILLS-MAP` is mandatory when routing is team-routed or ambiguous-route.
- Every lane entry records methodology or capability skills frozen as required for credible execution.
- Use `[]` to record absence of required methodology or capability skills.
- Lane ownership triggers agent-specific skill loading outside `LANE-REQUIRED-SKILLS-MAP`.
- Methodology-only entries go to `SKILL-RECOMMENDATIONS`.
- `SKILL-RECOMMENDATIONS` is mandatory as `[]` or a lane-scoped methodology instruction map when any configured lane is a candidate receiver for assignment-grade work.
- `SKILL-RECOMMENDATIONS` carries methodology instructions only.
- `SKILL-RECOMMENDATIONS` preserves the receiving lane's work-surface selection.
- The receiving lane classifies each carried recommendation as applied, not-material, or blocked under `.claude/reference/work-skill-reference-binding-law.md`.
- Deliverable trigger-flag analysis determines `LANE-REQUIRED-SKILLS-MAP` and `LEAD-LOCAL-REQUIRED-SKILLS` skill freezes:

| trigger flag (set when frozen scope makes it material) | activates owner asset |
|---|---|
| visible-surface (rendered acceptance material) | visual-composition for developer-owned design/production; rendered-surface basis for review, proof, and validation lanes |
| practical-work-tool-output (personal/team internal tool, dashboard, workflow app, analysis tool, report automation program, calculation/design helper, or spreadsheet/manual-process migration where operator workflow and completion proof matter) | work-tool-patterns for developer-owned product-pattern packet; business-workflow when spreadsheet meaning, operational state, mutation authority, allocation, participation, period, reconciliation, or workflow semantics are material; benchmark-simulation when new, quality-critical, disputed, or external-reference-shaped pattern synthesis is material; pattern and workflow oracle basis for review, proof, and validation lanes |
| external-visual-benchmark (visual / UX / interaction / layout / design quality benefits from external references, public examples, or best-practice comparison) | benchmark-simulation for developer-owned synthesis; researcher secondary-consumer evidence support when comparative source gathering is assigned |
| token-system material (cross-platform token / theme / component-layer architecture) | design-system-tokens for developer-owned design/production; token contract basis for reviewer-owned design-system consistency review |
| learner-facing (audience must learn) | instructional-design for developer-owned content/design; learner-objective basis for review/proof/validation lanes |
| logs-as-decisive-proof (frozen proof surface names logs) | log-based-qa for tester-owned proof |
| software-cross-artifact-boundary (module / interface / state boundary) | software-architecture for developer-owned design/production |
| generated-document-output (report / template / reference-based document) | document-automation for developer-owned generation/design |
| knowledge-analysis-output (market / technology / patent / literature / standards analysis supports a decision, report, or downstream artifact) | researcher for source-family method and evidence packet; document-automation when a reader-facing report or generated document is produced |
| evidence-bound-generation-program (program ingests sources and generates reports, analyses, or decision artifacts) | researcher evidence schema + document-automation generation contract + software-architecture implementation contract |
| engineering-calculation-or-design-tool (formula, standard, unit, tolerance, or operating-condition correctness determines acceptance) | engineering-grounding and mathematical-correctness for developer-owned design/production; oracle basis for review, proof, and validation lanes |
| receiver-comprehension-decisive (next owner / reader / decider acts from this artifact alone) | feynman-clarity for developer-owned lane-local `Skill(self-verification)` and reviewer-owned clarity review |
| executable-on-receiver-runtime (deliverable runs on operator's actual environment) | operator-delivery reference (loaded by dev-workflow at Phase 1/2/4/5) |

This table is the trigger floor.
The receiving lane's lane-detail specialist matrix supplies additional specialist candidates.
Specialist trigger scan also checks the receiving lane's lane-detail specialist matrix for material domain, architecture, quality, security, proof, tool, document, visual, or enterprise needs.
For material specialist triggers outside this table, freeze the lane-appropriate required skill or method recommendation from the lane-detail matrix, or record `not-applicable:<basis>`.
`work-planning` records active trigger flags inside the freeze.
Skill-freeze eligibility requires credible execution dependency.
Skill-freeze target defaults to the skill's owner lane.
Skill-freeze target for a declared `SECONDARY-CONSUMER` lane requires the skill boundary.
Skill-freeze target for lead-local requires lawful lead-local support.
Required methodology or capability skills go to `LEAD-LOCAL-REQUIRED-SKILLS` or `LANE-REQUIRED-SKILLS-MAP`.
Methodology instructions go to `SKILL-RECOMMENDATIONS`.
Other lanes receive the trigger flag as request-bound basis.
Reference activations are loaded by the named owning skill at the listed phases.
- `EXECUTION-READINESS-BASIS` is mandatory for consequential `team-lead` plans. Use `ready:<basis>` only when the next owner can execute the next action from the frozen basis without rediscovering material packet, skill, proof, tool/setup, cleanup, parallel, or acceptance facts. Use `blocked:<owner-and-basis>` when the next lawful action is blocker-clear, authorization request, or hold. Use `not-applicable:<basis>` only for delegated lane-local plans that are not producing a top-level route.
- `EXECUTION-READINESS-BASIS: ready:<basis>` requires the next owner/action to match the first executable row of `TEAM-LEAD-WORK-PLAN`.
- For team-routed, ambiguous-route, independent specialist-fit, additional-agent, or dispatch-capable routes, `EXECUTION-READINESS-BASIS: ready:<basis>` must include the frozen team-runtime route basis from `team-runtime-fit.md`; missing, standalone-only, or lead-local evidence-only basis is not `ready` when assignment-grade lane work, receipt, reuse, monitoring, completion handoff, or independent specialist separation is required.
- `CODEX-INDEPENDENT-REVIEW-BASIS` is mandatory only after configured independent-review trigger evaluation is material or required by the active workflow.
- `CODEX-INDEPENDENT-REVIEW-BASIS` records team-lead trigger handling, adjudication, or fail-open truth.
- Configured-review output is not authority.
- Use `triggered:*` when configured-review points were adjudicated.
- Use `fail-open:*` when a required or triggered attempt did not complete.
- Use `skipped:*` only when no trigger applies.
- If `ACTIVE-WORKFLOW: dev-workflow`, `skipped:*` is valid only as `skipped:no-material-independent-review-trigger:<basis>`.
- Codex MCP access failure is `fail-open:*`.
- Codex MCP access failure is not a blocker by itself.
- For any route eligible to enter `task-execution`, `EXECUTION-READINESS-BASIS` must state that packet preflight categories are frozen or explicitly blocked.
- For assignment-grade dispatch, `EXECUTION-READINESS-BASIS` cannot be `ready:<basis>` unless the standard `RECEIPT-COMPLETION-CONTRACT` can be carried by `task-execution` packet assembly.
- If additional-agent routing is authorized and `PARALLEL-GROUPS` does not name each group, non-overlap boundary, and burden-balance basis, reopen `work-planning`.
- `PARALLEL-GROUPS` burden-balance basis must not use file count alone. Use the smallest truthful weighted basis: line/byte scale, critical surfaces, reference density, proof/review complexity, and synthesis burden. The basis must come from the frozen planning path, a cited artifact, or self-verification-verified measurement; pre-`work-planning` measurement is invalid. Splittable material imbalance reopens `work-planning`.
- If `PARALLEL-GROUPS` is `none`, record the exact serial reason.
- `NEXT-CONSEQUENTIAL-ACTION` must point to the first named local item, frozen workflow owner, frozen sequence owner, `Skill(task-execution)` activation, loaded `task-execution` consumption, exact blocker-clear move, or exact authorization request from `TEAM-LEAD-WORK-PLAN`.
- Team-routed or ambiguous `NEXT-CONSEQUENTIAL-ACTION` points to `Skill(task-execution)` activation per the activation rule at `.claude/skills/task-execution/SKILL.md` `## Activation`.
- If execution reveals a new consequential local item that is not frozen here, reopen `work-planning`.
- A bounded correction stays inside the same frozen boundary through packet correction, bounded local carry-forward, or workflow-owned same-artifact/review-surface iteration.
- That bounded correction exception ends immediately when execution reveals a moved `work-planning` boundary-change axis or route ambiguity.
- Downstream agent communication receives a bounded assignment packet derived from this freeze by `task-execution`; the full internal planning record stays in team-lead carry-forward.

## Internal Planning Record Template
Hold this record in current-turn context only. User-facing output, continuity files, and agent packets receive admitted or bounded derived surfaces instead of this full record.

```
REQUEST-FIT-BASIS:
SEMANTIC-INTENT-BASIS:
TARGET-INTENT-BASIS:
COMPLETION-STOP-CONDITION:
DERIVED-DEFAULTS:
CLAIM-CEILING:
REQUEST-BOUND-PACKET-FIELDS:
TEAM-LEAD-WORK-PLAN:
PROJECT-TIER:
ACTIVE-REQUEST-TIER:
TIER-RAISE-REASON:
ACTIVE-WORKFLOW:
ACTIVE-SEQUENCE:
ACTION-CLASS:
ROUTING-SIGNAL:
LEAD-LOCAL-WORK-ITEMS:
LEAD-LOCAL-REQUIRED-SKILLS:
ACTIVE-CONCURRENT-AGENT-CAP:
AGENT-MAP:
PARALLEL-GROUPS:
LANE-REQUIRED-SKILLS-MAP:
SKILL-RECOMMENDATIONS:
EXECUTION-READINESS-BASIS:
CODEX-INDEPENDENT-REVIEW-BASIS:
NEXT-CONSEQUENTIAL-ACTION:
DISPATCH-BLOCKERS:
```

## Resolve Next Owner And Action
- Complete planning record opens `NEXT-CONSEQUENTIAL-ACTION`.
- `EXECUTION-READINESS-BASIS: ready:<basis>` opens the frozen next owner.
- Team-routed ready basis opens one-time same-session `Skill(task-execution)` activation or loaded `task-execution` consumption according to current session state.
- Frozen workflow or sequence basis opens the named owner before deeper execution.
- `EXECUTION-READINESS-BASIS: blocked:<owner-and-basis>` opens blocker-clear or `HOLD`.
- Missing mandatory field keeps `work-planning` open.
- Invalid `not-applicable` basis reopens `work-planning`.
- Boundary-changing execution discovery reopens `work-planning`.
- Bounded same-boundary correction returns to the same frozen owner.
