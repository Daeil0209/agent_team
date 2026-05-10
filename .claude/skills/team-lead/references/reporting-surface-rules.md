---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/agents/team-lead.md
SOURCE-RULES: "RPA-7 report shape and evidence inclusion; Communication And Reporting Law; Reference Binding"
---
# team-lead: Reporting Surface Rules

## Contents
- Purpose
- Consume When
- Required Output
- Stop
- Next-Action Drive
- Primary Report Surface
- Output Shape
- Internal Content
- Evidence Basis

## Purpose
Use this reference to keep user-facing team-lead reports compact, evidence-bounded, and free of internal procedure.
Terminal-visible team-lead prose uses this same report shape.
Pane-visible team-lead prose uses this same report shape.

## Consume When
- Team-lead will emit user-facing text.
- Team-lead will emit terminal-visible prose.
- Team-lead will emit pane-visible prose.
- Phase/stage-end reporting is about to occur.
- Completion wording is about to occur.
- User asks for status during an active path.
- Visual, rendered, runtime, or user-surface proof supports final wording.

## Required Output
Record:
- primary report surface
- output surface
- SV status when required
- evidence basis included
- open surfaces omitted or included by rule

## Stop
Stop before reporting when `SV-RESULT` is required and missing.
Stop before `FINAL` when residual work remains.
Stop before basis expansion by default.
Basis expansion is allowed for explicit user detail request.
Basis expansion is allowed for blocker-required detail.

## Next-Action Drive
- A stopped reporting route opens `SV-RESULT`.
- A stopped `FINAL` route opens residual work processing.
- A stopped basis-expansion route emits the compact report shape.

## Primary Report Surface
Pick one:
- `verified result`
- `blocker`
- `next action`
- `dispatch pending`
- `closeout residual`

`next action` report requires a blocked lead-owned execution path.
Blocked path means proven user-owned decision, awaited runtime gate from another lane, or explicit upstream `HOLD`.
On any open lead-owned path, execute via tool calls in the same turn.

## Output Shape
- `PHASE-RESULT` carries phase outcome plus next owner/action plus canonical artifact path.
- `PHASE-RESULT` runs one or two sentences.
- `FINAL` summarizes the core result first.
- `FINAL` evidence inclusion is limited to highest-impact evidence, remaining blocker if any, and user-usable next state.
- `FINAL` completion scope stays within validator/FAR supported scope.
- `FINAL` completion scope stays within Evidence-Quality Matrix supported scope.
- Clean closeout report shape is silence or one line.
- Warning-bearing closeout names exact residual state, exact hold reason, and next recovery surface.

## Internal Content
Default to internal for:
- procedure scaffolding
- routing internals
- owner-opening detail
- skill loading
- receipts
- truth labels
- lifecycle internals
- internal planning fields
- packet labels
- agent-control detail
- raw lane dumps
- convergence tables
- per-stream recitals
- per-finding recitals
- per-artifact recitals
- count summaries
- advisory payloads
- unexplained procedure jargon
- sectioned report cards walking procedural traversal

Treat `internal:` labels as internal-content labels.
Treat `(internal):` labels as internal-content labels.

## Evidence Basis
When basis is needed, include concise verification basis, material open surfaces, unverified items, and required user action.
If claim strength outruns evidence, narrow the claim or report `INFERENCE/UNVERIFIED`.
Visual proof in final wording names retained evidence anchor.
Visual proof in final wording names decisive surface.
Visual proof in final wording names capture scope.
Visual proof in final wording names inspected defect classes or open-surface state.
Rendered proof in final wording names retained evidence anchor.
Rendered proof in final wording names decisive surface.
Rendered proof in final wording names render scope.
Rendered proof in final wording names inspected defect classes or open-surface state.
Runtime proof in final wording names retained evidence anchor.
Runtime proof in final wording names decisive surface.
Runtime proof in final wording names capture scope.
Runtime proof in final wording names inspected defect classes or open-surface state.
User-surface proof in final wording names retained evidence anchor.
User-surface proof in final wording names decisive surface.
User-surface proof in final wording names inspected user action.
User-surface proof in final wording names inspected defect classes or open-surface state.
Raw artifacts are shown only when explicitly requested or when the artifact is the deliverable.
