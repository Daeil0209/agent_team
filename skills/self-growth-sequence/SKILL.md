---
name: self-growth-sequence
description: Self-growth procedures for team capability hardening and behavioral defect correction.
user-invocable: false
---

## Activation

Load this skill when a behavioral defect is detected (self-detected or user-corrected). Trigger sources:
- UserPromptSubmit hook detects correction patterns and injects "SELF-GROWTH TRIGGER" reminder
- team-lead agent doc RPA-4 "Self-Growth Trigger And Execution Gate" contains the atomic classify-dispatch rule

After self-growth work completes, changes are applied through the normal `Change Sequence` which remains in the always-loaded `team-governance-sequences` skill.

## Self-Growth Sequence

The `Self-Growth Sequence` applies when the team hardens its own rules, skills, charters, or capability boundaries.

- Treat self-growth as a quality-and-capability upgrade path first. Resource or cost optimization is secondary and must not outrun the upgraded quality bar.
- When self-growth expands a lane's charter, capability, or reusable content, require a bounded follow-on optimization decision before the topic is fully closed. Run the optimization pass when material avoidable cost, runtime burden, or redundancy is visible; otherwise close with an explicit `FOLLOW-ON-OPTIMIZATION: not-needed` record while preserving the upgraded quality bar and protected meaning.

### Trigger discipline

- On recognizing a behavioral defect (self-detected or user-corrected): Classify (missing rule or non-compliance?) → Dispatch a separate agent for correction via `Self-Growth Sequence` in parallel as a sidecar — current work continues without stopping. Self-growth must not preempt freezing the active user task's request-fit, deliverable shape, or immediate correctness/safety basis. If the defect directly blocks correct or safe handling of the current request, stabilize that basis first, then dispatch or explicitly queue the self-growth lane at the nearest safe boundary. Classify and Dispatch/Queue are atomic — analysis without dispatch or explicit queueing is failure, not action. If an equivalent rule exists, the defect is non-compliance — harden adherence instead of adding duplicates.
- Self-growth dispatch may be immediate, but governance-sensitive file modification is still execution-gated. Use the dispatch to classify, route, inspect, and prepare the bounded patch packet; do not execute the modification on approval-gated surfaces until the explicit user confirmation step is satisfied.
- When a missing reusable skill blocks execution, authorize skill introduction under `Self-Growth Sequence` with explicit ownership: gap confirmation, target owner, bounded scope, review path, and verification.
- When you authorize new skill introduction, keep ownership explicit: capability-gap confirmation, target owner, bounded creation scope, review path, and post-adoption verification must all be named before execution begins.
- When more than one lane could plausibly own the growth topic, do not let the most familiar lane win by habit. Open the competitive bid packet and record why the chosen route was better for long-run cumulative team benefit.

### Self-Growth Ownership Adjudication

- Ownership claims for improvement work must be explicitly adjudicated by the supervisor; approve, reject, merge, reduce, defer, and reassign are all valid outcomes.
- Ownership of improvement work must be explicit; ownerless gaps are not allowed at round close.
- The supervisor remains the staffing, mediation, adjudication, and merge-governance owner for self-growth rounds and must not become the hidden primary producer or bottleneck.

### Required order

1. Identify the active improvement topic from evidence.
2. Require relevant lanes to inspect the topic before ownership is finalized.
3. Adjudicate ownership explicitly.
4. Keep self-growth role-scoped.
   A lane hardens its own charter-bound failures first.
5. Apply the actual change through the normal `Change Sequence`.
6. After the quality-raising change lands, make a bounded follow-on optimization decision. Run the optimization pass only when material avoidable cost, runtime burden, or redundancy is now visible; otherwise record `FOLLOW-ON-OPTIMIZATION: not-needed` and close without manufacturing a redundant extra loop.
7. When the active topic came from recurrence, missed-catch, or rejected-challenge evidence, require a rerun, retest, or equivalent fresh evidence gate before treating the hardening topic as fully closed.
8. Close only after identified improvements, unresolved missed-catches, and deferred passivity defects are either hardened into the correct parent document or explicitly assigned follow-up ownership.

### Capability-Gap Fast Path

- When a missing reusable skill is the active improvement topic, `team-lead` may authorize a bounded rapid-skill sprint inside the `Self-Growth Sequence`.
- When that missing skill is a prerequisite for safe, credible, or non-duplicative completion of the active task, stop only the genuinely blocked work surface and complete the skill update or introduction before that surface resumes normal downstream execution. Unrelated or already-safe work should continue instead of being stalled by habit.
- The fast path still requires:
  1. gap confirmation
  2. overlap check against existing skills, agents, and rules
  3. explicit owner assignment
  4. bounded creation scope
  5. review of the resulting skill content
  6. post-adoption verification that the new skill actually closes the gap
- Fast path means reduced delay, not reduced governance. Do not skip owner fit, overlap review, or information-preservation checks merely because the need is urgent.
- Do not retroactively create a skill just to justify ad hoc behavior that already bypassed the missing capability.
- Default rapid-skill routing:
  - `researcher` confirms the gap and checks for overlap with existing assets
  - `team-lead` fixes owner, scope, and adoption path
  - `developer` creates or updates the skill assets
  - `reviewer` checks placement, overlap, and information-loss risk
  - `validator` is assigned when acceptance risk is meaningful

### Self-growth constraints

- Do not allow undocumented doctrine drift.
- Do not let self-growth become a hidden excuse for unrelated refactors.
- Do not declare improvement complete without evidence of the actual hardening change.
- Do not introduce a new skill when a bounded update to an existing owner would solve the same problem more cleanly.
- Do not use self-growth, optimization, compression, or rewrite work as justification for removing protected local restatements that keep owner files safe to read in isolation.
- When self-growth affects reusable ownership, protect average-capability and prevent lane hollowing.

### Benchmark Protocol Detail (migrated from CLAUDE.md)
- Comparative self-growth, reusable-ownership, and quality-hardening claims default to benchmark-first discipline. Name the baseline and comparison surface before the hardening claim is allowed to harden into routing or ownership.
- Benchmark conclusions must declare provenance. If benchmark inputs are not directly inspectable or credibly cited, downgrade to `HOLD`, `UNVERIFIED`, or simulator-only status.
- Default preparation sequence: benchmark -> cross-check and anti-hallucination confirmation -> concrete modification proposal -> pre-edit loss-risk gate -> bounded modification -> verification -> only then bounded optimization.
- Early investigation and benchmark stages identify the actual deficiency and determine whether self-growth is warranted. Do not jump from a recurring symptom into edits.
- `BENCHMARK-PROVENANCE: simulator-only` or `CROSS-CHECK-STATUS: simulator-unconfirmed` is still a benchmark-stage `HOLD`, not edit authorization.
- When a self-growth round claims advancement, keep the current readiness label, visible evidence delta, throughput or neighbor-regression visibility, and follow-on optimization closure explicit in the active sequence packet before the round is handed back for lead judgment.

### Readiness And Promotion Handoff

- Readiness, promotion, and adaptation policy stay in `agents/team-lead.md` `RPA-4` because the lead owns those judgments directly during self-growth supervision.
- This sequence skill uses that policy only as execution-gating context; it does not become a second owner of promotion doctrine.
- When a self-growth round reaches hardening or promotion evaluation, keep the target capability surface, current readiness label, evidence basis, and follow-on optimization closure explicit before the round is treated as closed.
