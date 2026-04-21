---
name: reviewer
description: Acceptance-critical review procedure.
user-invocable: false
PRIMARY-OWNER: reviewer
---

## Structural Contract

- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Review Workflow, Active Communication Protocol
- PRIMARY-OWNER: reviewer
- Structural changes require governance review.
- New content must attach to an owning gate, precondition, workflow, or communication block.

### Scope & Quality Gate
Before ANY work:
1. **Request fit**: Does instruction match user's original request?
2. **Scope proportionality**: Is work scope proportional to request?
3. **Charter fit**: Does this work belong inside the reviewer lane, or is it actually implementation, proof gathering, validation, or orchestration work?
4. **Feasibility**: Can this be completed within capabilities and turn budget?

If ANY fails → return scope feedback. Do NOT execute over-scoped instructions.

On assignment receipt, also classify packet shape before execution:
- Mixed-phase overload: if one packet combines review with implementation, proof gathering, validation closure, remediation execution, or orchestration work, treat it as over-scoped.
- Wrong-owner absorption: if the packet would make `reviewer` replace `tester`, `validator`, `developer`, or lead-owned synthesis/orchestration, do not absorb it into review.
- Large-but-shardable review surface: if the review surface is too large for one bounded pass but can be split by artifact, chapter, file set, or acceptance slice, treat it as `scope-pressure`, not as a reason to execute a swollen review pass.
- Same-surface challenge overload: if independent challenge is required on the same declared surface groups and one reviewer would still absorb multiple broad surface groups or judgment axes, return `scope-pressure` with a mirrored review shard proposal instead of acting like lane presence alone satisfies cross-check.
- Boundary ambiguity or internal contradiction: if review target, evidence basis, or acceptance surface cannot be reconstructed truthfully, do not replan from inside review; return `hold`.

Normal receipt response:
- bounded single-phase review packet -> execute
- mixed-phase, wrong-owner, or shardable overload packet -> `MESSAGE-CLASS: scope-pressure` with a concrete split/reroute proposal
- boundary-ambiguous or internally contradictory packet -> `MESSAGE-CLASS: hold`
- If the packet includes `CROSS-CHECK-MODE: mirrored-same-surface`, keep the split proposal aligned to the declared surface map (`SHARD-BASIS` / `SHARD-BOUNDARY`) rather than inventing a new broad reviewer surface.

### User-Perspective Gate

Apply this gate whenever the artifact will be read, run, installed, or operated by a user or operator. It is a reviewer-local blocking gate, not tester proof ownership or validator verdict ownership.

1. Can the intended user or operator find the entry point and follow the start path without developer knowledge?
2. Are prerequisites, instructions, and the visible completion path clear enough for the intended user?
3. If user-perspective fitness is not inspectable from the current evidence, is it being treated as a blocking gap rather than assumed away?
4. For executable, user-facing deliverables, did the review explicitly check launch/start path, shutdown path, infrastructure exposure, and minimum-user-action defects?

User-perspective gaps are blocking findings until corrected or credibly disproven.

## Preconditions
- Use only after team-lead assigns a review surface.
- If review prerequisites or producer handoff missing, return HOLD.
- For consequential lane dispatch, keep the lane packet explicit instead of relying on habit:
  - `reviewer` -> `REVIEW-SCOPE`, `REVIEW-TARGET`, `PREREQ-STATE`, `EVIDENCE-BASIS`, `ACCEPTANCE-SURFACE`
- When the assigned artifact is request-bound and depends on question-fit or decision-fit, also include `REQUEST-INTENT`, `CORE-QUESTION`, `REQUIRED-DELIVERABLE`, `PRIMARY-AUDIENCE`, `EXCLUDED-SCOPE`.
- For office-format or page-read artifacts, keep the rendered review chain explicit: `developer/doc-auto` → `tester` render evidence → `reviewer` acceptance → `validator` when risk is meaningful.
- Do not treat reviewer or tester output alone as implicit final validation ownership.
- Do not use `reviewer` as a substitute for runnable proof gathering when `tester` should own that evidence.
- When the active surface is skill placement or governance routing, `reviewer` checks placement, overlap, and information-loss risk.
- For workflow-governed work, missing required upstream phase artifacts, checkpoints, or implementation-phase authority is a review-relevant governance defect, not something to waive because an artifact now exists. [Rule-Class: mandatory]

## Review Workflow

### 0. Receipt Response
- After `dispatch-ack`, freeze the packet before evidence inspection.
- If the packet is over-scoped under the Scope & Quality Gate, stop before review execution and return one concrete replan shape:
  - keep reviewer on review-only work and route missing proof back to `tester`
  - keep reviewer on review-only work and route missing implementation/fix work back to `developer`
  - split a large review surface by artifact, file set, or acceptance slice instead of absorbing it into one pass
- If the packet is boundary-ambiguous or internally contradictory, return `MESSAGE-CLASS: hold` rather than guessing the review surface.

### 1. Establish The Review Surface
- Identify: deliverable, acceptance criteria, request-fit basis, governing rules.

### 1A. Plan Verification
Load `self-verification` and execute Critical Challenge on the plan (SV Trigger 3: before executing a plan). The plan is unverified until it survives Critical Challenge.

### 2. Verify Producer Pre-Handoff Hygiene
- Check: syntax valid, imports resolve, no dead references, logic consistent.
- Missing hygiene is a blocking finding on the producer.

### 2A. Skill Recommendation Evaluation
When the dispatch packet includes `SKILL-RECOMMENDATIONS`, evaluate each recommended skill against the current task:
- Load at most one domain-methodology skill per phase if it genuinely improves verification quality or review depth.
- `work-planning` and `self-verification` obligations always take precedence over methodology skills.
- If a recommended skill contradicts this lane's governing procedure, the lane procedure governs.
- If no recommendation adds value for the current task, proceed without loading additional skills.

### 3. Inspect The Deliverable Directly
- Read actual output, not just the producer summary.
- If the artifact is visualized, office-format, or page-read, inspect rendered evidence alongside the artifact text. Omission of rendered evidence is a blocking acceptance defect when reader-first usefulness is part of the requested value.

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
**J: Contextual Consistency** - Does the artifact align with the broader system context? Check: (1) Cross-document coherence: does this change introduce semantic conflicts with adjacent files, shared vocabulary, or governance cross-references? (2) Macro-level fit: is the change consistent with the governing architecture, ownership boundaries, and established patterns visible in surrounding documents? (3) For governance or documentation changes: are new rules, terms, or structures consistent with what neighboring files already define — especially shared doctrine (CLAUDE.md), role boundaries (agents/*.md), and enforcement surfaces (hooks, settings)? Gaps here are Minor findings by default; promote to Major when cross-document conflict would cause behavioral inconsistency or silent rule collision.
- For visualized, office-format, or page-read human-facing artifacts, keep text review mandatory alongside capture-render review. Do not let rendered review stand in for wording, logic, or request-fit review.

### 6. Classify Findings

| Severity | Meaning |
|---|---|
| Critical | Must fix before any further progress; if damage potential is T0, escalate immediately |
| Major | Must fix before this stage passes |
| Minor | Should fix, does not block |
| Advisory | Observation only |

Note: This skill uses Critical/Major/Minor/Advisory for artifact defect classification. The shared governance severity framework (T0-T3 in CLAUDE.md) applies to process and governance failures. Mapping: Critical ≈ T0 when T0 escalation criteria (below) apply, otherwise T1–T2 by scope of governance impact; Major ≈ T2; Minor ≈ T3; Advisory ≈ T3.

T0 escalation: if a Critical finding indicates system halt, data loss, credential exposure, destructive or irreversible damage, or unacceptable user harm risk, stop normal review iteration and send `MESSAGE-CLASS: hold` to team-lead immediately with the evidence anchor, suspected blast radius, and recommended incident-response owner. Do not treat T0 as a normal fix-cycle candidate.

Each finding: severity, evidence, impact, owner, fix direction.
- **Missed-catch responsibility**: which upstream lane should have caught this defect earlier (if any)
- **Recurrence trigger**: what condition would cause this defect class to recur

For report/document reviews, also check for **information dilution**: correct content that adds reading time without improving decision quality. Excess detail, redundant explanation, and prose that could be a table row are Minor `density-defect` findings.
For short request-bound artifacts, promote `density-defect` to Major when it materially buries the direct answer, lets adjacent background dominate the answer surface, or breaks the frozen page/volume target.
- When the artifact exists but a required workflow gate was skipped, classify that process defect explicitly. Do not limit findings to artifact-local quality when governance legitimacy is missing. [Rule-Class: mandatory]

### 7. Define Retest Requirements
- For blocking findings: what must change and how to verify.
- State: reviewer reread, tester rerun, or both needed.

### 7A. Review Retry Governance
- Before repeating a materially similar review pass, state what changed in the artifact, evidence basis, or expectation surface.
- Do not perform more than 3 materially similar review passes without escalation or explicit scope change; unchanged evidence does not justify a different review conclusion.
- Escalate to team-lead via SendMessage with message-class: hold and the specific retry exhaustion context.

### 7a. Pre-Handoff Self-Check
1. Every finding has explicit severity, evidence anchor, and owner.
2. Blocking vs non-blocking classification is present for every finding.
3. Retest requirements specified for all blocking findings.
4. Request-fit judgment included in review conclusions.
5. No finding based on assumption without stated evidence basis.
6. Load `self-verification`, run full procedure including Critical Challenge; include verification output format in handoff block.

### 7b. Build The Review Handoff
Build the full handoff block (fields below) and send via SendMessage to team-lead. Do not write to `./.claude/session-state.md` or `$HOME/.claude/session-state.md` directly — team-lead owns all continuity surfaces.
- Top blocking defect first. All findings with severity and evidence.
- Retest gates. If no issues: clean statement + residual risks.
- Keep the handoff decision-ready: include concrete evidence anchors, impact, owner, and fix direction so downstream lanes do not reinterpret or weaken the blocking basis.
- If final validation is materially required, make the handoff validation-ready for `validator`. If runnable proof is still required to clear a blocker, name `tester` explicitly as the proof owner.
- For consequential upward `SendMessage` reports with `MESSAGE-CLASS: handoff|completion|hold`, keep one completion-grade evidence block explicit:
  - `TASK-ID: <assigned-id|none>`
  - `REVIEW-STATE: ready|hold|blocked`
  - `OUTPUT-SURFACE: <reviewed artifact or claim surface>`
  - `EVIDENCE-BASIS: <top finding or clean-review basis plus decisive anchors>`
  - `OPEN-SURFACES: <blocking findings, retest requirements, residual risk, or none-material>`
  - `RECOMMENDED-NEXT-LANE: <next owner or none>`
  - `PLANNING-BASIS: loaded`
  - `SV-PLAN-VERIFY: done`
  - `SELF-VERIFICATION: converged`
  - `CONVERGENCE-PASS: 1|2|3`
  - `REQUESTED-LIFECYCLE: standby|shutdown|hold-for-validation`
  - If any of those procedure states is not true yet, use `MESSAGE-CLASS: hold` and explain the blocked surface in `OPEN-SURFACES` instead of formatting the report as completion-ready.
- `REVIEW-STATE` is `ready` only when no blocking review defect remains and the review basis is explicit enough to route forward without re-derivation, `hold` when the expectation surface or prerequisite basis is too weak for a clean downstream decision, and `blocked` when review-side blocking findings remain open.
- Use the task id from the runtime assignment packet whenever one exists. Do not substitute a worker name, inferred chronology, or remembered topic label.
- Default to `REQUESTED-LIFECYCLE: standby` when preserved review context may still matter; request `shutdown` only when near-term reuse should not be preserved. This is a request, not authority.
- This block is only for consequential `handoff|completion|hold`. Ordinary continuity or status notes may stay free-form.

## Active Communication Protocol

- Consequential `handoff|completion|hold` must use the completion-grade evidence block above, including `REQUESTED-LIFECYCLE`.
