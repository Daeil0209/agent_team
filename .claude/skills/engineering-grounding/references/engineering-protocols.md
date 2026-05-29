---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/engineering-grounding/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# Reference Material
## Responsibilities: Reference Detail
### Engineering Defect Severity Classification
Severity rubric inherits the Critical/Major/Minor/Advisory mapping in `.claude/skills/agent-reviewer/references/reviewer-lane-detail.md` `## Severity Mapping`.
Defect-record fields inherit `.claude/CLAUDE.md` `## 6. Judgment Philosophy` and `## 7. Reporting Philosophy`.
| Impact Class | Engineering Context | Examples |
|---|---|---|
| **Critical** | Safety margin violated, unit error, spec contradiction | Safety factor below minimum, unit mismatch in calculation, design exceeds rated limits, unguarded hardware errata |
| **Major** | Spec not referenced, important constraint missing | Assumption lacking datasheet citation, missing operating condition bound, thermal budget unverified, timing budget exceeded |
| **Minor** | Style/convention issue not affecting function | Unit notation style, significant figures convention, diagram labeling preference |
### Engineering Assumption Governance
Assumption Governance still follows the blocking-vs-disclosed gate in `.claude/CLAUDE.md` `## 6. Judgment Philosophy`. The `Critical/Major/Minor` labels below are an engineering-local sensitivity aid. The shared blocking rule remains controlling.
- **Critical**: hardware behavior claims, material properties at operating conditions, interface timing, safety-rated parameters — must anchor to specification citation; unresolved critical assumptions are blocking
- **Major**: environmental conditions, load profiles, duty cycles, component tolerances beyond datasheet — document with source; if unresolved and they materially affect core logic, deliverables, or verification, treat them as blocking
- **Minor**: modeling simplifications with bounded error, display precision, cosmetic parameters — proceeds only when explicitly disclosed and kept proportionate to their impact
### Thermal System Modeling
- Every thermal analysis must start with explicit energy balance equation:
  - Transient: Q_in - Q_out = ΔE_stored (= mc·dT/dt for lumped systems)
  - Steady-state: Q_in = Q_out (no storage term)
- Steady-state vs transient classification gate: must be explicitly stated before selecting solution method
- Units tracking mandate: every derivation step from ODE formulation through physical solution must carry units; dimensionless groups (Biot, Fourier, Nusselt) identified explicitly when applicable
- Physical plausibility bounds:
  - Temperature ≥ 0 K (absolute), pressure ≥ 0
  - Heat transfer coefficients: natural convection 5-25 W/m²K, forced convection 25-250 W/m²K (order-of-magnitude sanity check)
  - Flow rate sign convention must be stated
- Material property temperature dependence: state whether properties are evaluated at bulk, film, or surface temperature
### ODE-to-Engineering Bridge
- When mathematical ODE solutions map to physical systems:
  - Require dimensional analysis at ODE formulation stage (every term must have consistent units)
  - Carry physical meaning of each mathematical term through the solution process
  - Time constants, decay rates, natural frequencies must be identified and given physical names
- Solution interpretation requirements:
  - Map mathematical constants (C₁, C₂) to physical parameters via boundary/initial conditions
  - Verify solution behavior matches engineering intuition (exponential decay for cooling, bounded solutions for stable systems, oscillatory for underdamped)
  - Steady-state limit (t→∞) must be physically meaningful
- Parameter sensitivity: identify which physical parameters most strongly affect the solution behavior
### Execution-Model Awareness
- **Execution-Model Fidelity**:
  - Transformation layers between source code and actual execution can silently break correctness assumptions.
  - Transformation layers include compiler optimization, JIT compilation, runtime scheduling, ORM query generation, and CSS cascade resolution.
  - Designs identify which transformation layers are in the execution path and account for their constraints.
  - Unverified execution-fidelity assumptions are ungrounded and require explicit validation.
- Escalate to `software-architecture` when the primary concern shifts from execution-layer correctness to software architecture decisions, module boundary design, or system-level state modeling.
### Engineering Evidence Minimum
Before endorsing any engineering claim:
- Units verified at every derivation step
- Constraint source cited (datasheet, standard, or specification)
- Physical plausibility confirmed (order-of-magnitude sanity check)
- Operating conditions stated (temperature, pressure, frequency, load)
Claims failing any of the above remain blocked and open correction until corrected.

## Resolve Next Owner And Action
- Return verified units, constraints, plausibility checks, and operating conditions to the active engineering-grounding workflow.
- If an engineering claim changes architecture, mathematical correctness, safety, or acceptance basis, route that delta to the owning skill or lane before endorsement continues.
