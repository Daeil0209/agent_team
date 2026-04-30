# dev-workflow: Phase Surfaces
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

## Phase 0 Discovery Basis
- Discovery shape must be explicit: `single`, `lead-skim-then-shards`, or `immediate-shards`
- `lead-skim-then-shards` exists only to reach boundary sufficiency; once shard boundaries are explicit, dispatch interpretive shards immediately
- Discovery output must separate: what the reference is, what the user wants from it, and what is adopted/adapted/rejected before planning begins
- Discovery does not authorize implementation dispatch or design freeze

## Phase 1 Canonical Plan Surface
- Canonical output path: `docs/01-plan/features/{feature}.plan.md` unless project config states otherwise
- The canonical plan surface, not internal reasoning, closes Phase 1
- Minimum canonical contents:
  - verbatim `USER-INSTRUCTION`
  - executive summary
  - WHY / WHO / RISK / SUCCESS / SCOPE / DELIVERY
  - Reference Fit Summary when a reference exists
  - Acceptance Evidence Basis
  - Verification Strategy Basis
  - explicit Open Questions
- team-lead may materialize already-frozen bridge sections into the canonical plan path before developer authors the remaining plan body

## Phase 2 Design Surface
- Canonical output path: `docs/02-design/features/{feature}.design.md` unless project config states otherwise
- Design options count scales by project tier: Lightweight 1, Standard 2, Precision 3
- Minimum design contents:
  - inherited `USER-INSTRUCTION`
  - selected option and rationale
  - component and responsibility map
  - API/data flow/dependency surface
  - Verification Plan derived from the plan's proof basis
- For executable, user-facing software deliverables, design must preserve delivery path, shutdown path, infrastructure exposure policy, and the control inventory needed for tester browser-proof first-pass proof and validator browser-proof final acceptance

## Phase 3 Implementation Surface
- Implementation may not start before CP4 is resolved
- CP4 scope summary must make lane decomposition explicit: serial prerequisites, parallel-eligible modules, module-to-agent map, merge ownership
- If decomposition shows independent implementation surfaces, serializing them onto one developer is a bottleneck defect
- Developer handoff must include changed surfaces, executed checks, and row-mapped Verification Plan coverage/delta so downstream proof does not re-derive stale acceptance

## Phase 4 Analysis And Acceptance
- Reviewer and tester are both mandatory analysis owners for executable, user-facing software
- Reviewer packet must evaluate design conformance, blocking defect classification, delivery experience, and user-readiness on the declared acceptance surface
- Tester packet must execute the planned proof surface, not a narrowed substitute
- For web/UI deliverables:
  - tester proof path = frozen browser-proof path on the browser interaction surface; Playwright CLI is the preferred fast profile when available or explicitly frozen
  - validator final acceptance path = browser-proof confirmation on the same resolved interaction/control inventory; Playwright MCP is the preferred precise profile when available or explicitly frozen
- Reviewer + tester no-gap is necessary but not sufficient when validator-governed acceptance is required

## Phase 5 Iteration Limits
- Iteration order is fixed: developer fix -> reviewer quick-check -> tester re-verify
- No self-certification inside iteration
- Maximum 5 iteration cycles per Phase 5 entry
- Maximum 2 Phase 4 re-entries per resolution cycle; recurring same gap class beyond that forces explicit `HOLD`/replan or Incident Response
- Iteration resets only after genuine re-analysis, not by habit
