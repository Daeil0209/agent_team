---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/mathematical-correctness/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# Reference Material
## Responsibilities: Reference Protocols
### Analytical Solution Verification Protocol
Non-ODE analytical families (Laplace transforms, Fourier series, PDE separation of variables, eigenvalue problems) verify with the same-rigor checklist: step justification per `## Derivation Rigor Standards`; block claims on unverified existence/uniqueness and open correction; back-substitution validation per family.
#### ODE Exactness Verification
**Exactness test checklist:**
1. Identify M(x,y) and N(x,y) from the form M dx + N dy = 0
2. Compute ∂M/∂y and ∂N/∂x
3. Verify equality: ∂M/∂y = ∂N/∂x → exact; proceed to step 4
4. If exact: integrate M w.r.t. x to get F(x,y) = ∫M dx + h(y)
5. Determine h(y) by comparing ∂F/∂y with N
6. Write implicit solution F(x,y) = C
**Integrating factor decision tree:**
- When not exact → compute (∂M/∂y − ∂N/∂x)/N
  - If function of x only → μ(x) = exp(∫[(∂M/∂y − ∂N/∂x)/N] dx)
- If above fails → compute (∂N/∂x − ∂M/∂y)/M
  - If function of y only → μ(y) = exp(∫[(∂N/∂x − ∂M/∂y)/M] dy)
- If both fail → check special forms μ(xy), or escalate as non-standard
**Solution validation:**
- Back-substitute solution into original ODE to verify
- Check initial/boundary conditions are satisfied
- Verify no singular solutions lost during derivation (division by zero terms, squared expressions)
- Confirm solution domain matches problem domain
### Derivation Rigor Standards
- Every derivation step must be justified: algebraic manipulation, substitution, integration, or theorem application
- Irreversible operations (division by expression, squaring, log transformation) must:
  - State restrictions explicitly at point of application
  - Check for solutions lost during the operation
  - Document excluded cases (e.g., "assuming g(y) ≠ 0")
- Existence/uniqueness conditions (Picard-Lindelöf theorem, Lipschitz continuity) must precede solution construction when applicable
- Parameter restrictions must be stated at introduction, not discovered mid-derivation
- General solution must include arbitrary constant(s) with physical/mathematical interpretation
- Particular solutions require explicit statement of which initial/boundary condition determines the constant
### Mathematical Defect Severity Classification
Severity rubric inherits the Critical/Major/Minor/Advisory mapping in `.claude/skills/agent-reviewer/references/reviewer-lane-detail.md` `## Severity Mapping`.
Defect-record fields inherit `.claude/CLAUDE.md` `## 6. Judgment Philosophy` and `## 7. Reporting Philosophy`.
| Impact Class | Mathematical Context | Examples |
|---|---|---|
| **Critical** | Result correctness destroyed, derivation logic broken | Sign error changing physical meaning, wrong integration limits, division by zero unguarded, existence theorem violated |
| **Major** | Result weakened but not destroyed, important constraint missing | Domain restriction omitted, boundary condition incomplete, convergence not verified, singular solution lost |
| **Minor** | Presentation/notation issue with correctness preserved | Notation inconsistency, conventional symbol choice, formatting of equation |
### Mathematical Assumption Governance
Assumption Governance still follows the blocking-vs-disclosed gate in `.claude/CLAUDE.md` `## 6. Judgment Philosophy`. The `Critical/Major/Minor` labels below are a mathematical local sensitivity aid. The shared blocking rule remains controlling.
- **Critical**: initial/boundary conditions, existence/uniqueness conditions (Picard-Lindelöf), domain of validity, convergence conditions for series/integrals — must verify before proceeding; unverified critical assumptions are blocking and propagate through all dependent derivations
- **Major**: smoothness/continuity requirements, parameter ranges, independence conditions, linearity approximations — document with source; if unresolved and materially relevant to correctness or verification, treat them as blocking
- **Minor**: notation conventions, variable naming, coordinate system choice — proceeds after explicit disclosure and proportionate impact control

## Resolve Next Owner And Action
- Return checked derivation steps, assumption class, defect class, and retest conditions to the active mathematical-correctness workflow.
- If a mathematical finding affects engineering grounding, implementation logic, or acceptance, route the named finding to that owner before dependent work continues.
