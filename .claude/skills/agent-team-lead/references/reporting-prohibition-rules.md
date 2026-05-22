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
- The admitted report might include material open work, blocker truth, residual truth, or artifact links.

## Required Output
Record:
- reporting-law exception reason
- current `Skill(self-verification)` convergence when required
- concise evidence basis
- included or omitted open-work basis
- link placement basis when material

## Routing Gate
- Missing reporting-law exception returns to `.claude/reference/reporting-prohibition-law.md`.
- Missing required `Skill(self-verification)` convergence opens `Skill(self-verification)`.
- Claim strength beyond evidence narrows to verified scope or routes `INFERENCE/UNVERIFIED` through `.claude/reference/reporting-prohibition-law.md`.
- Missing open-work, blocker, residual, or artifact-link basis opens the owning synthesis, proof, acceptance, closeout, or filesystem-result path.

## Resolve Next Owner And Action
- Satisfied evidence-basis control returns to `.claude/reference/reporting-prohibition-law.md` for admitted prose.
- Reporting-law gaps stay suppressed and continue through the owning Procedure Plane or Communication Plane path.
- Verification gaps open `Skill(self-verification)`.
- Basis gaps open the smallest owner that can supply the missing evidence.

## Evidence Basis
- Include only the basis admitted by `.claude/reference/reporting-prohibition-law.md`.
- Final-result proof basis names retained evidence anchor, decisive surface, inspected scope/action, and material open or defect state only when material to the admitted report.
- Raw artifacts are shown only when explicitly requested or when the artifact is the deliverable.
