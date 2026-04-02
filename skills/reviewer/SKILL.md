---
name: reviewer
description: Acceptance-critical review procedure.
user-invocable: false
---

# Reviewer Skill

## Preconditions
- Use only after team-lead assigns a review surface.
- If review prerequisites or producer handoff missing, return HOLD.

## Review Workflow

### 1. Establish The Review Surface
- Identify: deliverable, acceptance criteria, request-fit packet, governing rules.

### 2. Verify Producer Pre-Handoff Hygiene
- Check: syntax valid, imports resolve, no dead references, logic consistent.
- Missing hygiene is a blocking finding on the producer.

### 3. Inspect The Deliverable Directly
- Read actual output, not just the producer summary.

### 4. Run The Evidence Challenge
- Verify factual claims against inspectable evidence.
- Check conclusions follow from premises. Look for unstated assumptions.

### 5. Apply Domain Lenses (relevant ones only)

**A: Evidence Quality** - Claims grounded? Sources cited? Contradictions surfaced?
**B: Logical Rigor** - Conclusions follow? Edge cases? Assumptions marked?
**C: Software Quality** - Clean code? Tests adequate? Error handling? Dependencies safe?
**C+: Security** - Trust boundaries? Secrets protected? Input validated?
**C++: Realizability** - Can this actually run/deploy/operate as designed?
**D: Human-Facing** - Readable? Decision-first? Rendered correctly?
**E: Operational** - Workflow correct? State transitions valid? Recovery paths?
**F: Failure/Risk** - Failure modes identified? Rollback possible? Blast radius bounded?
**G: UX** - User path intuitive? Error messages helpful? Exit paths clean?
**H: Business Logic** - Rules correct? Edge cases? Compliance met?
**I: Report/Document Quality** - Metadata present? (date, author, scope) Conclusion substantive? References detailed? (law names, standard numbers) Summary accessible in 30s? Actionable elements? (checklists, steps) Density appropriate? (tables over redundant prose) Scope/limits stated? Bidirectional criteria present?

### 6. Classify Findings

| Severity | Meaning |
|---|---|
| Critical | Must fix before any further progress |
| Major | Must fix before this stage passes |
| Minor | Should fix, does not block |
| Advisory | Observation only |

Each finding: severity, evidence, impact, owner, fix direction.

For report/document reviews, also check for **information dilution**: content that is correct but adds reading time without improving decision quality. Excessive detail in areas the reader already understands, redundant explanations across sections, and prose that could be a table row are Minor findings of type `density-defect`.

### 7. Define Retest Requirements
- For blocking findings: what must change and how to verify.
- State: reviewer reread, tester rerun, or both needed.

### 8. Build The Review Handoff
- Top blocking defect first. All findings with severity and evidence.
- Retest gates. If no issues: clean statement + residual risks.

## Active Communication Protocol

- After handoff content is prepared, actively deliver it via `SendMessage` to the governing lane. Passive output availability alone is not sufficient.
- When approaching turn-budget exhaustion (last ~5 turns), proactively report via `SendMessage`: current progress, preserved state, incomplete surfaces, and what a successor worker would need to continue. Do not exhaust turns silently.
