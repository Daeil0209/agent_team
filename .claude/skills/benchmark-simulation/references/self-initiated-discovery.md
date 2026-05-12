---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/benchmark-simulation/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
---

# benchmark-simulation: Owner-Initiated Benchmark Cues
These cues are mandatory selection checks for `SKILL-RECOMMENDATIONS` or lane-selected skill basis. Loading still follows CLAUDE.md `## Skill Loading`.
The responsible owner evaluates them without waiting for explicit user direction.
When a material cue applies, select `benchmark-simulation` or record a valid deferral basis.

## Cues
- **T1. Visual / structural deliverable**: dashboard, monitoring UI, report-with-figures, document layout, slide composition, form-flow design.
- **T2. "Best" / "ideal" / "professional" / "industry-standard" claim** is implied or stated for the deliverable.
- **T3. Known external solution space exists**: industry standards, established design systems, public reference implementations are known to address this problem class.
- **T4. Verification methodology selection** materially affects acceptance quality.
- **T5. Iteration of previously-shipped surface** where iteration must avoid known anti-patterns.
- **T6. Capability-evolution claim**: when a self-growth round claims the team will be better at a capability after the round.

## Conditional Cues
- **C1. Prior session evidence is purely model-prior** on a material decision.
- **C2. Multiple destination paths are credible** and the choice depends on real-world fit.
- **C3. Cross-cultural / cross-locale concern** requires domain-specific benchmark.
- **C4. Accessibility / regulatory constraint** is in scope; authoritative standards must ground the design.

## Deferral Discipline
When a material cue is not selected, record the deferral basis:
- `BENCHMARK-DEFERRED: user-supplied-reference-already-fits` with citation
- `BENCHMARK-DEFERRED: prior-session-already-grounded` with citation
- `BENCHMARK-DEFERRED: burden-exceeds-value` with burden basis
Silent skip when a material cue applies is a planning-evidence defect, not legitimate scope reduction.

## Resolve Next Owner And Action
- Applied material cue opens `benchmark-simulation`.
- Valid deferral returns cited deferral basis to the consuming owner.
- Silent skip opens planning-evidence correction.
