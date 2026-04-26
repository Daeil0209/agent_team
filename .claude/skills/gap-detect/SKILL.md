---
name: gap-detect
description: Design-implementation gap detection methodology, YAGNI scope review, and iteration protocol for feature development quality verification.
user-invocable: false
---

## Structural Contract

- PRIMARY-OWNER: team-lead
- Fixed section order:
  1. `Activation Criteria`
  2. `YAGNI Scope Review`
  3. `Design-Implementation Gap Detection`
  4. `Iteration Protocol`
- Do not add new sections without explicit governance review.
- Keep section names stable when referenced by dev-workflow dispatch packets.
- Structural connectivity is immutable: new procedural content must remain attached to an owning section rather than appearing as free-floating doctrine.

# Gap Detection Skill

This skill provides the structured gap detection methodology, YAGNI scope-pruning exercise, and iteration protocol for the dev-workflow. It governs how reviewer and tester verify implementation against design, and how team-lead manages iterative fix cycles.

## Activation Criteria

This skill is loaded alongside `dev-workflow` when:
- Phase 1 (Plan) YAGNI scope review is required before CP2
- Phase 4 (Analysis) is active — reviewer and tester need gap detection methodology
- Phase 5 (Iteration) is active — team-lead needs iteration cycle protocol

Loading uses the canonical packet `REQUIRED-SKILLS` mechanism per `.claude/skills/task-execution/reference.md`; specialist skills do not carry parallel authorization fields.

---

## YAGNI Scope Review

**Phase**: Plan (Phase 1, before CP2)

**Purpose**: Prevent scope creep before design begins by forcing a deliberate scope-pruning exercise on the plan document.

**Procedure** (before finalizing the plan document, before CP2):

1. List all proposed features/components from the plan
2. For each item, ask: "Is this essential for the core problem, or is it nice-to-have?"
3. Classify:
   - **MUST** — blocks core value; required in current scope
   - **SHOULD** — improves but not essential
   - **COULD** — nice-to-have
   - **WON'T** — out of scope
4. Remove all COULD and WON'T items from the current plan scope
5. Record removed items as "Future Consideration" in the plan document

**Rule**: Do not advance to CP2 without completing this classification. Scope inflation in the plan doc will compound in every downstream phase.

---

## Design-Implementation Gap Detection

**Purpose**: Give reviewer and tester a structured method to verify implementation against design. This is an analytical tool, not an automatic pass/fail gate.

### Structural Check

Verify that all components defined in the design doc exist in the codebase.

For each component in the design doc:
1. Does the file or module exist?
2. Does the class, function, or namespace match the designed structure?
3. Are all sub-components present (not just the parent)?

**Defect signal**: Component defined in design has no corresponding implementation artifact.

### Functional Check

Verify that each component implements its designed behavior.

For each component:
1. Does the implementation cover the primary use case described in the design?
2. Are error paths and edge cases from the design present in code?
3. Does observable behavior match designed behavior (not just presence of code)?

**Defect signal**: Component exists structurally but does not perform its designed function.

### Contract Check

Verify that API contracts are consistent across design, server, and client.

For each interface or API point in the design:
1. Does the server implementation match the designed contract (inputs, outputs, error codes)?
2. Does the client consumption match the same contract?
3. Are data shapes, field names, and types consistent across the boundary?

**Defect signal**: Contract mismatch between design doc and either server or client implementation.

### Coverage Score Per File

Score each implementation file or component on a 0–100 scale:

| Score | Meaning |
|-------|---------|
| 0 | Not started / empty |
| 20 | Skeleton only — stubs, no logic |
| 40 | Basic structure — partial logic, key paths incomplete |
| 60 | Real logic present — key paths work, some requirements missing |
| 80 | Most requirements implemented — minor gaps only |
| 100 | Fully implements designed behavior |

**Usage rule**: Coverage scores are signals for team-lead judgment. They are not automatic thresholds. team-lead reads the score distribution alongside blocking defect counts to decide whether iteration is warranted. A single blocking defect at score 90 still blocks advancement; full coverage at score 100 still requires reviewer and tester sign-off on the acceptance chain.

### Gap Classification

reviewer classifies each gap found:

| Class | Definition | Iteration required |
|-------|------------|-------------------|
| **Blocking** | Missing component, broken contract, or failure to implement primary use case | Yes, unless user accepts at CP5 |
| **Non-blocking** | Minor behavioral gap, cosmetic mismatch, low-risk deviation | No, but record in report |
| **Deferred** | Design decision intentionally not implemented in this iteration | No, but document in report under follow-up |

---

**Severity escalation rule**: When a gap is classified as Blocking at T0 or T1 severity (per `.claude/skills/incident-response/SKILL.md`), escalate immediately to the incident-response workflow for dedicated incident handling. T0/T1 gaps must not be treated as normal iteration candidates — they require the incident-response classification, impact analysis, and fix proposal process before iteration resumes.

## Iteration Protocol

`dev-workflow` Phase 5 owns iteration cycle structure, cycle counter, and cycle limits (see `.claude/skills/dev-workflow/SKILL.md` Phase 5 and `.claude/skills/dev-workflow/reference.md`). gap-detect contributes only the gap re-classification step within each cycle and the gap-state input to any cycle-limit escalation; it does not author parallel cycle policy or parallel message vocabulary.

**Per-cycle gap-detect contribution** (after developer fix, before tester re-verify):
1. reviewer re-runs the structural / functional / contract checks from `Design-Implementation Gap Detection` scoped to the affected components only.
2. reviewer re-applies the Gap Classification table from the previous section to remaining or newly-introduced gaps.
3. Coverage score and blocking-gap count after re-check feed back into `dev-workflow` Phase 5's continue-or-escalate decision; gap-detect does not own that decision.

**Iteration-exhaustion escalation input**: when `dev-workflow` Phase 5's cycle limit fires, gap-detect supplies the gap state (remaining blocking gaps with classification, coverage score distribution, optional follow-up classifications). The outbound message uses the canonical `MESSAGE-CLASS: hold|blocker` form per `.claude/skills/task-execution/reference.md`; do not author a parallel message-class format here.

**No self-certification on the gap-classification surface**: a re-classified gap state is not closed by the agent that produced it. reviewer's re-classification feeds tester re-verify and team-lead Phase 5 assessment per the iteration order owned by `dev-workflow` Phase 5.
