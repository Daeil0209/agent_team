CRITIC: researcher
ROUND: r1
TARGET-DRAFT: claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/draft-r1.md
LENS-BASIS (team-lead packet): evidence-quality / external-reference / source-citation — applied as researcher-lane evidence-tier discipline + `Skill(review-verification)` `### 12b. Citation Substantiation Gate` carrier-citation rule per `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`
FINDING-STATE-CEILING (lane): `candidate-classified` per `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law` lines 33-34 (binding cross-surface filtering, promotion, and patch-worthiness route to team-lead synthesis + `Skill(review-verification)` defect-promotion basis)
ASSIGNMENT-FOCUS (team-lead packet, verbatim): "challenge the upper-philosophy-compliance claim with evidence checks — does the rule wording actually cite each controlling §1-§8 surface? does the fallback chain trace evidence?"

## 1. Headline Finding
The draft installs a generalized choice-situation rule whose substantive design intent (canonical owner + 3 consumer triggers + carve-out + fallback chain) is defensible, but **multiple controlling source citations in the proposed bullet wording are wrong-owner, wrong-line-range, wrong-heading-depth, or paraphrase-shifted relative to the cited surfaces**, and the **"§1-§8 upper-philosophy compliance" claim is asserted as a unified phrase without per-section anchor for §2, §4, §5, §6, §7, §8** — leaving downstream consumers (Skill(work-planning) Step 2 reader, Skill(task-execution) Step 1 reader, Skill(governance-modification) Step 4 reader, and active-owner choice-situation evaluator) unable to trace which §2-§8 axes the team-meeting solution must satisfy at consumption time. The fallback chain's middle anchor ("standard exception classes at lines 95-99") is line-range-misaligned with the canonical referent already in-corpus at work-execution-core-law line 93.

Lens basis: per researcher lane Evidence Tier Discipline (`.claude/skills/agent-researcher/references/researcher-lane-detail.md` lines 56-60), external authoritative reference > prior session evidence > model prior knowledge > intuition; in-corpus governance text is the authoritative tier for an in-corpus governance patch citation, and citation drift against that tier is an evidence defect even when the substantive design conclusion is defensible.

## 2. Per-Citation Findings (verbatim source-trace evidence)

### F1. Wrong-owner citation: `Skill(review-verification) ## Upstream Basis Review Law` (Item 1, bullet 2)
- **Draft wording**: "the team-meeting solution must be designed for full §1-§8 upper-philosophy compliance per `Skill(review-verification)` `## Upstream Basis Review Law` consumption of every controlling philosophy section and mapped core-law axes"
- **Source check evidence (current-turn Read tool-calls)**:
  - `.claude/skills/review-verification/SKILL.md` section headers (current-turn `Bash grep -n "^## "`): `## Structural Contract`, `## Activation`, `## Reference Map`, `## Named Lane Lens Index`, `## Packet`, `## Review Workflow` (with Steps 1-14 + 12b), `## Handoff Or Next Work`. **No `## Upstream Basis Review Law` section exists in `Skill(review-verification)` SKILL.md.**
  - `.claude/reference/review-and-verification-core-law.md` line 16: `## Upstream Basis Review Law` — section DOES exist here, in the mapped core law, NOT in the skill.
- **Defect class**: source-citation wrong-owner — cites a skill that does not own the section; canonical owner is `.claude/reference/review-and-verification-core-law.md` `## Upstream Basis Review Law` (line 16, executable detail at lines 17-21).
- **Operating effect**: a Skill(work-planning) Step 2 reader (Item 2 consumer trigger), Skill(task-execution) Step 1 reader (Item 3 trigger), or Skill(governance-modification) Step 4 reader (Item 4 trigger) following the citation chain through to `Skill(review-verification)` for the upper-philosophy-compliance test will find no `## Upstream Basis Review Law` section there and will either (a) silently substitute review-verification Steps 1-14 as the basis (which is not the §1-§8 compliance test owner) or (b) HOLD on missing basis. Either path breaks the new rule's enforceability at consumption time.
- **Candidate-classified state**: `candidate-classified:source-citation-wrong-owner`
- **Suggested correction (researcher candidate, not promotion)**: replace `Skill(review-verification) ## Upstream Basis Review Law` with `.claude/reference/review-and-verification-core-law.md ## Upstream Basis Review Law`.

### F2. Incomplete §1-§8 per-section anchor (Item 1, bullet 2; Items 2/3/4 trigger bullets all echo)
- **Draft wording**: "designed for full §1-§8 upper-philosophy compliance" (Item 1); "the team-meeting solution must satisfy §1-§8 upper-philosophy compliance" (Items 2, 3, 4).
- **Source check evidence (current-turn Read tool-calls on `.claude/CLAUDE.md` lines 25-80 + governance text body)**:
  - §1 Design Definition Philosophy — explicitly cited via "user-stated-goal coverage per `.claude/CLAUDE.md` `## 1. Design Definition Philosophy` Success criteria" parenthetical in Item 1 bullet 1.
  - §3 Work Execution Philosophy — implicitly invoked via "[NO-NEEDLESS-ASK] + procedure-adherence violation" wording (Item 1 bullet 2); `[NO-NEEDLESS-ASK]` is the §3 / work-execution-core-law `## Autonomy And Escalation Law` line 88 token.
  - §2 Detailed Design Philosophy — **NOT cited** in any of the 6 proposed bullets. CLAUDE.md §2 lines 36-43 carry `TARGET-INTENT-BASIS`, design intent, solution structure, scope boundary, proof path, acceptance path, and drift stop. A choice situation whose options differ on `TARGET-INTENT-BASIS` fidelity has §2 as the controlling philosophy section; the team-meeting compliance test must consult §2 / detailed-design-core-law axes. The unified phrase "§1-§8" gives the reader no anchor to §2's axes.
  - §4 Review And Verification Philosophy — **NOT cited per-section**. CLAUDE.md §4 lines 61-74 carry upstream-basis review, evidence-outranks-assumption, candidate vs confirmed-defect separation, and patch-worthiness separation. The team-meeting solution's "designed for compliance" claim is a positive claim that §4's Upstream Basis Review Law (the actual section, in `review-and-verification-core-law.md` line 16) governs; per-section anchor missing.
  - §5 Modification Philosophy — **NOT cited per-section** even though Item 4 trigger bullet targets `Skill(governance-modification)` Step 4 (i.e., the philosophy whose canonical executable detail is `modification-core-law.md`). The 8 operator-emphasized keywords (CLAUDE.md §5 line 79) are not referenced in the proposed bullets' §1-§8 compliance phrase; the self-check section MEETING-AUDIT-CRITERIA (lines 97-105) names them, but the **proposed canonical text itself** does not.
  - §6 Judgment Philosophy — **NOT cited**. Choice situations affecting validator's final PASS/HOLD/FAIL ownership or independent-lane separation (CLAUDE.md §6 lines 113-122) are not anchored.
  - §7 Reporting Philosophy — **NOT cited**. Choice situations affecting reporting curtain or admitted user-facing surfaces (CLAUDE.md §7 lines 124-134) are not anchored.
  - §8 Environment Configuration Philosophy — **NOT cited**. Choice situations affecting hooks, settings, runtime footprint (CLAUDE.md §8 lines 136-145) are not anchored.
- **Defect class**: source-citation incomplete-anchor — "§1-§8 upper-philosophy compliance" is a unified phrase asserting per-section coverage without per-section anchor; the consuming owner cannot perform the compliance test from the proposed rule wording alone.
- **Operating effect**: the new rule's strongest claim — "designed for full §1-§8 upper-philosophy compliance" — is the rule's UNIQUE contribution beyond existing line 91-93. If the consuming owner cannot trace per-section axes, the new rule reduces to "hold a team-meeting and assert compliance," losing the substantive force that operator directive #2 ("상위 철학 규정을 모두 빠짐없이 준수") demanded.
- **Candidate-classified state**: `candidate-classified:source-citation-incomplete-anchor` + `candidate-classified:execution-force-weakening` (per `.claude/reference/review-and-verification-core-law.md` `## Minimum Executable Information Law` line 91 under-specification class — the rule lacks per-section anchor needed for the active owner to perform the compliance test).
- **Suggested correction (researcher candidate)**: either (a) replace "§1-§8 upper-philosophy compliance" with explicit anchor enumeration "per `.claude/reference/review-and-verification-core-law.md` `## Upstream Basis Review Law` consumption of §1 design-frozen-success-criteria, §2 target-intent-basis, §3 procedure/owner/skill basis, §4 evidence-outranks + finding-state separation, §5 operator-emphasized-keyword gate, §6 owner-separation + validator-final, §7 reporting-curtain, and §8 runtime-boundary"; or (b) replace it with a single owner-binding pointer "per `.claude/reference/review-and-verification-core-law.md` `## Upstream Basis Review Law` 1-3 basis consumption rule extended to §4-§8 by `.claude/CLAUDE.md` Structural Contract line 17 downstream-consumption chain" if the per-section enumeration would over-grow the bullet. Either path is more evidence-traceable than the current unified phrase.

### F3. Wrong-line-range citation: "standard exception classes at lines 95-99" (Item 1, bullet 3 — fallback chain)
- **Draft wording**: "route to operator-policy-choice user escalation per the standard exception classes at lines 95-99"
- **Source check evidence (current-turn Read tool-call on `.claude/reference/work-execution-core-law.md` lines 87-105)**:
  - Line 90 (the canonical user-escalation rule): "User escalation requires irreversible, destructive, security-sensitive, operator-policy-choice, or proven user-owned blocker basis." — **this is the actual line that enumerates the 5 standard exception classes.**
  - Line 93: "when any condition fails, direct user escalation is lawful per the standard exception classes above." — **the in-corpus referent "standard exception classes above" points to line 90, not lines 95-99.**
  - Lines 95-99: operator-policy-choice scope narrowing (definition, scope coverage, escalation requires user expression, non-applicability conditions, evasion-vector defect classification). These NARROW one of the 5 classes (operator-policy-choice), they do not enumerate the class set.
- **Defect class**: source-citation wrong-line-range — the fallback chain's authoritative anchor is line 90's 5-class enumeration; line 93 already establishes the in-corpus referent shorthand. Lines 95-99 are operator-policy-choice scope narrowing, applicable AFTER class selection routes to operator-policy-choice.
- **Operating effect**: an active owner consuming the new fallback chain reads "operator-policy-choice user escalation per the standard exception classes at lines 95-99" and finds at lines 95-99 only the operator-policy-choice non-applicability tests (line 98) and the evasion-vector defect rule (line 99) — which actively NARROW the operator-policy-choice route. The consumer is left to either (a) skip lines 95-99's narrowing (citation-trust failure) or (b) apply lines 95-99's narrowing tests and frequently fail them (because "an evidence-backed reversible default exists" or "the decision is derivable from user instruction wording" — line 98 — applies broadly when the team-meeting itself produced a defensible converged design), creating a higher rate of operator-policy-choice REJECTIONS than the drafter likely intended.
- **Candidate-classified state**: `candidate-classified:source-citation-wrong-line-range` + `candidate-classified:execution-conflict-with-cited-text` (per `## Minimum Executable Information Law` line 99 conflicting-governance class — the proposed wording's cited surface conflicts with the proposed rule's intended fallback effect).
- **Suggested correction (researcher candidate)**: replace "the standard exception classes at lines 95-99" with "the standard exception classes at line 90 (irreversible / destructive / security-sensitive / operator-policy-choice / proven user-owned blocker)"; if the drafter wants to also bind operator-policy-choice's narrowing tests (lines 95-99), state that separately as a secondary qualifier rather than substituting it for the class enumeration.

### F4. Wrong-heading-depth citation: `Skill(team-meeting) ## 3-6. Convergence` (Item 1, bullet 3 — fallback chain)
- **Draft wording**: "OR the meeting reaches `HOLD` per `Skill(team-meeting)` `## 3-6. Convergence` round-cap"
- **Source check evidence (current-turn Read tool-call on `.claude/skills/team-meeting/SKILL.md` lines 40-150)**:
  - Top-level section: `## 3. Meeting Procedure` (line 40).
  - Sub-section: `### 3-6. Convergence` (line 128) — **three hashes, sub-section depth, NOT `##` two-hash top-level.**
  - Round-cap content (lines 102-104): "Default round cap is five rounds; drafter declares `HOLD` with documented objection-persistence basis when full consent is not reached within the cap, and operator may extend the cap explicitly." This content is at lines 102-104 within the `### 3-4. Opinion Round` sub-section, and is restated at line 132 within `### 3-6. Convergence`. The substantive HOLD basis exists; the heading depth is the only citation defect.
- **Defect class**: source-citation wrong-heading-depth — minor citation precision defect.
- **Operating effect**: the wrong heading depth degrades grep-based citation discovery (a reader running `grep -n "^## 3-6"` finds nothing; `grep -n "^### 3-6"` finds it). Substantive force is preserved because the section name "3-6. Convergence" is unique and discoverable by content; the defect is procedural-adherence, not execution-blocking.
- **Candidate-classified state**: `candidate-classified:source-citation-precision-defect` (minor; researcher recommends correction but not promotion-blocking).
- **Suggested correction**: write `### 3-6. Convergence` (three hashes) or rewrite as `Skill(team-meeting) Section 3-6. Convergence` to avoid depth ambiguity.

### F5. Paraphrase-shifted citation of CLAUDE.md §1 Success criteria (Item 1, bullet 1)
- **Draft wording**: "user-stated-goal coverage per `.claude/CLAUDE.md` `## 1. Design Definition Philosophy` Success criteria (frozen request fit + concrete deliverable satisfaction + user burden reduction + decisive user-surface closure)"
- **Source check evidence (current-turn Read tool-call on `.claude/CLAUDE.md` line 29)**:
  - Source exact wording (CLAUDE.md line 29): "Success requires request fit, frozen deliverable satisfaction, user burden reduction, and decisive user-surface closure."
- **Comparison**:
  | Source | Draft paraphrase | Shift |
  |---|---|---|
  | "request fit" | "frozen request fit" | +frozen modifier (frozen-ness attribute added) |
  | "frozen deliverable satisfaction" | "concrete deliverable satisfaction" | -frozen, +concrete (frozen-ness attribute removed; concrete substituted) |
  | "user burden reduction" | "user burden reduction" | exact |
  | "decisive user-surface closure" | "decisive user-surface closure" | exact |
- **Defect class**: source-citation paraphrase-shift — the drafter migrated the "frozen" attribute from "deliverable satisfaction" to "request fit" and replaced the deliverable's "frozen" with "concrete." Semantically: §1 line 27 explicitly says "Design Definition Philosophy freezes the request, deliverable, scope, user burden, and completion shape" — so freezing applies to BOTH request and deliverable. But §1 line 29's specific success-criteria wording chose to bind "frozen" to deliverable satisfaction (the FROZEN deliverable must be satisfied — not paraphrase-substituted "concrete"). The draft loses the frozen-deliverable emphasis.
- **Operating effect**: in a choice-situation evaluation, a consumer testing "does the option cover the frozen deliverable" is the §1 success-criteria test that catches scope-narrowing / partial-completion options. Substituting "concrete" weakens this — many "concrete" options exist that do not satisfy the FROZEN deliverable.
- **Candidate-classified state**: `candidate-classified:source-citation-paraphrase-shift` + `candidate-classified:execution-force-weakening` (per `## Minimum Executable Information Law` weaker-execution-force class).
- **Suggested correction**: cite source-exact "request fit, frozen deliverable satisfaction, user burden reduction, and decisive user-surface closure" without paraphrase substitution, or quote with backticks.

### F6. Implicit but uncited carrier: `procedure-adherence` defect classification (Item 1, bullet 2)
- **Draft wording**: "direct owner-side choice or direct user escalation without prior `Skill(team-meeting)` attempt in a choice situation is a `[NO-NEEDLESS-ASK]` + procedure-adherence violation."
- **Source check evidence (current-turn Read tool-call on `.claude/reference/review-and-verification-core-law.md` lines 61-75)**:
  - `## Owner Boundary And Skill Consumption Law` line 65: "Confirmed owner-boundary conflict or skill-consumption defect is a procedure-adherence defect and an execution-force defect."
  - `## Anti-Narrowing Law` line 73: "is a procedure-adherence defect and an execution-force defect, classified as `confirmed-defect:silent-narrowing` and blocking positive review/verification/acceptance claims..."
- **Defect class**: source-citation missing-anchor — `procedure-adherence` is an in-corpus defect classification term whose canonical owner is `review-and-verification-core-law.md`'s two laws above; the draft uses the term without anchor. A reader cannot trace which classification's promotion path applies.
- **Operating effect**: minor — the term is discoverable by grep, but explicit anchor lets downstream `Skill(review-verification)` Step 4 / Step 12 classify the violation into the correct finding-state ladder without separate ownership research.
- **Candidate-classified state**: `candidate-classified:source-citation-missing-anchor` (minor; researcher recommends anchor addition).
- **Suggested correction**: append "(per `.claude/reference/review-and-verification-core-law.md` `## Owner Boundary And Skill Consumption Law`)" to the "procedure-adherence violation" phrase, or restructure to "is a `[NO-NEEDLESS-ASK]` violation per `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law` line 88 and classifies as a procedure-adherence defect per `.claude/reference/review-and-verification-core-law.md` `## Owner Boundary And Skill Consumption Law`."

## 3. Fallback-Chain Evidence Trace (assignment-focus answer)

Question 1 (team-lead packet): **"does the rule wording actually cite each controlling §1-§8 surface?"**
- Answer: **No.** Per F2: §1 cited (paraphrase-shifted per F5); §3 cited via `[NO-NEEDLESS-ASK]` token; §2, §4, §5, §6, §7, §8 NOT per-section anchored. The unified phrase "§1-§8 upper-philosophy compliance" asserts coverage without traceable per-section citation.

Question 2 (team-lead packet): **"does the fallback chain trace evidence?"**
- The fallback chain is Item 1 bullet 3, with three hops:
  - Hop A — `Skill(team-meeting)` form infeasible per 3-condition convergence-tractable test (line 92 above): trace evidence **valid**. Line 92 of `work-execution-core-law.md` carries the 3-condition test verbatim. Citation correct.
  - Hop B — OR meeting reaches `HOLD` per `Skill(team-meeting)` `## 3-6. Convergence` round-cap: trace evidence **partially valid** (substantive HOLD content exists at team-meeting line 132 within `### 3-6. Convergence`; round-cap exists at lines 102-104 within `### 3-4. Opinion Round` and is referenced again at line 132). Heading-depth defect per F4.
  - Hop C — route to operator-policy-choice user escalation per the standard exception classes at lines 95-99: trace evidence **INVALID per F3** — line 90 is the actual class enumeration; lines 95-99 carry operator-policy-choice narrowing tests that, if applied as gate for the fallback route, will frequently REJECT the fallback (per line 98 non-applicability conditions when an evidence-backed reversible default exists).
- Overall fallback chain trace: 1 valid hop, 1 partially-valid hop (precision defect), 1 invalid hop (wrong-line-range with execution-conflict-with-cited-text risk).

## 4. Out-Of-Direct-Assignment Adjacent Findings (researcher lane evidence-only)

These observations arose during citation tracing; they are recorded as `candidate-evidence` (below `candidate-classified` ladder state — observed signal without classification commitment) for team-lead synthesis to consider or reject.

### A1. Item 4 (governance-modification Step 4 trigger) duplication risk vs. existing §5 8-keyword gate
- Observation: Item 4 inserts at `Skill(governance-modification)` Step 4 a choice-situation trigger that invokes team-meeting for "design row selection" when multiple defensible CHANGE-SEQUENCE-DESIGN options exist. CLAUDE.md §5 Modification Philosophy already binds patch design to operator-emphasized 8-keyword gate (line 79) and to recording 1-4 basis (line 78). The team-meeting trigger may overlap with an already-active patch-design review pass; researcher cannot resolve overlap-vs-additive from researcher lane.
- State: `candidate-evidence:overlap-with-existing-design-gate` — for team-lead/Skill(review-verification) coherence-integrity-lens judgment.

### A2. "Lines 95-99" cite (F3) was likely intended to import operator-policy-choice non-applicability gate as a FILTER on the fallback, not as the class enumeration
- Observation: lines 98-99 (operator-policy-choice non-applicability + evasion-vector defect) ARE relevant to the fallback chain — they catch cases where the active owner mislabels a derivable decision as operator-policy-choice. So the cite may be intentional but mis-positioned in the sentence (placed as enumeration anchor instead of non-applicability filter).
- State: `candidate-evidence:probable-intent-mis-positioning` — for drafter revision rather than rejection.

### A3. Item 1 bullet 2 conjoins `[NO-NEEDLESS-ASK]` + `procedure-adherence` violation classification — promotion-path ambiguity
- Observation: `[NO-NEEDLESS-ASK]` is a `## Autonomy And Escalation Law` execution token; `procedure-adherence` is a `review-and-verification-core-law.md ## Owner Boundary And Skill Consumption Law` defect classification. Conjoining them without disambiguation leaves unclear whether the violation routes to (a) execution correction (active owner applies the missed evidence-backed default) or (b) review-verification defect promotion (the violation is filtered through finding-state ladder by review owner). Both paths may be valid simultaneously; the wording does not say so.
- State: `candidate-evidence:promotion-path-ambiguity` — for drafter revision.

## 5. MEETING-AUDIT-CRITERIA Lens (researcher critique)

Per `.claude/skills/team-meeting/SKILL.md` `### 3-5. MEETING-AUDIT-CRITERIA` (lines 106-126), researcher names failed criteria when the criterion controls the objection:
- **agenda fit**: substantive design covers operator directive parts 1-3; pre-critic feedback part 4 partially covered (R1-R4 stated as resolved). Researcher does not challenge this.
- **simplicity**: 6 bullets total claimed minimum-executable-information. F2 + F3 + F5 show that the proposed bullet text under-specifies controlling source citation (per `## Minimum Executable Information Law` under-specification class). Simplicity by bullet count is satisfied; simplicity by minimum-executable-information per bullet is **NOT satisfied for Item 1 bullets 2 and 3**.
- **correctness**: F1 through F6 enumerate source-citation defects against the cited surfaces. The substantive design claim is correctness-defensible; the citation claim is NOT correctness-clean.
- **feasibility**: NEXT ACTION names `Skill(governance-modification)` 4-patch loop — feasibility test passes on form. Per-patch source citation must be corrected before mutation so post-verify can pass.
- **bottleneck control**: 4 patches independent per dimensional-independence — researcher does not challenge.
- **operator-emphasized 8 keywords**: drafter self-check asserts all 8 pass. Researcher challenges:
  - `consumed-surface` ✗ (F1: `## Upstream Basis Review Law` cited at wrong owner; consumed-surface discipline is violated when the cited surface is not the canonical owner)
  - `executable-imperative` ✗ partial (F2: §1-§8 unified phrase without per-section anchor leaves the compliance test non-executable at consumption surface)
  - `minimum-executable-information` ✗ partial (F2 + F3 + F5: under-specification on Item 1 bullet 2's controlling-§-anchor field; wrong-line-range on bullet 3 hop C; paraphrase-shift on bullet 1 §1 anchor)
  - other 5 keywords (`removal-first`, `no-compression`, `upper-lower execution-drive`, `dimensional-independence`, `comprehension-as-execution-force`) — researcher does not challenge.

## 6. Researcher Critic Verdict
- **Overall**: substantive design intent **accepted with material objection**; source-citation field of every proposed bullet requires correction before patch mutation.
- **Material objections (drafter must address before researcher consent)**:
  - O1 (F1): correct wrong-owner citation of `## Upstream Basis Review Law`.
  - O2 (F2): replace unified "§1-§8 upper-philosophy compliance" with per-section anchor enumeration OR with single owner-binding pointer that preserves traceability for all 8 sections.
  - O3 (F3): correct wrong-line-range citation of "standard exception classes at lines 95-99" to line 90 (and re-position lines 95-99 narrowing tests as separate qualifier if intended).
  - O4 (F5): restore source-exact CLAUDE.md §1 success-criteria wording (preserve frozen-ness attribution on deliverable satisfaction).
- **Non-material objections (recommended but not consent-blocking)**:
  - N1 (F4): heading-depth precision `### 3-6.` not `## 3-6.`
  - N2 (F6): explicit anchor for `procedure-adherence` term.
- **Adjacent observations carried as candidate-evidence (A1/A2/A3) — for drafter consideration or rejection.**

## 7. FINDING-STATE-INVENTORY (researcher lane, ceiling = candidate-classified)

| ID | Defect class | Ladder state | Lens basis | Promotion owner |
|---|---|---|---|---|
| F1 | source-citation wrong-owner | `candidate-classified:source-citation-wrong-owner` | source-citation + evidence-quality | team-lead synthesis + Skill(review-verification) defect-promotion |
| F2 | source-citation incomplete-anchor + execution-force-weakening | `candidate-classified:source-citation-incomplete-anchor` | source-citation + external-reference | team-lead synthesis + Skill(review-verification) defect-promotion |
| F3 | source-citation wrong-line-range + execution-conflict-with-cited-text | `candidate-classified:source-citation-wrong-line-range` | source-citation + evidence-quality | team-lead synthesis + Skill(review-verification) defect-promotion |
| F4 | source-citation wrong-heading-depth | `candidate-classified:source-citation-precision-defect` | source-citation | drafter direct revision |
| F5 | source-citation paraphrase-shift + execution-force-weakening | `candidate-classified:source-citation-paraphrase-shift` | source-citation | team-lead synthesis + Skill(review-verification) defect-promotion |
| F6 | source-citation missing-anchor | `candidate-classified:source-citation-missing-anchor` | source-citation | drafter direct revision |
| A1 | overlap-with-existing-design-gate | `candidate-evidence:adjacent-coherence-observation` | coherence-integrity (out-of-lane) | team-lead / coherence-integrity-lens reviewer |
| A2 | probable-intent-mis-positioning | `candidate-evidence:drafter-intent-observation` | source-citation | drafter direct revision |
| A3 | promotion-path-ambiguity | `candidate-evidence:execution-ambiguity-observation` | procedure-adherence (out-of-lane) | drafter direct revision or team-lead |

## 8. CITATION-EVIDENCE-INVENTORY (per `Skill(review-verification) ### 12b. Citation Substantiation Gate` — Class A)

All external citations in this critique carrier are Class A (current-turn Read/Bash tool-call against cited surface in this turn):

- `.claude/CLAUDE.md` line 29 (§1 success criteria source-exact wording) — Class A; current-turn Read tool-call on `/mnt/d/Agent_team/.claude/CLAUDE.md` lines 1-80; verbatim content: "Success requires request fit, frozen deliverable satisfaction, user burden reduction, and decisive user-surface closure."
- `.claude/CLAUDE.md` line 17 (Structural Contract downstream-consumption chain) — Class A; same Read tool-call; verbatim content: "The philosophy chain is downstream consumption, not hierarchy collapse: 1 freezes the user problem, 2 specifies it, 3 executes it, 4 reviews claims against 1-3, 5 modifies governance while preserving 1-4, 6 judges proof and acceptance, 7 reports admitted user-facing surfaces, and 8 controls runtime/environment boundaries."
- `.claude/CLAUDE.md` line 79 (§5 8-keyword list) — Class A; same Read tool-call; verbatim content includes the 8 keywords.
- `.claude/reference/work-execution-core-law.md` lines 87-105 (`## Autonomy And Escalation Law`) — Class A; current-turn Read tool-call on full file; verified: line 88 `[NO-NEEDLESS-ASK]`, line 90 user-escalation 5-class enumeration, line 91 hard-design-decision rule, line 92 3-condition test, line 93 "standard exception classes above" referent, lines 95-99 operator-policy-choice scope narrowing.
- `.claude/reference/review-and-verification-core-law.md` line 16 (`## Upstream Basis Review Law` section header) and lines 17-21 (executable detail) — Class A; current-turn Read tool-call lines 1-100; verbatim section name confirmed.
- `.claude/reference/review-and-verification-core-law.md` line 65 (`procedure-adherence defect` term) and line 73 (`Anti-Narrowing Law` use of the term) — Class A; same Read tool-call; verbatim content verified.
- `.claude/skills/review-verification/SKILL.md` section header inventory (no `## Upstream Basis Review Law` present) — Class A; current-turn `Bash grep -n "Upstream Basis Review Law"` cross-file search returning zero matches in this file plus current-turn Read of full SKILL.md; absence verified.
- `.claude/skills/team-meeting/SKILL.md` line 128 (`### 3-6. Convergence` three-hash sub-section header) + lines 102-104 (round-cap content) + line 132 (HOLD restatement) — Class A; current-turn Read tool-call lines 40-150 and `Bash grep -n "^## "`; verbatim content verified.
- `.claude/skills/agent-researcher/references/researcher-lane-detail.md` lines 56-60 (Evidence Tier Discipline) — Class A; current-turn Read tool-call full file; verbatim content verified.
- `.claude/skills/governance-modification/SKILL.md` line 46 (`# Step 4: Change Sequence Design`) — Class A; current-turn `Bash grep -n "^## \|^# "`; section presence verified (single-hash; the draft cites it with single-hash, OK).
- `.claude/skills/work-planning/SKILL.md` line 137 (`## Step 2: Q1-Q5 Work Analysis`) — Class A; same grep; verified.
- `.claude/skills/task-execution/SKILL.md` line 80 (`## Step 1: Activate Frozen Route`) — Class A; same grep; verified.

## 9. OPEN-SURFACES (researcher → team-lead synthesis)
- O1-O4 (material): require drafter revision in r2 before researcher critic consent.
- N1-N2 (non-material): recommended for drafter clean-up, not consent-blocking.
- A1-A3 (adjacent candidate-evidence): for team-lead synthesis + coherence-integrity / procedure-adherence lens reviewer consideration; researcher does not promote out-of-lane.
- Substantive design intent (canonical owner + 3+1 consumer triggers + carve-out + fallback chain) is researcher-acceptable as design shape; researcher consent is gated on source-citation correction, not design redesign.

## 10. LANE-NEXT-CANDIDATE
- Smallest next owner/action: team-lead routes O1-O4 to drafter (team-lead) for r2 revision; r2 carrier path = `claude_doc/governance-audit-2026-05-27/meetings/choice-situation-rule-design/draft-r2.md`; r2 receives a fresh researcher critic pass.
- Reviewer-shard-a (design-intent + coherence-integrity + patch-worthiness) and reviewer-shard-b (governance-continuity + minimum-executable-information + negative-risk + removal-first) opinions remain independent and may converge or diverge with researcher findings.
- Final acceptance authority remains with operator gate per `### 3-7. Operator Gate`; researcher critique is bounded packet evidence only.

UPSTREAM-DECISION-BASIS-CONSUMPTION: `draft-r1.md` consumed in current turn; cited surfaces (CLAUDE.md, work-execution-core-law.md, review-and-verification-core-law.md, team-meeting/SKILL.md, review-verification/SKILL.md, governance-modification/SKILL.md, work-planning/SKILL.md, task-execution/SKILL.md, agent-researcher/references/researcher-lane-detail.md) consumed in current turn via Read + Bash grep; researcher Skill(agent-researcher) loaded in current turn; evidence-tier discipline applied with external-authoritative in-corpus governance text as the authoritative tier; no model-memory substitution.
