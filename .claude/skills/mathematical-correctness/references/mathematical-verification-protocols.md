---
PRIMARY-OWNER: developer
LOAD-POLICY: on-demand reference only
---

# Reference Material
## Responsibilities: Reference Protocols
### Analytical Solution Verification Protocol
Note: The exactness test and integrating factor decision tree below are exemplars for ODEs; apply the same rigor (step justification, HOLD on unverified existence/uniqueness, back-substitution validation) to other analytical solution families (Laplace transforms, Fourier series, PDE separation of variables, eigenvalue problems).
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
Defect handling still uses the shared blocking, acceptance, and reporting contract from `CLAUDE.md`, especially `### Role And Acceptance Law` and `### Communication And Reporting Law`. The table below is a mathematical local impact classification used to describe defect character and escalation examples; it does not replace the shared governance contract.
| Impact Class | Mathematical Context | Examples |
|---|---|---|
| **Critical** | Result correctness destroyed, derivation logic broken | Sign error changing physical meaning, wrong integration limits, division by zero unguarded, existence theorem violated |
| **Major** | Result weakened but not destroyed, important constraint missing | Domain restriction omitted, boundary condition incomplete, convergence not verified, singular solution lost |
| **Minor** | Presentation/notation issue not affecting correctness | Notation inconsistency, conventional symbol choice, formatting of equation |
Defect records must also satisfy the shared classification contract: defect type, owner, missed-catch responsibility, severity, corrective action, retest conditions, and recurrence trigger.
### Mathematical Assumption Governance
Assumption Governance still follows the blocking-vs-disclosed gate in `CLAUDE.md` `### Role And Acceptance Law`. The `Critical/Major/Minor` labels below are a mathematical local sensitivity aid; they do not replace the shared blocking rule.
- **Critical**: initial/boundary conditions, existence/uniqueness conditions (Picard-Lindelöf), domain of validity, convergence conditions for series/integrals — must verify before proceeding; unverified critical assumptions are blocking and propagate through all dependent derivations
- **Major**: smoothness/continuity requirements, parameter ranges, independence conditions, linearity approximations — document with source; if unresolved and materially relevant to correctness or verification, treat them as blocking
- **Minor**: notation conventions, variable naming, coordinate system choice — may proceed only when explicitly disclosed and kept proportionate to their impact
