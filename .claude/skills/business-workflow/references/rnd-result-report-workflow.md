---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/business-workflow/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# R&D Result Report Workflow Rules

## Purpose
Use this reference for automated generation of R&D result reports, completion reports, and final reports against a prior proposal or plan.

## Plan-To-Report State Machine
business-workflow owns the business rules: input capture, gap analysis, fact-vs-design tagging, expected-effects basis, and page-count hard constraint.
Generation state machine (text-first → visualization → compression → conformance) is owned by `.claude/skills/document-automation/references/result-report-generation.md`.
Document generation pipeline architecture is owned by `.claude/skills/software-architecture/references/architecture-extensions.md` `## Constraint-Satisfaction Document Generator Architecture Extension`.

## Adaptive Generation Level
Adaptive generation levels are owned by `.claude/skills/document-automation/references/result-report-generation.md`.
Business-workflow supplies domain facts, constraints, and fabrication blockers for the selected level.

## Fact Fabrication Boundary
Specific performance metrics require evidence.
Quantitative experiment results require evidence.
Test measurements require evidence.
Benchmark numbers require evidence.
Result images or screenshots that imply real system output require evidence.
Development process narrative is inferred only within the selected adaptive level.
Conceptual diagrams are generated only when they are explanatory.
Expected effects are generated only when grounded in market context and technical rationale.
Content at risk of being mistaken for empirical evidence must be marked as projected or illustrative.

## Expected Effects
Expected effects sections incorporate industry applicability, market scalability, and business significance.
Effects must tie to:
- the project's specific technology domain
- identifiable market segments, adoption scenarios, competitive landscape, or regulatory landscape when material
Generic field-contribution boilerplate is insufficient.

## Visualization Requirement
Result reports require visualizations when visuals materially carry completion evidence, process explanation, architecture, comparison, or reader comprehension.
Reference images are used first when provided.
Generated conceptual diagrams fill sections where no reference image exists and visual explanation materially aids comprehension.
Each figure must carry argument weight or clarify structure.

## Writing Stance
Result reports use a mixed stance.
Body and process sections use factual-report tone with completion-oriented language when the report claims completed work.
Effects and significance sections use persuasive-emphasis tone grounded in achieved capabilities.
Projected impact uses qualified persuasion.
Proposal stance must not describe work the report claims is finished.

## Resolve Next Owner And Action
- Complete result-report rule packet opens document-automation for report generation.
- Missing evidence for empirical claims opens researcher evidence work or claim downgrade.
- Missing visualization basis opens visual-composition or document-automation correction.
