---
PRIMARY-OWNER: developer
LOAD-POLICY: on-demand reference only
---

# benchmark-simulation: Cited External Reference Evidence
The following reference families were captured via external benchmark and ground the `SKILL.md` doctrine assertions. Per `Reference-Class Discrimination`, each is classified principle-class or standard-class. Where direct fetch was blocked, downgrade flag is recorded. This file is a preserved evidence cache, not an always-loaded procedure spine.

## NN/g UX Research Methodology
- Class: principle-class, high confidence
- Sources: nngroup.com - "When to Use Which UX Research Methods" (Rohrer), "Contextual Inquiry", "10 Usability Heuristics", "UX Research Cheat Sheet", "The Trustworthiness of UX Evidence"
- Abstracted principle: research methodology is structured along three axes: attitudinal vs behavioral (what people say vs do), qualitative vs quantitative (why/how vs how-many), and context (natural / scripted / limited / no-product). Methods sit at axis intersections, and the same method shifts purpose by Discover/Explore/Test/Listen phase. NN/g's heuristics framework was empirically derived from factor analysis of 249 observed usability problems; frameworks themselves can be evidence-derived rather than merely asserted.
- Anti-pattern: sample size alone is a poor indicator of validity. Research diversity across user types, geographies, methodologies, and longitudinal span is the credibility multiplier. Apply to this doctrine: five sources from the same source family do not count as five independent corroborations; cross-family diversity is the actual multiplier.
- Reject log: NN/g's "Listen phase" (continuous post-launch monitoring via analytics and search logs) does not fit benchmark-simulation's design-time / verification-design-time invocation surface. Keep it as a future cross-reference for `dev-workflow` gap-iteration (`.claude/skills/dev-workflow/references/gap-iteration.md`) only.

## Major Design Systems Comparison
- Class: mixed-class, mixed confidence
- Sources: Material Design 3 (`m3.material.io`), IBM Carbon (`carbondesignsystem.com`), Apple HIG (`developer.apple.com/design/human-interface-guidelines`), Polaris (`polaris-react.shopify.com/foundations/experience-values`), W3C WCAG 2.2 (`w3.org/WAI/WCAG22`)
- Downgrade flag: Apple HIG accessibility/inclusion pages, Material Design 3 accessibility pages, and Carbon main pages returned page-title-only or truncated through fetch in the captured benchmark. Specific claims about those sources are drawn from cross-source corroboration and therefore carry medium confidence, not high. Polaris experience-values page succeeded with full content; Polaris claims are direct-source.
- Abstracted principle: major design systems converge on a documentation pattern: they state principles (for example Carbon clarity/efficiency/consistency/beauty, Apple HIG clarity/deference/depth, Polaris experience values) as identity declarations without per-principle empirical citation, but ground standards such as contrast thresholds heavily and explicitly to W3C/ISO. That asymmetry matters: principles function as identity and methodology input; standards function as compliance contracts.
- Anti-pattern: research-grounding without accessible research artifacts is a documentation defect. Carbon-like "rigorous research" claims without exposed methodology, sample, or findings and Polaris-like experience-value pages without external citation must not be promoted to research evidence. Apply to this doctrine: tighten provenance with research-artifact-accessibility checks.
- Reject log: direct adoption of any specific principle list is rejected. This skill operates at the meta-methodology layer, not as a principle-instance importer.

## ISO/IEC 25010 Software Quality Model
- Class: standard-class, high confidence
- Sources: `iso.org/standard/35733.html` (2011), `iso.org/standard/78176.html` (2023), `blog.codacy.com/iso-25010-software-quality-model`, `quality.arc42.org/standards/iso-25010`
- Abstracted principle: software quality structurally splits into two models: Product Quality (artifact-intrinsic characteristics such as functional suitability, performance efficiency, compatibility, usability, reliability, security, maintainability, portability) and Quality in Use (interaction outcome characteristics such as effectiveness, efficiency, satisfaction, freedom from risk, context coverage). Quamoco operationalization maps QualityAspect -> ProductFactor -> Measure -> Instrument, which mirrors abstraction-fit-adapt applied to verification.
- Apply to this doctrine: this is external grounding for `[USER-SURFACE]`. Source-only verification addresses Product Quality, but not Quality in Use, so it is structurally insufficient when deliverable value depends on interaction outcome.
- Anti-pattern: "Freedom from Risk" was added explicitly in 25010 because product-quality-only frameworks miss real-world failure modes. Treat risk-not-checked as a quality defect, not a style gap.
- Reject log: direct adoption of the full ISO subcharacteristic taxonomy is too formal for this governance register. Keep it as downstream consultation reference only.

## ThoughtWorks Technology Radar
- Class: principle-class, high confidence
- Sources: `thoughtworks.com/en-us/radar/faq`, `thoughtworks.com/en-us/radar`, `thoughtworks.com/insights/blog/build-your-own-technology-radar`
- Abstracted principle: evidence-driven technology adoption operates through four explicit rings: Adopt / Trial / Assess / Hold. Trial requires production experience; reassessment is time-boxed; unchanged items fade to keep attention on meaningful confidence shifts. Hold is an active recommendation against new use, not passive ignore.
- Apply to this doctrine: this grounds `Pattern Lifecycle Staging` in `SKILL.md`. Adopt the ring discipline, active rejection, and periodic prune-and-promote review.
- Anti-pattern: catalogs that grow monotonically without periodic prune-and-promote review degrade into noise rather than evidence.
- Reject log: ThoughtWorks quadrant structure and committee process are domain-specific to enterprise technology selection. The team evolves doctrine through team-lead, lane interaction, and governance review rather than a periodic in-person committee.

## Martin Fowler Testing Methodology
- Class: principle-class, high confidence
- Sources: `martinfowler.com/testing`, `martinfowler.com/articles/practical-test-pyramid.html`, `martinfowler.com/bliki/TestDrivenDevelopment.html`, `martinfowler.com/books/refactoring.html`
- Abstracted principle: verification methodology choice operates on three explicit tradeoff axes: test scope (broad-stack / component / unit, business-facing / story / contract), test doubles taxonomy (stub / mock / fake / dummy), and verification style (state-based vs behavior-based). Self-testing code is an enabling investment, not a quality tax. Subcutaneous testing names a fidelity-vs-brittleness middle ground. Contract tests are a "verify the verification" recursive discipline.
- Apply to this doctrine: add verification-style discrimination to verification-methodology benchmarking. Choosing on only one axis under-specifies the method. Subcutaneous testing is a structured exception between full-surface fidelity and source-only detachment. Contract testing justifies recursive benchmark-simulation against verification itself.
- Anti-pattern: conflating test doubles produces false-confidence verification. Same-word-different-meaning across sources requires source-specific definition in the provenance ledger.
- Reject log: Page Object Pattern and xUnit-family runner mechanics are domain-instance details outside this doctrine.

## Google SMURF + Beck TDD
- Class: principle-class + standard-class hybrid, high confidence
- Sources: `testing.googleblog.com/2024/10/smurf-beyond-test-pyramid.html`, `abseil.io/resources/swe-book/html/ch11.html`, `abseil.io/resources/swe-book/html/ch14.html`, `testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html`, TDD references
- Abstracted principle: Google's testing methodology evolved from the test pyramid to SMURF, adding Speed / Maintainability / Utilization / Reliability / Fidelity axes. Test size (resource requirement) and test scope (code paths exercised) are independent dimensions. Hermetic tests reduce flakiness; SUT frameworks trade hermeticity against production fidelity. Beck TDD adds red-green-refactor as evidence acquisition: red proves the test detects absence, green proves implementation satisfies spec, refactor changes design without changing satisfied spec.
- Apply to this doctrine: this is the highest-yield reference family for Verification-Methodology Benchmark Extension. Adopt SMURF as the primary verification tradeoff frame, adopt size-vs-scope distinction, adopt hermeticity-vs-fidelity as explicit `[USER-SURFACE]` plus reliability balance, and treat verification claims without demonstrated failure mode as `INFERENCE/UNVERIFIED`.
- Anti-pattern: E2E-heavy suites raise runtime, flakiness, and debugging difficulty proportional to scope. Flaky failures erode trust in passing tests. Doctrine that requires the most faithful surface for every check can create a cost burden that causes verification to be skipped; skipped verification is worse than narrowed-scope verification. `[USER-SURFACE]` needs SMURF-Reliability balance.
- Reject log: Google's specific 80/15/5 ratio and infrastructure timeout values are context-specific, not universal doctrine. Beck's xUnit mechanics are framework-instance details.

## Cross-Reference Synthesis
The reference families converge on three meta-strengthenings integrated into `SKILL.md`:
- **META-1 Reference-Class Discrimination**: design-system sources separate principle-class identity declarations from standard-class compliance contracts.
- **META-2 Pattern Lifecycle Staging**: ThoughtWorks Radar supplies Adopt/Trial/Assess/Hold, active Hold, and periodic prune-and-promote.
- **META-3 Axis-Coverage Discipline**: NN/g axes, Google SMURF, Fowler testing axes, and ISO 25010 show methodology choice is structurally multi-axis rather than one-dimensional.

## Open Surfaces
- ISO 25010 Quality-in-Use vs Product-Quality can deepen `[USER-SURFACE]` cited grounding.
- Fowler test-double taxonomy can add vocabulary-precision rules to the text-document modality glossary.
- Google SMURF size-vs-scope and hermeticity-vs-fidelity can deepen verification-methodology synthesis.
- NN/g diversity-not-N can strengthen multi-source corroboration with same-source-family discounting.
- ThoughtWorks cadence can inspire "every Nth benchmark-simulation invocation triggers stale-pattern review"; N is a doctrine-design decision, not evidence-driven.
