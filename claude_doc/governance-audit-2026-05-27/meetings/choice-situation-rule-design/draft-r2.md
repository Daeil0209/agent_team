MEETING-ID: choice-situation-rule-design
DRAFTER: team-lead
CRITICS: reviewer-shard-a, reviewer-shard-b, researcher, developer
ROUND: r2 (operator pre-critic feedback #2 incorporated — "새로운 작업 절차에서 도출되고 선택되어야 하는 방향은 규정된 상위 철학 모든 조건을 만족하는 방향이어야 한다. 제시된 조건이 이를 만족하지 못하면 만족하도록 재설계해서 그 방향으로 진행되어야 해~!! 이건 불변이야~!" — INVARIANT clause added: chosen direction MUST satisfy ALL §1-§8 upper philosophy; if presented options fail → REDESIGN until compliant; "best of incompliant options" is forbidden)

## MEETING-AGENDA (unchanged from r0/r1)
Operator directive 2026-05-26 (now 5-part with r2 invariant):
1. Choice situations must trigger critical-discussion-based direction-setting; regulated in + consumed by Skill(work-planning) + Skill(task-execution)
2. Chosen direction MUST comply with ALL §1-§8 upper philosophy AND be designed for compliance; UNCONDITIONALLY required
3. USE team-meeting NOW to design + install rule; plug gap; then USE for downstream work
4. (r1) All R1-R4 open questions resolved in design (not deferred)
5. **(r2) INVARIANT: chosen direction MUST satisfy ALL §1-§8 upper-philosophy conditions; if presented options fail → mandatory REDESIGN within meeting until a compliant option is produced; "best of incompliant options" selection is forbidden; this is invariant, non-negotiable**

## TARGET-OUTCOME (r2 unchanged + INVARIANT added)
- Canonical owner rule (work-execution-core-law `## Autonomy And Escalation Law`) covering 4 bullets now: trigger definition + mandatory team-meeting + INVARIANT compliance clause + fallback chain
- 3 consumer-surface synchronization triggers (Skill(work-planning) + Skill(task-execution) + Skill(governance-modification))
- Non-choice-situation enumeration (R1)
- Fallback chain for team-meeting infeasibility / HOLD (R2/R4)
- Post-install: apply to Phase 4-5 best-direction decision

## SOLUTION (revised r2 — 4 items, INVARIANT clause added to canonical Item 1)

### Item 1 — work-execution-core-law `## Autonomy And Escalation Law` rule addition (canonical mapped-core-law)
TARGET: `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` — insert 4 bullets after current line 90 user-escalation rule and before current line 91 hard-design-decision team-meeting mandate
EDIT-OPERATION: additive insertion of **4 bullets** (was 3 in r1; INVARIANT clause added as new bullet 3)

NEW-TEXT (proposed, r2):
```
- A `choice situation` exists when the active owner faces multiple defensible options with material variance per `## Material And Materiality Law` in any of: (i) §1-§8 upper-philosophy compliance, (ii) user-stated-goal coverage per `.claude/CLAUDE.md` `## 1. Design Definition Philosophy` Success criteria (frozen request fit + concrete deliverable satisfaction + user burden reduction + decisive user-surface closure), (iii) user burden, (iv) trade-off shape, or (v) built-in safety via existing verification gates. Options that are trivially equivalent — differing only in implementation detail without user-outcome, evidence-burden, or upper-philosophy compliance variance — are NOT choice situations.
- In every choice situation, `Skill(team-meeting)` is unconditionally mandatory before owner-side selection OR user escalation; direct owner-side choice or direct user escalation without prior `Skill(team-meeting)` attempt in a choice situation is a `[NO-NEEDLESS-ASK]` + procedure-adherence violation.
- INVARIANT: the team-meeting outcome direction MUST satisfy ALL §1-§8 upper-philosophy conditions per `Skill(review-verification)` `## Upstream Basis Review Law` consumption of every controlling philosophy section and mapped core-law axes; when any presented option fails to satisfy ALL conditions, the meeting MUST redesign options within the meeting (additional opinion rounds, drafter persuasion-target conversion, or new SOLUTION items per `Skill(team-meeting)` `## 3-4. Opinion Round`) until at least one option satisfies all upper-philosophy conditions. Selection of an upper-philosophy-incompliant option, picking the "best of incompliant options", or shortcutting redesign in favor of escalation is a procedure-adherence + invariant violation.
- Fallback chain when `Skill(team-meeting)` form is structurally infeasible per the 3-condition convergence-tractable test (line 92 above — bounded, reversible, ≥2 critics with material lens basis) OR when the meeting reaches `HOLD` per `Skill(team-meeting)` `## 3-6. Convergence` round-cap after exhausting redesign rounds: route to operator-policy-choice user escalation per the standard exception classes at lines 95-99 with explicit record of which upper-philosophy conditions remain incompliant in every option; direct user escalation that bypasses the team-meeting attempt or skips the redesign requirement is invalid.
```

### Item 2 — Skill(work-planning) trigger consumption (r2 unchanged from r1)
TARGET: `.claude/skills/work-planning/SKILL.md` `## Step 2: Q1-Q5 Work Analysis`
NEW-TEXT (proposed):
```
- If Q1-Q5 or any later planning step reveals a choice situation per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (multiple defensible options with material variance in upper-philosophy compliance / user-stated-goal coverage / user burden / trade-off shape / built-in safety), open `Skill(team-meeting)` before Step 3 work-plan build or Step 4 freeze; the team-meeting solution must satisfy ALL §1-§8 upper-philosophy conditions per the canonical INVARIANT and becomes the frozen route basis; fallback to operator-policy-choice user escalation per the canonical rule applies only when `Skill(team-meeting)` infeasible or `HOLD` after redesign exhaustion.
```

### Item 3 — Skill(task-execution) trigger consumption (r2 unchanged from r1)
TARGET: `.claude/skills/task-execution/SKILL.md` `## Step 1: Activate Frozen Route`
NEW-TEXT (proposed):
```
- If Step 1 reveals a choice situation per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (multiple defensible execution moves with material variance — e.g., wave-by-wave vs all-wave, sequential vs parallel, multiple equally-defensible dispatch shapes), open `Skill(team-meeting)` before execution-move selection; the team-meeting solution must satisfy ALL §1-§8 upper-philosophy conditions per the canonical INVARIANT and becomes the executed move; fallback to operator-policy-choice user escalation per the canonical rule applies only when `Skill(team-meeting)` infeasible or `HOLD` after redesign exhaustion.
```

### Item 4 — Skill(governance-modification) trigger consumption (r2 unchanged from r1)
TARGET: `.claude/skills/governance-modification/SKILL.md` `# Step 4: Change Sequence Design`
NEW-TEXT (proposed):
```
- If multiple defensible CHANGE-SEQUENCE-DESIGN options exist for the same `PROBLEM-BASIS` per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` (e.g., re-home vs delete vs split vs merge with material variance in upper-philosophy compliance / user-stated-goal coverage / user burden / trade-off shape / built-in safety), open `Skill(team-meeting)` before design row selection; the team-meeting solution must satisfy ALL §1-§8 upper-philosophy conditions per the canonical INVARIANT and becomes the chosen design row; fallback to operator-policy-choice user escalation per the canonical rule applies only when `Skill(team-meeting)` infeasible or `HOLD` after redesign exhaustion.
```

## WHY THIS SOLVES IT (r2 — S1-S10 from r1 + S11 INVARIANT)
- (S1-S10) Per r1 rationale: gap closure + generalization + unconditional procedure + upper-philosophy binding + R1-R4 resolutions + minimum-info + dimensional-independence + coherence with existing line 91-93. Carried forward unchanged.
- (S11 r2) **INVARIANT binding**: canonical Item 1 bullet 3 makes upper-philosophy compliance NON-NEGOTIABLE for the chosen direction. The meeting CANNOT select an incompliant option; the meeting MUST redesign options until compliant; "best of bad options" is forbidden. Each consumer trigger (Items 2-4) cites "ALL §1-§8 upper-philosophy conditions per the canonical INVARIANT" so the invariant propagates automatically. Per operator directive #5 ("이건 불변이야"), the rule wording uses "INVARIANT" explicitly + "MUST" twice + "forbidden" framing.

## MAIN RISKS OR TRADEOFFS (r2 — R5/R6/R7 from r1 + R8 INVARIANT-redesign exhaustion)

### R8 (NEW r2) — Redesign exhaustion before convergence
- Risk: if NO redesign produces a compliant option (e.g., genuine philosophy-conflict between §1 and §6 in the assigned scope), the meeting iterates without convergence and exhausts round cap → HOLD per Section 3-6
- Mitigation: fallback chain (Item 1 bullet 4) routes to operator-policy-choice user escalation, but ONLY after redesign exhaustion is documented (explicit record of which upper-philosophy conditions remain incompliant in every option). This preserves the invariant (no quiet compromise) AND provides escape valve (HOLD escalation when genuinely impossible)
- Residual: in the rare case of genuine philosophy-conflict that cannot be designed away, operator-policy-choice escalation is the lawful path; meeting record carries the incompliance disclosure for operator transparency

### R5/R6/R7 (carried from r1)
- R5 material-variance qualifier judgment burden — mitigated by `## Material And Materiality Law` anchor
- R6 existing line 91-93 hard-design-decision rule overlap — co-exist; line 91-93 = specific hard-decision classes; new rule = broader generalization
- R7 cap-overflow risk when team-meeting needs critics — fallback chain (Item 1 bullet 4) handles infeasibility

## NEXT ACTION
After unanimous critics' consent on r2 + operator gate accept, route to `Skill(governance-modification)` for **4-patch loop** (work-execution-core-law canonical 4-bullet addition + 3 consumer trigger bullets). Each patch follows Step 3 review-verification + Step 4 design (with the new Item 4 trigger applying to governance-modification's own design — meta-recursive but lawful since the patch design itself is a choice situation requiring team-meeting if multiple defensible designs exist; for THIS patch series the design is now converged via this meeting so meta-recursion does not re-trigger) + Step 5 self-verification + Patch Execution Method + Post-Verify 5-axis matrix per `.claude/reference/modification-core-law.md` patch-independence acceptance contract.

After all 4 patches applied + post-verified, the new rule (with INVARIANT) is applied to the original Phase 4-5 best-direction decision via fresh team-meeting under the newly-installed canonical rule. The Phase 4-5 meeting MUST produce a direction satisfying ALL §1-§8 upper philosophy; if my earlier (a)/(b)/(c) options fail this test, the Phase 4-5 meeting will redesign.

## MEETING-AUDIT-CRITERIA Self-Check (drafter, r2)
- agenda fit: ✓ (r2 addresses all 5 operator-directive parts including INVARIANT)
- simplicity: ✓ (7 bullets total across 4 surfaces; +1 bullet from r1 for INVARIANT; minimum-executable-information)
- correctness: ✓ (R1-R4 resolved in r1 wording; R5/R6/R7 residual + R8 new redesign-exhaustion risk named with mitigation)
- feasibility: ✓ (NEXT ACTION names executable owner = Skill(governance-modification) 4-patch loop)
- bottleneck control: ✓ (4 patches independent per dimensional-independence)
- 8 operator-emphasized keywords (CLAUDE.md §5):
  - `removal-first` ✓ (additive 7 bullets; line 91-93 retained as special case)
  - `consumed-surface` ✓ (canonical owner + 3 consumers)
  - `no-compression` ✓ (each bullet one rule; INVARIANT bullet is one rule with sub-clauses describing the same invariant requirement)
  - `upper-lower execution-drive` ✓
  - `executable-imperative` ✓ ("unconditionally mandatory" + "MUST" + "forbidden" + "INVARIANT")
  - `minimum-executable-information` ✓ (7 bullets total; INVARIANT clause adds only the redesign + ban-compromise wording, no examples)
  - `dimensional-independence` ✓
  - `comprehension-as-execution-force` ✓ (INVARIANT prefix makes the binding immediately visible to readers)

## OPINION-ROUND REQUEST TO CRITICS (r2 supersedes r1)
**Redirect notice**: draft-r1.md was operator-pre-empted with INVARIANT clause demand; draft-r2.md is current. If critique-r1-<name>.md was already started, fold the r1 work into a fresh critique-r2-<name>.md against r2; if r1 critique not yet started, skip directly to r2.

Each critic deliver opinion targeting:
- the 4 SOLUTION items (Item 1 canonical with new INVARIANT bullet 3 + Item 2/3/4 consumer triggers)
- the INVARIANT clause specifically: is "MUST satisfy ALL §1-§8" enforceable? are "presented options redesign" semantics clear? is "best of incompliant options forbidden" wording strong enough?
- the WHY THIS SOLVES IT rationale (S1-S11)
- the residual R5/R6/R7 + R8 risks (mitigation sufficient? hidden risks missed?)
- the MEETING-AUDIT-CRITERIA self-check (any failed criterion?)
- any new defect or risk not covered

Critique-response delivery: SendMessage MESSAGE-CLASS: critique-response with carrier pointer to `claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/critique-r2-<your-member-name>.md`.
