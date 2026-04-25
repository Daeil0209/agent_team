---
name: researcher
description: Evidence gathering and investigation procedure.
user-invocable: false
PRIMARY-OWNER: researcher
---
## Structural Contract
- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Research Modes, Research Workflow, Evidence Standards, Active Communication Protocol
- PRIMARY-OWNER: researcher
- Structural changes require governance review.
- New content must attach to an owning gate, precondition, workflow, or communication block.
### Scope & Quality Gate
Before any work:
1. Request fit: does the research still serve the user's actual question or decision need?
2. Scope proportionality: is the evidence surface bounded and truthful?
3. Charter fit: is this evidence work rather than drafting, implementation, proof, validation, or orchestration?
4. Feasibility: can this be completed inside the declared question boundary and turn budget?
5. Split fit: does the assignment hide multiple independent research surfaces that should be sharded?
If any answer is `no`, do not execute the packet as research.
On assignment receipt, classify the packet before execution:
- bounded single-target or tightly coupled deep research -> execute
- hidden multi-target, mixed drafting/implementation/acceptance ownership, shardable overload, or hidden prerequisite -> `scope-pressure`
- materially ambiguous decision target, evidence boundary, downstream consumer, or question surface -> `hold|blocker`
- intended parallel work collapsing onto one researcher strongly enough to create a schedule bottleneck -> `scope-pressure` with `PRESSURE-TYPE: parallel-split-needed` and `REPLAN-REQUIRED: yes`
### User-Perspective Gate
Apply this gate whenever research shapes a user-facing deliverable or operator workflow.
1. Does the handoff explain how the intended user or operator will access, start, or use the downstream deliverable when that workflow is in scope?
2. Does it surface user-access blockers, onboarding assumptions, or usability-critical gaps instead of stopping at technical correctness?
3. If no direct user workflow is in scope, is that absence explicit so downstream lanes do not invent one by habit?
Technically correct but user-inaccessible research is not finish-ready.

## Preconditions
- Use only after team-lead assigns a bounded research brief.
- Consume the common base packet from `.claude/skills/task-execution/reference.md` plus the researcher additions in `.claude/agents/researcher.md`.
- You receive the worker-facing packet, not the full internal planning record. Do not reconstruct or overwrite global routing, staffing, or acceptance ownership from memory or habit.
- When request-fit materially shapes research or downstream decision-fit, require the request-bound packet fields rather than reconstructing them from gist alone.
- If the safe question boundary is inferable, reconstruct the working packet explicitly and mark inferred pieces as inference.
- If the decision target, evidence boundary, downstream consumer, or question surface is materially ambiguous, send `hold|blocker`.
- Load packet `REQUIRED-SKILLS`; methodology skills may deepen evidence quality, but they never replace `work-planning` or `self-verification`.
- See `reference.md` for packet detail, benchmark fields, evidence-hardening patterns, operational-reality classification, and handoff detail.

## Research Modes
- `bounded`: one decision target; tightly coupled subquestions only.
- `deep`: one decision target requiring broader evidence or contradiction mapping.
- `sharded`: multiple independent decision targets, source families, domains, or question axes with explicit merge ownership.
- `deep` and `sharded` expand evidence coverage, not deliverable class or document length.

## Research Workflow
### 1. Fix The Decision Target
- State the one decision or question this research must inform.
- If the target is vague or unstable, return `hold|blocker`.
### 2. Frame The Search
- Name included scope, excluded scope, source families, and evidence threshold.
- When benchmark shaping is active, keep the benchmark comparison frame explicit rather than implied.
### 3. Skill Recommendation Evaluation
- Evaluate packet `REQUIRED-SKILLS` and any `SKILL-RECOMMENDATIONS` against the research surface.
- Load at most one governing methodology skill per phase unless the packet basis materially requires more.
- If no recommended skill fits and another clearly does, report that upward before loading it.
- Methodology skills never replace `work-planning` or `self-verification`.
### 4. Plan Verification
- Load `self-verification` and run Critical Challenge on the plan before executing the research.
- Do not repeat materially similar failed research passes more than 3 times without narrowing the boundary or escalating with `hold|blocker`.
### 5. Gather Evidence
- Search repository-local evidence first when it exists.
- Use external research only when local evidence is insufficient.
- Keep source anchors explicit enough for downstream lanes to reuse them without rerunning the whole pass.
### 6. Pressure-Test The Evidence
- Seek contradictions, counterexamples, and alternative explanations.
- Classify claims explicitly: confirmed, supported, inferred, unconfirmed, or conflicting.
- Keep benchmark-light and operational-reality classifications explicit when the assignment depends on comparison, governance/process critique, or runtime-policy critique.
### 7. Downstream Verification Readiness
- State what downstream lanes still need to verify, draft, prove, or validate.
- For visualized or page-read artifacts, keep both text-review needs and rendered-review needs explicit.
### 8. Handoff
- Send consequential upward results to team-lead via `SendMessage`; do not write continuity surfaces directly.
- Use the common completion-grade evidence block from `.claude/skills/task-execution/reference.md`.
- Return evidence-local truth only: researched surface, evidence basis, open surfaces, skill recommendations, and the narrowest truthful next-lane recommendation.
- Do not convert evidence work into drafting authority, implementation authority, or final acceptance closure from inside research. If the truthful next step changes owner, phase, deliverable shape, or acceptance chain, use `scope-pressure` or `hold|blocker` instead of ordinary completion.
- If the procedure state is not converged, use `hold|blocker` instead of a completion-style report.
- Wait for lifecycle direction after handoff.
- See `reference.md` for researcher-specific handoff detail.

## Evidence Standards
- Separate facts, inferences, assumptions, and unresolved contradictions explicitly.
- Keep governance/process evidence classes explicit so document-only contradictions are not silently promoted into false runtime defects.
- Research output is evidence input to downstream owners, not implementation or validation authority.
- When the surface is discovery or requirements clarification, state whether the result supports planning only, design refinement, or remains insufficient.

## Active Communication Protocol
- `dispatch-ack` first on fresh assignment receipt.
- Use the minimal receipt spine from `.claude/skills/task-execution/reference.md` when those fields are available.
- `dispatch-ack` is receipt only. If intake or worker-local planning immediately finds a blocker, send a separate `hold|blocker`; do not attach blocker text to `dispatch-ack`.
- `control-ack` only for structured control receipt.
- `status` for bounded progress only.
- `scope-pressure` for unsafe packet or staffing shape.
- `hold|blocker` for blocked evidence path or material ambiguity.
- `handoff|completion` only for converged lane-owned output.
- Follow `.claude/skills/task-execution/reference.md` for common message classes, blocker fields, completion-grade evidence, and lifecycle-safe reporting.
