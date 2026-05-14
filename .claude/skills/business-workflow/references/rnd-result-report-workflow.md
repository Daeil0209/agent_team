---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/business-workflow/SKILL.md
SOURCE-RULES: "domain-rule-catalog.md routed Result Report Domain Rules"
LOAD-POLICY: on-demand reference only
---

# R&D Result Report Workflow Rules

## Purpose
Use this reference for automated generation of R&D result reports, completion reports, and final reports against a prior proposal or plan.

## Plan-To-Report State Machine
For document generation pipeline architecture, use `.claude/skills/document-automation/references/document-generation-detail.md`.
business-workflow owns the business rules and generation levels for result reports.
Result report generation follows this state sequence:
1. Input capture.
2. Gap analysis.
3. Adaptive content generation.
4. Text-first draft.
5. Visualization review.
6. Visualization integration.
7. Compression and volume adjustment.
8. Template conformance check.
Page count is a hard output constraint.

## Adaptive Generation Level
Generation level is assessed from input richness.
L1 rich plan summarizes and reorganizes detailed source plans into completion-oriented narrative.
L2 standard generates domain-standard process narrative when the source lacks execution detail.
L3 sparse infers plausible development process from domain knowledge, stated objectives, and deliverable type.
Each level defines allowed inference.
No level permits fabricated outcomes.

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
