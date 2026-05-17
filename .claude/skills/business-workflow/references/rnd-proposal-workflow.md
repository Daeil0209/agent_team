---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/business-workflow/SKILL.md
SOURCE-RULES: "domain-rule-catalog.md routed R&D Proposal Domain Rules"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---

# R&D Proposal Workflow Rules

## Purpose
Use this reference for automated generation of R&D proposals against external announcements or RFPs.

## Announcement As Rule Source
The business packet decomposes an announcement or RFP into explicit requirements, implicit requirements, and estimated evaluator intent.
Explicit requirements include stated evaluation criteria, mandatory sections, and format rules.
Implicit requirements include expectations inferable from announcement structure, issuing body norms, and domain conventions.
Estimated evaluator intent identifies what the evaluator is likely optimizing for from program goals and funding context.
Each requirement class remains separately labeled.

## Organizational Strategy Parameters
Proposal-based generation captures organizational strategy inputs before generation.
Required fields are purpose, focus item, emphasis axis, and roadmap position.
Purpose states why the organization pursues the call.
Focus item names the technology, product, or capability being proposed.
Emphasis axis names the persuasion angle.
Roadmap position states where the proposal sits in the organization's multi-year plan.
Development subject and persuasion axis remain separate fields.

## Fact Vs Design Boundary
Current holdings are fact-class.
Fact-class examples include verified results, published metrics, granted patents, customer deployments, and partnership agreements.
Fact-class claims require evidence.
Future plans are design-class.
Design-class examples include development stages, review milestones, persuasion structure, expected effects, and market projections.
The business packet tags each claim class before downstream generation.

## Proposal Business-Rule Checkpoints
For proposal document generation order, use `.claude/skills/document-automation/references/proposal-plan-grant.md` `Proposal/Plan/Grant`.
For generator architecture, use `.claude/skills/software-architecture/references/architecture-extensions.md` `Constraint-Satisfaction Document Generator Architecture Extension`.
business-workflow owns proposal business rules, requirement decomposition, evaluator-intent estimate, organizational strategy parameters, fact-vs-design claim labels, and narrative dependency constraints consumed by document generation.
Proposal business-rule checkpoints are announcement or RFP decomposition, evaluator-intent estimate, benchmark relevance basis, organizational strategy capture, strategy axis determination, fact-vs-design tagging, and narrative dependency basis.
These checkpoints gate generation while document-automation remains the proposal document generation-order owner.
The narrative dependency chain is `problem -> goal -> method -> effect`.
Each narrative stage must logically necessitate the next.

## Writing Stance
Proposals use plan-oriented and execution-specific language.
Valid proposal stance examples are "will develop", "targets X metric by Y milestone", and "applies method Z to achieve W".
Completion-oriented assertions require fact-class evidence.
Future certainty must not be written as past accomplishment.

## Resolve Next Owner And Action
- Complete proposal rule packet opens document-automation for proposal generation.
- Missing required proposal business-rule checkpoint opens business-workflow packet correction.
- Missing fact-class evidence downgrades the claim or opens researcher evidence work.
