---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-13 report shape and evidence inclusion; Reporting Philosophy; Work Execution Philosophy"
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# team-lead: Reporting Prohibition Rules

## Contents
- Purpose
- Consume When
- Required Output
- Routing Gate
- Resolve Next Owner And Action
- Prohibited Report Surface
- Shape Binding
- Internal Content
- Evidence Basis

## Purpose
Use this reference when team-lead visible prose is being considered. It applies `.claude/reference/reporting-prohibition-law.md`, keeps prohibited content out of the user surface, and limits output to the compact narrow exception.
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
Record shape only after reporting-prohibition law grants a narrow report exception:
- narrow exception reason
- output surface
- self-verification status when required
- evidence basis included
- open surfaces omitted or included by rule

## Routing Gate
Reporting requires required `Skill(self-verification)` result verification.
`FINAL` follows `.claude/skills/agent-team-lead/references/output-surface-law.md` `## Output Routing Gate` as the canonical FINAL-residual owner.
Basis expansion stays closed by default.
Basis expansion remains limited to:
- explicit user detail request
- blocker-required detail

## Resolve Next Owner And Action
- Reporting gaps open `Skill(self-verification)` result verification.
- `FINAL` residual gaps open the residual queue, synthesis merge, proof, acceptance, owner-deferral, or out-of-scope action named by the open item.
- Basis-expansion gaps emit the compact report shape.

## Prohibited Report Surface
Report prohibition and narrow exception reasons are owned by `.claude/reference/reporting-prohibition-law.md`.
This section records only the chosen narrow exception reason and report shape.
On any open lead-owned path, execute silently in the same turn.
Agent signals are Communication Plane transport and are not report surfaces.

## Shape Binding
Report shape, narrow exception reasons, and non-reportable content are owned by `.claude/reference/reporting-prohibition-law.md`.
This reference records the narrow exception report's compact shape by citing reporting-prohibition law rather than restating `PHASE-RESULT`, `FINAL`, status, blocker, or closeout exception lists.
Use this reference only to record the compact evidence basis after reporting-prohibition law grants a narrow report exception.
Incomplete shard, corpus, synthesis, validation, or defect-classification surfaces stay outside positive wording by the reporting law and the active synthesis/acceptance owner.

## Internal Content
Internal-content suppression is owned by `.claude/reference/reporting-prohibition-law.md`.
Use the compact output shape granted by `.claude/reference/reporting-prohibition-law.md`.
Include permitted outcome only when the narrow exception supports it.
Include status only when the narrow exception supports it.
Include blocker truth only when the narrow exception supports it.
Include residual truth only when the narrow exception supports it.
Include compact basis only when material to the granted exception.

Treat these labels as internal-content labels:
- `internal:`
- `(internal):`

## Evidence Basis
When verification basis is needed, include concise verification basis.
When material open surfaces are reportable, include material open surfaces.
When unverified items are material to the claim, include unverified items.
When user action is required, include required user action.
Apply `.claude/reference/reporting-prohibition-law.md` `## Report Shape` ordering before final-result prose.
When final-result links are material, consume that section for link placement before emission.
If claim strength outruns evidence, narrow the claim or report `INFERENCE/UNVERIFIED`.
Visual, rendered, runtime, or user-surface proof in final wording names retained evidence anchor, decisive surface, inspected scope/action, and defect/open-surface state.
Raw artifacts are shown only when explicitly requested or when the artifact is the deliverable.
