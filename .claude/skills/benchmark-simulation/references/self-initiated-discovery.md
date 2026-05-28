---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/benchmark-simulation/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# benchmark-simulation: Owner-Initiated Benchmark Cues
These cues are mandatory selection checks for `SKILL-RECOMMENDATIONS` or lane-selected skill basis. Loading still follows `.claude/CLAUDE.md` `## 3. Work Execution Philosophy`.
The responsible owner evaluates them without waiting for explicit user direction.
When a material cue applies, select `benchmark-simulation` unless a valid non-selection basis below proves the benchmark path is not needed for the active decision; non-selection is not owner deferral.

## Cues
- **T1. Visual / structural / information-representation deliverable**: dashboard, monitoring UI, report-with-figures, document layout, slide composition, form-flow design, diagram, dense table, chart, card set, governance/procedure representation, or any surface where external examples can reveal useful information elements or presentation patterns.
- **T2. "Best" / "ideal" / "professional" / "industry-standard" claim** is implied or stated for the deliverable.
- **T3. Known external solution space exists**: industry standards, established design systems, public reference implementations are known to address this problem class.
- **T4. Verification methodology selection** materially affects acceptance quality.
- **T5. Iteration of previously-shipped surface** where iteration must avoid known anti-patterns.
- **T6. Capability-growth claim**: when a governance modification round claims the team will be better at a capability after the round.

## Conditional Cues
- **C1. Prior session evidence is purely model-prior** on a material decision.
- **C2. Multiple destination paths are credible** and the choice depends on real-world fit.
- **C3. Cross-cultural / cross-locale concern** requires domain-specific benchmark.
- **C4. Accessibility / regulatory constraint** is in scope; authoritative standards must ground the design.

## Non-Selection Discipline
When a material cue is not selected, record the non-selection basis:
- `BENCHMARK-NOT-SELECTED: user-supplied-reference-already-fits` with citation
- `BENCHMARK-NOT-SELECTED: prior-session-already-grounded` with citation
- `BENCHMARK-NOT-SELECTED: burden-exceeds-value` with burden basis, lower-confidence impact, and open evidence risk
Silent skip when a material cue applies is a planning-evidence defect, not legitimate scope reduction.

## Resolve Next Owner And Action
- Applied material cue opens `benchmark-simulation`.
- Valid non-selection returns cited non-selection basis to the consuming owner and keeps any material evidence risk open.
- Silent skip opens planning-evidence correction.
