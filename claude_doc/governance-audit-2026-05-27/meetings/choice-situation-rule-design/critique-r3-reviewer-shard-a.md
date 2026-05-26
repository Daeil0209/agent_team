MEETING-ID: choice-situation-rule-design
ROUND: r3 (operator ANTI-PASSIVE-WAIT clause incorporated; r1/r2 critique findings folded forward per drafter REDIRECT)
CRITIC: reviewer-shard-a
LENSES-APPLIED: design-intent-lens + coherence-integrity-lens + patch-worthiness-lens (per packet OPINION-ROUND REQUEST; same lenses as r1/r2)
TARGET: claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/draft-r3.md
PRIOR-CRITIQUE-CARRY-FORWARD: critique-r1-reviewer-shard-a.md + critique-r2-reviewer-shard-a.md (carry-forward findings C-A through C-J evaluated against r3 wording)
EVIDENCE-BASIS: Read of draft-r3.md (full file, this turn) + carry-forward of r1/r2 critique findings; same-session loaded basis for binding-surface + 8 audit-method lenses + 9 named lenses; task-1 audit Read of work-execution-core-law.md (lines 158-165 `## Execution Progress Law` location verified).

## OVERALL POSITION
Draft-r3 adds the operator ANTI-PASSIVE-WAIT clause (Item 1 bullet 4 new + consumer trigger updates + fallback chain addition + S12 rationale + R9 risk + Operator-Directive Compliance Check addition). The ANTI-PASSIVE-WAIT addition is design-intent-preserving per operator directive #6+#7. Drafter partially addressed C-C (changed "above" → "below" in fallback chain line-92 reference) — direction-correction was needed because insertion is BEFORE line 91 not AFTER. However, the NUMERIC line references remain stale.

**Critical observation**: r3 introduces a NEW instance of the same stale-line-number defect pattern (C-C/C-D) at the ANTI-PASSIVE-WAIT bullet (line 158 reference). The defect pattern now has 3 occurrences in r3 canonical text. This pattern should be addressed comprehensively in r4 rather than per-instance.

**Per-lens verdict (r3)**:
- design-intent-lens: pass-with-C-A-persisting (operator directives #6+#7 reflected; minor C-A wording divergence carry-forward)
- coherence-integrity-lens: pass-with-3-blocking-stale-line-numbers (C-C partial-fix + C-D persisting + C-K NEW; all same pattern)
- patch-worthiness-lens: candidate-patch-worthy with same persisting open items

**Blocking concerns (require correction for r4)**: C-C + C-D + C-K — all 3 are stale-pre-patch-line-numbers embedded in inserted bullet text.

## CARRIED-FORWARD FINDINGS STATUS (r3 verification)

### [C-A] DESIGN-INTENT — Wording divergence at Item 1 bullet 1 (ii) — STILL OPEN
r3 STATUS: **PERSISTS**. r3 line 30 (Item 1 bullet 1 (ii) parenthetical) reads "(frozen request fit + concrete deliverable satisfaction + user burden reduction + decisive user-surface closure)" — same as r1/r2. CLAUDE.md §1 line 29 canonical = "request fit, frozen deliverable satisfaction, user burden reduction, and decisive user-surface closure."
PROPOSED-CORRECTION (same as r1/r2): verbatim canonical wording.
SEVERITY: minor; recommended for r4.
STATE: candidate-evidence (3rd round persisting)

### [C-B] DESIGN-INTENT — R3 governance-modification expansion — RESOLVED (no action)
r3 STATUS: **RESOLVED** in r2; no change.
STATE: candidate-classified

### [C-C] COHERENCE-INTEGRITY — Stale line-92 reference — PARTIAL FIX in r3 (direction corrected; numeric still stale)
r3 STATUS: **PARTIAL FIX with residual defect**. Verified r3 line 34 (Item 1 bullet 5 — fallback chain) reads:
> "Fallback chain when `Skill(team-meeting)` form is structurally infeasible per the 3-condition convergence-tractable test **(line 92 below — bounded, reversible, ≥2 critics with material lens basis)** OR when the meeting reaches `HOLD`..."

Drafter changed r2 "(line 92 **above**)" → r3 "(line 92 **below**)" — direction correction was needed because the EDIT-OPERATION inserts the new bullets BEFORE current line 91 (not after), so post-insertion the existing line-92 convergence-tractable test rule appears AFTER the new bullets — hence "below". ✓ Direction now correct.

**BUT numeric "92" remains stale**: r3 inserts 5 bullets at line 91. Post-insertion, the existing line 92 (convergence-tractable test rule) shifts to **line 97** (line 92 + 5 bullet shift). The "(line 92 below)" reference will point to wrong line post-patch.

PROPOSED-CORRECTION (escalated from r1/r2): replace numeric line reference with name-based reference:
> "(per the 3-condition convergence-tractable form rule **later in `## Autonomy And Escalation Law`** — bounded, reversible, ≥2 critics with material lens basis)"

OR if drafter strongly prefers retaining numeric, update to post-patch line: "(line 97 below — ...)". But name-based reference is more robust (survives any future insertion that shifts the line).

SEVERITY: blocking for r4 (defect identical to r1/r2; partial fix did not resolve).
STATE: candidate-evidence (3rd round; partial-fix-residual)

### [C-D] COHERENCE-INTEGRITY — Stale lines-95-99 reference — STILL OPEN
r3 STATUS: **PERSISTS**. Verified r3 line 34 still reads "the standard exception classes at lines 95-99". After 5-bullet insertion at line 91, lines 95-99 shift to lines 100-104.
PROPOSED-CORRECTION (same as r1/r2): name-based reference, e.g., "the standard exception classes later in `## Autonomy And Escalation Law` (irreversible / destructive / security-sensitive / operator-policy-choice / proven user-owned blocker bases)".
SEVERITY: blocking for r4.
STATE: candidate-evidence (3rd round persisting)

### [C-E] COHERENCE-INTEGRITY — Consumer trigger criteria-restatement — STILL OPEN
r3 STATUS: **PERSISTS**. r3 Items 2/3/4 (lines 41, 48, 55) carry same wording as r2 with addition of post-meeting-execute clause but the 5-criterion list restatement at Items 2 and 4 unchanged.
PROPOSED-CORRECTION (same as r1/r2): option (a) cite-only OR option (b) declare PROTECTED-LOCAL-RESTATEMENT-BASIS.
SEVERITY: minor; drafter's choice.
STATE: candidate-evidence (drafter choice)

### [C-F] PATCH-WORTHINESS — Line 91-93 vacuousness observation — STILL OPEN
r3 STATUS: **PERSISTS**. r3 S1-S11 carried from r2 by reference (line 59).
SEVERITY: observation; not r4-blocking.
STATE: candidate-evidence (Phase 4+ follow-on)

### [C-G] COHERENCE-INTEGRITY — INVARIANT mega-bullet — STILL OPEN
r3 STATUS: **PERSISTS**. r3 Item 1 bullet 3 (INVARIANT) unchanged from r2.
SEVERITY: drafter's choice.
STATE: candidate-evidence (drafter choice)

### [C-H] PATCH-WORTHINESS — NEXT ACTION meta-recursion parenthetical — RESOLVED in r3
r3 STATUS: **RESOLVED**. r3 NEXT ACTION (lines 75-78) is cleaner than r2 — the meta-recursion parenthetical from r2 line 73 was removed. The NEXT ACTION text is now focused on the 4-patch loop + Phase 4-5 application.
STATE: candidate-classified — class: drafter-resolved-by-cleanup, no defect

### [C-I] COHERENCE-INTEGRITY — Incompliance-record format — STILL OPEN
r3 STATUS: **PERSISTS**. r3 Item 1 bullet 5 (fallback chain) carries same "explicit record" wording as r2 line 32.
SEVERITY: drafter's choice.
STATE: candidate-evidence (drafter choice)

### [C-J] COHERENCE-INTEGRITY — "ALL" qualifier ambiguity — STILL OPEN
r3 STATUS: **PERSISTS**. r3 Item 1 bullet 3 + propagated consumer trigger wording still uses "ALL §1-§8 upper-philosophy conditions" without "applicable" or "controlling" qualifier.
SEVERITY: minor; recommended clarification.
STATE: candidate-evidence (recommended)

## NEW FINDINGS INTRODUCED IN r3

### [C-K] COHERENCE-INTEGRITY — ANTI-PASSIVE-WAIT bullet contains stale "line 158" reference (3rd stale-line-number instance)
LENS: coherence-integrity-lens
SEVERITY: blocking for r4 (same defect pattern as C-C/C-D; this is the 3rd instance in canonical text)
EVIDENCE:
r3 Item 1 bullet 4 (ANTI-PASSIVE-WAIT, lines 33) reads:
> "ANTI-PASSIVE-WAIT: after `Skill(team-meeting)` produces a converged direction satisfying the INVARIANT, the active owner EXECUTES that direction immediately in the same execution segment per `## Execution Progress Law` **(line 158** 'Process state report opens the next truthful action in the same turn') and `[NO-NEEDLESS-ASK]` (line 88 'Choose the evidence-backed best solution');..."

PROBLEM: The cited "line 158" refers to work-execution-core-law.md `## Execution Progress Law` first line. After the 5-bullet insertion at line 91, the existing line 158 shifts to **line 163** (line 158 + 5 bullet shift).

NOTE: "line 88" reference is UNAFFECTED because line 88 ([NO-NEEDLESS-ASK]) is BEFORE the insertion point (line 91) and does not shift. ✓

So this bullet has ONE stale line-number reference ("line 158") + ONE correct line-number reference ("line 88"). Per the comprehensive-pattern view: the canonical Item 1 now contains 3 stale-line-number references in 2 bullets (bullet 4 ANTI-PASSIVE-WAIT line 158 + bullet 5 fallback chain line 92 + lines 95-99).

PROPOSED-CORRECTION (comprehensive — applies to C-C + C-D + C-K together):

Replace all 3 stale references with name-based references:
- Bullet 4 line 33: "per `## Execution Progress Law` **(line 158** 'Process state report opens the next truthful action in the same turn')" → "per `## Execution Progress Law` **later in this file** ('Process state report opens the next truthful action in the same turn')"
- Bullet 4 line 33: "(line 88 'Choose the evidence-backed best solution')" → "(per `[NO-NEEDLESS-ASK]` **earlier in this section** 'Choose the evidence-backed best solution')" — even though line 88 is currently correct, switching to name-based reference future-proofs against further insertions
- Bullet 5 line 34: "(line 92 below — ...)" → "(per the 3-condition convergence-tractable form rule **later in `## Autonomy And Escalation Law`** — ...)"
- Bullet 5 line 34: "lines 95-99" → "the standard exception classes **later in `## Autonomy And Escalation Law`** (irreversible / destructive / security-sensitive / operator-policy-choice / proven user-owned blocker bases)"

Per `.claude/reference/modification-minimal-governance-change-law.md` `## Patch-Ready Gate` "Mutation requires reconstructed source-to-destination meaning" — embedded pre-patch line numbers break source-to-destination meaning on any insertion that shifts referenced lines. Name-based references survive line shifts and remain valid across future insertions.

STRUCTURAL RECOMMENDATION: drafter should adopt a **no-numeric-line-references rule** for ALL inserted bullet text. This is a generalizable principle for governance patches that insert bullets into existing sections. Embedding line numbers in inserted text is an anti-pattern; embedding name-based references (section headers, rule names, anchor wording) is the safer pattern.

STATE: candidate-evidence (3rd instance of stale-line-number pattern; blocking for r4)

### [C-L] COHERENCE-INTEGRITY — ANTI-PASSIVE-WAIT bullet final sentence borderline redundant
LENS: coherence-integrity-lens
SEVERITY: minor (drafter choice)
EVIDENCE:
r3 Item 1 bullet 4 (ANTI-PASSIVE-WAIT) ends:
> "Passive waiting for user direction-confirmation post-team-meeting is a `[NO-NEEDLESS-ASK]` + procedure-adherence violation; **the team-meeting outcome IS the direction, and execution is the next-truthful-action.**"

The final sentence "the team-meeting outcome IS the direction, and execution is the next-truthful-action" is a restatement-for-emphasis of the bullet's earlier rules ("EXECUTES that direction immediately" + "does NOT pause to ask"). Per minimum-executable-information, this is slight redundancy.

COUNTER-ARGUMENT: the restatement serves comprehension-as-execution-force purpose by reinforcing the rule in plain declarative form after the prohibition wording. Aids reader understanding of the rule's positive shape.

DRAFTER'S CHOICE: keep for emphasis OR remove for minimum-executable-information.
SEVERITY: minor.
STATE: candidate-evidence (drafter choice)

### [C-M] DESIGN-INTENT — ANTI-PASSIVE-WAIT scope clarification needed for Operator Gate moment
LENS: design-intent-lens
SEVERITY: minor (potential reader confusion; clarification recommended)
EVIDENCE:
r3 Item 1 bullet 4 ANTI-PASSIVE-WAIT says "after `Skill(team-meeting)` produces a converged direction satisfying the INVARIANT, the active owner EXECUTES that direction immediately". Per `Skill(team-meeting)` `## 3-7. Operator Gate` (verified task-3 audit lines 139-149), the meeting workflow includes Operator Gate AFTER convergence — drafter presents final solution to operator; operator accept opens downstream owner per Section 4-1.

POTENTIAL READER CONFUSION: is "converged direction" defined as (a) post-Section-3-6-Convergence (unanimous critics consent) or (b) post-Section-3-7-Operator-Gate-accept? 
- Reading (a): execute immediately after critics consent, BEFORE operator accept — would conflict with Operator Gate
- Reading (b): execute immediately after operator accept — coherent with existing Operator Gate workflow

The bullet's wording leans toward (b) since "satisfying the INVARIANT" implies the full review including operator gate, but doesn't explicitly say so.

DEFEATER ANALYSIS: this is the same R9 analytic risk — distinguishing user-owned-blocker (legitimate user input) from anti-passive-wait violation (illegitimate user direction-confirmation). The Operator Gate IS user input but it's WITHIN the team-meeting workflow, not POST-meeting direction-confirmation. So Operator Gate is OUT-OF-SCOPE of ANTI-PASSIVE-WAIT.

PROPOSED-CORRECTION (minor clarification): change "after `Skill(team-meeting)` produces a converged direction satisfying the INVARIANT" → "after `Skill(team-meeting)` produces a converged direction satisfying the INVARIANT AND operator-gate acceptance per `Skill(team-meeting)` `## 3-7. Operator Gate`". This makes the post-Operator-Gate-accept timing explicit.

ALTERNATIVELY: rely on intra-skill workflow knowledge (Operator Gate is part of team-meeting workflow per `Skill(team-meeting)` Section 3-7; ANTI-PASSIVE-WAIT activates after the FULL meeting workflow including Operator Gate).
SEVERITY: minor.
STATE: candidate-evidence (recommended clarification or workflow-knowledge dependency)

## DEFEATER-FIRST POSTURE — r3 ADDITIONAL DISPROOF-ATTEMPT RECORD

Per agent-reviewer charter defeater-first posture, applied to r3 ANTI-PASSIVE-WAIT additions. 3 ANTI-PASSIVE-WAIT-specific defeaters tested:

D10: Could ANTI-PASSIVE-WAIT over-block legitimate user-input-required cases?
- Search: R9 mitigation (line 65-67) explicitly excludes true user-owned-blocker from anti-passive-wait scope (user-owned blockers are NOT choice situations per trigger definition; route directly to user escalation without team-meeting).
- Outcome: disproven (R9 covers edge case correctly)

D11: Does ANTI-PASSIVE-WAIT conflict with §3 line 50 user-escalation gate?
- Search: ANTI-PASSIVE-WAIT applies POST-team-meeting-convergence; §3 line 50 user-escalation gate applies BEFORE owner-action-decision. Different stages of work flow. Coherent.
- Outcome: disproven (no conflict)

D12: Could the Operator Gate (Section 3-7) itself be misread as "pause for direction-confirmation"?
- Search: Operator Gate is WITHIN the team-meeting workflow; ANTI-PASSIVE-WAIT activates POST-meeting (which includes Operator Gate acceptance). The bullet wording "satisfying the INVARIANT" implies full meeting workflow completion including operator gate. Slight under-specification flagged at C-M.
- Outcome: candidate-evidence (C-M clarification recommended; otherwise coherent)

DEFEATER outcomes: 3 of 3 effectively disproven (with C-M minor under-specification flagged).

## OPERATOR-DIRECTIVE COMPLIANCE CHECK (r3 verification by critic)

Drafter's r3 Operator-Directive Compliance Check at lines 81-90 declares all 7 directives reflected. Independent verification by critic:
- Directive 1 (choice-situation team-meeting in work-planning + work-execution) → Items 1+2+3 ✓ confirmed
- Directive 2 (ALL upper philosophy compliance + UNCONDITIONAL) → Item 1 bullets 2-3 ✓ confirmed
- Directive 3 (use team-meeting to design + install + apply) → NEXT ACTION ✓ confirmed
- Directive 4 (all open questions resolved) → R1-R9 all named + mitigated ✓ confirmed
- Directive 5 (INVARIANT redesign) → Item 1 bullet 3 ✓ confirmed
- Directive 6 (anti-passive-wait defect must disappear) → Item 1 bullet 4 NEW ✓ confirmed
- Directive 7 (include anti-passive-wait as new defect in rule) → Item 1 bullet 4 + consumer trigger updates + S12 + Item 1 bullet 5 fallback addition ✓ confirmed

ALL 7 operator directives reflected. ✓ No omissions detected.

## SUMMARY OF MEETING-AUDIT-CRITERIA OBSERVATIONS (r3)

Drafter's r3 self-check at lines 92-106 declares all criteria pass. Independent verification:
- agenda fit: ✓ confirmed (7 operator-directive parts)
- simplicity: pass-with-C-G/C-L-observations
- correctness: pass-with-blocking-defects-carried-forward (C-C partial-fix + C-D + C-K — all 3 stale-line-numbers); C-A/C-E/C-F/C-G/C-I/C-J/C-L/C-M open as candidate-evidence
- feasibility: ✓ confirmed
- bottleneck control: ✓ confirmed
- 8 operator-emphasized keywords:
  - `removal-first` ✓ confirmed
  - `consumed-surface` ✓ confirmed
  - `no-compression` pass-with-C-G-observation (INVARIANT bullet) + C-L observation (ANTI-PASSIVE-WAIT trailing-sentence redundancy)
  - `upper-lower execution-drive` ✓ confirmed (§3 §3 line 88 + line 158 + Execution Progress Law cited at ANTI-PASSIVE-WAIT)
  - `executable-imperative` ✓ confirmed ("INVARIANT" + "MUST" + "EXECUTES" + "forbidden" + "violation" + "ANTI-PASSIVE-WAIT")
  - `minimum-executable-information` pass-with-C-G/C-L-observations
  - `dimensional-independence` ✓ confirmed
  - `comprehension-as-execution-force` ✓ confirmed (ANTI-PASSIVE-WAIT prefix immediately visible; natural-language examples in quotes aid comprehension)

## REQUIRED REVISIONS FOR r4

To clear blocking concerns (3 stale-line-number references):
- **C-C / C-D / C-K (REQUIRED — same defect pattern)**: replace ALL 3 stale numeric line-references in Item 1 with name-based references per the comprehensive-correction proposed at C-K above. STRUCTURAL RECOMMENDATION: adopt no-numeric-line-references rule for ALL inserted bullet text.

Recommended improvements:
- **C-A (RECOMMENDED, 3rd round)**: align Item 1 bullet 1 (ii) parenthetical wording verbatim to CLAUDE.md §1 line 29.
- **C-E (DRAFTER'S CHOICE)**: cite-only OR PROTECTED-LOCAL-RESTATEMENT-BASIS for Items 2/4 criteria-restatement.
- **C-G (DRAFTER'S CHOICE)**: INVARIANT mega-bullet split OR retain-with-justification.
- **C-I (DRAFTER'S CHOICE)**: incompliance-record format guidance OR rely on inherited HOLD-record format.
- **C-J (RECOMMENDED)**: add "applicable" or "controlling" qualifier to "ALL §1-§8 upper-philosophy conditions".
- **C-L (DRAFTER'S CHOICE)**: ANTI-PASSIVE-WAIT trailing sentence keep-for-emphasis OR remove.
- **C-M (RECOMMENDED)**: clarify ANTI-PASSIVE-WAIT activation timing (post-Operator-Gate-accept).

Phase 4+ follow-on:
- **C-F (NO r4 ACTION)**: line 91-93 vacuousness-vs-protected-restatement clarification.

## CONSENT POSITION (per Skill(team-meeting) `## 3-6. Convergence`)
**Conditional consent** (3rd round; same blocking conditions + new C-K + new minor C-L/C-M): I consent to draft-r4 advancement IF C-C + C-D + C-K are corrected per comprehensive name-based-reference correction proposed at C-K. The stale-line-number defect pattern now has 3 instances in r3 canonical text; comprehensive correction (no-numeric-line-references rule) is more efficient than per-instance fix.

Without correction, the canonical patch produces 3 bullets with stale line-number references at patch-application moment — immediate coherence defect requiring follow-on patch. Violates `Skill(review-verification)` `### 9. Integrity Gate Before Live Patch` reference-integrity rule across 3 sites. R3's 5-bullet expansion (vs r2's 4-bullet) compounds the line-shift error.

C-A is recommended improvement; C-E + C-G + C-I + C-L are drafter's choice between options; C-J + C-M are recommended clarifications; C-F is Phase 4+ follow-on not blocking r4.

PER `Skill(team-meeting)` `## 3-4. Opinion Round` drafter-conversion options:
- (revise) drafter updates Item 1 bullets 4 + 5 per comprehensive name-based-reference correction in r4 draft
- (evidence-rationale) — INVALID for stale-line-numbers per `## Patch-Ready Gate` "Mutation requires reconstructed source-to-destination meaning"
- (tradeoff) — does not apply

Drafter should pursue (revise) for C-C/C-D/C-K in r4.

LANE-NEXT-CANDIDATE: drafter incorporates C-C/C-D/C-K comprehensive correction + chooses options for C-E/C-G/C-I/C-L + applies C-A/C-J/C-M recommended clarifications in r4 draft. After r4, opinion round repeats until full consent (or HOLD per round cap).
