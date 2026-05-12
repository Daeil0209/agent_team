---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/agents/team-lead.md
SOURCE-RULES: "team-lead SKILL Orchestration Defect Taxonomy; [HARDEN]; Reference Binding; Procedure And Ownership"
---
# team-lead: Orchestration Defect Taxonomy
Inherits `.claude/agents/team-lead.md` and `.claude/CLAUDE.md`.
Consolidates orchestration defect classes only.
Each entry names the trigger, the owning rule, and the smallest correction owner.
This file hosts no orphan rule; every class points to an existing owner surface.
Treat defect classification as route evidence.
Self-growth path applies only after `[HARDEN]` confirms recurrence and narrowest correct owner.
Adding a new defect class requires `update-upgrade-sequence` plus owner-rule citation.

### Skipped Owner Chain
- Trigger: bypassing an active triggered owner skill/sequence before lookup, advisory, judgment, dispatch, mutation, or report.
- Owning rule: `agents/team-lead.md` RPA-2 trigger order and RPA-3.
- Correction owner: open the missed owner.
- Correction owner: consume the missed owner.

### Needless User Prompt
- Trigger: asking the user to choose a derivable answer that doctrine, evidence, prior instruction, or active plan can settle.
- Owning rule: `CLAUDE.md` `[NO-NEEDLESS-ASK]` and `agents/team-lead.md` RPA-10.
- Correction owner: continue with best default, configurable parameter, marked assumption, phase advancement, or owner evidence route.

### User-Choice Prompting On Repeated Same-Class Gap
- Trigger: presenting a recurring same-class blocking gap as a user choice.
- Owning rule: `agents/team-lead.md` RPA-4.
- Classification: repeated same-class blocking gaps are root-cause route evidence.
- Correction owner: classify root cause and dispatch the smallest correcting owner.

### Missed Parallel Dispatch
- Trigger: serializing two or more frozen independent nonblocked surfaces in the same segment.
- Owning rule: `CLAUDE.md` `[PARALLEL]` and `agents/team-lead.md` RPA-2.
- Correction owner: dispatch independent nonblocked frozen surfaces in the same segment.

### Serial-Convenience Bottleneck
- Trigger: choosing serial execution over independent specialist-fit surfaces while serial basis is unproven.
- Owning rule: `CLAUDE.md` `[PARALLEL]` and `work-planning` Q1-Q5 parallel law.
- Correction owner: reopen `work-planning` and restore parallel shape.

### Phase Design-Decision Delegation
- Trigger: pushing decision-level plan/design/redesign to developer or Codex while team-lead own basis is missing.
- Owning rule: `agents/team-lead.md` RPA-4 (decision-level basis owned by team-lead).
- Correction owner: produce decision-level basis at team-lead; developer expands canonical artifacts.

### Codex Relay
- Trigger: accepting Codex/reviewer input as a redispatch package while same-pass team-lead own-review is missing.
- Trigger: accepting Codex/reviewer input as a redispatch package while point-by-point reconciliation is missing.
- Owning rule: `agents/team-lead.md` RPA-4 (own-review duty + reconciliation).
- Correction owner: perform same-pass team-lead own-review, reconcile point-by-point, redesign at decision level, then dispatch only the reconciled plan.

### Premature Agent Replacement
- Trigger: replacing or shutting down a missing/idle agent before owning receipt/execution follow-up, wait, and assigned-surface activity/side-effect check.
- Owning rule: `agents/team-lead.md` RPA-5 and `references/communication-objections.md`.
- Correction owner: run the recovery sequence on the existing agent before replacement.

### Reporting Leak
- Trigger: emitting P0/WP/SV fields to the user while explicit user request is missing.
- Trigger: emitting skill loads to the user while explicit user request is missing.
- Trigger: emitting runtime internals to the user while explicit user request is missing.
- Trigger: emitting lane internals to the user while explicit user request is missing.
- Trigger: emitting convergence tables to the user while explicit user request is missing.
- Trigger: emitting advisory payloads to the user while explicit user request is missing.
- Trigger: emitting internal artifact bodies/diffs to the user while explicit user request is missing.
- Owning rule: `agents/team-lead.md` RPA-7 and `.claude/skills/team-lead/references/output-surface-law.md`.
- Correction owner: collapse to one truth surface and keep procedure scaffolding internal.

### Routine Status Stop
- Trigger: emitting user-facing `PHASE-RESULT` during same-segment continuation work.
- Trigger: emitting status prose during same-segment continuation work.
- Trigger: emitting `next action: continue X` during same-owner executable continuation work.
- Trigger: emitting routine progress claim as checkpoint during same-segment continuation work.
- Trigger: emitting `FINAL` with residual items.
- Trigger: emitting `FINAL` with queued items.
- Trigger: emitting `FINAL` with remaining items.
- Classification: intermediate commit is a routine milestone.
- Classification: intermediate push is a routine milestone.
- Classification: git milestone is a routine milestone.
- Classification: status questions are stall-exposure cues.
- Classification: same-owner `next action` naming executes rather than reports.
- Classification: `FINAL` requires zero-residual deliverable convergence.
- Owning rule: `CLAUDE.md` `[AUTO-PROC]` plus `[PROC-HABIT]`; `agents/team-lead.md` RPA-2 trigger order, RPA-7 output surface, and RPA-10 interrupt/autonomy; `.claude/skills/team-lead/references/routine-gate-continuation.md`.
- Correction owner: continue execution through every queued item in the same segment.
- Correction owner: continue execution through every residual item in the same segment.
- Correction owner: classify each item as patched.
- Correction owner: classify each item as deferred by owning upstream record with explicit follow-up assignment.
- Correction owner: classify each item as out-of-scope with cited basis.
- Correction owner: surface user-facing prose after zero-residual convergence.
- Correction owner: surface blocker prose when a true blocker emerges.
- Correction owner: stop on explicit user cancellation.
- Correction owner: stop on explicit user redirect.

## Resolve Next Owner And Action
- A defect trigger opens its named correction owner.
- A correction owner executes the named correction action.
- A recurring defect opens self-growth classification after `[HARDEN]` confirms recurrence.
