---
PRIMARY-OWNER: developer
LOAD-POLICY: on-demand reference only
---

# benchmark-simulation: Self-Initiated Discovery Trigger Catalog
These triggers fire autonomously. The responsible owner — `team-lead` at planning, `developer` / `researcher` at execution — must initiate external benchmarking at their own owner path without waiting for explicit user direction; loading this skill still follows CLAUDE.md `## Skill Loading` (frozen packet basis, `SKILL-AUTH`, or verified phase-local refinement at the named owner path). Trigger detection is the planner's job at planning and lane agents' job at execution.

## Mandatory Triggers
- **T1. Visual / structural deliverable**: dashboard, monitoring UI, report-with-figures, document layout, slide composition, form-flow design.
- **T2. "Best" / "ideal" / "professional" / "industry-standard" claim** is implied or stated for the deliverable.
- **T3. Known external solution space exists**: industry standards, established design systems, public reference implementations are known to address this problem class.
- **T4. Verification methodology selection** materially affects acceptance quality.
- **T5. Iteration of previously-shipped surface** where iteration must avoid known anti-patterns.
- **T6. Capability-evolution claim**: when a self-growth round claims the team will be better at a capability after the round.

## Conditional Triggers
- **C1. Prior session evidence is purely model-prior** on a material decision.
- **C2. Multiple destination paths are credible** and the choice depends on real-world fit.
- **C3. Cross-cultural / cross-locale concern** requires domain-specific benchmark.
- **C4. Accessibility / regulatory constraint** is in scope; authoritative standards must ground the design.

## Deferral Discipline
When a trigger fires but external benchmarking is intentionally deferred, record the deferral basis explicitly:
- `BENCHMARK-DEFERRED: user-supplied-reference-already-fits` with citation
- `BENCHMARK-DEFERRED: prior-session-already-grounded` with citation
- `BENCHMARK-DEFERRED: cost-exceeds-value` with cost calculation

Silent skip when a mandatory trigger fired is a planning-evidence defect, not legitimate scope reduction.
