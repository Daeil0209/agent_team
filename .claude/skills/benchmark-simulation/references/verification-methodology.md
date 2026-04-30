---
PRIMARY-OWNER: developer
LOAD-POLICY: on-demand reference only
---

# benchmark-simulation: Verification-Methodology Benchmark Extension
The abstraction-fit-adapt cycle applies recursively to verification methodology: how the team verifies, not just what the team designs. When the verification approach materially affects acceptance quality, benchmark verification patterns the same way.

## When Verification Benchmarking Is Mandatory
- selecting test framework / proof tooling for a new deliverable type
- selecting coverage strategy (unit-only / integration / E2E / visual regression / contract / property-based)
- defining correction criteria when iteration is expected
- selecting acceptance gates
- when prior session has not already frozen the verification basis from external evidence

## Required Search Targets
- authoritative testing references: Google Testing Blog, MS Engineering Excellence, Martin Fowler, Kent Beck publications, ThoughtWorks Technology Radar
- framework-official testing guides: Playwright Best Practices, Cypress Best Practices, Vitest Guide, pytest documentation, Testing Library principles
- domain-specific testing: regulatory testing standards, academic research on test effectiveness
- case studies of verification failures

## Synthesis Output For Verification Methodology
- frame: which verification approach for which acceptance class
- coverage matrix: scenario x interaction x state combination grid
- assertion patterns: contract behavior over implementation detail
- maintenance load: how the verification approach ages
- recovery: when a test fails, whether it tells the developer where the defect is

## Composition With Execution Lanes
- benchmark-simulation -> tester -> validator
- `dev-workflow` gap-iteration (`.claude/skills/dev-workflow/references/gap-iteration.md`) operates on result-level test outcome vs expected acceptance
- if the verification approach is itself a learning surface, schedule a retrospective benchmark cycle after first use to refine
