---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "report-exception; evidence-basis; final-verified-result; open-work-truth"
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# team-lead: Reporting Prohibition Rules

## Purpose
Consume this reference only after `.claude/reference/reporting-prohibition-law.md` grants a narrow report exception.
Return report admission, exception reasons, and non-reportable content to `.claude/reference/reporting-prohibition-law.md`.
Record team-lead's compact report-admission evidence-basis decision.

## Consume When
- A reporting-law-admitted team-lead report needs compact evidence-basis control.
- The admitted report uses visual, rendered, runtime, or user-surface proof to support final verified result wording.
- The admitted report might include a cited lawful owner-deferral authority, explicit out-of-scope surface, user-action blocker truth, closeout residual truth, or artifact links.

## Required Output
Record:
- reporting-law exception reason
- current `Skill(self-verification)` convergence when required
- concise evidence basis
- included or omitted cited lawful owner-deferral authority or explicit out-of-scope basis

## Routing Gate
- Missing reporting-law exception returns to `.claude/reference/reporting-prohibition-law.md`.
- Missing required `Skill(self-verification)` convergence opens `Skill(self-verification)`.
- Claim strength beyond evidence narrows to verified scope or routes `INFERENCE/UNVERIFIED` through `.claude/reference/reporting-prohibition-law.md`.
- Missing cited lawful owner-deferral authority, explicit out-of-scope, user-action blocker, residual, or artifact-link basis opens the owning synthesis, proof, acceptance, closeout, or filesystem-result path.

## Resolve Next Owner And Action
- Satisfied report-admission evidence-basis control returns to `.claude/reference/reporting-user-reporting-law.md` for admitted prose shape only. For `final verified result`, the admitted shape closes rendering at `REPORT-LOCATION-LINE`. For other admitted report reasons, resume the reporting-law continuation or prior live owner/action when allowed by `.claude/reference/reporting-prohibition-law.md`.
- Reporting-law gaps stay suppressed and continue through the owning Procedure Plane or Communication Plane path.
- Verification gaps open `Skill(self-verification)`.
- Basis gaps open the smallest owner that can supply the missing evidence.

## Evidence Basis
- Include only the basis admitted by `.claude/reference/reporting-prohibition-law.md`.
- Final-result proof basis names retained evidence anchor, decisive surface, inspected scope/action, and material cited lawful owner-deferral authority, explicit out-of-scope, or defect state only when material to the admitted report.
- Raw-artifact display shape is owned by `.claude/skills/agent-team-lead/references/reporting-user-reporting-rules.md` `## Evidence Basis`.
