---
name: team-lead
description: Provide on-demand binding team-lead role detail for planning consumption, message-class/lifecycle edge cases, agent objections, synthesis/reporting truth, interrupt-resume, and autonomous judgment. Use when active team-lead ownership needs explicit lead-side procedure detail.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Inherits `CLAUDE.md` `Priority And Ownership` floor and `agents/team-lead.md`.
- Sharpens only active edge-case detail.
- Fixed top-level section order after Structural Contract: Purpose, Activation, Work-Planning Detailed Consume, Communication Detail, Agent Objection Detailed Consume, Synthesis Detail, Reporting Detail, Interrupt-Resume Detail, Autonomous Judgment Detail, Orchestration Defect Taxonomy, Resolve Next Owner And Action.
- Reference Map stays inside Purpose.
- PRIMARY-OWNER: team-lead
- Binding detail for active team-lead edge cases.

## Purpose
Keep always-loaded `agents/team-lead.md` small.
Preserve detailed team-lead edge-case mechanics here.
Use explicit STOP, REOPEN, RESOLVE, owner-boundary, and handoff rules.
For cached official Claude Code source notes, read `.claude/reference/official-claude-code-reference.md`.
For context-reduction preservation audits, read `.claude/reference/context-reduction-preservation-map.md`.
Classify these references as evidence caches.
When compact and detailed team-lead rules overlap, `agents/team-lead.md` is the trigger/anchor and this skill supplies edge-case detail.
If wording diverges, resolve to the precise owning procedure before acting.

Load for active compact team-lead role edge-case detail in:
- work-planning field consumption edge cases
- communication or message-class edge cases
- agent `hold|blocker` or `scope-pressure` arbitration
- synthesis, reporting, or closeout truth edge cases
- interrupt-resume stack handling
- autonomous judgment under delegated authority

### Reference Map
Load the direct trigger-specific file.
- `references/pre-action-gate.md`: Priority 0 work/intent/owner/reference/report/route/user-fit/change-fit/uncertainty gate.
- `references/owner-trigger-order.md`: highest-active-trigger order and named-artifact consumption.
- `references/session-route-bridge.md`: fresh-instruction interpretation, session bridge, route bridge, FAR bridge entry.
- `references/planning-field-consume.md`: frozen planning field order and stale-field reaction.
- `references/far-reject-routing.md`: FAR `FINAL-REJECT` correction routing.
- `references/codex-output-lead-own-review.md`: same-pass Codex-output lead own-review discipline.
- `references/lead-local-guarded-law.md`: lead-local conditions and guarded-local law.
- `references/communication-objections.md`: message-class truth, lifecycle debt, `hold|blocker`, `scope-pressure`, and resolution loops.
- `references/synthesis-consume.md`: completion-grade synthesis, delivery-contract comparison, redispatch, FAR correction-packet consumption.
- `.claude/reference/user-reporting-law.md`: user-report admission, non-reportable content, and Communication/Procedure/Reporting plane separation.
- `references/output-surface-law.md`: output staging after user-report admission.
- `references/reporting-surface-rules.md`: evidence shaping and report brevity after user-report admission.
- `references/routine-gate-continuation.md`: status, paused path, routine milestone, and zero-residual final continuation.
- `references/interrupt-autonomy.md`: interrupt-resume stack discipline, autonomous judgment, user-challenge re-evaluation, and accountability.
- `references/orchestration-defects.md`: consolidated orchestration defect taxonomy with trigger, owning rule, and correction owner per class.

## Activation
Edge-case trigger scan checks the named edge cases in this Activation section.

Load when one of these named edge cases is active:
- a compact RPA rule explicitly says to load this skill for a named edge case
- an agent objection requires reference resolution beyond the compact rule
- interrupt nesting or autonomy judgment creates a material edge case
- self-verification needs the detailed basis behind a compact team-lead rule
- an orchestration defect signal appears (skipped owner chain, needless user prompt, user-choice loop on repeated same-class gap, missed parallel dispatch, serial-convenience bottleneck, design-decision delegation, Codex relay, premature agent replacement, or reporting leak)

Default session start and ordinary RPA-4 planning consume compact rules after edge-case trigger scan classifies the path as ordinary.

When this skill is loaded, its rules are decisive detail for the active edge case.

## Work-Planning Detailed Consume
- Trigger: RPA-4 missing/contradictory frozen field, FAR `FINAL-REJECT` correction routing, lead-local routing scenarios, Codex-output lead own-review, specialist-skill consumption, Guarded-Local Law.
- Owner: `references/planning-field-consume.md`, `references/far-reject-routing.md`, `references/codex-output-lead-own-review.md`, or `references/lead-local-guarded-law.md` by active sub-trigger.

## Communication Detail
- Trigger: assignment vs workflow-control vs lifecycle-control vs completion class distinction, lifecycle-debt visibility, primary-downward-class limit on a single agent segment.
- Owner: `references/communication-objections.md` plus `.claude/skills/task-execution/references/message-classes.md` and `.claude/skills/task-execution/references/truth-rules.md`.

## Agent Objection Detailed Consume
- Trigger: `hold|blocker` / `scope-pressure` arbitration, single-agent parallel collapse, boundary/owner/phase/proof/acceptance mismatch, `REPLAN-REQUIRED: yes`.
- Owner: `references/communication-objections.md`.

## Synthesis Detail
- Trigger: completion-grade `handoff`/`completion` synthesis, strengthened synthesis or redispatch needing `SV-RESULT`+`[DESIGN-INTENT]` fit, FAR `FINAL-REJECT` correction-packet consumption.
- Owner: `references/synthesis-consume.md` plus `.claude/skills/task-execution/references/completion-handoff.md`.

## Reporting Detail
- Trigger: phase/stage-end reporting requiring `SV-RESULT`, claim-strength narrowing to `INFERENCE/UNVERIFIED`, planning/dispatch/closeout reporting limits, or explicit user request for internal material.
- Owner: `.claude/reference/user-reporting-law.md` for report admission; `references/output-surface-law.md`, `references/reporting-surface-rules.md`, or `references/routine-gate-continuation.md` only for admitted report staging/shape by active sub-trigger.

## Interrupt-Resume Detail
- Trigger: stacked interrupt frame discipline, status-question stall exposure, resume from verified resume action, reopen-`work-planning` only on owner/surface/deliverable/route/staffing/proof/acceptance/user-requirement axis movement.
- Interrupt owner: `references/interrupt-autonomy.md`.

## Autonomous Judgment Detail
- Trigger: philosophy alignment + evidence basis + net team-operation benefit test, user-challenge re-evaluation, accountability under delegated authority.
- Autonomy owner: `references/interrupt-autonomy.md`.

## Orchestration Defect Taxonomy
- Trigger: skipped owner chain, needless user prompt, user-choice loop on repeated same-class gap, missed parallel dispatch, serial-convenience bottleneck, design-decision delegation, Codex relay, premature agent replacement, reporting leak.
- Owner: `references/orchestration-defects.md`.

## Resolve Next Owner And Action
- Resolved lead-side detail opens the next owner/action named by planning, dispatch, synthesis, reporting, interrupt-resume, or closeout.
- Unresolved lead-side detail opens `work-planning`, `task-execution`, `self-verification`, `session-boot`, `session-closeout`, or `hold|blocker` by the governing owner surface.
