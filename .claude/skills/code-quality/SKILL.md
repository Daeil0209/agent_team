---
name: code-quality
description: Code quality deep review with SOLID checklist, duplication taxonomy, and refactoring priority matrix.
user-invocable: false
---

## Structural Contract

- Fixed owner pattern:
  1. `Identity`
  2. `Activation Criteria`
  3. specialist operating sections: `SOLID Principles Checklist`, `Duplication Taxonomy`, `Reusability Assessment`, `Extensibility Patterns`, `Refactoring Priority Matrix`
  4. owner-local structural feedback / self-growth / regression-guard blocks when present
- PRIMARY-OWNER: reviewer
- SECONDARY-CONSUMER: developer
- Do not add new peer top-level sections without explicit governance review.
- Keep downstream owner-map restatements local so the skill remains safe to read in isolation.
- Strengthen an existing operating block before adding a new sibling doctrine block.

## Identity

You are the code-quality lane for Claude Code.

- You own deep code quality review covering SOLID principles, duplication classification, reusability scoring, extensibility pattern evaluation, and refactoring prioritization.
- In the current target design, this is a reviewer-exclusive specialist skill. When self-growth hardens or expands this skill, the `reviewer` lane owns the skill-up execution while `team-lead` governs approval.
- Domain scope: implementation-level quality assessment, SOLID principle compliance review, duplication classification, reusability scoring, extensibility pattern evaluation, and refactoring triage for enterprise-scale code surfaces.
- Source: content originated in `skills/enterprise-arch/SKILL.md` and was re-homed here under structural normalization to separate architecture-level and code-quality-level review surfaces.

## Activation Criteria

Load this skill when all of the following are true:

- The active task is code review or implementation quality assessment
- The review surface includes class or function design, duplication, SOLID compliance, or structural quality

**Note for developer lane:** this skill may also be loaded by `developer` for self-review before handoff.

`team-lead` may also direct loading via SKILL-AUTH.

---

# Code Quality Deep Review

## 1. SOLID Principles Checklist

Concrete, actionable per-principle checks before accepting implementation work:

- **SRP (Single Responsibility):** Does the class/function change for only one reason? Does the name contain "and"? If yes → separation required.
- **OCP (Open/Closed):** Can behavior be extended without modifying existing code? Are there hardcoded if/else chains for type dispatch? If yes → refactor to extension point.
- **LSP (Liskov Substitution):** Can subtypes replace parent types without breaking behavior? Do overrides change preconditions or postconditions? If yes → inheritance is misused.
- **ISP (Interface Segregation):** Are clients forced to depend on methods they don't use? Are interfaces bloated with unrelated concerns? If yes → split the interface.
- **DIP (Dependency Inversion):** Do high-level modules depend on low-level implementations directly? Are abstractions used at layer boundaries? If no → introduce interface at the boundary.

## 2. Duplication Taxonomy

Three duplication types require different remediation strategies:

| Type | Description | Remediation |
|---|---|---|
| Exact duplicate | Identical code blocks in two or more places | Extract to a shared function |
| Structural similarity | Same logic, different variable names or literals | Parameterize into a reusable function |
| Conceptual similarity | Same purpose, different implementation | Unify the interface or extract a strategy |

Detection: grep for repeated patterns, compare function signatures, check for copy-paste indicators (same comment blocks, parallel variable names, mirrored structure).

## 3. Reusability Assessment

Score each module or function on 5 questions (1 point each):

- Is it domain-independent? (reusable across features without modification)
- Is it free of external state dependencies?
- Does it accept generic parameters rather than specific types?
- Is the return value predictable given the same inputs?
- Is it free of side effects?

**Score interpretation:** 5/5 = highly reusable; 3–4 = moderately reusable; 0–2 = tightly coupled, refactoring required before reuse.

## 4. Extensibility Anti-Patterns vs Good Patterns

| Anti-Pattern | Good Pattern |
|---|---|
| if/else chains for type dispatch | Registry pattern (map of type → handler function) |
| Hardcoded configuration lists | Config-driven with external source |
| Switch on enum with inline logic | Plugin or strategy interface |

When an anti-pattern is detected, return a `HOLD` with the pattern name and the recommended replacement before accepting the work.

## 5. Refactoring Priority Matrix

| Priority | Trigger Threshold | Action |
|---|---|---|
| Urgent (T1) | Files >300 lines, nesting >5 levels, same logic in 4+ places | Refactor before next feature; block merge |
| High (T2) | Files >200 lines, nesting >4 levels, same logic in 3 places | Refactor in current sprint |
| Medium (T3) | Complex conditionals, unclear naming, missing type annotations | Schedule refactoring; record as technical debt |
| Low | Style inconsistencies, minor naming issues | Record for future cleanup |

Apply this matrix during review. T1 and T2 triggers require explicit owner assignment and resolution path before merge approval.
