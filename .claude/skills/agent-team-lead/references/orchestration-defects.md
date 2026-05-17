---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "agent-team-lead Orchestration Defect Taxonomy; [HARDEN]; Reference Binding; Procedure And Ownership"
---
# team-lead: Orchestration Defect Taxonomy
Inherits `.claude/agents/team-lead.md` and `.claude/CLAUDE.md`.
Consolidates orchestration defect classes only.
Each entry names the trigger, the owning rule, and the smallest correction owner.
This file hosts no orphan rule; every class points to an existing owner surface.
Treat defect classification as route evidence.
`governance-change` recurrence-hardening path applies only after `[HARDEN]` confirms recurrence and narrowest correct owner.
Adding a new defect class requires `governance-change` plus owner-rule citation.

### Skipped Owner Chain
- Trigger: bypassing an active triggered owner skill/sequence before lookup, review-tool use, judgment, dispatch, mutation, or report.
- Owning rule: `agents/team-lead.md` RPA-2 trigger order and RPA-3.
- Correction owner: open the missed owner.
- Correction owner: consume the missed owner.

### Needless User Prompt
- Trigger: asking the user to choose a derivable answer that doctrine, evidence, prior instruction, or active plan can settle.
- Trigger: asking whether to reuse prior outputs when the current request asks to perform work on the current target or corpus and does not request reuse.
- Owning rule: `CLAUDE.md` `[NO-NEEDLESS-ASK]` and `agents/team-lead.md` RPA-10.
- Correction owner: continue with best default, configurable parameter, marked assumption, phase advancement, or owner evidence route.
- Correction owner: treat prior outputs as excluded sources unless explicit reuse, merge, validate, report, or compare use was requested.

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
- Owning rule: `agents/team-lead.md` RPA-5 and `.claude/skills/agent-team-lead/references/communication-objections.md`.
- Correction owner: run the recovery sequence on the existing agent before replacement.

### Reporting Leak
- Trigger: emitting non-token visible prose not admitted by `.claude/reference/user-reporting-law.md`.
- Owning rule: `agents/team-lead.md` RPA-7 and `.claude/reference/user-reporting-law.md`.
- Correction owner: suppress non-admitted user-facing prose and keep Communication Plane and Procedure Plane payload internal.
- Correction owner: reapply `agents/team-lead.md` RPA-7 before any retry on the same visible surface.
- Recurrence owner: after protected work integrity is secure, route repeated same-class emission to `governance-change` as `[PROC-HABIT]` hardening.

### Routine Status Stop
- Trigger: emitting user-facing `PHASE-RESULT` during same-segment continuation work.
- Trigger: emitting status prose during same-segment continuation work.
- Trigger: emitting `next action: continue X` during same-owner executable continuation work.
- Trigger: emitting routine progress claim, remaining-work count, or runtime-excuse wording as checkpoint during same-segment continuation work.
- Trigger: emitting `FINAL` before zero-residual deliverable convergence.
- Classification: intermediate commit is a routine milestone.
- Classification: intermediate push is a routine milestone.
- Classification: intermediate build is a routine milestone.
- Classification: status questions are stall-exposure cues.
- Classification: same-owner `next action` naming executes rather than becomes a user report.
- Classification: `FINAL` requires zero-residual deliverable convergence.
- Owning rule: `CLAUDE.md` `[AUTO-PROC]` plus `[PROC-HABIT]`; `agents/team-lead.md` RPA-2 trigger order, RPA-7 user reporting, and RPA-10 interrupt/autonomy; `.claude/skills/agent-team-lead/references/routine-gate-continuation.md`.
- Correction owner: apply `.claude/skills/agent-team-lead/references/routine-gate-continuation.md` `## Final Convergence`.
- Correction owner: surface user-facing prose only after `.claude/reference/user-reporting-law.md` admits it.

## Resolve Next Owner And Action
- A defect trigger opens its named correction owner.
- A correction owner executes the named correction action.
- A recurring defect opens `governance-change` recurrence-hardening classification after `[HARDEN]` confirms recurrence.
