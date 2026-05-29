---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Design Definition Philosophy; Review And Verification Philosophy; Judgment Philosophy"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
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
- These outputs are about to claim an implemented subset matches the frozen requested deliverable:
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

## Completion Routing Gate
Positive completion requires:
- requested content, function, format, data/example/use instructions, run/read path, and user burden satisfied
- decisive user surface proven
Final acceptance verdict always routes to `validator`.
Local `final verified result` closure is a reporting exception only when no final-arbitration trigger applies.
Local `final verified result` closure does not issue final `PASS/HOLD/FAIL`.

## Resolve Next Owner And Action
- Missing-deliverable gaps open missing-deliverable correction.
- Unproven user-surface gaps open decisive-surface proof.
- Final-acceptance verdict needs open validator routing.

## Evidence Rules
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
- Visual claims require a concrete evidence record naming the visual claim, lane output or owner-local basis, material skill basis, tool execution evidence, rendered or live-document evidence path, and exception basis when any field is not applicable.
- UX claims require a concrete evidence record naming the UX claim, lane output or owner-local basis, material skill basis, tool execution evidence, rendered or live-document evidence path, and exception basis when any field is not applicable.
- A screenshot proves only the captured visual state.
- Dynamic behavior requires executed user action and retained postcondition evidence.

## Delivery-Fit Rules
- Completion uses owner deferral only through the owning upstream record.
- Owner deferral names:
  - deferred item
  - owner
  - reason
  - next action
- Downstream missing implementation, proof, or acceptance evidence leaves the row open or blocked.
- Record implemented subset coverage against the requested deliverable.
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
An uncovered row blocks validator `PASS` and local `final verified result` closure.
Prove dynamic rows with executed user action.
Prove UI consumption through the UI surface.
Prove user-surface behavior on the user surface.

## Acceptance Rules
- Reviewer evidence feeds validation.
- Tester evidence feeds validation.
- `validator` owns final acceptance and issues final `PASS/HOLD/FAIL`.
- Local closure report exception is owned by `.claude/reference/reporting-prohibition-law.md`.
- Local `final verified result` closure is valid only when no final-arbitration trigger applies and the report avoids final acceptance or `PASS/HOLD/FAIL` wording.
- Final-arbitration trigger definitions live in `.claude/skills/agent-validator/references/validator-lane-detail.md` `## Final-Arbitration Trigger Definitions`.
- Acceptance compares against the frozen delivery contract.
