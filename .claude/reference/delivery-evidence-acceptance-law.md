---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Core Laws 2 [EVI-ASSUM], [USER-SURFACE], [USER-DELIVERY-FIT], [FUNCTIONAL-CLOSURE], [USER-CONVENIENCE]; Acceptance"
LOAD-POLICY: on-demand reference only
---
# Common Doctrine Reference: Delivery, Evidence, And Acceptance

## Purpose
This reference gives the detailed execution rules behind `CLAUDE.md` User Delivery, Evidence, and Acceptance.
`AC` means acceptance criterion.
Use it whenever a result might be reported as:
- usable
- complete
- verified
- accepted
- user-ready

## Consume When
- The deliverable is user-facing.
- The claim depends on:
  - visual evidence
  - UX evidence
  - method evidence
  - governance evidence
  - best-practice evidence
  - rendered proof
  - runtime proof
  - office/PDF/slide proof
  - layout proof
  - packaging proof
  - reader-surface proof
- The deliverable is executable software.
- These outputs might rely on an implemented subset:
  - completion
  - validation
  - final report
- These lane transports and team-lead reports use positive wording:
  - tester transport
  - reviewer transport
  - validator transport
  - team-lead report

## Required Output
The consuming owner records:
- decisive user surface
- evidence surface used
- requested delivery contract
- covered row-granular baseline or explicitly deferred baseline row
- open surfaces
- claim strength

## Stop
Stop positive completion when:
- requested content, function, format, data/example/use instructions, run/read path, or user burden remains missing
- the decisive user surface remains unproven
Stop final acceptance when:
- validator rules require a verdict
- final-arbitration trigger rules require a verdict

## Resolve Next Owner And Action
- A stopped delivery route opens missing-deliverable correction.
- A stopped user-surface route opens decisive-surface proof.
- A stopped final-acceptance route opens validator routing.

## Evidence Rules
- Evidence outranks assumption.
- Use indirect evidence for diagnosis.
- Verification stays where the user:
  - runs the deliverable
  - reads the deliverable
  - operates the deliverable
  - decides from the deliverable
  - learns from the deliverable
  - presents the deliverable
- Source-read evidence is decisive only for source-read deliverables.
- Rendered claims require rendered proof.
- Runtime claims require runtime proof.
- Visual claims need proper:
  - lane evidence
  - skill evidence
  - tool evidence
  - live-document evidence when live-document evidence is the fitting surface
- UX claims need proper:
  - lane evidence
  - skill evidence
  - tool evidence
  - live-document evidence when live-document evidence is the fitting surface
- A screenshot proves only the captured visual state.
- Dynamic behavior requires executed user action and retained postcondition evidence.

## Delivery-Fit Rules
- Completion requires the frozen requested deliverable.
- Completion requires user burden to be satisfied.
- Completion uses owner deferral only through the owning upstream record.
- Owner deferral names:
  - deferred item
  - owner
  - reason
  - next action
- Downstream missing implementation, proof, or acceptance evidence cannot create deferral; it leaves the row open or blocked.
- Record implemented subset coverage against the requested deliverable.
- Classify half-delivered artifacts as defects.
- Type-fit defaults live in `.claude/skills/work-planning/references/deliverable-defaults.md`.

## CORE-WORKFLOW-CLOSURE
Use `CORE-WORKFLOW-CLOSURE` for executable user-facing software.
The matrix is canonical for user-visible action closure.
Every row is proven end-to-end on the user surface.

Required row families:
- create/import/upsert->disposition path, including delete, clear, archive, void, deactivate, restrict, or frozen no-disposition basis
- edit->save plus reload persistence and every in-scope visible consumer of the changed fact
- input/mutation->dependent recompute/reactivity across in-scope summaries, totals, badges, warnings, statuses, reports, and exported or ledger views
- displayed record, metric, card, row, icon, or button->inspection, action, navigation destination, or explicit display-only basis
- entity, relationship, derived value, or displayed aggregate->source authority trace and related-entity path, unless a frozen not-applicable basis states why no user decision or action depends on that path

Each row names:
- trigger surface
- paired completion surface
- persistence or recompute basis
- expected visible postcondition
- proof owner
- acceptance owner

An uncovered row is a defect.
An uncovered row blocks validator `PASS` and local verified-result closure.
Prove dynamic rows with executed user action.
Prove UI consumption through the UI surface.
Prove user-surface behavior on the user surface.

## Acceptance Rules
- Reviewer evidence feeds validation.
- Tester evidence feeds validation.
- `validator` owns final acceptance and issues final `PASS/HOLD/FAIL`.
- Local closure report admission is owned by `.claude/reference/user-reporting-law.md`.
- Local closure is valid only when no final-arbitration trigger applies.
- Final-arbitration trigger definitions live in `.claude/skills/agent-validator/references/validator-lane-detail.md` `## Final-Arbitration Trigger Definitions`.
- Acceptance compares against the frozen delivery contract.
