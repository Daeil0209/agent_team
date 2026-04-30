---
PRIMARY-OWNER: reviewer
LOAD-POLICY: on-demand reference only
---

# Code Quality — Reference Material
Reference checklists, tables, and catalogs for `code-quality-review`.
Read this file explicitly when needed; it is not auto-injected on Skill load.
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
| Urgent (RFP-1) | Files >300 lines, nesting >5 levels, same logic in 4+ places | Refactor before next feature; block merge |
| High (RFP-2) | Files >200 lines, nesting >4 levels, same logic in 3 places | Refactor in current sprint |
| Medium (RFP-3) | Complex conditionals, unclear naming, missing type annotations | Schedule refactoring; record as technical debt |
| Low | Style inconsistencies, minor naming issues | Record for future cleanup |
Apply this matrix during review. RFP-1 and RFP-2 triggers require explicit owner assignment and resolution path before merge approval.
> **Note:** RFP labels are code-quality-review-local refactoring priorities. They do not map to the T0-T3 severity framework used by `.claude/skills/security-review/references/security-review-detail.md`.
