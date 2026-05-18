---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
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
- Shape Binding
- Internal Content
- Evidence Basis

## Purpose
Use this reference only after `.claude/reference/user-reporting-law.md` admits a user-facing team-lead report. It keeps admitted reports compact, evidence-bounded, and free of Communication Plane or Procedure Plane payload.
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
Record shape only after user-reporting law admits the report:
- admitted report reason
- output surface
- self-verification status when required
- evidence basis included
- open surfaces omitted or included by rule

## Stop
Stop before reporting when required `Skill(self-verification)` result verification is missing.
Stop before `FINAL` when residual deliverable convergence remains open under `.claude/skills/agent-team-lead/references/routine-gate-continuation.md`, `.claude/skills/agent-team-lead/references/synthesis-consume.md`, or the active acceptance/proof owner.
Stop before basis expansion by default.
Basis expansion is allowed only for:
- explicit user detail request
- blocker-required detail

## Resolve Next Owner And Action
- A stopped reporting route opens `Skill(self-verification)` result verification.
- A stopped `FINAL` route opens the residual queue, synthesis merge, proof, acceptance, owner-deferral, or out-of-scope action named by the open item.
- A stopped basis-expansion route emits the compact report shape.

## Primary Report Surface
Report admissibility and allowed report reasons are owned by `.claude/reference/user-reporting-law.md`.
This section records only the chosen admitted reason and report shape.
On any open lead-owned path, execute silently in the same turn.
Agent signals are Communication Plane transport and are not report surfaces.

## Shape Binding
Report shape, allowed reasons, and non-reportable content are owned by `.claude/reference/user-reporting-law.md`.
This reference does not restate `PHASE-RESULT`, `FINAL`, status, blocker, or closeout allowlists.
Use this reference only to record the admitted report's compact evidence basis after user-reporting law admits the report.
Incomplete shard, corpus, synthesis, validation, or defect-classification surfaces stay outside positive wording by the reporting law and the active synthesis/acceptance owner.

## Internal Content
Internal-content suppression is owned by `.claude/reference/user-reporting-law.md`.
Report only the user-reporting-law-admitted reason in the compact output shape.

Treat these labels as internal-content labels:
- `internal:`
- `(internal):`

## Evidence Basis
When basis is needed, include concise verification basis, material open surfaces, unverified items, and required user action.
If claim strength outruns evidence, narrow the claim or report `INFERENCE/UNVERIFIED`.
Visual, rendered, runtime, or user-surface proof in final wording names retained evidence anchor, decisive surface, inspected scope/action, and defect/open-surface state.
Raw artifacts are shown only when explicitly requested or when the artifact is the deliverable.
