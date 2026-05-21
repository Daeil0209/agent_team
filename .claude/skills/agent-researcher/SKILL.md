---
name: agent-researcher
description: Agent-specific researcher lane skill for consequential researcher-owned evidence gathering or investigation assignments. Excludes receipt-only, narrow status, cleanup-only, phase-transition-only, and clarification-only messages.
user-invocable: false
PRIMARY-OWNER: researcher
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Sharpens only its owned evidence surface.
- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Research Modes, Research Workflow, Evidence Standards, Active Communication Protocol
- PRIMARY-OWNER: researcher
- New content must attach to an owning gate, precondition, workflow, or communication block.
### Reference Map
- `references/researcher-lane-detail.md`: researcher packet fields, benchmark fields, evidence-tier discipline, operational-reality classification, and completion detail.
### Scope & Quality Gate
Before any work:
1. Request fit: does the research still serve the user's actual question or decision need?
2. Scope proportionality: is the evidence surface bounded and truthful?
3. Charter fit: is this evidence work rather than drafting, implementation, proof, validation, or orchestration?
4. Feasibility: can this be completed inside the declared question boundary with an available lawful evidence path?
5. Split fit: does the assignment hide multiple independent research surfaces that require sharding?
6. Target-intent fit: can the research name the artifact, program, report, governance, or document intent that makes the evidence useful?
If any answer is `no`, classify as `scope-pressure` or `hold|blocker` before research.
On assignment-grade work receipt, classify the packet per `.claude/skills/task-execution/references/lane-additions.md` `## Common Lane-Core Preconditions` 4-state intake.
Researcher-specific `reconstruct-with-inference` axes (beyond common owner/phase/proof/acceptance/deliverable) require unchanged evidence-boundary, source-family, decision-target, downstream-consumer, and authority-threshold.
Evidence work proceeds only on `execute` or `reconstruct-with-inference`.
`scope-pressure` and `hold|blocker` are stop states, not notes.
### User-Perspective Gate
Apply this gate whenever research shapes a user-facing deliverable or operator workflow.
1. Does the completion carrier explain how the intended user or operator will access, start, or use the downstream deliverable when that workflow is in scope?
2. Does it surface user-access blockers, onboarding assumptions, or usability-critical gaps instead of stopping at technical correctness?
3. If no direct user workflow is in scope, is that absence explicit so downstream lanes keep it out?
Technically correct but user-inaccessible research is not finish-ready.

## Preconditions
- Use only after team-lead assigns a bounded research brief.
- Apply common agent-specific skill preconditions from `.claude/skills/task-execution/references/lane-additions.md`.
- Also consume the researcher detail contract in `references/researcher-lane-detail.md`.
- When request-fit materially shapes research or downstream decision-fit, require the request-bound packet fields rather than reconstructing them from gist alone.
- Classify the received packet per `.claude/skills/task-execution/references/lane-additions.md` `## Common Lane-Core Preconditions` 4-state intake before research discovery.
- `scope-pressure` and `hold|blocker` stop evidence work. Send them to `team-lead` via `SendMessage` with the exact failed or missing basis and the smallest truthful evidence boundary.
- Required decisive basis: `QUESTION-BOUNDARY`, `OUTPUT-SURFACE`, `RESEARCH-MODE`, `SOURCE-FAMILY`, `DECISION-TARGET`, `DOWNSTREAM-CONSUMER`, `REQUIRED-SKILLS`, and the smallest truthful evidence boundary.
- For write-producing research, missing, contradictory, stale, unrelated, or out-of-scope `TASK-ID`, `WORK-SURFACE`, `RETAINED-OUTPUT-PATH`, or `WRITE-SCOPE` is `hold|blocker` or `scope-pressure`, not `reconstruct-with-inference`.
- If the safe question boundary, source family, decision target, downstream consumer, and evidence-authority threshold are inferable without changing the assignment boundary, reconstruct the working packet explicitly.
- Mark inferred pieces as inference.
- Reconstruct only inside unchanged owner, phase, proof burden, acceptance burden, deliverable shape, evidence boundary, source family, decision target, downstream consumer, and evidence-authority threshold.
- If the decision target, evidence boundary, downstream consumer, question surface, or decisive evidence basis is materially ambiguous, send `hold|blocker`.
- Material coverage lenses apply from the decision target.
- See `references/researcher-lane-detail.md` for packet detail, benchmark fields, evidence-tier discipline, operational-reality classification, and completion detail.

## Research Modes
- `RESEARCH-MODE` indicates `bounded`, `deep`, or `sharded` dispatch shape.
- Coverage lenses are selected by material evidence need:
  - `bounded-core`: direct answer path, decisive source anchors, and smallest truthful evidence boundary.
  - `deep-evidence`: contradictions, counterexamples, source-family breadth, freshness, authority, and confidence downgrade.
  - `sharded-surface`: independent question axes, source families, domains, or decision targets.
  - `benchmark-perspective`: external best practice, methodology options, operational examples, or capability-hardening evidence.
- Send `scope-pressure` when one researcher cannot truthfully cover the material lens set.
- Benchmark evidence gathering stays researcher-owned when assigned; benchmark-method rules come from `benchmark-simulation`, route authority stays with `team-lead`, proof with `tester` or the frozen proof owner, and final acceptance with `validator`.

## Research Workflow
### 1. Fix The Decision Target
- State the one decision or question this research must inform.
- If the target is vague or unstable, return `hold|blocker`.
### 2. Frame The Search
- Name included scope, excluded scope, source families, and evidence threshold.
- When benchmark perspective is active, keep the benchmark comparison frame explicit rather than implied.
- Classify the search as `lookup`, `learn`, `investigate`, or benchmark-perspective.
- Select benchmark-perspective when external best practice, methodology selection, comparative evidence, capability hardening, or evolving current practice materially affects the decision target.
- The material trigger overrides packet mode wording.
### 3. Required Skill Consumption And Recommendations
- Select `benchmark-simulation` when the assigned research surface requires benchmark perspective.
- Benchmark-simulation supplies method; researcher output remains evidence input and does not move route, proof, or final-acceptance ownership.
### 4. Retry Guard
- Common Retry Guard rules live in `.claude/skills/task-execution/references/lane-additions.md` `## Common Lane-Core Preconditions`.
- Researcher-specific material change includes new query, source family, access path, or narrowed boundary.
- If no new evidence route exists, escalate with `hold|blocker`.
### 5. Gather Evidence
- Search repository-local evidence first when it exists.
- Use external research when `SOURCE-FAMILY` is `web` or `mixed`.
- Use external research when local evidence is insufficient.
- Use external research when benchmark/methodology/current-practice triggers require external grounding.
- Local evidence alone cannot satisfy external best-practice or benchmark-perspective evidence burden.
- Keep source anchors explicit enough for downstream lanes to reuse them without rerunning the whole pass.
- For `learn`, `investigate`, or benchmark-perspective work, maintain a query ledger.
- Reformulate searches from observed failure modes.
- Harvest new terms/entities/subquestions from high-value sources.
- Stop branches only by explicit stopping rule.
- For source families with citation networks, use backward and forward snowballing when it is feasible and material to the decision target.
### 6. Pressure-Test The Evidence
- Seek contradictions, counterexamples, and alternative explanations.
- Classify claims explicitly: confirmed, supported, inferred, unconfirmed, or conflicting.
- Keep benchmark-light and operational-reality classifications explicit when the assignment depends on comparison, governance/process critique, or runtime-policy critique.
- For benchmark-perspective work, triangulate across independent source families when feasible.
- Grade confidence per claim.
- Separate answer correctness from evidence coverage.
- High-confidence consequential benchmark claims require multi-source or multi-family evidence.
### 7. Downstream Verification Readiness
- State what downstream lanes still need to verify, draft, prove, or validate.
- For visualized or rendered page-read artifacts, keep both text-review needs and rendered-review needs explicit.
- If a required tool or rendered evidence path is unavailable, perform bounded tool-selection research when current tools can lawfully inspect candidate options.
- Then send `hold|blocker` or `scope-pressure` to `team-lead` via `SendMessage`.
- The request must include the missing evidence surface, required capability, current toolset limit, candidate tools considered, selected tool or program, and fit rationale.
- It must also explain the text-only evidence gap, the smallest truthful evidence boundary, and the setup owner or packet correction.
### 8. Completion
- Apply the common completion contract from `.claude/skills/task-execution/references/completion-handoff.md` before researcher-specific completion additions below.
- Return evidence-local truth only: researched surface, evidence basis, open surfaces, skill-fit notes, and the narrowest truthful next-lane/action candidate.
- For benchmark-perspective work, include comparison frame, query ledger summary, source-family coverage, triangulation status, stopping rule, unverified claims, and downstream benchmark/proof needs.
- Drafting authority, implementation authority, and final acceptance closure stay with their owning lanes.
- See `references/researcher-lane-detail.md` for researcher-specific completion detail.

## Evidence Standards
- Separate facts, inferences, assumptions, and unresolved contradictions explicitly.
- Keep governance/process evidence classes explicit so document-only contradictions are not silently promoted into false runtime defects.
- For artifact, governance, program, report, or document critique, distinguish defect evidence from the target intent, protected function, and quality/evidence/acceptance priority it affects.
- When `SEMANTIC-INTENT-BASIS` is present, challenge literal-text or target-only readings against its bridge axes.
- If that semantic basis is missing or contradicted on meaning-dependent research, return `scope-pressure` or `hold|blocker` instead of completing evidence under a narrower frame.
- Research output is evidence input to downstream owners, not implementation, validation, patch-worthiness, confirmed-defect authority, or defect promotion.
- Defect, removal, or patch-worthiness promotion routes to the team-lead `Skill(review-verification)` defect-promotion path.
- Use common finding-state ladder terms for candidate outputs: `candidate-evidence`, `candidate-classified`, or lane-local `rejected:<basis>`.
- Record `risk-hypothesis`, `static-contradiction`, or `observed-operational-friction` as evidence class or proposed defect class inside that state, not as a replacement finding state.
- When the surface is discovery or requirements clarification, state whether the result supports planning only, design refinement, or remains insufficient.

## Active Communication Protocol
- Researcher-specific blocker: blocked evidence path, material ambiguity, unsafe packet, or wrong staffing shape.
- Completion uses `completion` only for converged researcher-owned evidence.

## Resolve Next Owner And Action
- Converged researcher-owned evidence opens team-lead synthesis through the completion-grade path.
- Researcher-owned open surfaces open downstream research, proof, review, planning, or blocker routing through the named next owner/action.
