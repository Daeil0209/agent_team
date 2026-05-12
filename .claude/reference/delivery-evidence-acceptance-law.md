---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Core Laws 2 [EVI-ASSUM], [USER-SURFACE], [USER-DELIVERY-FIT], [FUNCTIONAL-CLOSURE], [USER-CONVENIENCE]; Acceptance"
LOAD-POLICY: on-demand reference only
---
# Common Doctrine Reference: Delivery, Evidence, And Acceptance

## Purpose
This reference gives the detailed execution rules behind `CLAUDE.md` User Delivery, Evidence, and Acceptance.
Use it whenever a result might be reported as usable.
Use it whenever a result might be reported as complete.
Use it whenever a result might be reported as verified.
Use it whenever a result might be reported as accepted.
Use it whenever a result might be reported as user-ready.

## Consume When
- The deliverable is user-facing.
- The claim depends on visual evidence.
- The claim depends on UX evidence.
- The claim depends on method evidence.
- The claim depends on governance evidence.
- The claim depends on best-practice evidence.
- The claim depends on rendered proof.
- The claim depends on runtime proof.
- The claim depends on office/PDF/slide proof.
- The claim depends on layout proof.
- The claim depends on packaging proof.
- The claim depends on reader-surface proof.
- The deliverable is executable software.
- A completion might rely on an implemented subset.
- A handoff might rely on an implemented subset.
- A validation might rely on an implemented subset.
- A final report might rely on an implemented subset.
- A tester report uses positive wording.
- A reviewer report uses positive wording.
- A validator report uses positive wording.
- A team-lead report uses positive wording.

## Required Output
The consuming owner records:
- decisive user surface
- evidence surface used
- requested delivery contract
- covered baseline or explicitly deferred baseline
- open surfaces
- claim strength

## Stop
Stop positive completion when requested content, function, format, data/example/use guidance, run/read path, or user burden remains missing.
Stop positive completion when the decisive user surface remains unproven.
Stop final acceptance when validator rules require a verdict.
Stop final acceptance when final-arbitration trigger rules require a verdict.

## Resolve Next Owner And Action
- A stopped delivery route opens missing-deliverable correction.
- A stopped user-surface route opens decisive-surface proof.
- A stopped final-acceptance route opens validator routing.

## Evidence Rules
- Evidence outranks assumption.
- Use indirect evidence for diagnosis.
- Verification stays where the user runs the deliverable.
- Verification stays where the user reads the deliverable.
- Verification stays where the user operates the deliverable.
- Verification stays where the user decides from the deliverable.
- Verification stays where the user learns from the deliverable.
- Verification stays where the user presents the deliverable.
- Source-read evidence is decisive only for source-read deliverables.
- Rendered claims require rendered proof.
- Runtime claims require runtime proof.
- Visual claims need proper lane evidence.
- Visual claims need proper skill evidence.
- Visual claims need proper tool evidence.
- Visual claims need live-document evidence when live-document evidence is the fitting surface.
- UX claims need proper lane evidence.
- UX claims need proper skill evidence.
- UX claims need proper tool evidence.
- UX claims need live-document evidence when live-document evidence is the fitting surface.
- A screenshot proves only the captured visual state.
- Dynamic behavior requires executed user action and retained postcondition evidence.

## Delivery-Fit Rules
- Completion requires the frozen requested deliverable.
- Completion requires user burden to be satisfied.
- Completion uses owner deferral only through the owning upstream record.
- Owner deferral names deferred item.
- Owner deferral names owner.
- Owner deferral names reason.
- Owner deferral names next action.
- Record implemented subset coverage against the requested deliverable.
- Classify half-delivered artifacts as defects.
- Type-fit defaults live in `.claude/skills/work-planning/references/deliverable-defaults.md`.

## CORE-WORKFLOW-CLOSURE
Use `CORE-WORKFLOW-CLOSURE` for executable user-facing software.
The matrix is canonical for user-visible action closure.
Every row is proven end-to-end on the user surface.

Required row families:
- create<->delete
- edit<->save plus reload persistence
- input->dependent-recompute/reactivity
- UI-element->navigation-destination
- entity<->related-entity link

Each row names:
- trigger surface
- paired completion surface
- persistence or recompute basis
- expected visible postcondition
- proof owner
- acceptance owner

An uncovered row is a defect.
Keep uncovered rows outside positive verdict scope.
Prove dynamic rows with executed user action.
Prove UI consumption through the UI surface.
Prove user-surface behavior on the user surface.

## Acceptance Rules
- Reviewer evidence feeds validation.
- Tester evidence feeds validation.
- Validator issues final acceptance.
- `validator` issues final `PASS/HOLD/FAIL`.
- Local closure reports only `verified result`.
- Local closure is valid only when no final-arbitration trigger applies.
- Final-arbitration trigger definitions live in `.claude/skills/validator/references/validator-lane-detail.md`.
- Acceptance compares against the frozen delivery contract.
