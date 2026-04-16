# Edu-Spec — Reference Material

Reference checklists, tables, and catalogs for the edu-spec skill.
Agents must Read this file explicitly when needed — it is NOT auto-injected on Skill load.

### Mathematical Instruction Standards

- Prerequisite checkpoint annotation: before presenting ODE or advanced math solutions, list required prerequisites (integration techniques, chain rule, partial derivatives) with self-assessment reference
- Scaffolding progression mandate: concrete example → abstract method → applied problem → reflection
- Pacing rule: one new concept per instructional unit; compound concept introduction requires explicit bridging explanation connecting to prior knowledge
- Notation consistency: define all symbols at first use; maintain consistent notation throughout (do not switch between y', dy/dx, and ẏ without explicit equivalence statement)
- Difficulty gradient: each problem set must progress from direct application → moderate variation → synthesis/transfer

### Worked Example Pedagogy

- 5-component structure mandate for every worked example:
  1. **Problem classification** — what type of problem is this? (separable, exact, linear, etc.)
  2. **Method selection rationale** — why this method? What features of the equation indicate the choice?
  3. **Full solution with units** — complete derivation, no skipped steps, units carried through
  4. **Verification/sanity check** — back-substitute, check limits, dimensional analysis
  5. **Common error warnings** — typical mistakes students make at each critical step
- Anti-pattern: jumping directly to solution technique without classification = pedagogical defect
- Variation requirement: after each worked example, provide at least one variation that changes the classification or requires a different method
- Faded scaffolding: in problem sets following worked examples, progressively remove hints (first problems show method choice, later problems require student to identify method)

### Defect Ownership

This role owns the following visual/instructional defect types per the shared taxonomy:

- `concept_cascade_missing` — lesson concept structure not frozen before dense fill; prerequisites and reveal order not established
- `equation_text_placeholder` — formula slide reads as notes rather than a teachable equation block with interpretation
- `slide_role_conflict` — slide carries mixed roles (content + navigation + summary) that fragment learner attention
- `narrative_redundancy` — explanatory text restates what a diagram already shows without adding interpretive value
- `feature_missing` — geometry, feature state, or handoff context absent from a process or CAD slide, forcing the learner to imagine missing information

Defect records must also satisfy the shared classification contract (CLAUDE.md): defect type, owner, missed-catch responsibility, severity, corrective action, retest conditions, and recurrence trigger.

On recurrence of any owned defect type, add or strengthen the corresponding gate in this SKILL.md before the next run.
