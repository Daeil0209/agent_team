---
name: validator
description: Standard final validation procedure for the validator lane when the team needs an evidence-based PASS/HOLD/FAIL recommendation grounded in request intent, governing expectations, material references, produced outputs, review findings, and test evidence.
user-invocable: false
---

# Validator

This skill defines the repeatable final validation procedure for the `validator` lane.

Keep role identity, authority boundaries, and completion ownership in `.claude/agents/validator.md`.
Use this skill for final comparison, mismatch framing, blocked-state handling, and final validation recommendation.

## Procedure Preconditions

- Use when acceptance risk is meaningful enough that review and testing alone should not silently stand in for final validation.
- Use after the relevant review and testing packets exist, or after the lack of those packets has itself become a validation finding.
- Keep the validation surface bounded to the assigned artifact set, delivery scope, or decision surface.

## Validation Inputs

Use the strongest available evidence for each expectation source.

- requested
  - what the user explicitly asked for
- governed
  - what the active doctrine, plan, contract, or execution expectations require
- referenced
  - what material references indicate should be preserved, matched, or respected
- produced
  - what was actually created or changed
- reviewed
  - what `reviewer` found, blocked, or left uncertain
- tested
  - what `tester` proved directly, indirectly, or could not prove

Do not collapse these into one vague impression. Preserve where each expectation came from and how strongly each source constrains the verdict.

## Lane Relationship Contract

- Intentional local restatement: keep this lane contract in the validator skill even when similar wording exists elsewhere. Removing it as "duplicate" is information loss unless an equivalent validator-local contract remains here.
- `reviewer` owns review findings, blocking versus non-blocking classification, review-side `HOLD` recommendations, missed-catch attribution, and review-found retest requirements.
- `tester` owns proof classification, executed-check evidence, blocked-proof reporting, and rerun gates for executed checks.
- `validator` owns the final `PASS` / `HOLD` / `FAIL` recommendation and the explicit arbitration of review and test packets.
- Upstream review-side `HOLD` recommendations and tester blocked-proof states are gating evidence surfaces, not disposable prose. They remain active until satisfied, explicitly disproven, or narrowed with evidence.

## Preflight Validation

Before final comparison begins, confirm:

1. the active validation surface is identifiable
2. the relevant produced outputs are inspectable, or their absence is itself a finding
3. the relevant review and test packets are available, or their absence is explicitly recorded
4. the validation scope is meaningful enough to assess
5. material reference evidence is available or its absence is explicitly recorded
6. repository-local evidence can be inspected without forbidden operations

If preflight fails:

- do not fabricate comparison results
- keep the validation state on `HOLD` unless the failure itself justifies `FAIL`
- report exactly what could not be assessed and why

## Validation Arbitration Standard

- Prefer the strongest explicit operator evidence when requested and governed meaning diverge materially.
- Use governed expectations as the primary execution baseline, but do not let a distorted or bloated governance artifact excuse a weak delivery.
- Distinguish:
  - not built
  - built but conceptually wrong
  - built but weakly evidenced
  - built but blocked from honest assessment
- Treat references as role-bearing evidence, not as a single flat authority layer.
- If a later reference appears to introduce a new hidden requirement, judge whether that requirement was genuinely required or only supplemental.

## Validation Workflow

### 1. Build The Expectation Suite

- Construct an explicit expectation suite before starting verdict work.
- At minimum, separate:
  - existence expectations
  - scope coverage expectations
  - behavior or logic expectations
  - reference expectations when material references exist
  - acceptance or quality expectations
  - blocked or not-assessable expectations
- If the governing expectation set is weak or distorted, record that as a validation finding instead of pretending it is clean.

### 2. Inspect Requested Intent

- Read the active request or equivalent operator intent.
- Extract:
  - requested deliverables
  - the single dominant question the artifact must answer
  - explicit constraints
  - excluded scope
  - user-visible quality expectations
  - operability or workflow expectations when relevant

### 3. Inspect Governing Expectations

- Read the active plan, governance artifact, or equivalent execution baseline when it materially constrains acceptance.
- Extract:
  - expected outputs
  - acceptance criteria
  - fail or hold conditions
  - important constraints
  - declared assumptions or excluded paths

### 4. Inspect Relevant References

- Inspect only the references that materially affect acceptance.
- For each important reference, determine:
  - what role it serves
  - what requirement it supports
  - how strongly it constrains the output
  - what it does not justify inferring
- If a consequential benchmark or externally sourced claim depends on that reference, require cross-check or authoritative corroboration before letting it act as clean verdict-driving evidence.
- Common reference roles include:
  - format or template reference
  - structure reference
  - terminology reference
  - behavior or logic reference
  - validation reference
  - low-confidence supplemental material
- Do not treat all references as equally authoritative.

### 5. Inspect Produced Outputs

- Inspect the actual produced artifacts, not only summaries.
- Determine:
  - what exists
  - what is missing
  - what is only partially present
  - what is present but weakly evidenced
- For human-facing or operator-facing outputs, do not treat existence or openability alone as practical usefulness proof.
- For executable deliverables, do not treat build success or file existence alone as functional correctness proof.
- For human-facing artifacts such as documents, reports, decks, or UI surfaces, require usefulness-oriented evidence rather than format integrity alone.

### 6. Incorporate Review And Test Evidence

- Pull in `reviewer` findings as upstream challenge evidence.
- Pull in `tester` packets as execution or blocked-proof evidence.
- Preserve monotonicity:
  - you may strengthen a non-blocking concern into a blocking validation outcome when evidence warrants it
  - you may not relax an upstream blocking finding without factual error proof
- Treat reviewer-side `HOLD` recommendations and tester blocked-proof states as unresolved upstream gates unless explicit evidence shows the gate has been cleared or narrowed.
- If `reviewer` and `tester` disagree factually, keep the final state non-clean until the smallest decisive rereview, rerun, or stronger evidence resolves the conflict.
- If `reviewer` and `tester` do not disagree factually but imply different next steps, preserve both upstream packets and explain which gate is controlling the final verdict.

### 7. Build Requirement-To-Evidence Comparison

For each important expectation, record:

- expectation source
- expected condition
- baseline or prior-state anchor when the claim is comparative, self-growth-oriented, or promotion-oriented
- observed evidence
- result:
  - matched
  - partially matched
  - mismatched
  - blocked
  - not assessable
- severity or trust impact
- notes or limitations

### 8. Apply Required Checks

At minimum, evaluate all of the following:

#### Existence And Completeness

- required deliverables exist
- the output set is materially complete
- missing outputs are treated as findings, not silently skipped

#### Scope Coverage

- core requested scope is represented
- governed scope is covered
- excluded scope is not misclassified as required scope
- unsupported reinterpretation did not replace explicit requirements
- the user's named subject was not silently narrowed to one subtype, scenario, or example unless that branch was made explicit

#### Logic And Behavior Preservation

- important governed logic is represented
- important reference-backed structure or behavior is represented when relevant
- conceptually wrong outputs are not mistaken for complete outputs

#### Operability And Usefulness

- executable deliverables have credible execution or functional evidence
- operator-facing workflows show a credible start, progress, and finish path when such use is required
- human-facing artifacts show practical usefulness, not only file integrity or openability
- supporting appendices, source lists, or follow-on annexes do not displace the main requested answer
- for office-format or page-read artifacts, rendered evidence is strong enough to assess first-glance comprehension, page-level repetition, conclusion visibility, and section-order fitness

#### Validation-Criteria Satisfaction

- required acceptance criteria were actually checked
- known unmet criteria are listed explicitly
- review and test evidence were considered where their scope was required for honest acceptance

#### Assumptions, Blockers, And Evidence Coverage

- unresolved assumptions are identified and assessed for trust impact
- blocked checks are listed explicitly
- each major conclusion is traceable to evidence
- not-assessable items are not misrepresented as passing
- externally sourced or benchmark-shaping claims are not treated as verified unless cross-check or strong authoritative corroboration is explicit

#### Critical-Path Proof Presence Check

- Confirm that the evidence suite already contains direct functional proof for one or two critical paths beyond structural or existence validation.
- Prefer existing `tester` evidence for this check.
- If that proof is missing, record the gap as a validation finding and route proof generation back to `tester` instead of silently replacing the tester lane.
- This remains required even when the rest of the validation surface appears structurally clean.

### 9. Apply Final Acceptance Gate

`PASS` is prohibited when any of the following remain true:

- unresolved blocking findings from `reviewer` or `tester` are present
- declared fail conditions from the governed expectation set have occurred
- required acceptance criteria remain unevaluated
- decisive evidence is missing for a core requirement
- blocked validation prevents an honest pass
- a request-bound artifact answers a neighboring question, lets excluded scope crowd out the requested answer, or never makes the dominant question easy for the primary audience to find
- the work drifted materially beyond the core of the question, even though the added material was true or potentially useful
- a benchmark-sensitive office-format or page-read document is being accepted without explicit benchmark intake or an explicit no-benchmark rationale
- required rendered evidence for a page-read or office-format artifact is missing or too weak to judge page-level usefulness honestly
- a visualized, office-format, or page-read artifact is being accepted without both text-review evidence and capture-render-review evidence when the rendered result is part of acceptance
- a self-growth, capability-hardening, or comparative-improvement claim lacks inspectable before/after delta, fairness conditions, or promotion-readiness status
- required follow-on optimization remains missing without an explicit no-safer-reduction disposition

`HOLD` is the correct result when:

- decisive evidence is still missing
- blocked areas prevent an honest pass but do not yet justify a clean fail
- ownership or evidence gaps still need corrective follow-up

`FAIL` is the correct result when:

- a core requirement is clearly not met
- a critical mismatch is directly evidenced
- the blocked or missing evidence itself makes the requested delivery impossible to defend as complete

## Severity Model

Use severity according to delivery impact and trust impact.

### Critical

Examples:

- required deliverable missing
- requested executable output lacks credible runnable evidence
- core governed requirement ignored
- result contradicts explicit requested intent or strong reference evidence
- validation cannot proceed credibly because core evidence is missing

Default result:

- `FAIL`

### Major

Examples:

- important scope only partially implemented
- key structure or behavior only partially represented
- important validation criteria not satisfied
- important checks remain blocked without adequate alternative evidence

Default result:

- usually `FAIL` unless narrowly bounded and explicitly justified

### Minor

Examples:

- formatting or polish differences without core functional impact
- wording drift without important semantic consequence
- non-critical documentation defects

Default result:

- may still allow `PASS` if core requirements are satisfied

## Final Decision Rule

- Any Critical mismatch defaults to `FAIL`.
- Missing required runnable evidence for a requested executable deliverable defaults to `FAIL`.
- A blocked assessment defaults to `HOLD` when decisive evidence is missing but the record is still insufficient for a clean `FAIL`.
- A blocked assessment may escalate to `FAIL` when the blocked area affects a core requirement or prevents an honest `PASS`.
- Major mismatches require explicit justification and do not allow automatic `PASS`.
- Only Minor mismatches with core requirements satisfied may allow `PASS`.
- If the result is not clearly `PASS`, do not soften it with vague language.

## Blocked Validation Rules

Validation is blocked when any of the following is true:

- produced outputs are missing entirely
- core comparison evidence is unreadable or absent
- a core requirement cannot be assessed meaningfully
- repository constraints prevent a required inspection and no adequate alternative evidence exists

When validation is blocked:

- explain exactly what could not be assessed
- explain how the blocked area affects trust
- keep blocked findings distinct from direct mismatches
- default to `HOLD` unless the blocked area itself prevents an honest `PASS` strongly enough to justify `FAIL`

### 10. Build The Final Validation Handoff

- Start with the final recommendation: `PASS`, `HOLD`, or `FAIL`
- Immediately state the strongest verdict-driving reasons before secondary detail.
- Then report:
  - validated surface
  - compared sources and their authority level when material
  - matched items
  - partially matched items
  - mismatched items
  - blocked or not-assessable items
  - unresolved upstream blockers
  - confidence level:
    - high
    - medium
    - low
  - next-action owner for each unresolved blocking or corrective item when that owner is clear
  - exact next action needed to clear `HOLD` or correct `FAIL`
- If a blocking item still lacks a clear corrective owner, record that ownership gap explicitly and keep the closeout path non-clean.
- If you keep an upstream corrective owner or retest gate, say so plainly when that gate is still controlling the final outcome.
- If you replace an upstream corrective owner or retest gate, state exactly what evidence justified the change.
- Keep the output compact but decision-ready for `team-lead`.

## Confidence Level Rules

- `high`
  - core expectations are directly evidenced
  - compared sources materially agree or the disagreement is resolved
  - blocked or not-assessable areas do not affect the verdict's core logic
- `medium`
  - the main verdict is defensible, but some meaningful limits, partial proof, or unresolved secondary disagreement remain
- `low`
  - important parts of the verdict still depend on weak evidence, blocked assessment, or unresolved source conflict

- Do not assign `high` confidence when:
  - a core requirement remains blocked or only indirectly evidenced
  - review or testing scope was materially incomplete for honest acceptance
  - reference authority is still ambiguous on a verdict-critical point

## Validation Judgment Quality Standard

- Tie each major validation conclusion to observable evidence.
- Separate missing evidence from negative evidence.
- Preserve the source of each expectation so requested, governed, referenced, produced, reviewed, and tested views do not blur together.
- Assign severity according to delivery impact and trust impact, not according to how expensive a fix would be.
- Remain neutral when evidence is mixed; do not upgrade uncertainty into `PASS`.
- Reject clean `PASS` when only existence, openability, or format integrity is proven for a human-facing deliverable.
- Reject clean `PASS` when review or testing packets are materially incomplete but their scope was required for honest acceptance.
- Reject clean `PASS` when the evidence suite lacks direct functional proof for critical paths that materially require it.
- Reject clean `PASS` when a self-growth or capability-hardening claim is supported only by an after-state clean run without inspectable before/after delta and fairness conditions.
- Reject clean `PASS` when claimed advancement or promotion-readiness lacks explicit follow-on optimization closure or an explicit no-safer-reduction disposition.
- Do not treat a prior summary, report, or convenience narrative as stronger evidence than the actual produced artifact when they conflict.

## Evidence Quality Rules

- Prefer direct evidence over inference.
- Identify inferred conclusions as inferred.
- Do not exaggerate certainty.
- Do not hide missing evidence.
- Do not convert `not assessable` into `matched`.
- If sources disagree, explain the disagreement explicitly instead of flattening it into one verdict sentence.
- Normalize upstream evidence wording onto the canonical cross-lane taxonomy in `CLAUDE.md`: `confirmed`, `supported`, `inferred`, `unconfirmed`, `conflicting`. Do not let lane-local labels silently upgrade or downgrade certainty during final arbitration.

## Review Chain Monotonicity

- Reviewer or tester blocking findings may be strengthened downstream, but not silently weakened.
- Reviewer-owned finding classification and tester-owned proof classification remain authoritative for their own surfaces unless explicit evidence proves factual error.
- Reporter-style summarization belongs to `team-lead` closeout, not to this lane.
- If the validator result is not clearly `PASS`, do not soften it with optimistic phrasing.

## Role-Scoped Structural Feedback

- Challenge manager instructions, peer handoffs, or comparison inputs when the validation basis is structurally weak.
- State the issue in validation language:
  - which comparison source, acceptance criterion, mismatch test, or evidence boundary is weak
  - why that weakness can distort the verdict
  - the smallest corrective rewrite or evidence addition needed
- Do not silently convert an evidence-gap or comparison-frame defect into an apparently disciplined validation result.

## Skill Maintenance Rule

- When this skill itself is being patched, keep role-owned final validation procedure here and shared doctrine in `CLAUDE.md`.
- If a proposed addition mostly restates team-wide doctrine, move it back to the correct owner instead of bloating validator procedure.
