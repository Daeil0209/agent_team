---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/document-automation/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# document-automation: Result Report Generation
Use when generating a result report from a plan, proposal, or project reference.

## Adaptive Generation Levels
- L1 rich plan: reorganize evidence-rich source content with minimal inference.
- L2 standard plan: generate domain-appropriate process narrative for structural gaps when source lacks execution detail.
- L2 is the default.
- L3 sparse or outline-only plan: supply expert-level structure and explicit domain assumptions within evidence-safe bounds.
- No level permits fabricated outcomes, measurements, or performed work.
- Assess generation level per section.
- Section-level evidence differences govern over document-level generation level.

## Voice And Evidence Rules
- Default to bulletin-style short declarative sentences with key information first.
- Hybrid voice uses factual-report tone for body and method sections.
- Hybrid voice uses performance-emphasis tone for expected-effect and significance sections.
- Experiments, tests, measurements, and validation results require actual evidence before writing them as performed.
- Plan-described experiments are referenced only as planned or intended.

## Visual Rules
- PPT places text with supporting visual per slide.
- PPT uses balanced text-to-visual ratio.
- PPT font sizes remain legible inside all visuals.
- Word/HWP images occupy at most about one-third of page area.
- Every Word/HWP image requires a descriptive caption.
- Short documents of 2-3 pages use heavier visual ratio only when visuals compress decision-relevant information better than text.
- Long documents of 10+ pages use about 5:5 to 6:4 text-to-visual ratio.

## Completion Conditions
- Target submission-ready quality where the human role is reviewer or approver.
- Fill logical, structural, and transitional gaps within evidence-safe bounds.
- Page-count mismatch is a defect.
- Resolve page-count mismatch through text-visualize-compress cycle.

## Resolve Next Owner And Action
- Return generation level, voice/evidence boundary, visual ratio, page-count state, and completion-condition gaps to the active document-automation workflow.
- If evidence-safe bounds or page-count target is unresolved, route the named gap before result report generation continues.
