---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "admitted-report-shape; final-result-line-budget; report-location-line"
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# team-lead: User Reporting Rules

## Purpose
Consume this reference only after `.claude/reference/reporting-prohibition-law.md` grants a narrow report exception.
Return report admission, exception reasons, and non-reportable content to `.claude/reference/reporting-prohibition-law.md`.
Return admitted report wording and shape to `.claude/reference/reporting-user-reporting-law.md`.
Record the compact report-shape basis for admitted team-lead prose.

## Consume When
- A reporting-law-admitted team-lead report needs final-result line-budget, requested-work-only, report-location, or link-placement basis.
- A draft admitted report may exceed the shape allowed by `.claude/reference/reporting-user-reporting-law.md`.

## Required Output
Record:
- report-shape law consumed
- final-result `<=8` rendered-line basis when material
- requested-work-only basis when material
- report-location line basis when material
- link-placement basis when material

## Routing Gate
- Missing reporting-law exception returns to `.claude/reference/reporting-prohibition-law.md`.
- Missing final-result line-budget, requested-work-only, report-location, or link-placement basis keeps this reference active until the basis is recorded or opens the smallest evidence owner that can supply it.
- A recorded basis with draft wording that violates report shape returns to `.claude/reference/reporting-user-reporting-law.md`.

## Resolve Next Owner And Action
- Satisfied report-shape basis returns to `.claude/reference/reporting-user-reporting-law.md` for admitted prose shape only, then resumes the reporting-law continuation or prior live owner/action.
- Report-admission gaps stay suppressed and return to `.claude/reference/reporting-prohibition-law.md`.
- Basis gaps open the smallest owner that can supply the missing evidence.

## Evidence Basis
- Final-result shape basis records `REPORT-LINE-BUDGET: <=8`, `REQUESTED-WORK-ONLY: pass`, and `REPORT-LOCATION-LINE: 보고서: <canonical artifact path> | 보고서: 해당 없음`.
- Raw artifacts are shown only when explicitly requested or when the artifact is the deliverable.
