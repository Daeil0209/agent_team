CRITIC: researcher
ROUND: r2 (folds r1 in-progress critique forward; r1 critique-r1-researcher.md remains in carrier for reference but r2 supersedes for current-round opinion)
TARGET-DRAFT: claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/draft-r2.md
LENS-BASIS (team-lead packet): evidence-quality / external-reference / source-citation — applied as researcher-lane evidence-tier discipline + `Skill(review-verification)` `### 12b. Citation Substantiation Gate` carrier-citation rule per `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`
FINDING-STATE-CEILING (lane): `candidate-classified` per `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`
ASSIGNMENT-FOCUS (team-lead packet, verbatim): "challenge the upper-philosophy-compliance claim with evidence checks — does the rule wording actually cite each controlling §1-§8 surface? does the fallback chain trace evidence?" + r2 specific: INVARIANT clause enforceability, redesign semantics, "best of incompliant options forbidden" wording strength.

## 1. r2 Delta Summary And Headline Finding

**r2 delta vs r1**: r2 adds Item 1 bullet 3 INVARIANT clause + amends Items 2/3/4 trigger bullets to cite "the canonical INVARIANT" pointer. r2 preserves r1 wording on Item 1 bullets 1, 2, and 4 (renumbered as the fallback chain) verbatim — so r1's source-citation defects (F1-F6) carry forward into r2 unchanged.

**Headline (r2)**: the INVARIANT clause is operationally the **strongest** binding the draft contains — but its enforcement mechanism cites `Skill(review-verification) ## Upstream Basis Review Law` (wrong owner per r1 F1, carried forward) and "ALL §1-§8 upper-philosophy conditions" (still no per-section anchor per r1 F2, AMPLIFIED by the new MUST/INVARIANT/forbidden framing). The stronger the claim, the more critical the source-citation defect. r2 amplifies r1's headline rather than fixing it: a non-negotiable rule that cannot be performed at the consumption surface because its enforcement anchor points to a section that does not exist in the cited owner.

r2-specific NEW findings beyond r1 carry-forward:
- F7-NEW: "invariant violation" defect classification term used in Item 1 bullet 3 without anchor; not a defined class in the in-corpus defect taxonomy.
- F8-NEW: `Skill(team-meeting) ## 3-4. Opinion Round` cited at wrong heading depth (same defect pattern as r1 F4 on `## 3-6. Convergence`).
- F9-NEW: "new SOLUTION items" cross-referenced under `### 3-4. Opinion Round`, but the SOLUTION-items definition + iterability rule lives at `### 3-3. Solution Draft`; cross-reference imprecision.
- F10-NEW: "until at least one option satisfies all upper-philosophy conditions" wording introduces a potential sufficiency tension with `Skill(team-meeting) ### 3-6. Convergence` line 129 "unanimous participant consent for every solution item" requirement — INVARIANT compliance is necessary, consent is also required; the "at least one option" phrasing risks reading as sufficient.

Carry-forward findings F1-F6 from r1 still apply to r2. Adjacent observations A1-A3 from r1 still apply to r2.

## 2. r2 INVARIANT-Specific Findings (NEW)

### F7-NEW. "Invariant violation" defect classification without anchor (Item 1 bullet 3)
- **Draft wording**: "Selection of an upper-philosophy-incompliant option, picking the 'best of incompliant options', or shortcutting redesign in favor of escalation is a procedure-adherence + invariant violation."
- **Source check evidence (current-turn Bash grep on `.claude/CLAUDE.md` + `.claude/reference/*.md`)**:
  - The term `invariant` IS in-corpus, but only as a NOUN describing the Constitutional Reporting Curtain's 4 invariants (a/b/c/d) per `.claude/CLAUDE.md` line 7 and `.claude/reference/reporting-core-law.md` line 26.
  - There is NO defined defect class named `invariant-violation` or `invariant-breach` in the corpus. The closest existing class is `curtain-breach` (per `.claude/reference/review-and-verification-core-law.md` line 125) for breach of constitutional curtain invariants specifically — which is NOT the choice-situation-invariant the drafter introduces.
  - Verbatim grep output: no match for `invariant-violation`, `invariant-breach`, `invariant violation` (other than the draft itself), or `invariant violations` in `.claude/reference/*.md` or `.claude/CLAUDE.md`.
- **Defect class**: source-citation missing-anchor + new-term-without-owner — the draft introduces "invariant violation" as a defect classification without (a) citing an existing owner that defines it, (b) declaring a new class with its own owner surface, or (c) subsuming it under an existing class (e.g., `procedure-adherence` already covers the same operating effect per `.claude/reference/review-and-verification-core-law.md` `## Owner Boundary And Skill Consumption Law` line 65).
- **Operating effect**: a downstream `Skill(review-verification)` Step 4 / Step 12 attempting to classify a violation of the new INVARIANT into the finding-state ladder cannot map "invariant violation" to a defined defect class. Either (a) the reviewer drops "invariant violation" and uses "procedure-adherence defect" alone, weakening the new INVARIANT's distinct enforcement basis, or (b) the reviewer treats "invariant violation" as a novel class without promotion criteria, leaving classification undefined.
- **Candidate-classified state**: `candidate-classified:source-citation-missing-anchor` + `candidate-classified:new-term-without-owner-surface`
- **Suggested correction**: either (a) drop the "invariant violation" phrase and use only "procedure-adherence violation" (with anchor to `.claude/reference/review-and-verification-core-law.md` `## Owner Boundary And Skill Consumption Law`), since procedure-adherence already covers the operating effect; or (b) explicitly define `invariant-violation` as a new defect class with its own owner clause inside Item 1 bullet 3 (e.g., "is a procedure-adherence defect classified as `confirmed-defect:invariant-violation` per this rule") so the new class has its own definition surface in the canonical owner; or (c) re-use the `curtain-breach` pattern from `review-and-verification-core-law.md` line 125 — a named defect class with explicit promotion criteria — as the structural model.

### F8-NEW. Wrong-heading-depth citation: `Skill(team-meeting) ## 3-4. Opinion Round` (Item 1 bullet 3)
- **Draft wording**: "the meeting MUST redesign options within the meeting (additional opinion rounds, drafter persuasion-target conversion, or new SOLUTION items per `Skill(team-meeting)` `## 3-4. Opinion Round`) until at least one option satisfies all upper-philosophy conditions"
- **Source check evidence (current-turn Read tool-call on `.claude/skills/team-meeting/SKILL.md` lines 40-150)**:
  - Top-level section: `## 3. Meeting Procedure` (line 40, two hashes).
  - Sub-section: `### 3-4. Opinion Round` (line 72, **three hashes**, sub-section depth).
- **Defect class**: source-citation wrong-heading-depth — same defect pattern as r1 F4 (`## 3-6. Convergence` cited at wrong depth). Both r1 F4 and r2 F8 demonstrate consistent heading-depth citation imprecision across the drafter's references to team-meeting sub-sections.
- **Operating effect**: minor — section is content-discoverable; grep-based discovery requires `^### 3-4` not `^## 3-4`. Substantive force preserved.
- **Candidate-classified state**: `candidate-classified:source-citation-precision-defect`
- **Suggested correction**: write `### 3-4. Opinion Round` (three hashes) or rewrite as `Skill(team-meeting) Section 3-4. Opinion Round`.

### F9-NEW. Cross-reference imprecision: "new SOLUTION items" cited under `### 3-4. Opinion Round` (Item 1 bullet 3)
- **Draft wording**: "(additional opinion rounds, drafter persuasion-target conversion, or new SOLUTION items per `Skill(team-meeting)` `## 3-4. Opinion Round`)"
- **Source check evidence (current-turn Read tool-call on team-meeting SKILL.md)**:
  - `### 3-3. Solution Draft` (line 55) carries SOLUTION-item definition: line 59 "The draft's SOLUTION may contain multiple items." line 60 "Each item is independently identifiable and independently iteratable." This is the canonical owner of "SOLUTION items can be added/iterated."
  - `### 3-4. Opinion Round` (line 72) carries opinion-round procedure and revision-action: line 87 "Drafter revises the draft once per round when possible." This covers WHEN revision happens but does not define what SOLUTION items are.
  - "new SOLUTION items" semantically combines the `### 3-3` definition with the `### 3-4` revision-trigger. The single citation to `### 3-4` is incomplete.
- **Defect class**: source-citation incomplete-anchor (cross-reference imprecision) — minor.
- **Operating effect**: minor — readers familiar with `### 3-3` content can infer; readers without familiarity may not find SOLUTION-items definition under `### 3-4`.
- **Candidate-classified state**: `candidate-classified:source-citation-cross-reference-imprecision`
- **Suggested correction**: cite both anchors: "per `Skill(team-meeting)` `### 3-4. Opinion Round` revision discipline and `### 3-3. Solution Draft` multi-item structure" — or restructure so each of the 3 listed redesign mechanisms gets its own anchor.

### F10-NEW. Sufficiency-vs-necessity tension: "at least one option satisfies all upper-philosophy conditions" vs `### 3-6. Convergence` unanimous-consent rule (Item 1 bullet 3)
- **Draft wording**: "the meeting MUST redesign options within the meeting ... until at least one option satisfies all upper-philosophy conditions"
- **Source check evidence (current-turn Read tool-call on `.claude/skills/team-meeting/SKILL.md`)**:
  - Line 129 (`### 3-6. Convergence`): "Marathon convergence requires unanimous participant consent for every solution item."
  - Line 130: "A remaining material objection on any item triggers dissent-to-solution conversion before further opinion rounds on that item."
  - Line 132: "Operator-set round limit reached before full consent records `HOLD`."
- **Tension analysis**:
  - The INVARIANT establishes a NECESSARY condition: the chosen direction must satisfy ALL §1-§8.
  - `### 3-6. Convergence` establishes a separate NECESSARY condition: unanimous participant consent.
  - The "until at least one option satisfies" phrasing in r2 reads as if invariant compliance is sufficient to stop redesign rounds. But unanimous consent is also required to STOP the meeting at convergence; without consent, the meeting continues regardless of compliance status.
  - Worst-case scenario: drafter produces one INVARIANT-compliant option (compliance satisfied) but participants withhold consent on grounds OTHER than upper-philosophy compliance (e.g., a different procedural concern). The r2 wording could be read as authorizing meeting closure on compliance alone, bypassing consent.
- **Defect class**: source-citation incomplete-coherence — the INVARIANT clause should explicitly preserve `### 3-6. Convergence` consent gate.
- **Operating effect**: in practice, a careful drafter would not close a meeting without consent; but the rule wording reads as if INVARIANT compliance is the sole gate. A misinterpreting consumer could prematurely close meetings.
- **Candidate-classified state**: `candidate-classified:source-citation-incomplete-coherence` + `candidate-classified:rule-wording-sufficiency-ambiguity`
- **Suggested correction**: replace "until at least one option satisfies all upper-philosophy conditions" with "until the meeting's chosen solution satisfies all upper-philosophy conditions AND meets `Skill(team-meeting)` `### 3-6. Convergence` unanimous-participant-consent requirement"; or split the requirement: "until at least one option satisfies all upper-philosophy conditions; the meeting still requires `Skill(team-meeting)` `### 3-6. Convergence` unanimous consent to close."

## 3. Carry-Forward Findings From r1 (still present in r2)

r1 findings F1-F6 were authored against draft-r1; their cited source text is preserved verbatim in r2 bullets 1, 2, and 4 (renumbered as the fallback chain). r2 Item 1 bullet 3 (INVARIANT) REPRODUCES the F1 + F2 defects in its own enforcement anchor. Each is recorded here in short form; full evidence inventory is in `claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/critique-r1-researcher.md` and remains current as upstream basis.

### F1' (r2-amplified, was r1 F1). Wrong-owner citation: `Skill(review-verification) ## Upstream Basis Review Law`
- **r2 location**: Item 1 bullet 3 INVARIANT clause: "per `Skill(review-verification)` `## Upstream Basis Review Law` consumption of every controlling philosophy section and mapped core-law axes"
- **r2 amplification**: the section `## Upstream Basis Review Law` lives at `.claude/reference/review-and-verification-core-law.md` line 16, NOT in `Skill(review-verification)` SKILL.md (current-turn `Bash grep` zero matches in SKILL.md, exact match in core law). r2 uses this wrong-owner citation as the enforcement mechanism for the strongest claim in the draft (the INVARIANT). The INVARIANT cannot be performed at the cited owner because the section does not exist there.
- **Candidate-classified state**: `candidate-classified:source-citation-wrong-owner` + `candidate-classified:invariant-enforcement-anchor-broken`
- **Promotion path**: team-lead synthesis + Skill(review-verification) defect-promotion

### F2' (r2-amplified, was r1 F2). Incomplete §1-§8 per-section anchor
- **r2 location**: Item 1 bullet 3 INVARIANT clause "ALL §1-§8 upper-philosophy conditions" + Items 2/3/4 "ALL §1-§8 upper-philosophy conditions per the canonical INVARIANT"
- **r2 amplification**: r1 said "designed for full §1-§8 upper-philosophy compliance"; r2 says "MUST satisfy ALL §1-§8 upper-philosophy conditions" and adds the redesign mandate "until at least one option satisfies all upper-philosophy conditions". The verb force escalated (designed → MUST + INVARIANT + forbidden), but the per-section anchor gap is unchanged: §2 Detailed Design, §4 Review And Verification, §5 Modification, §6 Judgment, §7 Reporting, §8 Environment Configuration are still not per-section anchored. The "explicit record of which upper-philosophy conditions remain incompliant in every option" (r2 fallback bullet 4) explicitly DEPENDS on per-section anchor — without it, the explicit record cannot be operationalized.
- **Candidate-classified state**: `candidate-classified:source-citation-incomplete-anchor` + `candidate-classified:execution-force-weakening` + `candidate-classified:invariant-enforcement-anchor-broken`
- **Promotion path**: team-lead synthesis + Skill(review-verification) defect-promotion

### F3' (carry-forward, was r1 F3). Wrong-line-range citation: "standard exception classes at lines 95-99"
- **r2 location**: Item 1 fallback chain (bullet 4)
- **r2 status**: identical wording to r1; same defect. r2 adds "with explicit record of which upper-philosophy conditions remain incompliant in every option" which depends on F2 anchor.
- **Candidate-classified state**: `candidate-classified:source-citation-wrong-line-range` + `candidate-classified:execution-conflict-with-cited-text`
- **Correction**: replace "lines 95-99" with "line 90".

### F4' (carry-forward, was r1 F4). Wrong-heading-depth citation: `Skill(team-meeting) ## 3-6. Convergence`
- **r2 location**: Item 1 fallback chain (bullet 4)
- **r2 status**: identical to r1; same defect.
- **Candidate-classified state**: `candidate-classified:source-citation-precision-defect`
- **Correction**: write `### 3-6.` not `## 3-6.`.

### F5' (carry-forward, was r1 F5). Paraphrase-shifted citation of CLAUDE.md §1 Success criteria
- **r2 location**: Item 1 bullet 1: "frozen request fit + concrete deliverable satisfaction + user burden reduction + decisive user-surface closure"
- **r2 status**: identical wording to r1; same paraphrase-shift (frozen → request, frozen → concrete on deliverable).
- **r2 ADDITIONAL concern**: the INVARIANT clause's enforcement now binds to §1-§8 "conditions" including §1 success criteria. The paraphrase-shift on §1 success criteria means the INVARIANT cannot be performed against §1 with source-exact fidelity. F5 escalates from precision-defect to invariant-enforcement-input defect.
- **Candidate-classified state**: `candidate-classified:source-citation-paraphrase-shift` + `candidate-classified:execution-force-weakening` + `candidate-classified:invariant-enforcement-input-corrupted`
- **Correction**: restore source-exact "request fit, frozen deliverable satisfaction, user burden reduction, and decisive user-surface closure".

### F6' (carry-forward, was r1 F6). Implicit but uncited carrier: `procedure-adherence` defect classification
- **r2 location**: Item 1 bullet 2 (preserved from r1) + Item 1 bullet 3 INVARIANT clause (newly uses the same phrasing "procedure-adherence + invariant violation").
- **r2 status**: identical to r1; same missing anchor. The new INVARIANT bullet adds "invariant violation" alongside "procedure-adherence" (see F7-NEW above).
- **Candidate-classified state**: `candidate-classified:source-citation-missing-anchor`
- **Correction**: anchor `procedure-adherence` to `.claude/reference/review-and-verification-core-law.md` `## Owner Boundary And Skill Consumption Law`.

## 4. INVARIANT Enforceability Assessment (team-lead packet specific questions)

Team-lead packet (r2 redirect) asks three specific INVARIANT-focused questions. Researcher direct answers with evidence basis:

### Q1: "is 'MUST satisfy ALL §1-§8' enforceable?"
**Answer: NOT ENFORCEABLE AS WRITTEN.** Two blocking defects:
- F1' (wrong-owner): the enforcement anchor `Skill(review-verification) ## Upstream Basis Review Law` points to a section that does not exist in the cited owner. Consumer cannot consume the test.
- F2' (incomplete-anchor): "ALL §1-§8 upper-philosophy conditions" is asserted without per-section axes. Even if F1' is corrected to the right owner (`.claude/reference/review-and-verification-core-law.md`), the §1-§8 unified phrase still leaves §2, §4, §5, §6, §7, §8 without traceable per-section test axes. The active owner consuming this rule cannot enumerate which conditions to check.
**Enforceability becomes possible after F1' + F2' correction.** Suggested wording in r1 F2 carry-forward correction applies here also.

### Q2: "are 'presented options redesign' semantics clear?"
**Answer: PARTIALLY CLEAR; THREE PRECISION DEFECTS.**
- The redesign mechanisms cited ("additional opinion rounds, drafter persuasion-target conversion, or new SOLUTION items") map to team-meeting `### 3-4. Opinion Round` content lines 86-99 — substantively correct.
- F8-NEW: heading depth `## 3-4.` should be `### 3-4.` (minor).
- F9-NEW: "new SOLUTION items" semantics span `### 3-3` + `### 3-4`; single anchor incomplete (minor).
- F10-NEW: "until at least one option satisfies all upper-philosophy conditions" creates a sufficiency tension with `### 3-6. Convergence` unanimous-consent requirement; the rule wording could be misread as authorizing meeting closure on compliance alone (material).
- "after exhausting redesign rounds" in the fallback chain (bullet 4) — semantically maps to `### 3-6. Convergence` round-cap reached without full consent (HOLD) per line 132; this part is clear.

### Q3: "is 'best of incompliant options forbidden' wording strong enough?"
**Answer: WORDING STRENGTH IS ADEQUATE; CLASSIFICATION PATH IS NOT.**
- Wording: "Selection of an upper-philosophy-incompliant option, picking the 'best of incompliant options', or shortcutting redesign in favor of escalation is a procedure-adherence + invariant violation." — three explicit forbidden patterns + classification = strong wording on form.
- Classification path defect: F7-NEW — "invariant violation" is a novel classification term without anchor; downstream `Skill(review-verification)` cannot map it to a defined defect class. Either drop the term and use procedure-adherence alone, or define `invariant-violation` as a new class with its own owner clause (recommended pattern: follow `curtain-breach` precedent at `.claude/reference/review-and-verification-core-law.md` line 125).
- Additional gap: the wording forbids selection/picking/shortcutting but does not explicitly state the POSITIVE next-action. A consumer seeing the forbidden patterns needs the positive route: "If no compliant option exists after redesign exhaustion, route to fallback chain (Item 1 bullet 4)." This is implicit in the structure but not stated in bullet 3. Suggest cross-link: "If redesign rounds fail to produce a compliant option, route to the fallback chain below."

## 5. Fallback-Chain Evidence Trace (r2 update from r1)

r2 Item 1 bullet 4 (fallback chain) preserves r1's wording AND adds "after exhausting redesign rounds" + "with explicit record of which upper-philosophy conditions remain incompliant in every option".

- Hop A (Skill(team-meeting) infeasible per 3-condition test, line 92): **VALID** (verified current-turn Read of work-execution-core-law.md line 92). r2 adds parenthetical paraphrase "bounded, reversible, ≥2 critics with material lens basis" — paraphrase of line 92 conditions. Verbatim line 92 says: "(i) design problem is bounded — single-question or single-design-decision, no external evidence gathering required; (ii) no irreversible commitment within the design — no permanent data loss, no operator-policy-choice the team cannot reverse internally; (iii) the team has sufficient perspective coverage — drafter (team-lead) + ≥2 critics with material lens basis." The r2 paraphrase compresses condition (ii) "no irreversible commitment" to "reversible" — minor compression but acceptable; substantive force preserved.
- Hop B (meeting HOLD per `### 3-6. Convergence` round-cap): **PARTIALLY VALID** — substantive content verified (team-meeting line 103 + line 132), but heading depth defect F4' persists. r2 adds "after exhausting redesign rounds" — semantically aligned with `### 3-6. Convergence` HOLD.
- Hop C (route to operator-policy-choice via "standard exception classes at lines 95-99"): **INVALID** — F3' (wrong-line-range); class enumeration is at line 90, not lines 95-99.
- r2 additional gate: "with explicit record of which upper-philosophy conditions remain incompliant in every option" — depends on F2' per-section anchor. Without per-section anchor, the "explicit record" lacks enumerable axes.

**Overall fallback chain trace (r2)**: 1 valid hop (with minor paraphrase compression), 1 partially-valid hop (precision defect), 1 invalid hop (wrong-line-range), 1 added requirement that inherits F2' anchor gap.

## 6. Out-Of-Direct-Assignment Adjacent Findings (carry-forward from r1 + r2-specific)

Carried as `candidate-evidence` for team-lead synthesis to consider or reject; researcher does not promote out-of-lane.

### A1 (carry-forward from r1). Item 4 (governance-modification Step 4 trigger) duplication risk vs. existing §5 8-keyword gate
- Same observation as r1 critique-r1-researcher.md Section 4 A1.
- State: `candidate-evidence:overlap-with-existing-design-gate`

### A2 (carry-forward from r1). "Lines 95-99" cite was likely intended as filter, not enumeration
- Same observation as r1 critique-r1-researcher.md Section 4 A2.
- State: `candidate-evidence:probable-intent-mis-positioning`

### A3 (carry-forward from r1). Promotion-path ambiguity on conjoined classification labels
- Same observation as r1 critique-r1-researcher.md Section 4 A3.
- r2 amplification: r2 conjoins THREE classification labels in Item 1 bullet 3 ("procedure-adherence + invariant violation") with the unresolved "invariant violation" anchor (F7-NEW); promotion-path ambiguity becomes more material.
- State: `candidate-evidence:promotion-path-ambiguity` (r2-amplified)

### A4-NEW (r2). Meta-recursion handling in NEXT ACTION rationale (line 73)
- Observation: r2 NEXT ACTION states "(with the new Item 4 trigger applying to governance-modification's own design — meta-recursive but lawful since the patch design itself is a choice situation requiring team-meeting if multiple defensible designs exist; for THIS patch series the design is now converged via this meeting so meta-recursion does not re-trigger)".
- Researcher reading: the drafter asserts meta-recursion does not re-trigger because design is converged in current meeting. This is defensible IF the current meeting's converged design satisfies Item 4's choice-situation test. But the test requires "multiple defensible CHANGE-SEQUENCE-DESIGN options" — has the current meeting actually explored multiple change-sequence designs (e.g., 4-bullet additive insertion vs. re-home to `## 1. Purpose` vs. split across two laws vs. consolidate with existing line 91-93)? The MEETING-AGENDA + SOLUTION sections show only one design (additive 4-bullet to canonical owner + 3 consumers); there is no evidence the meeting explored alternative change-sequence designs and converged on this one.
- This means at consumption time, a future Skill(review-verification) auditor could find the patch series violated Item 4 at install time. Not blocking for current meeting consent but a documented preservation concern.
- State: `candidate-evidence:meta-recursion-preservation-risk` — for team-lead synthesis + Skill(governance-modification) Step 4 design review at patch installation.

### A5-NEW (r2). INVARIANT clause coverage gap on r1-r2 carry-forward defects
- Observation: r2 introduces INVARIANT requiring chosen direction to satisfy ALL §1-§8 upper philosophy. The current draft-r2 contains source-citation defects (F1-F10) that themselves violate §4 Review And Verification Philosophy (specifically `Skill(review-verification)` `### 12b. Citation Substantiation Gate` and `.claude/reference/review-and-verification-core-law.md` `## Minimum Executable Information Law` under-specification class).
- Meta-implication: by the INVARIANT's own test, draft-r2 currently does NOT satisfy §4 upper-philosophy compliance — and therefore by the INVARIANT itself, draft-r2 should be redesigned (F1-F10 corrected) before consent rather than selected as-is.
- This is a self-referential application of the new rule to the patch that installs it.
- State: `candidate-evidence:self-referential-invariant-test` — for drafter awareness and r3 revision posture.

## 7. MEETING-AUDIT-CRITERIA Lens (researcher, r2)

Per `### 3-5. MEETING-AUDIT-CRITERIA` (team-meeting line 106-126):
- **agenda fit**: substantive design covers all 5 operator-directive parts including INVARIANT. Researcher does not challenge this.
- **simplicity**: 7 bullets total (4 canonical + 3 consumer). INVARIANT bullet is one rule with sub-clauses. Bullet count is reasonable. **Minimum-executable-information by bullet content is NOT satisfied** for Item 1 bullets 1, 2, 3, 4 (F1'-F6' + F7-F10 source-citation defects make per-bullet content non-minimum-executable at consumption surface).
- **correctness**: F1-F10 enumerate citation defects against cited surfaces. Substantive design intent (canonical + 3 consumers + INVARIANT + carve-out + fallback) is correctness-defensible. Citation correctness is NOT clean. r2 INVARIANT's self-application (A5-NEW) suggests by-its-own-test it requires redesign before consent.
- **feasibility**: NEXT ACTION names `Skill(governance-modification)` 4-patch loop — form passes. Per-patch citation correction must happen before mutation so post-verify can pass.
- **bottleneck control**: 4 patches independent per dimensional-independence. Researcher does not challenge.
- **operator-emphasized 8 keywords** (drafter self-check claims all pass):
  - `consumed-surface` ✗ (F1': wrong-owner citation)
  - `executable-imperative` ✗ partial (F2': §1-§8 unified phrase non-executable at consumption surface; F7-NEW: "invariant violation" classification non-executable)
  - `minimum-executable-information` ✗ partial (F2' + F3' + F5' + F10-NEW: under-specification / conflict / paraphrase-shift / sufficiency-ambiguity defects)
  - `comprehension-as-execution-force` ✗ partial (F7-NEW: "invariant violation" introduces new term without owner definition; F10-NEW: "at least one option" wording risks misread)
  - other 4 keywords (`removal-first`, `no-compression`, `upper-lower execution-drive`, `dimensional-independence`) — researcher does not challenge.

## 8. Researcher Critic Verdict (r2)
- **Overall**: substantive design intent including new INVARIANT clause **accepted with material objection**; source-citation field of every proposed bullet requires correction before patch mutation; r2's INVARIANT clause increases the criticality of r1's unresolved F1' and F2' findings because the INVARIANT depends on them as enforcement anchors.

- **r2 material objections (drafter must address before researcher consent on r3)**:
  - O1' (F1'): correct wrong-owner citation of `## Upstream Basis Review Law` (carry-forward from r1; r2 escalates criticality).
  - O2' (F2'): replace unified "ALL §1-§8 upper-philosophy conditions" with per-section anchor enumeration OR single owner-binding pointer preserving traceability for all 8 sections (carry-forward from r1; r2 escalates).
  - O3' (F3'): correct wrong-line-range "lines 95-99" → "line 90" (carry-forward from r1).
  - O4' (F5'): restore source-exact CLAUDE.md §1 success-criteria wording (carry-forward from r1; r2 escalates because INVARIANT now binds to §1 conditions).
  - O5-NEW (F7-NEW): resolve "invariant violation" classification — drop the term and use procedure-adherence alone, OR define as new class with owner clause inside Item 1 bullet 3.
  - O6-NEW (F10-NEW): resolve sufficiency-vs-necessity tension between INVARIANT compliance and `### 3-6. Convergence` unanimous-consent requirement.

- **Non-material objections (recommended but not consent-blocking)**:
  - N1' (F4'): heading-depth precision `### 3-6.` not `## 3-6.` (carry-forward from r1).
  - N2' (F6'): explicit anchor for `procedure-adherence` term (carry-forward from r1).
  - N3-NEW (F8-NEW): heading-depth precision `### 3-4.` not `## 3-4.`.
  - N4-NEW (F9-NEW): cross-reference "new SOLUTION items" — add `### 3-3. Solution Draft` co-anchor.

- **Adjacent observations carried as candidate-evidence (A1-A5)** — for drafter / team-lead synthesis / coherence-integrity-lens reviewer / Skill(governance-modification) Step 4 reviewer consideration. A5-NEW (self-referential invariant test) is particularly material to drafter's r3 posture.

## 9. FINDING-STATE-INVENTORY (researcher lane, r2; ceiling = candidate-classified)

| ID | Defect class | Ladder state | Lens basis | Promotion owner | Carry/New |
|---|---|---|---|---|---|
| F1' | source-citation wrong-owner + invariant-enforcement-anchor-broken | `candidate-classified:source-citation-wrong-owner` + `candidate-classified:invariant-enforcement-anchor-broken` | source-citation + evidence-quality | team-lead synthesis + Skill(review-verification) | r2-amplified |
| F2' | source-citation incomplete-anchor + execution-force-weakening + invariant-enforcement-anchor-broken | `candidate-classified:source-citation-incomplete-anchor` | source-citation + external-reference | team-lead synthesis + Skill(review-verification) | r2-amplified |
| F3' | source-citation wrong-line-range + execution-conflict-with-cited-text | `candidate-classified:source-citation-wrong-line-range` | source-citation | team-lead synthesis + Skill(review-verification) | r1 carry-forward |
| F4' | source-citation wrong-heading-depth | `candidate-classified:source-citation-precision-defect` | source-citation | drafter direct revision | r1 carry-forward |
| F5' | source-citation paraphrase-shift + execution-force-weakening + invariant-enforcement-input-corrupted | `candidate-classified:source-citation-paraphrase-shift` | source-citation | team-lead synthesis + Skill(review-verification) | r2-amplified |
| F6' | source-citation missing-anchor | `candidate-classified:source-citation-missing-anchor` | source-citation | drafter direct revision | r1 carry-forward |
| F7-NEW | source-citation missing-anchor + new-term-without-owner-surface | `candidate-classified:new-term-without-owner-surface` | source-citation | team-lead synthesis + Skill(review-verification) | r2-NEW |
| F8-NEW | source-citation wrong-heading-depth (`## 3-4.` should be `### 3-4.`) | `candidate-classified:source-citation-precision-defect` | source-citation | drafter direct revision | r2-NEW |
| F9-NEW | source-citation cross-reference-imprecision | `candidate-classified:source-citation-cross-reference-imprecision` | source-citation | drafter direct revision | r2-NEW |
| F10-NEW | source-citation incomplete-coherence + rule-wording-sufficiency-ambiguity | `candidate-classified:source-citation-incomplete-coherence` | source-citation + coherence-integrity (in-scope as source-citation since rule wording is the cited surface) | team-lead synthesis + Skill(review-verification) | r2-NEW |
| A1 | overlap-with-existing-design-gate | `candidate-evidence:adjacent-coherence-observation` | coherence-integrity (out-of-lane) | team-lead / coherence-integrity-lens reviewer | r1 carry-forward |
| A2 | probable-intent-mis-positioning | `candidate-evidence:drafter-intent-observation` | source-citation | drafter direct revision | r1 carry-forward |
| A3 | promotion-path-ambiguity (r2-amplified by F7-NEW) | `candidate-evidence:execution-ambiguity-observation` | procedure-adherence (out-of-lane) | drafter direct revision or team-lead | r1 carry-forward (r2-amplified) |
| A4-NEW | meta-recursion preservation risk for Item 4's own patch installation | `candidate-evidence:meta-recursion-preservation-risk` | governance-continuity (out-of-lane) | team-lead synthesis + Skill(governance-modification) Step 4 reviewer | r2-NEW |
| A5-NEW | self-referential invariant test (INVARIANT applied to draft-r2 itself flags F1-F10 as §4 incompliance) | `candidate-evidence:self-referential-invariant-test` | source-citation + coherence-integrity (in-scope as researcher critique meta-observation) | drafter (r3 redesign posture) | r2-NEW |

## 10. CITATION-EVIDENCE-INVENTORY (per `Skill(review-verification) ### 12b. Citation Substantiation Gate`)

All external citations in this critique carrier are Class A (current-turn Read/Bash tool-call against cited surface). Where citation evidence reuses r1 critique's verified tool-calls within the same session, the entry is Class B with explicit originating-turn reference to the prior turn's tool-call.

- `.claude/CLAUDE.md` line 7 (Constitutional 4 invariants enumeration) — Class B with originating r1-critique-turn Read tool-call reference; current-turn confirmation via `Bash grep -n "invariant\|INVARIANT" .claude/CLAUDE.md` returning line 7 match.
- `.claude/CLAUDE.md` line 29 (§1 success criteria) — Class B with originating r1-critique-turn Read tool-call.
- `.claude/reference/work-execution-core-law.md` lines 87-99 (Autonomy And Escalation Law) — Class B with originating r1-critique-turn Read.
- `.claude/reference/review-and-verification-core-law.md` line 16 (Upstream Basis Review Law header), line 65 (procedure-adherence term), line 73 (Anti-Narrowing Law procedure-adherence term), line 125 (curtain-breach defect class) — Class B (r1-turn) + Class A current-turn Bash grep on `.claude/reference/*.md` confirming `invariant` term distribution.
- `.claude/reference/reporting-core-law.md` line 26 (Constitutional 4 invariants reference) — Class A current-turn Bash grep on `.claude/reference/*.md`.
- `.claude/skills/review-verification/SKILL.md` (no `## Upstream Basis Review Law` section) — Class B with r1-turn Bash grep zero-match evidence.
- `.claude/skills/team-meeting/SKILL.md` lines 40-150 — Class B (r1-turn) for `## 3. Meeting Procedure`, `### 3-3. Solution Draft` (line 55), `### 3-4. Opinion Round` (line 72), `### 3-5. MEETING-AUDIT-CRITERIA` (line 106), `### 3-6. Convergence` (line 128), round-cap content (lines 102-104, line 132), persuasion-target (lines 93-99), multi-item SOLUTION (lines 59-60), unanimous consent (line 129).
- `claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/draft-r2.md` — Class A current-turn Read tool-call full file.
- `claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/critique-r1-researcher.md` — Class A current-turn (file written by researcher in same session; self-reference + Write tool-call evidence).

## 11. OPEN-SURFACES (researcher → team-lead synthesis, r2)
- O1'-O4' (material, r1 carry-forward, r2-amplified for O1'-O2'-O4'): require drafter revision in r3 before researcher critic consent.
- O5-NEW (F7-NEW) + O6-NEW (F10-NEW): r2-specific material objections; require r3 revision.
- N1'-N4-NEW (non-material): recommended for drafter clean-up, not consent-blocking.
- A1-A5 (adjacent candidate-evidence): for team-lead synthesis + downstream lens reviewers; A5-NEW particularly material to drafter's r3 redesign posture.
- Substantive design intent (canonical 4-bullet + 3 consumer triggers + INVARIANT + carve-out + fallback chain) remains researcher-acceptable as design shape; researcher consent is gated on source-citation correction and INVARIANT enforcement anchor restoration, not design redesign.

## 12. LANE-NEXT-CANDIDATE
- Smallest next owner/action: team-lead routes O1'-O6-NEW to drafter (team-lead) for r3 revision; r3 carrier path = `claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/draft-r3.md`; r3 receives a fresh researcher critic pass and fresh reviewer-shard-a / reviewer-shard-b / developer critic passes.
- reviewer-shard-a (design-intent + coherence-integrity + patch-worthiness) and reviewer-shard-b (governance-continuity + minimum-executable-information + negative-risk + removal-first) and developer opinions remain independent and may converge or diverge with researcher findings on r2.
- Per `### 3-4. Opinion Round` line 81-84 and operator-set round-cap (default 5 rounds per line 103), r3 budget remains within marathon limits.
- Final acceptance authority remains with operator gate per `### 3-7. Operator Gate`; researcher critique is bounded packet evidence only.

UPSTREAM-DECISION-BASIS-CONSUMPTION: `draft-r2.md` consumed in current turn (Read); `draft-r1.md`, `critique-r1-researcher.md`, CLAUDE.md, work-execution-core-law.md, review-and-verification-core-law.md, team-meeting/SKILL.md, review-verification/SKILL.md, agent-researcher/references/researcher-lane-detail.md consumed via prior-turn Read in same session (Class B basis); current-turn Bash grep on `.claude/reference/*.md` + `.claude/CLAUDE.md` for `invariant` term verified F7-NEW. researcher Skill(agent-researcher) loaded prior turn (same session, Class B); Skill(review-verification) loaded prior turn (same session, Class B); evidence-tier discipline applied with external-authoritative in-corpus governance text as authoritative tier; no model-memory substitution.
