---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Detailed Design Philosophy; Modification Philosophy; Work Execution Philosophy continuity and change boundary"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# Common Doctrine Reference: Scope, Continuity, And Change

## Purpose
This reference gives the detailed execution rules behind `CLAUDE.md` Scope, Continuity, Change, and Preservation.
Use it when work:
- judges an existing artifact
- modifies an existing artifact
- migrates an existing artifact
- reduces an existing artifact
- reports on an existing artifact

## Consume When
- Work judges, modifies, migrates, reduces, or reports on an existing artifact.
- Work changes governance, role, skill, reference, hook, setting, or runtime-adjacent text.
- Packet, handoff, or synthesis drift from the original request, plan, or design is possible.
- New or sharpened doctrine affects current-session artifacts, in-flight outputs, prior verdicts, or active acceptance.
- A change moves text between owner surfaces.

## Required Output
The consuming owner records these fields for every consumption:
- target artifact
- cited design intent
- applicable core-law axes
- next owner/action

The consuming owner records these fields when structure, scope, meaning movement, mutation, migration, reduction, re-home, reporting, or owner-surface effect is material:
- affected owner surfaces
- preserved meaning
- changed meaning

The consuming owner records stale verdicts or carry-forward evidence when current-session continuity can affect artifacts, in-flight outputs, prior verdicts, or active acceptance.

## Continuity Routing Gate
Judgment requires inspected live owner surfaces.
Mutation requires reconstructed target intent.
Positive synthesis requires carry-forward of:
- same-session changes
- sibling outputs
- acceptance contracts
Removal requires reconstructed source-to-destination meaning.
Governance text removal must additionally satisfy `.claude/reference/modification-minimal-governance-change-law.md` `## Patch-Ready Gate`.

## Resolve Next Owner And Action
- Judgment gaps open live-owner-surface inspection.
- Mutation gaps open target-intent reconstruction.
- Synthesis gaps open cross-continuity carry-forward.
- Removal gaps open source-to-destination reconstruction.

## Design-Intent Rules
- Consequential work starts from the target artifact's cited design intent.
- Consequential work also starts from cited applicable core-law axes.
- Existing-artifact judgment, mutation, migration, reduction, and reporting carry both as `TARGET-INTENT-BASIS`.
- Receivers consume `TARGET-INTENT-BASIS` before lane work.
- Receivers raise `scope-pressure` when `TARGET-INTENT-BASIS` is missing or unsafe.
- Original creation applies `.claude/reference/detailed-design-core-law.md` `## Design Intent And Scope Law` before recording concrete or `not-applicable` `TARGET-INTENT-BASIS`.

## Scope-Abuse Rules
Scope-abuse trigger exists when a route, dispatch, governance proposal, patch, mutation, active-rule application, synthesis, report, completion, or acceptance claim omits, substitutes, infers, or defaults required material.
Required material is a material request, plan, `TARGET-INTENT-BASIS`, evidence basis, or acceptance requirement.
Route to correction when the unsafe move is:
- `silent omission`: required material is absent from the packet, synthesis, judgment, or report.
- `vague phrasing`: wording hides the owner, boundary, evidence, or required next action.
- `assignment-intent-only basis`: assignment purpose replaces cited request, plan, design intent, or evidence.
- `anchor-by-inference`: an uncited source or unstated assumption is treated as a scope anchor.
- `literal-text-only-lens substitution`: literal wording replaces semantic intent, design intent, or user burden.
- `request-fit-only substitution`: request fit is treated as enough without plan, design, evidence, and acceptance reconciliation.
- `PASS-by-default`: missing evidence or missing required owner output is treated as pass instead of `OPEN-SURFACES` or blocker.

Corrective route:
- dispatcher uses `route-replan`
- lane intake uses `scope-pressure`
- uncorrected unsafe state uses `hold|blocker`

## Cross-Continuity Rules
Before dispatch, synthesis, phase movement, or consequential user-facing output, apply:
- same-session patches
- confirmed corrections
- recurrence barriers
- lane charters
- packet requirements
- acceptance contracts
- sibling outputs

Drift reopens `work-planning`.

## Preservation Rules
- Scope-continuity consumers use `.claude/reference/modification-core-law.md` `### Preservation Rules` as the canonical common baseline.
- Local scope/change edits inherit the baseline at the canonical owner without local restatement.
- Operation-specific emphasis (Migration / Refactoring / Reduction / Re-home verification), weaker-duplicate handling, and role-specific content placement are owned by `.claude/reference/modification-core-law.md` `### Preservation Rules`; scope-continuity consumers consult that canonical owner for the operation-specific verification detail and the duplicate/role-specific rules.

## Retroactive Application Rules
- Retroactive application is owned by `.claude/reference/modification-core-law.md` `### Retroactive Application Rules`.
- Scope-continuity consumers record affected current-session artifacts, stale verdicts, carry-forward evidence, and next owner/action before synthesis or mutation.
