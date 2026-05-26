---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "report-exception; evidence-basis; final-verified-result; open-work-truth"
---
# team-lead: Reporting Prohibition Rules

## Purpose
Consume this reference only after `.claude/reference/reporting-prohibition-law.md` grants a narrow report exception.
Return report admission, exception reasons, non-reportable content, and report shape to `.claude/reference/reporting-prohibition-law.md`.
Record team-lead's compact evidence-basis decision for the admitted report.

## Consume When
- A reporting-law-admitted team-lead report needs compact evidence-basis control.
- The admitted report uses visual, rendered, runtime, or user-surface proof to support final verified result wording.
- The admitted report might include a lawfully deferred/out-of-scope surface, user-action blocker truth, closeout residual truth, or artifact links.

## Required Output
Record:
- reporting-law exception reason
- current `Skill(self-verification)` convergence when required
- concise evidence basis
- included or omitted lawfully deferred/out-of-scope basis
- link placement basis when material

## Routing Gate
- Missing reporting-law exception returns to `.claude/reference/reporting-prohibition-law.md`.
- Missing required `Skill(self-verification)` convergence opens `Skill(self-verification)`.
- Claim strength beyond evidence narrows to verified scope or routes `INFERENCE/UNVERIFIED` through `.claude/reference/reporting-prohibition-law.md`.
- Missing lawfully deferred/out-of-scope, user-action blocker, residual, or artifact-link basis opens the owning synthesis, proof, acceptance, closeout, or filesystem-result path.

## Resolve Next Owner And Action
- Satisfied evidence-basis control returns to `.claude/reference/reporting-prohibition-law.md` for admitted prose.
- Reporting-law gaps stay suppressed and continue through the owning Procedure Plane or Communication Plane path.
- Verification gaps open `Skill(self-verification)`.
- Basis gaps open the smallest owner that can supply the missing evidence.

## Evidence Basis
- Include only the basis admitted by `.claude/reference/reporting-prohibition-law.md`.
- Final-result proof basis names retained evidence anchor, decisive surface, inspected scope/action, and material lawfully deferred/out-of-scope or defect state only when material to the admitted report.
- Raw artifacts are shown only when explicitly requested or when the artifact is the deliverable.

## Composition Atomic-Check

PROTECTED-LOCAL-RESTATEMENT-BASIS: composition-atomic-check colocated at team-lead reporting-discipline owner because cure activates at every team-lead admitted-prose composition moment. Canonical rules at `.claude/reference/reporting-prohibition-law.md` `## Report Shape` Multi-Element Inline-Render Constraint + `## Pre-Report Gate` row 52; this surface applies them at team-lead-specific composition moments with atomic-check framing.

NAMING DISAMBIGUATION: this file `.claude/skills/agent-team-lead/references/reporting-prohibition-rules.md` is the OPERATIONAL team-lead reference for reporting discipline; it is DISTINCT from the PROTECTED `.claude/reference/reporting-prohibition-law.md` which carries the canonical rules. Modifications here go through normal Skill(governance-modification) cycle; modifications to the PROTECTED file require operator-policy-choice gate per `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection`.

### Multi-Element Inline-Render Atomic-Check
Before composing any admitted-class report containing multi-element required content (≥2 patches/items each requiring multi-element detail, or single patch whose elements alone exceed concise default capacity), atomically test total inline bullet/cell count against the concise default (lead-with-result sentence + ≤5 supporting bullets total). If total exceeds, suspend inline composition; route required detail to a retained carrier; emit only (1) lead-with-result statement, (2) item count + concise cross-row summary ≤5 bullets, (3) carrier path citation, (4) operator decision options when applicable. Inline-dump of all required elements × N patches is anti-pattern per canonical `## Report Shape` Multi-Element Inline-Render Constraint.

### Direct-Question Answer-Required Atomic-Check
When the active user turn contains a direct question (yes/no, what/why/which, status-asking, or equivalent in any language), the same-turn response MUST emit an answer prose with REPORT-REASON: `explicit status answer` per canonical `## Pre-Report Gate` row 52 before any non-trivial tool batch. Tool-batch-only response without answer prose to a direct user question is `explicit status answer` evasion. Force-continuation reflex (immediate jump to grep/Bash/Read without emitting answer) is the named anti-pattern; the cure is: answer first, then tool batch. Post-answer next-tool-call duty is owned by `.claude/skills/agent-team-lead/references/pre-action-gate.md` `## Action Invariants` Report separation invariant (covers post-answer prose surface composition moment).
