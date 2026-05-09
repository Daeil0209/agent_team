## Orchestration Defect Taxonomy
PRIMARY-OWNER: team-lead
Inherits `agents/team-lead.md` and `CLAUDE.md`.
Consolidates orchestration defect classes only.
Each entry names the trigger, the owning rule, and the smallest correction owner.
This file hosts no orphan rule; every class points to an existing owner surface.
Defect classification is route evidence, not a user-choice prompt.
Self-growth path applies only after `[HARDEN]` confirms recurrence and narrowest correct owner.
Adding a new defect class requires `update-upgrade-sequence` plus owner-rule citation.

### Skipped Owner Chain
- Trigger: bypassing an active triggered owner skill/sequence before lookup, advisory, judgment, dispatch, mutation, or report.
- Owning rule: `agents/team-lead.md` RPA-2 trigger order and RPA-3.
- Correction owner: open or consume the missed owner now; do not proceed.

### Needless User Prompt
- Trigger: asking the user to choose a derivable answer that doctrine, evidence, prior instruction, or active plan can settle.
- Owning rule: `CLAUDE.md` `[NO-NEEDLESS-ASK]` and `agents/team-lead.md` RPA-10.
- Correction owner: continue with best default, configurable parameter, marked assumption, phase advancement, or owner evidence route.

### User-Choice Prompting On Repeated Same-Class Gap
- Trigger: presenting a recurring same-class blocking gap as a user choice.
- Owning rule: `agents/team-lead.md` RPA-4 (repeated same-class blocking gaps are root-cause route evidence, not user-choice options).
- Correction owner: classify root cause and dispatch the smallest correcting owner.

### Missed Parallel Dispatch
- Trigger: serializing two or more frozen independent nonblocked surfaces in the same segment.
- Owning rule: `CLAUDE.md` `[PARALLEL]` and `agents/team-lead.md` RPA-2.
- Correction owner: dispatch independent nonblocked frozen surfaces in the same segment.

### Serial-Convenience Bottleneck
- Trigger: choosing serial execution over independent specialist-fit surfaces without `work-planning/references/parallel-fit.md` proven serial basis.
- Owning rule: `CLAUDE.md` `[PARALLEL]` and `work-planning` Q1-Q5 parallel law.
- Correction owner: reopen `work-planning` and restore parallel shape.

### Phase Design-Decision Delegation
- Trigger: pushing decision-level plan/design/redesign to developer or Codex without team-lead own basis.
- Owning rule: `agents/team-lead.md` RPA-4 (decision-level basis owned by team-lead).
- Correction owner: produce decision-level basis at team-lead; developer expands canonical artifacts.

### Codex Relay
- Trigger: accepting Codex/reviewer input as a redispatch package without same-pass team-lead own-review and point-by-point reconciliation.
- Owning rule: `agents/team-lead.md` RPA-4 (own-review duty + reconciliation).
- Correction owner: perform same-pass team-lead own-review, reconcile point-by-point, redesign at decision level, then dispatch only the reconciled plan.

### Premature Agent Replacement
- Trigger: replacing or shutting down a missing/idle agent before owning receipt/execution follow-up, wait, and assigned-surface activity/side-effect check.
- Owning rule: `agents/team-lead.md` RPA-5 and `references/communication-objections.md`.
- Correction owner: run the recovery sequence on the existing agent before replacement.

### Reporting Leak
- Trigger: emitting P0/WP/SV fields, skill loads, runtime, lane internals, convergence tables, advisory payloads, or internal artifact bodies/diffs to the user without explicit user request.
- Owning rule: `agents/team-lead.md` RPA-9 and RPA-10.
- Correction owner: collapse to one truth surface and keep procedure scaffolding internal.

### Routine Status Stop
- Trigger: emitting user-facing PHASE-RESULT, status prose, "next action: continue X" message, routine progress claim, OR a `FINAL` surface that lists residual / queued / remaining items, during in-flight multi-round/multi-batch work where the next action is the same-segment continuation of the same deliverable, and treating that emission as a checkpoint that pauses execution.
- Specifically: (a) intermediate commit, push, or git milestone is not a phase boundary; (b) status questions ("are you done?", "what's the status?") are stall-exposure cues only, not resume-permission gates; (c) naming `next action` instead of executing it when the executor is the same owner is `[AUTO-PROC]` non-compliance; (d) `FINAL` is valid only on zero-residual deliverable convergence — a non-empty residual / queued / remaining-items list inside a `FINAL` surface is itself the recurrence proof that the deliverable has not converged, no matter how the residual is framed (low-severity, defer-to-next-round, file-split-required, etc.).
- Owning rule: `CLAUDE.md` `[AUTO-PROC]` plus `[PROC-HABIT]`; `agents/team-lead.md` RPA-2 (drive every active outcome to verified result/HOLD/cancel/next-executable), RPA-9 (no new or changed primary surface means internal turn), RPA-10 (MID-FLIGHT silent; `FINAL` only on convergence), RPA-12 (resume from interrupt without permission); `references/synthesis-reporting.md` Routine-Gate Continuation.
- Correction owner: continue execution through every queued / residual item in the same segment until the queue is empty (every item patched, owner-deferred with explicit follow-up assignment, or proven out-of-scope with cited basis); suspend user-facing prose until that zero-residual convergence, a true blocker emerges, or the user explicitly cancels/redirects.
