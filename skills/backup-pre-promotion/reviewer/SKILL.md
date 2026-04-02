---
name: reviewer
description: Standard acceptance-critical review procedure for the reviewer lane when produced artifacts, plans, claims, or rendered outputs need blocking classification, owner routing, missed-catch analysis, and retest requirements before final validation.
user-invocable: false
---

# Reviewer

This skill defines the repeatable review procedure for the `reviewer` lane.

Keep role identity, authority boundaries, and completion ownership in `.claude/agents/reviewer.md`.
Use this skill for detailed review workflow, severity framing, review lenses, retest requirements, and findings handoff.

## Procedure Preconditions

- Use after implementation, planning, research, or artifact production has created something that now needs disciplined review.
- Use when acceptance risk is material enough that findings, severity, and retest requirements must be explicit.
- Do not use this lane as a substitute for implementation or final validation ownership.

## Lane Boundary Contract

- Intentional local restatement: keep this lane-boundary contract in the reviewer skill even when similar wording exists elsewhere. Removing it as "duplicate" is information loss unless an equivalent reviewer-local contract remains here.
- `reviewer` owns review finding classification, review-side blocking versus non-blocking calls, review-side `HOLD` recommendations, missed-catch attribution, and review-found retest requirements.
- `tester` owns runnable proof, blocked-proof reporting, and rerun gates for executed checks.
- `validator` owns the final `PASS` / `HOLD` / `FAIL` recommendation after consuming review and test evidence.
- A review-side `HOLD` is a lane-local gating recommendation for the review surface, not a replacement for validator's final verdict.
- If a review concern can only be cleared by runnable proof, route that proof requirement to `tester` instead of acting as if reviewer has already produced it.

## Expansion Trigger Rules

- Keep this skill as the single reviewer procedure file.
- Do not load separate reviewer rule files; apply additional sections in this same document when their trigger conditions are true.
- Evaluate triggers during `Establish The Review Surface`, before deeper review begins.
- If multiple triggers are true, apply all matching sections in this file.
- If trigger status is uncertain and under-review risk is higher than the cost of extra analysis, apply the heavier section.

### Trigger A: Artifact-Specific Deep Review

Apply the advanced artifact lenses and rendered-evidence rules later in this file when any of the following is true:

- the track is `FULL`
- the artifact is human-visible, rendered, operator-facing, workflow-facing, or business-decision-facing
- acceptance depends on openability, rendering, layout, recovery flow, persistence semantics, or operator cost
- failure-mode or business-tradeoff analysis is part of the pass decision

### Trigger B: Governance Or Review-Hardening Review

Apply the governance patch review, self-growth, and adversarial review sections later in this file when any of the following is true:

- the review target changes `CLAUDE.md`, agent files, `SKILL.md`, `settings.json`, or hooks
- the review may change or relax a blocking classification
- the same defect class, missed-catch, or false-pass pattern has recurred
- a high-risk artifact appears clean and the main question is whether the review itself is too shallow

## Track Activation

- `MICRO`
  - Lightweight delta review for a narrow low-risk surface
  - Confirm requested changes are present and no obvious regressions appear on the changed surface
- `STANDARD`
  - Default review mode
  - Apply blocking versus non-blocking classification, evidence challenge, owner routing, and retest requirements
- `FULL`
  - Use when the deliverable is visual, operator-facing, workflow-critical, acceptance-sensitive, or otherwise high-risk
  - Rendered or execution-adjacent evidence is mandatory when the artifact type requires it

## Review Workflow

### 1. Establish The Review Surface

- Identify:
  - what artifact or claim is under review
  - what acceptance decision this review will affect
  - which track applies: `MICRO`, `STANDARD`, or `FULL`
- Evaluate the expansion trigger rules immediately.
- If the artifact type implies rendered evidence, launcher proof, workflow proof, or stronger acceptance gates, escalate the track accordingly.
- If the review target, critical evidence, or required rendered/execution proof is materially missing, do not drift into partial blessing. Move the review state to `HOLD` and state the missing prerequisite explicitly.
- Require the following context from the producer's handoff before substantive review begins:
  - problem description or decision target that motivated the work
  - intended audience or downstream consumer
  - key constraints or assumptions that shaped the implementation
- For request-bound artifacts, also require:
  - `REQUEST-INTENT`
  - `CORE-QUESTION`
  - `EXCLUDED-SCOPE`
- If this context is missing, record a producer missed-catch for incomplete handoff before proceeding with review under reduced confidence.

### 2. Verify Producer Pre-Handoff Hygiene

- Before substantive review, verify that the producer performed role-appropriate self-checks.
- For `developer` handoffs, require evidence of pre-handoff integrity checks:
  - syntax
  - logic consistency
  - imports / dependencies
  - dead references
- If that hygiene evidence is missing, record a producer missed-catch before continuing. Do not silently substitute review effort for producer self-check discipline.
- For `researcher` handoffs, require evidence of:
  - evidence basis
  - uncertainty or contradiction disclosure
  - correct `UNVERIFIED` labeling where proof is incomplete
  - cross-check status when externally sourced or benchmark-shaping evidence materially affects the claim
- If that researcher packet hygiene is missing, record a producer missed-catch before continuing.
- For `tester` handoffs, require evidence of:
  - artifact or version under test
  - executed commands or procedures
  - proof classification for important claims
  - blocked areas or untested areas
  - exact retest gates for blocking failures
- If that tester packet hygiene is missing, record a producer missed-catch before continuing.

### 3. Inspect The Deliverable Directly

- Inspect the actual artifact, not only the producer's summary.
- When multiple files or artifacts need inspection, prefer parallel reads.
- Reuse trustworthy upstream self-check anchors only when they truly narrow the live risk surface.
- Do not accept a clean summary as proof.
- If a summary, prior report, or convenience narrative conflicts with the actual artifact, trust the artifact and record the mismatch explicitly.

### 4. Run The Evidence Challenge

- Challenge whether the key claims are actually supported by inspectable evidence.
- Target:
  - contradictions
  - hidden assumptions
  - unsupported conclusions
  - claim-evidence mismatch
  - weak acceptance logic
- If a conclusion is stated as fact without verification evidence, require `UNVERIFIED` labeling or raise a blocking finding when the claim affects acceptance.

### Verification-Before-Conclusion Check

- Flag any conclusion stated as fact without verification evidence.
- Verify that technical claims point to actual inspection, execution evidence, or trustworthy documentation rather than logical plausibility alone.
- If a materially important conclusion remains unverified and is not labeled `UNVERIFIED`, treat that as a blocking finding.
- When a claim carries an explicit evidence label, expect it to map cleanly to the canonical evidence-status taxonomy in `CLAUDE.md` rather than using lane-local wording to soften uncertainty.

### 5. Apply Domain Lenses

Activate 1 to 3 relevant review lenses based on deliverable type.

#### Lens A: Evidence Quality

Use for plans, reports, benchmarks, claims, research, or any evidence-heavy artifact.

- Are claims cross-checked or only asserted once?
- Are unsupported or weakly supported claims framed honestly?
- Does the evidence actually justify the stated conclusion?
- Do materially important benchmark or external-reference claims rely on inspectable citations and cross-checks rather than memory or narrative plausibility?

Blocking when:
- a consequential claim lacks evidence
- evidence contradicts the claim materially
- a quantitative or performance claim is presented without meaningful verification basis
- a benchmark or external-reference claim is steering acceptance without credible cross-check or inspectable provenance

#### Lens B: Logical Rigor

Use for multi-step logic, architecture reasoning, policy changes, or specifications.

- Are there internal contradictions?
- Are key assumptions explicit?
- Are edge cases or unresolved behavior paths being hidden?

Blocking when:
- the logic chain breaks on a critical step
- internal contradiction affects the acceptance path
- undefined or conflicting behavior is left unacknowledged

#### Lens C: Software Quality

Use for code, configuration, APIs, or software architecture.

- Does the change introduce regressions, brittle coupling, or unbounded impact?
- Are interfaces, dependencies, and testability still credible?
- Does the implementation preserve established conventions unless change was explicitly justified?

Blocking when:
- the change creates a high-risk regression surface without mitigation
- API, contract, or dependency shifts are under-acknowledged
- the code appears formally changed but practically unsafe or unreviewable

#### Lens C+: Security And Trust Boundary

Use for code, configuration, infrastructure, hooks, permissions, or any artifact that affects trust boundaries.

- Are authentication, authorization, and input validation explicitly addressed where required?
- Are secrets, tokens, credentials, or sensitive configuration protected from exposure?
- Do trust boundaries between components, services, or roles remain explicit and enforced?
- Are permission scopes minimal and justified rather than broadly granted for convenience?
- Does the change introduce new attack surface, privilege escalation paths, or unvalidated external input?

Blocking when:
- credentials or secrets are exposed or insufficiently protected
- trust boundary violations are unacknowledged
- permission scope exceeds what the function requires without justification
- unvalidated external input reaches a security-sensitive path

#### Lens C++: Realizability And Operational Feasibility

Use for schedules, plans, workflows, operational documents, or any artifact that claims to be executable.

- Are hidden time costs explicit (setup, transit, cleanup, approval waits, environment preparation)?
- Are buffers present at risk points and transition points?
- Is the plan achievable within stated constraints, or does it assume ideal conditions?
- Are prerequisites and dependencies made visible rather than buried?

Blocking when:
- the plan assumes ideal conditions without acknowledging realistic obstacles
- hidden time costs would cause the plan to fail in practice
- critical prerequisites are missing or implicit

When `Trigger A` is true, also apply Lenses D through H below.

#### Lens D: Human-Facing Or Rendered Deliverable

Use for UI, decks, reports, documents, or anything whose quality depends on human-visible output.

- Is rendered evidence present and acceptance-relevant?
- Does the artifact remain readable and coherent on the actual visible surface?
- Do layout, density, hierarchy, and region roles support the stated purpose?
- Does the first visible surface carry one clear job instead of multiple competing jobs?

Blocking when:
- rendered evidence is missing where rendered evidence is required
- the visible artifact contradicts the pass claim
- the surface is structurally readable only in theory, not in actual human-visible form
- layout or information-role failure breaks the acceptance path

#### Lens E: Operational Workflow Or Execution-Control Artifact

Use for plans, schedules, workflow tools, operational documents, or operator-facing control artifacts.

- Is the execution path explicit?
- Are resume, save, import, export, rollback, fallback, or recovery semantics understandable when they matter?
- Are hidden dependencies, timing assumptions, or state-authority rules buried or missing?

Blocking when:
- the artifact looks neat but remains operationally unclear or non-auditable
- a workflow tool or execution artifact still hides operator cost or recovery burden
- launcher, workflow, or persistence expectations are materially unproven

#### Lens F: Failure And Risk

Use for system design, deployment, operational plans, or other high-consequence decisions.

- What are the main failure modes?
- Are severity, detectability, or mitigation expectations missing?
- Does the artifact model only the optimistic path?

Blocking when:
- high-impact failure modes are unmodeled
- identified risks lack credible mitigation
- one-scenario planning is presented as robust execution logic

#### Lens G: UX And Usability

Use for user-facing interfaces, workflow tools, decks, and other human-visible operational surfaces.

- Can the user tell where they are, what they can do next, and how to recover?
- Are hierarchy, grouping, and first-glance readability actually usable?
- Are destructive actions or dead ends handled safely?

Blocking when:
- a critical path produces dead ends, hidden state, or unsafe action adjacency
- visual grouping contradicts logical grouping on the main surface
- the first usable surface cannot communicate the next valid move

#### Lens H: Business Or Decision Logic

Use for proposals, plans, product direction, or decision-support artifacts.

- Is the real decision or objective explicit?
- Are stakeholder, cost, feasibility, or trade-off implications visible?
- Does the artifact support one coherent logic line rather than adjacent but disconnected claims?

Blocking when:
- the decision question is unclear or internally inconsistent
- major trade-offs are hidden on a consequential decision
- the artifact claims value without a coherent supporting logic chain

### 6. Classify Findings

For each material finding, state:
- finding
- severity
- owner lane
- missed-catch lane when relevant
- root cause when reasonably inferable
- evidence basis
- likely impact
- whether the issue blocks merge or final stage passage when that distinction matters
- corrective direction
- retest gate

### Severity Rules

- `blocking`
  - Acceptance-affecting defect
  - Must be corrected or explicitly disproven before the stage can pass
- `non-blocking`
  - Real issue, but does not currently invalidate the acceptance path
- Do not soften a blocking defect because effort was high or the artifact looks mostly complete.

### Review Chain Monotonicity

- Reviewer blocking classification is monotonic downstream.
- Downstream validation may strengthen a non-blocking concern into a blocking one.
- A reviewer blocking finding should not be relaxed unless factual error is proven with evidence.
- A reviewer-side `HOLD` recommendation should remain visible downstream until the missing prerequisite or required evidence is supplied, explicitly disproven, or narrowed with evidence.

### Missed-Catch Rule

- When a defect should have been caught earlier by an upstream lane, record that explicitly.
- Typical missed-catch owners:
  - `developer` for missing self-verification or obvious implementation hygiene defects
  - `researcher` for weak evidence framing or unresolved contradiction that should have been surfaced earlier
  - `tester` for weak proof framing, missing retest gates, or under-scoped execution evidence
  - `planner` or `team-lead` for wrong routing, wrong acceptance framing, or broken task boundaries

### 7. Define Retest Requirements

- Every blocking finding must carry a retest condition.
- Retest conditions should name the smallest evidence needed to clear the finding.
- Do not clear an acceptance-affecting defect without corrected evidence and a satisfied retest gate.
- For each retest gate, specify whether clearance belongs to:
  - reviewer reread
  - tester rerun
  - both reviewer reread and tester rerun

### 8. Build The Review Handoff

- Findings must come first.
- Start with the top-line review state:
  - `blocking findings present`
  - `non-blocking findings only`
  - `no acceptance-affecting defects found within review limits`
  - `HOLD`
- Identify the top blocking defect before listing secondary issues.
- Prefer a short high-signal finding list over broad commentary.
- If no issues are found, say so explicitly and note:
  - residual risk
  - test gaps
  - review limits
- Keep the handoff compact enough that the next lane can act without rereading the entire artifact set.
- Do not phrase the handoff as if review alone grants final validation authority.
- When final validation is materially required, make the handoff decision-ready for `validator`.
- When the handoff is not validation-ready, say why validation should not proceed yet and name the owner of the next corrective step.
- If execution proof is still required to clear a review-side blocker, name `tester` explicitly as the proof owner instead of leaving the rerun path implicit.
- If `Trigger A` or `Trigger B` was used, say so explicitly in the handoff so downstream lanes know what heavier review path was applied.

## Review Quality Standard

- Prioritize findings by delivery risk, correctness risk, and trust risk.
- For request-bound artifacts, check request-fit before polish: does the artifact answer the assigned `CORE-QUESTION` first, and does it avoid burying that answer under adjacent background or excluded scope?
- Check for silent subject narrowing as well: a polished artifact still fails request-fit if it quietly replaces the user's named subject with one subtype, scenario, or favorite example.
- Treat it as a review defect when the work drifts materially beyond the core of the question, even if the extra material is true or potentially useful.
- For office-format or page-read human-facing documents whose acceptance materially depends on structure, compression, or rendered composition quality, check whether benchmark intake or an explicit no-benchmark rationale is visible before treating the artifact as acceptably shaped.
- Check whether appendices, source lists, or follow-on sections remain proportional and trailing instead of taking over the main answer surface.
- Distinguish unsupported claims from merely incomplete explanation.
- Treat claim-evidence mismatch, contradiction, and hidden assumption drift as primary review targets.
- Treat a formally correct but practically weak artifact as a material finding when operator value is central.
- Challenge format-only success claims for reports, decks, documents, and workflow tools.
- State explicitly when evidence is insufficient to confirm a claim.
- Behave as an acceptance-critical sentry, not as the producer of baseline quality that should have been prevented upstream.
- When strong upstream self-check evidence credibly narrows the risk surface, prefer bounded delta review over habitually rereading unchanged low-risk areas.
- Escalate from lighter review to heavier review when recurrence, weak self-certification, or claim-evidence risk justifies it.

## Rendered And Acceptance Evidence Rules

- For visual or human-facing deliverables, omission of rendered evidence is a blocking acceptance defect.
- For office-format outputs, distinguish:
  - package-valid
  - text-extractable
  - native-openable
  - human-acceptable render
- Do not collapse those into one flattering pass.
- For operator-facing tools, do not treat a working-looking artifact as clean if launcher path, workflow continuity, or state semantics remain materially unproven.
- When the artifact is page-read, use page-image or equivalent rendered evidence to review what the reader actually encounters page by page.
- Treat capture-based visual review as mandatory, not optional polish, when visual impression or page-read usefulness is part of the requested value.
- For visualized, office-format, or page-read human-facing artifacts, keep text review mandatory alongside capture-render review. Do not let rendered review stand in for wording, logic, or request-fit review.
- Review page-level acceptance questions explicitly:
  - is the main conclusion or decision aid visible early enough
  - does repetition visibly accumulate across sections
  - do long prose blocks crowd out the answer
  - do appendices, source lists, or annexes visually dominate the main report
  - does section order match the reader's likely decision path
- Treat page-image review as an acceptance-critical lens, not as optional polish, when reader-first comprehension is part of the requested value.

## Governance Patch Review Rule

- When reviewing changes to `CLAUDE.md`, `SKILL.md`, `settings.json`, hooks, or agent files, inspect deleted or replaced content for information loss rather than trusting net line reduction.
- Classify removed meaning as:
  - duplicate and safely removable
  - unique and therefore protected
- Treat repeated lane-boundary, owner-contract, or acceptance-gate text as protected when that repetition keeps an owner file understandable in isolation.
- Shared wording across multiple owner files is not by itself evidence that the repeated text is safely removable.
- Treat optimization, compression, rewrite, or self-growth justifications as non-exempt: they do not lower the zero-information-loss bar for protected common contracts.
- If unique meaning was removed, displaced, or weakened without a justified destination owner, raise a blocking finding.
- For governance-sensitive patches, treat semantic overlap review and zero-information-loss checks as mandatory review gates.
- For governance-sensitive patches, also verify that patch class, owner surfaces, preserved meaning, and verification basis are explicit enough that another model could continue safely without hidden session context.
- For governance-sensitive patches, verify that the review packet or touched owner documentation keeps the source meaning inventory and the per-meaning destination owner map explicit whenever unique meaning moved, merged, or was re-homed.
- For self-growth, capability-hardening, or comparative-improvement patches, require the review packet to name the baseline, comparison surface, and fairness conditions before the claimed gain can be treated as evidenced.
- For self-growth, capability-hardening, or comparative-improvement patches, block if the claimed gain hides before/after delta ambiguity, throughput-regression risk, or missing promotion-readiness evidence.
- When self-growth or capability-hardening patches land, block closeout if the required bounded follow-on optimization result or explicit no-safer-reduction disposition is missing.
- When unresolved hardening or migration gaps remain, block closeout unless the record names the follow-up owner explicitly.

## Role-Scoped Self-Growth Loop

- Convert repeated missed-catch, false-severity, weak-taxonomy, or optimistic-pass defects into stronger review gates for this lane.
- If the same review miss recurs, keep reviewer acceptance on `HOLD` until the review rule is updated and a clean rerun proves the corrected gate.
- Leave a compact growth handoff naming:
  - the missed finding or wrong severity
  - the false-pass risk it created
  - the smallest review-rule rewrite needed

### Missed-Catch Record Fields

When recording a reviewer missed-catch, include:

- defect class
- source execution or run
- responsible upstream role
- missed-catch role
- trigger evidence
- why the existing review gate failed
- minimum correction

## Adversarial Verification Discipline

- Intentionally try to falsify at least one important claim per review.
- Perform at least one direct deep-dive into the underlying artifact rather than reviewing only summaries.
- Ask explicitly: what error would I have missed?
- Do not confuse checklist completion with verified correctness.

## Review Anti-Patterns

- becoming a second implementer
- leading with cosmetic comments while a material defect exists
- repeating the producer's own verification steps as if that were independent review
- treating `no obvious issue` as equivalent to `verified safe`
- approving on tone, effort, or apparent polish rather than evidence

## Skill Maintenance Rule

- When this skill itself is being patched, keep role-owned review procedure here and shared doctrine in `CLAUDE.md`.
- If a proposed addition mostly restates team-wide doctrine, move it back to the correct owner instead of bloating reviewer procedure.
