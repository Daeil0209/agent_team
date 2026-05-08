---
name: team-lead
description: On-demand binding team-lead role detail for planning consumption, message-class/lifecycle edge cases, agent objections, synthesis/reporting truth, interrupt-resume, and autonomous judgment.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Inherits `CLAUDE.md` `Priority And Ownership` floor and `agents/team-lead.md`.
- Sharpens only active edge-case detail.
- Fixed section order: Purpose, Activation, Work-Planning Detailed Consume, Communication Detail, Agent Objection Detailed Consume, Synthesis Detail, Reporting Detail, Interrupt-Resume Detail, Autonomous Judgment Detail, Orchestration Defect Taxonomy
- PRIMARY-OWNER: team-lead
- Binding detail for active team-lead edge cases.

## Purpose
Keep always-loaded `agents/team-lead.md` small.
Preserve detailed team-lead edge-case mechanics here.
Use explicit STOP, REOPEN, RESOLVE, owner-boundary, and handoff rules.
For cached official Claude Code source notes, read `.claude/reference/official-claude-code-reference.md`.
For context-reduction preservation audits, read `.claude/reference/context-reduction-preservation-map.md`.
Treat these references as evidence caches, not skills.
When compact and detailed team-lead rules overlap, `agents/team-lead.md` is the trigger/anchor and this skill supplies edge-case detail.
If wording diverges, resolve to the precise owning procedure before acting.

Load only when the compact team-lead role rules require detail for:
- work-planning field consumption edge cases
- communication or message-class edge cases
- agent `hold|blocker` or `scope-pressure` arbitration
- synthesis, reporting, or closeout truth edge cases
- interrupt-resume stack handling
- autonomous judgment under delegated authority

### Reference Map
Load trigger-specific files directly from `SKILL.md`.
- `references/planning-consume.md`: frozen planning field order, route reaction rules, FAR `FINAL-REJECT` correction routing, Codex own-review discipline, lead-local routing rules, and guarded-local law.
- `references/communication-objections.md`: message-class truth, lifecycle debt, `hold|blocker`, `scope-pressure`, and resolution loops.
- `references/synthesis-reporting.md`: completion-grade synthesis limits, delivery-contract comparison, FAR `FINAL-REJECT` correction-packet consumption, reporting surfaces, lead-artifact exposure, routine-gate continuation, and dispatch/closeout narrowing.
- `references/interrupt-autonomy.md`: interrupt-resume stack discipline, autonomous judgment, user-challenge re-evaluation, and accountability.
- `references/orchestration-defects.md`: consolidated orchestration defect taxonomy with trigger, owning rule, and correction owner per class.

## Activation
Load only when one of these named edge cases is active:
- a compact RPA rule explicitly says to load this skill for a named edge case
- an agent objection cannot be resolved from the compact rule alone
- interrupt nesting or autonomy judgment creates a material edge case
- self-verification needs the detailed basis behind a compact team-lead rule
- an orchestration defect signal appears (skipped owner chain, needless user prompt, user-choice loop on repeated same-class gap, missed parallel dispatch, serial-convenience bottleneck, design-decision delegation, Codex relay, premature agent replacement, or reporting leak)

Default session start and ordinary RPA-4 planning consume compact rules when sufficient.

When this skill is loaded, its rules are decisive detail for the active edge case.

## Work-Planning Detailed Consume
- Trigger: RPA-4 missing/contradictory frozen field, FAR `FINAL-REJECT` correction routing, lead-local routing scenarios, Codex same-pass own-review, specialist-skill consumption, Guarded-Local Law.
- Owner: `references/planning-consume.md`.

## Communication Detail
- Trigger: assignment vs workflow-control vs lifecycle-control vs completion class distinction, lifecycle-debt visibility, primary-downward-class limit on a single agent segment.
- Owner: `references/communication-objections.md` plus `task-execution/references/{message-classes.md, truth-rules.md}`.

## Agent Objection Detailed Consume
- Trigger: `hold|blocker` / `scope-pressure` arbitration, single-agent parallel collapse, boundary/owner/phase/proof/acceptance mismatch, `REPLAN-REQUIRED: yes`.
- Owner: `references/communication-objections.md`.

## Synthesis Detail
- Trigger: completion-grade `handoff`/`completion` synthesis, strengthened synthesis or redispatch needing `SV-RESULT`+`[DESIGN-INTENT]` fit, FAR `FINAL-REJECT` correction-packet consumption.
- Owner: `references/synthesis-reporting.md` plus `task-execution/references/completion-handoff.md`.

## Reporting Detail
- Trigger: phase/stage-end reporting requiring `SV-RESULT`, claim-strength narrowing to `INFERENCE/UNVERIFIED`, planning/dispatch/closeout reporting limits, internal-by-default scaffolding exposure on explicit request.
- Owner: `references/synthesis-reporting.md` (governing surface for RPA-9 and RPA-10 edge cases).

## Interrupt-Resume Detail
- Trigger: stacked interrupt frame discipline, status-question stall exposure, resume from verified resume action, reopen-`work-planning` only on owner/surface/deliverable/route/staffing/proof/acceptance/user-requirement axis movement.
- Owner: `references/interrupt-autonomy.md`.

## Autonomous Judgment Detail
- Trigger: philosophy alignment + evidence basis + net team-operation benefit test, user-challenge re-evaluation, accountability under delegated authority.
- Owner: `references/interrupt-autonomy.md`.

## Orchestration Defect Taxonomy
- Trigger: skipped owner chain, needless user prompt, user-choice loop on repeated same-class gap, missed parallel dispatch, serial-convenience bottleneck, design-decision delegation, Codex relay, premature agent replacement, reporting leak.
- Owner: `references/orchestration-defects.md`.
- Hard surface (taxonomy meta-rules, no duplicate of class detail):
  - Defect classification is route evidence, not a user-choice prompt.
  - Self-growth path applies only after `[HARDEN]` confirms recurrence and narrowest correct owner.
  - Adding a new defect class requires `update-upgrade-sequence` plus owner-rule citation.
