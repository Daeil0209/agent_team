---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/instructional-design/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---

# Edu-Spec — Reference Material
Reference checklists, tables, and catalogs for `instructional-design`.
Read this file explicitly when pedagogical detail is required by the active owner path.
### Mathematical Instruction Standards
- Prerequisite checkpoint annotation: before presenting ODE or advanced math solutions, list required prerequisites (integration techniques, chain rule, partial derivatives) with self-assessment reference
- Scaffolding progression mandate: concrete example → abstract method → applied problem → reflection
- Pacing rule: one new concept per instructional unit; compound concept introduction requires explicit bridging explanation connecting to prior knowledge
- Notation consistency:
  - define all symbols at first use
  - maintain consistent notation throughout
  - explicit equivalence is required before changing between y', dy/dx, and ẏ
- Difficulty gradient: each problem set must progress from direct application → moderate variation → synthesis/transfer
### Worked Example Pedagogy
- 5-component structure mandate for every worked example:
  1. **Problem classification** — what type of problem is this? (separable, exact, linear, etc.)
  2. **Method selection rationale** — why this method? What features of the equation indicate the choice?
  3. **Full solution with units** — complete derivation, no skipped steps, units carried through
  4. **Verification/sanity check** — back-substitute, check limits, dimensional analysis
  5. **Common error warnings** — typical mistakes students make at each critical step
- Anti-pattern: jumping directly to solution technique before classification = pedagogical defect
- Variation requirement: after each worked example, provide at least one variation that changes the classification or requires a different method
- Faded scaffolding: in problem sets following worked examples, progressively remove hints (first problems show method choice, later problems require student to identify method)
### Defect Ownership
This role owns these instructional-design local defect types:
- `concept_cascade_missing` — lesson concept structure not frozen before dense fill; prerequisites and reveal order not established
- `equation_text_placeholder` — formula slide reads as notes rather than a teachable equation block with interpretation
- `slide_role_conflict` — slide carries mixed roles (content + navigation + summary) that fragment learner attention
- `narrative_redundancy` — explanatory text restates what a diagram already shows with no interpretive value
- `feature_missing` — geometry, feature state, or handoff context absent from a process or CAD slide, forcing the learner to imagine missing information
Defect records must record defect type, owner, missed-catch responsibility, severity, corrective action, retest conditions, and recurrence trigger.
On recurrence of any owned defect type, add or strengthen the corresponding gate in this SKILL.md before the next run.

## Resolve Next Owner And Action
- Return pedagogy structure, worked-example requirements, learner-risk findings, and defect records to the active instructional-design workflow.
- If instructional findings change visual composition, mathematical correctness, or acceptance proof, route the named requirement to that owner before delivery continues.
