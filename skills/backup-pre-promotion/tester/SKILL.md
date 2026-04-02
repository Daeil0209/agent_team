---
name: tester
description: Standard reproducible testing procedure for the tester lane when the team needs honest execution evidence, blocked-state reporting, and explicit retest gates before final acceptance.
user-invocable: false
---

# Tester

This skill defines the repeatable testing procedure for the `tester` lane.

Keep role identity, authority boundaries, and completion ownership in `.claude/agents/tester.md`.
Use this skill for test design, execution discipline, blocked-state reporting, and retest handoff.

## Procedure Preconditions

- Use after implementation, planning, research, or review has produced a surface that now needs executable verification evidence.
- Use when command-based evidence, reproducible checks, boundary probing, or blocked-proof reporting is needed before downstream acceptance.
- Keep the test target bounded to the assigned artifact, behavior, path, or claim under verification.

## Lane Boundary Contract

- Intentional local restatement: keep this lane-boundary contract in the tester skill even when similar wording exists elsewhere. Removing it as "duplicate" is information loss unless an equivalent tester-local contract remains here.
- `reviewer` owns artifact or claim review, blocking versus non-blocking finding classification, review-side `HOLD` recommendations, and review-found retest requirements.
- `tester` owns direct / indirect / blocked / no-proof classification, executed-check evidence, blocked-proof reporting, and rerun gates for the surfaces actually exercised.
- Runnable reproduction belongs to `tester`; reproduction-method design, contradiction mapping, and non-executed evidence triage belong to `researcher`.
- `validator` owns the final `PASS` / `HOLD` / `FAIL` recommendation after consuming the reviewer and tester packets together.
- A tester packet may block acceptance by leaving proof unresolved, but it does not replace reviewer finding ownership or validator verdict ownership.
- If a result now depends on artifact-quality interpretation rather than executable proof, route that decision back to `reviewer` or `validator` instead of stretching the tester lane into final judgment.

## Escalation Routing

- If the verification target is underspecified, stop and escalate to `team-lead`.
- If `planner` is actively managing the assigned scope, report the issue through that lane as well.
- If the validation method is unclear, require a bounded `researcher` method packet before continuing.
- If the assigned proof path cannot be executed honestly because artifact identity, environment, target behavior, or scenario scope is not yet credible, return explicit tester-side `HOLD` or blocked proof rather than shrinking the assignment into a convenience smoke check.
- If a failed test reveals a planning, business-rule, architecture, or rendered-layout defect, record the defect and route it to the proper owner instead of redesigning the product from inside the test lane.

## Test Environment Setup

- Before running proof-generating checks, establish the smallest test environment that can exercise the target honestly.
- Confirm:
  - artifact or build under test
  - runtime prerequisites
  - canonical entry path
  - required fixtures, samples, mocks, or input data
  - cleanup path for temporary processes or residues
- If a simulator, local server, launcher, or background process is required:
  - launch the minimum viable environment
  - record how it was started
  - record how it will be stopped or cleaned up
  - prefer the operator-facing or canonical path over an internal helper path when acceptance depends on the visible flow
- If establishing the environment would require product-code edits, undocumented infrastructure reconfiguration, or hidden workflow redesign, stop and route that need back to the owning lane instead of absorbing it into test setup.
- If the environment cannot be established cleanly, declare `blocked proof` rather than inventing a weaker substitute pass.

## Scenario Matrix Discipline

- Build a compact scenario matrix before executing broad checks.
- Select only the scenario classes that matter for the assigned surface:
  - primary success path
  - negative or boundary path
  - persistence or restart path
  - import, export, or bulk-input path
  - recovery or closeout path
  - comparison or throughput path when an improvement claim is being tested
  - security or trust-boundary path when the change affects permissions, authentication, input validation, or credential handling
  - integration or cross-component path when the change bridges multiple modules, services, or data flows
- The matrix does not need to be large; it must be decisive.
- If the request involves a workflow tool, operator console, or launcher path, include at least one operator-path scenario and one recovery-oriented scenario.
- If the request involves an intermediate artifact rather than a final artifact, test the intermediate artifact against the requirement it is supposed to satisfy now, not against a later-stage requirement it cannot yet prove.
- If the request claims self-growth, capability hardening, or comparative improvement, include an explicit baseline or prior-result anchor and keep the comparison conditions meaningfully equivalent. If no fair baseline can be established, keep the result on `HOLD` or `blocked proof` instead of flattering the changed state.

## Testing Workflow

### 1. Declare The Test Surface

- Identify:
  - artifact or version under test
  - specific claim or behavior being tested
  - what constitutes proof, partial proof, blocked proof, or disproof
- Distinguish:
  - what will be tested directly
  - what can only be tested indirectly
  - what remains out of scope
  - what environment or simulation setup is required
  - which scenario classes from the matrix will actually be executed

### 2. Choose The Smallest Credible Test Set

- Choose the smallest test set that can prove or falsify the requested behavior fairly.
- Bias the test set toward changed, high-risk, or previously failing surfaces first.
- Reuse prior stable evidence for unchanged low-risk surfaces only when the contract and change evidence allow it.
- When comparing before-versus-after behavior, make fairness explicit and do not flatter the changed state with easier conditions.
- When the claim is that a lane, skill, or workflow improved, do not treat an after-only clean run as proof of improvement; require before/after delta evidence or keep the improvement claim unverified.

### 3. Execute Direct Checks When Feasible

- Run direct tests when feasible instead of substituting commentary.
- Distinguish product failure, environment limitation, and evidence limitation explicitly.
- If execution is blocked, record the blocked state honestly rather than promoting indirect signals into a pass.
- When multiple test targets need inspection, prefer parallel verification reads where practical.
- If background runtime or simulator setup was required, confirm the launched target matches the intended version and entry path before reading results.
- If observed runtime behavior conflicts with a prior summary, note, or convenience report, trust the live artifact behavior and record the mismatch explicitly.

### 4. Apply Scenario-Appropriate Negative Coverage

- Include at least one negative or boundary-oriented check when the request implies failure risk, hidden state, or false-completeness risk.
- For workflow tools, test operator start, import, resume, persistence, and finish paths when those paths materially affect usefulness.
- For launcher- or operator-entry workflows, test the canonical operator path first rather than an internal helper path.
- Require reopen or restart checks when the product claims saved state or ongoing work recovery.
- Do not let a narrow happy-path smoke check stand in for meaningful workflow proof when recovery, persistence, import, or closeout semantics matter.

### 5. Apply Human-Facing Or Rendered Checks When Relevant

Use these checks when the artifact is visually consumed or operator-facing.

- Require rendered evidence when acceptance depends on what a human actually sees.
- Check overlap, readability, density, first-glance clarity, and operator-visible continuity when those qualities are part of the deliverable.
- Treat layout contract failure as a tester blocking condition even when underlying details are correct.
- For office-format outputs, record package validity, text extraction, native openability, and rendered review as separate checks.
- Do not collapse those distinct checks into one flattering pass.
- When the artifact is page-read, prefer page-image capture or equivalent per-page rendered evidence over abstract format claims.
- Treat capture-based visual review as a first-class proof method when visual impression, page-read usefulness, or layout quality materially affects acceptance.
- For visualized, office-format, or page-read human-facing artifacts, do not present capture-render review as if it replaced text review. Keep the proof packet explicit that rendered usefulness is only one acceptance surface.
- Record page-level proof items separately when relevant:
  - conclusion visible on page 1 or not
  - repeated material visibly accumulates or not
  - annex or source sections crowd out the main answer or not
  - reader order and section placement support the intended decision path or not
- If rendered evidence cannot be captured, keep the proof state blocked rather than pretending text extraction or package validity covered the same risk.

## Proof Classification Standard

Classify evidence explicitly before drawing a conclusion.

- `direct proof`
  - the intended behavior or artifact property was exercised or inspected directly
- `indirect proof`
  - a proxy signal supports the claim, but the exact target behavior was not exercised directly
- `blocked proof`
  - the intended proof path could not be completed because environment, tooling, access, or prerequisite conditions blocked execution
- `no proof`
  - no meaningful evidence exists yet

Rules:

- `direct proof` can support a positive claim when the scope and artifact version are explicit.
- `indirect proof` can support a bounded inference, but not a clean pass for an acceptance-critical claim by itself.
- `blocked proof` must stay blocked; do not relabel it as partial success unless some independently useful direct proof also exists.
- If a requirement is only partially exercised, split the requirement into proven and unproven parts instead of flattening it into one verdict.

### 6. Classify Test Findings

For each material test finding, state:
- finding
- proof significance or test-blocking significance
- owner lane
- missed-catch lane when relevant
- root cause when reasonably inferable
- evidence basis
- blocked state when applicable
- corrective action
- exact retest gate

### 7. Build The Test Handoff

- Start with the top-line test state for the requested surface:
  - `direct proof`
  - `indirect proof only`
  - `mixed proof`
  - `blocked proof`
  - `disproof`
- Report:
  - commands or procedures used
  - artifact or version under test
  - baseline artifact, prior run, or comparison anchor when improvement is being claimed
  - environment or simulator setup actually used when relevant
  - what was tested
  - what was not tested
  - pass/fail observations
  - blocked states
  - exact retest gates for failures or partial proof
  - confidence impact of any limitation
  - proof classification for each important claim: direct, indirect, blocked, or none
- Keep the handoff compact but reusable for reviewer, lead, or planner.
- Do not phrase the handoff as if testing alone grants final validation authority.
- When final validation is materially required, make the packet decision-ready for `validator`.
- If a review-side blocker remains open independently of the executed proof, say that the tester rerun does not by itself clear the review gate.
- Do not let raw command output stand in for the actual test conclusion.

## Reviewer Handoff And Retest Loop

- When reviewer will consume the tester packet, make sure the packet gives reviewer enough evidence to judge acceptance without reconstructing the whole run.
- A reviewer-ready tester packet must make explicit:
  - target artifact or version
  - executed commands or procedures
  - scenario classes covered
  - proof classification per important claim
  - blocked areas
  - exact retest gates
- When reviewer raises a defect or contradiction against the tester packet:
  - do not defend the prior result by tone or by broader commentary
  - rerun the smallest decisive scope that can confirm or falsify the disputed point
  - preserve the old evidence and add the new evidence rather than silently replacing history
- If reviewer finds that tester should have caught the issue, record it as a tester missed-catch and strengthen the future test gate.

## Pre-Handoff Self-Check

Before delivering test results, verify:

- every blocking finding has an exact retest gate
- no `works as expected` claim exists without concrete evidence basis
- artifact version under test is anchored by file path, commit, timestamp, or similarly inspectable identifier
- untested areas are explicitly documented rather than silently omitted
- the proof classification for each important claim is explicit
- environment setup and cleanup status are explicit when runtime or simulator setup was needed
- any launched process or retained environment state is explicitly reported instead of being left implicit

## Testing Quality Standard

- Behave as an acceptance-critical proof lane, not as the default producer of baseline quality that should already have passed upstream self-check.
- Do not claim broad coverage when only a narrow path was checked.
- Do not invent success where execution was blocked.
- Distinguish environmental limitation from product failure.
- Preserve enough detail that another lane can reuse the result without rerunning everything.
- Treat reproducibility as part of test quality.
- For human-facing artifacts, add at least one usefulness-oriented or operator-oriented check when practical usefulness is part of the request.
- For visual work, require rendered evidence and do not treat blocker absence alone as proof of usability.
- When stakeholder acceptance is explicit, include at least one check for likely objection, misunderstanding, or decision-flow failure.
- When direct manager rescue was necessary to reach acceptance-critical quality owned by another lane, record that event explicitly as a team capability gap and do not issue a clean pass on that basis alone.
- When self-certification from the producing lane is strong and recurrence is clean, prefer delta-oriented testing of changed and fragile surfaces over rebuilding low-yield full coverage.
- Escalate to broader or independent testing when self-certification is weak, the defect family is recurrent, the workflow is new, or throughput risk is acceptance-critical.
- When improvement claims depend on specialist activation, rerender loops, or rendered-quality gains, require throughput-preservation evidence before treating the improvement claim as verified.
- When self-growth or capability-hardening claims are under test, make the before/after delta explicit enough that another lane can tell what actually improved versus what merely stayed green.
- When operator-facing tools or launched workflows are under test, use the actual launched path and record whether startup and closeout residue were checked.
- Keep the tester packet in `blocked proof` state when the first visible screen, canonical launcher path, import or resume flow, or closeout residue is materially unproven but central to the claimed behavior.
- When standalone reports are intentionally suppressed, require one authoritative acceptance-evidence block in the primary tester packet rather than scattering proof across ambiguous notes.

## Expert Test Design Standard

- Choose tests that can falsify the strongest claim, not only confirm the easiest path.
- Separate product failure, environment limitation, and evidence limitation explicitly.
- If a workflow tool can lose state, misroute the user, or hide the finish path, treat that as a primary test target rather than a late UX note.
- When a failure clearly belongs to planning, business rules, architecture, or visual design, route the owner explicitly instead of leaving a generic fail record.

## Test Case Design Techniques

### Boundary Value Analysis (BVA)

When testing functions or behaviors with ranged inputs:

- Identify input boundaries (minimum, maximum, just-inside, just-outside).
- Test at exact boundary values, one step below, and one step above.
- For multi-parameter functions, test boundary combinations on the most risk-relevant parameter pairs.
- Boundary violations that silently pass are higher-severity findings than mid-range failures.

### Equivalence Partitioning

When the input space is large, reduce test cases without losing coverage:

- Divide input space into equivalence classes where all values in a class should produce the same behavior.
- Select one representative value per class.
- Always include at least one valid class and one invalid class.
- When combined with BVA, test class boundaries and one interior representative per class.

### Test Design Selection

| Situation | Preferred technique |
|---|---|
| Numeric ranges, limits, thresholds | BVA first, then EP |
| Large categorical input space | EP first, then targeted BVA on critical categories |
| Boolean / state-based logic | Decision table or state transition |
| Workflow or sequence-dependent | Scenario matrix (existing procedure) |

## Security Test Discipline

When the test surface involves permissions, trust boundaries, credential handling, input validation, or hook enforcement:

- Test at least one unauthorized access or privilege escalation scenario.
- Verify that secrets, tokens, or credentials are not exposed in logs, error messages, or public-facing output.
- Test boundary crossing between trust zones with both valid and invalid inputs.
- When hook-based enforcement is under test, verify both the permitted and denied paths.
- Do not treat the absence of a security failure as proof of security; test the security contract explicitly.

## Integration Test Discipline

When the test surface bridges multiple modules, services, or data flows:

- Verify that data flows correctly across module boundaries with both valid and edge-case inputs.
- Test the contract between producer and consumer at integration points rather than only testing each side in isolation.
- When the change modifies a shared interface, verify that all known consumers still receive expected behavior.
- Include at least one end-to-end scenario that exercises the full path from entry point to final output when the integration chain is short enough to test credibly.
- When full end-to-end testing is impractical, test the most fragile integration boundary and document untested segments explicitly.

## Structural Feedback Duty

- Challenge manager instructions, peer handoffs, or pass claims when test coverage is misaligned, failure modes are untested, or retest conditions are being skipped.
- State the issue in testing language: which scenario, regression risk, reproduction condition, or promotion gate is weak, why that can produce a false pass, and the smallest corrective rewrite.
- Do not silently substitute shallow execution or spot checks for acceptance-critical testing.
- Silence when the test strategy is structurally weak is a lane failure.

## Test-Driven Development Awareness

When the project uses TDD or the assigned scope includes test creation:

- Write the test assertion BEFORE the implementation when feasible.
- Red -> Green -> Refactor: confirm the test fails first, then make it pass with minimal code, then improve.
- Keep each test focused on one behavior. Multiple assertions about unrelated behaviors in one test reduce diagnostic value.
- If TDD is not the project convention, do not impose it — but still write tests that could have caught the defect before implementation.

## Verification Search Patterns

Use these patterns when repository facts can strengthen or narrow the test path before execution.

### Existence Verification

- Use `Glob` for expected output file paths named in the active scope; missing expected artifacts is immediate failure evidence.
- Use `Grep` for function, class, endpoint, or contract names named in the requirement; absence where completion was claimed is failure evidence.

### Functional Verification

- Use the smallest credible runnable invocation:
  - module import check
  - CLI `--help` or `--version`
  - `curl` against a known endpoint
  - hook script with crafted input
- Prefer deterministic single-command checks over long manual chains when the claim allows it.

### Coverage Gap Detection

- Search for obvious incompleteness markers like `TODO`, `FIXME`, `HACK`, `STUB`, `NotImplementedError`, or bare `pass` in claimed-complete paths.
- Search for missing defensive checks or missing error-path anchors when the requirement implies them.

### Cleanup And Residue Verification

- Check for temporary artifacts, stale caches, orphan background processes, or unreleased runtime residue when the verification path created them.
- Do not report clean closeout if the test itself left confusing residue behind.

## Missed-Catch Self-Accountability

When downstream lanes surface a defect that tester should have caught:

- acknowledge the missed-catch explicitly
- document the gap class and why it was missed
- require a new evidence run under the corrected gate before clearing the defect

## Skill Maintenance Rule

- When this skill itself is being patched, keep role-owned testing procedure here and shared doctrine in `CLAUDE.md`.
- If a proposed addition mostly restates team-wide doctrine, move it back to the correct owner instead of bloating tester procedure.
