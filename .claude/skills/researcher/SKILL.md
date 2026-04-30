---
name: researcher
description: Use only for consequential researcher-owned evidence gathering or investigation assignments; not for receipt-only, control-only, narrow status, lifecycle-only, phase-transition-only, or clarification-only messages.
user-invocable: false
PRIMARY-OWNER: researcher
---
## Structural Contract
- Inherits `CLAUDE.md`, the active owner role, and the common inheritance floor in `CLAUDE.md` `Priority And Ownership`. This skill may sharpen its owned procedure or specialist surface, but it must not weaken that floor or the owning role's stop conditions.
- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Research Modes, Research Workflow, Evidence Standards, Active Communication Protocol
- PRIMARY-OWNER: researcher
- Structural changes require governance review.
- New content must attach to an owning gate, precondition, workflow, or communication block.
### Reference Map
- `references/researcher-lane-detail.md`: researcher packet fields, benchmark fields, evidence-hardening, operational-reality classification, and handoff detail.
### Scope & Quality Gate
Before any work:
1. Request fit: does the research still serve the user's actual question or decision need?
2. Scope proportionality: is the evidence surface bounded and truthful?
3. Charter fit: is this evidence work rather than drafting, implementation, proof, validation, or orchestration?
4. Feasibility: can this be completed inside the declared question boundary and turn budget?
5. Split fit: does the assignment hide multiple independent research surfaces that should be sharded?
If any answer is `no`, do not execute the packet as research.
On assignment-grade work receipt, classify the packet before execution:
- bounded single-target or tightly coupled deep research -> `execute`
- safe inferred question boundary without owner, phase, proof, acceptance, deliverable, or evidence-boundary change -> `reconstruct-with-inference`
- hidden multi-target, mixed drafting/implementation/acceptance ownership, shardable overload, or hidden prerequisite -> `scope-pressure`
- materially ambiguous decision target, evidence boundary, downstream consumer, or question surface -> `hold|blocker`
- explicitly authorized parallel-agent work collapsing multiple independent surfaces onto one researcher -> `scope-pressure` with `PRESSURE-TYPE: parallel-split-needed` and `REPLAN-REQUIRED: yes`
Evidence work may proceed only on `execute` or `reconstruct-with-inference`. `scope-pressure` and `hold|blocker` are stop states, not notes.
### User-Perspective Gate
Apply this gate whenever research shapes a user-facing deliverable or operator workflow.
1. Does the handoff explain how the intended user or operator will access, start, or use the downstream deliverable when that workflow is in scope?
2. Does it surface user-access blockers, onboarding assumptions, or usability-critical gaps instead of stopping at technical correctness?
3. If no direct user workflow is in scope, is that absence explicit so downstream lanes do not invent one by habit?
Technically correct but user-inaccessible research is not finish-ready.

## Preconditions
- Use only after team-lead assigns a bounded research brief.
- Consume the common base packet from `.claude/skills/task-execution/references/assignment-packet.md` plus the researcher detail contract in `references/researcher-lane-detail.md`; `agents/researcher.md` is the role spine, not the packet-field catalog.
- You receive the agent-facing packet, not the full internal planning record. Do not reconstruct or overwrite global routing, staffing, or acceptance ownership from memory or habit.
- This lane-core skill is not always-loaded context. Use it only for consequential researcher-owned work; receipt-only, control-only, narrow status, lifecycle-only, phase-transition-only, or clarification-only messages do not activate it unless they assign or reopen bounded research work.
- Once this skill is loaded, it is the highest-priority lane-local procedure before packet `REQUIRED-SKILLS`, optional methodology skills, or specialist skills; it still cannot override `CLAUDE.md`, role boundaries, `task-execution`, `work-planning`, or `self-verification`.
- When request-fit materially shapes research or downstream decision-fit, require the request-bound packet fields rather than reconstructing them from gist alone.
- Before research discovery, use lane-local self-verification to classify the received packet as `execute`, `reconstruct-with-inference`, `scope-pressure`, or `hold|blocker`.
- `scope-pressure` and `hold|blocker` stop evidence work. Send them to `team-lead` via `SendMessage` with the exact invalid or missing basis and the smallest truthful evidence boundary.
- Required decisive basis: `QUESTION-BOUNDARY`, `OUTPUT-SURFACE`, `RESEARCH-MODE`, `SOURCE-FAMILY`, `DECISION-TARGET`, `DOWNSTREAM-CONSUMER`, `REQUIRED-SKILLS`, and the smallest truthful evidence boundary.
- If the safe question boundary is inferable, reconstruct the working packet explicitly and mark inferred pieces as inference. Do this only when it does not change owner, phase, proof burden, acceptance burden, deliverable shape, or evidence boundary.
- If the decision target, evidence boundary, downstream consumer, question surface, or decisive evidence basis is materially ambiguous, send `hold|blocker`.
- Evaluate packet `REQUIRED-SKILLS` and any `SKILL-RECOMMENDATIONS` against the assigned research surface before loading methodology or specialist skills.
- Load packet `REQUIRED-SKILLS` after this lane-core procedure is active; packet `REQUIRED-SKILLS` names additional non-lane-core skills, not this researcher lane-core skill.
- Methodology recommendations are advisory only and must not change lane ownership, required skill contract, proof ownership, or acceptance ownership.
- If no recommended skill fits and another clearly does, report that upward before loading it.
- Methodology skills may deepen evidence quality, but they never replace `work-planning` or `self-verification`.
- Benchmark perspective is mandatory whenever external best-practice, methodology selection, comparative evidence, capability-hardening, or evolving current practice materially shapes the decision target. Treat packet mode fields as context only; they do not limit the lane's obligation to apply all materially triggered coverage lenses. Use `SKILL-RECOMMENDATIONS`, packet `REQUIRED-SKILLS`, and `benchmark-simulation` only inside the frozen packet basis or verified phase-local refinement.
- See `references/researcher-lane-detail.md` for packet detail, benchmark fields, evidence-hardening patterns, operational-reality classification, and handoff detail.

## Research Modes
- `RESEARCH-MODE` is packet context and dispatch shape, not a limit on researcher reasoning.
- Every assignment must pass the materially applicable coverage lenses:
  - `bounded-core`: identify the direct answer path, decisive source anchors, and smallest truthful evidence boundary.
  - `deep-evidence`: test contradictions, counterexamples, source-family breadth, freshness, authority, and confidence downgrades inside the decision target.
  - `sharded-surface`: identify independent question axes, source families, domains, or decision targets; send `scope-pressure` to `team-lead` via `SendMessage` when one researcher cannot cover them truthfully.
  - `benchmark-perspective`: compare external best practice, methodology options, operational examples, or capability-hardening evidence whenever those factors materially shape the decision target.
- Packet mode fields may indicate the assigned dispatch shape, but they never authorize skipping a materially triggered coverage lens.
- Coverage lenses expand evidence discipline only; they do not transfer benchmark ownership, routing authority, proof authority, or final acceptance to researcher.

## Research Workflow
### 1. Fix The Decision Target
- State the one decision or question this research must inform.
- If the target is vague or unstable, return `hold|blocker`.
### 2. Frame The Search
- Name included scope, excluded scope, source families, and evidence threshold.
- When benchmark perspective is active, keep the benchmark comparison frame explicit rather than implied.
- Classify the search as `lookup`, `learn`, `investigate`, or benchmark-perspective. When external best practice, methodology selection, comparative evidence, capability hardening, or evolving current practice materially affects the decision target, benchmark perspective is mandatory regardless of packet mode wording.
### 3. Skill Recommendation Evaluation
- Evaluate packet `REQUIRED-SKILLS` and any `SKILL-RECOMMENDATIONS` against the research surface.
- Treat packet `REQUIRED-SKILLS` as additional non-lane-core skills only; do not load or list this lane-core skill through `REQUIRED-SKILLS`.
- Load at most one governing methodology skill per phase unless the packet basis materially requires more.
- If no recommended skill fits and another clearly does, report that upward before loading it.
- Methodology skills never replace `work-planning` or `self-verification`.
- When benchmark perspective requires `benchmark-simulation`, load it only as a methodology overlay through the packet skill basis or a verified phase-local refinement. Do not self-promote into benchmark owner or invent routing authority.
### 4. Plan Verification
- Load `self-verification` and run Critical Challenge on the plan before executing the research.
- Do not repeat materially similar failed research passes more than 3 times without narrowing the boundary or escalating with `hold|blocker`.
### 5. Gather Evidence
- Search repository-local evidence first when it exists.
- Use external research when `SOURCE-FAMILY` is `web` or `mixed`, local evidence is insufficient, or benchmark/methodology/current-practice triggers require external grounding. Local evidence alone cannot satisfy an external best-practice or benchmark-perspective evidence burden.
- Keep source anchors explicit enough for downstream lanes to reuse them without rerunning the whole pass.
- For `learn`, `investigate`, or benchmark-perspective work, maintain a query ledger, reformulate searches from observed failure modes, harvest new terms/entities/subquestions from high-value sources, and stop branches only by an explicit stopping rule.
- For source families with citation networks, use backward and forward snowballing when it is feasible and material to the decision target.
### 6. Pressure-Test The Evidence
- Seek contradictions, counterexamples, and alternative explanations.
- Classify claims explicitly: confirmed, supported, inferred, unconfirmed, or conflicting.
- Keep benchmark-light and operational-reality classifications explicit when the assignment depends on comparison, governance/process critique, or runtime-policy critique.
- For benchmark-perspective work, triangulate across independent source families when feasible, grade confidence per claim, and separate answer correctness from evidence coverage. Single-source or single-family evidence cannot support a high-confidence consequential benchmark claim.
### 7. Downstream Verification Readiness
- State what downstream lanes still need to verify, draft, prove, or validate.
- For visualized or page-read artifacts, keep both text-review needs and rendered-review needs explicit.
- If a required tool or rendered evidence path is unavailable to researcher, perform bounded tool-selection research when current tools can lawfully inspect or search candidate options. Then send `hold|blocker` or `scope-pressure` to `team-lead` via `SendMessage`.
- The request must include the missing evidence surface, required capability, current toolset limit, candidate tools considered, recommended tool or program, fit rationale, why text-only evidence is invalid, smallest truthful evidence boundary, and recommended setup owner or packet correction.
### 8. Handoff
- Load `self-verification` and run the full procedure before any completion-style handoff.
- Send consequential upward results to team-lead via `SendMessage`; do not write continuity surfaces directly.
- Use the common completion-grade evidence block from `.claude/skills/task-execution/references/completion-handoff.md`.
- Return evidence-local truth only: researched surface, evidence basis, open surfaces, skill recommendations, and the narrowest truthful next-lane recommendation.
- For benchmark-perspective work, include comparison frame, query ledger summary, source-family coverage, triangulation status, stopping rule, unverified claims, and downstream benchmark/proof needs.
- Do not convert evidence work into drafting authority, implementation authority, or final acceptance closure from inside research. If the truthful next step changes owner, phase, deliverable shape, or acceptance chain, use `scope-pressure` or `hold|blocker` instead of ordinary completion.
- If the procedure state is not converged, use `hold|blocker` instead of a completion-style report.
- Wait for lifecycle direction after handoff.
- See `references/researcher-lane-detail.md` for researcher-specific handoff detail.

## Evidence Standards
- Separate facts, inferences, assumptions, and unresolved contradictions explicitly.
- Keep governance/process evidence classes explicit so document-only contradictions are not silently promoted into false runtime defects.
- Research output is evidence input to downstream owners, not implementation or validation authority.
- When the surface is discovery or requirements clarification, state whether the result supports planning only, design refinement, or remains insufficient.

## Active Communication Protocol
- `dispatch-ack` first on fresh assignment-grade work receipt.
- Use the minimal receipt spine from `.claude/skills/task-execution/references/message-classes.md` only when the required receipt spine is present.
- `dispatch-ack` is receipt only. If intake or agent-local planning immediately finds a blocker, send a separate `hold|blocker`; do not attach blocker text to `dispatch-ack`.
- `control-ack` only for structured control receipt.
- `status` for bounded progress only.
- `scope-pressure` for unsafe packet or staffing shape.
- `hold|blocker` for blocked evidence path or material ambiguity.
- `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion` only for converged lane-owned output.
- Follow `.claude/skills/task-execution/references/message-classes.md`, `.claude/skills/task-execution/references/scope-pressure.md`, `.claude/skills/task-execution/references/completion-handoff.md`, and `.claude/skills/task-execution/references/lifecycle-control.md` for common message classes, blocker fields, completion-grade evidence, and lifecycle-safe reporting.
