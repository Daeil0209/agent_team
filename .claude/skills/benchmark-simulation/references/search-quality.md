---
PRIMARY-OWNER: developer
LOAD-POLICY: on-demand reference only
---

# benchmark-simulation: Search Strategy And Source Quality Ladder
## Search Query Design
- specific patterns over generic terms: search "data table column pinning UX" not "table design"
- comparative terms: "X vs Y", "alternatives to X", "X best practices", "X common mistakes"
- industry filter when relevant: "healthcare dashboard regulatory alert", "financial compliance UI"
- anti-pattern search: "common mistakes in X", "X failure case studies", "why X went wrong"
- recent year filter when freshness matters; verify recency claims

## Source Quality Ladder
1. **Authoritative standards / design systems**: W3C, WCAG, Material Design, HIG, Carbon, Polaris, shadcn/ui, Nielsen Norman Group
2. **Established practitioner publications**: A List Apart, CSS-Tricks, web.dev, MDN Web Docs, framework-official guides
3. **Domain-specific authoritative**: regulatory body publications, academic UX journals, industry consortium standards
4. **Reputable case studies**: well-known design agencies' published work and enterprise product blog posts
5. **Practitioner blogs / Medium / dev.to**: useful but lower confidence; require corroboration from higher tier
6. **Forum / Reddit / Stack Overflow**: pattern discovery only; never primary evidence
7. **Anonymous / undated content**: discovery only; not admissible as evidence

## Multi-Source Corroboration
- high confidence: 3+ authoritative sources agree
- medium confidence: 1-2 authoritative sources OR 3+ practitioner sources
- low confidence: single source from any tier OR multiple low-tier sources
- speculation: model prior knowledge with no external corroboration; label `INFERENCE`, not `evidence`

## Negative-Search Discipline
Anti-pattern search is as valuable as positive-pattern search. A benchmark cycle that found five positive patterns but zero anti-patterns is incomplete. Required: at least one anti-pattern search per benchmark cycle on visual / structural decisions.

## Search Depth Bound
Continue searching until: (a) pattern set saturates, (b) destination-fit decision is grounded enough to defend, (c) anti-pattern catalog has at least one entry. Do not search endlessly; over-searching is also a defect when cost exceeds value.
