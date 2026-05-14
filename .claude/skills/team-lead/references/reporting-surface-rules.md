---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/agents/team-lead.md
SOURCE-RULES: "RPA-7 report shape and evidence inclusion; CLAUDE.md Communication; Reference Binding"
---
# team-lead: Reporting Surface Rules

## Contents
- Purpose
- Consume When
- Required Output
- Stop
- Resolve Next Owner And Action
- Primary Report Surface
- Output Shape
- Internal Content
- Evidence Basis

## Purpose
Use this reference to keep user-facing team-lead reports compact, evidence-bounded, and free of internal procedure.
These team-lead prose surfaces use this same report shape:
- terminal-visible prose
- pane-visible prose

## Consume When
- Team-lead will emit:
  - user-facing text
  - terminal-visible prose
  - pane-visible prose
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
Stop before `FINAL` when:
- residual work remains
- required shard outputs, required corpus surfaces, or material open surfaces are missing, late, unintegrated, or not explicitly deferred/out-of-scope
Stop before basis expansion by default.
Basis expansion is allowed only for:
- explicit user detail request
- blocker-required detail

## Resolve Next Owner And Action
- A stopped reporting route opens `SV-RESULT`.
- A stopped `FINAL` route opens residual work processing.
- A stopped shard/corpus `FINAL` route opens merge-owner integration, explicit owner deferral, or out-of-scope classification.
- A stopped basis-expansion route emits the compact report shape.

## Primary Report Surface
Pick one:
- `verified result`
- `blocker`
- `next action`
- `closeout residual`

`next action` report requires a blocked lead-owned execution path.
Blocked path means:
- proven user-owned decision
- awaited runtime gate from another lane
- explicit upstream `HOLD`
On any open lead-owned path, execute silently in the same turn.
Agent-signal reporting follows `.claude/skills/team-lead/references/output-surface-law.md`.

## Output Shape
- `PHASE-RESULT` carries:
  - phase outcome
  - next owner/action
  - canonical artifact path
- `PHASE-RESULT` runs one or two sentences.
- `FINAL` summarizes the core result first.
- `FINAL` evidence inclusion is limited to:
  - highest-impact evidence
  - verified user-usable next state
- `FINAL` completion scope stays within:
  - validator/FAR supported scope
  - Evidence-Quality Matrix supported scope
- `FINAL` audit scope stays within:
  - integrated shard outputs
  - inspected corpus
  - explicitly owner-deferred surfaces
  - out-of-scope surfaces
- `FINAL` synthesis scope stays within:
  - integrated shard outputs
  - inspected corpus
  - explicitly owner-deferred surfaces
  - out-of-scope surfaces
- Do not use:
  - `FINAL` wording for partial shard drafts
  - full-corpus wording for incomplete corpus inspection
  - exhaustive wording for incomplete corpus inspection
  - confirmed-defect wording for unclassified findings
- Clean closeout report shape is silence or one line.
- Warning-bearing closeout names:
  - exact residual state
  - exact hold reason
  - next recovery surface

## Internal Content
Internal-content suppression is owned by `.claude/skills/team-lead/references/output-surface-law.md`.
Report only the selected primary truth surface in the compact output shape.

Treat these labels as internal-content labels:
- `internal:`
- `(internal):`

## Evidence Basis
When basis is needed, include concise verification basis, material open surfaces, unverified items, and required user action.
If claim strength outruns evidence, narrow the claim or report `INFERENCE/UNVERIFIED`.
Visual, rendered, runtime, or user-surface proof in final wording names retained evidence anchor, decisive surface, inspected scope/action, and defect/open-surface state.
Raw artifacts are shown only when explicitly requested or when the artifact is the deliverable.
