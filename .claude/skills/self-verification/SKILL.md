---
name: self-verification
description: Convergence-based self-verification procedure.
user-invocable: false
PRIMARY-OWNER: team-lead
---

## Self-Verification Skill

## Structural Contract
- Fixed section order: Purpose, Reporting Principle, Activation Trigger, Step 1: Scope Match, Step 2: Role-Specific Checklist, Step 3: Critical Challenge, Step 4: Evidence Basis Check, Step 5: Convergence Loop, Execution Depth Guide, Step 6: Output The Verified Result, Verification Output Format (internal handoff only)
- PRIMARY-OWNER: team-lead
- Structural changes require governance review.

## Purpose

Use this skill to verify that a plan, conclusion, or result survives challenge before it is executed, reported, or handed off.

Explicit user instructions and the user's stated philosophy, doctrine, or operating principles are first-class verification inputs. They are not optional context. A conclusion that conflicts with them without explicit justification fails verification.

Quick contract:
- check scope fit
- run role-specific checks
- run Critical Challenge
- confirm evidence basis
- converge or HOLD
- report only the verified result

Boundary: this is agent-local verification. Independent review still belongs to `reviewer`; final acceptance still belongs to `validator`.

## Reporting Principle

Self-verification is internal process work, not a user-facing deliverable. Do not expose the challenge procedure itself to the user.

However, for final user-facing conclusions, material recommendations, completion reports, explicit audit responses, or detailed status reports that the user explicitly asked for, the response must still surface the verification outcome concisely. Ordinary progress commentary does not carry this full verification surface. Minimum user-facing verification surface when that final/audit shape applies:
- verification basis: what evidence or checks the conclusion rests on
- residual risk or open surfaces: what remains unverified, blocked, or conditional
- unverified items: explicit if any remain

This is an outcome summary, not a process dump. The verification output format below remains for internal handoff blocks only. The user-facing surface is layered: direct result first, then the minimum verification outcome needed for that result, then residual risk/next step. Never mirror the full worker handoff ledger into the user-facing response.

Default user-facing final/audit result template:

```text
<final result or decision>
Verification basis: <1-3 decisive anchors in plain prose. For classification or judgment claims, include the strongest material alternative rejected and why, inline if needed.>
[Finding digest: <omit unless multiple material findings exist; if used, list only the top 1-3 decisive findings and summarize any remainder as +N additional items>]
Residual risk/open surfaces: <none | specific remaining conditions>
Unverified items: <none | explicit list>
```

The verification basis still requires concrete anchor points when the claim references existing source material: file path with line range, user-turn reference, prior-decision id, or equivalently concrete source coordinate in plain prose. A paraphrase alone does not satisfy this slot — that path defeats the gate, since head-trace and prior-memory can produce paraphrase without actual re-access. For classification or judgment claims, the strongest rejected alternative and the rejection reason materialize Critical Challenge Step 3a output; if 3a was not executed on a material classification or judgment, that conclusion is not yet verified. `Finding digest` is a user-facing compression layer only; it does not weaken the underlying evidence obligation.

Use natural prose around it when needed, but do not omit these surfaces on final/audit reporting. For routine in-progress updates, report only the current verified decision, next action, or blocker in plain prose. Do not preface routine progress updates with `SV converged`, `Checkpoint ...`, verification labels, or any other verification-packet heading. Do not surface internal handoff labels such as `TASK-ID`, `OUTPUT-SURFACE`, `OPEN-SURFACES`, `REQUESTED-LIFECYCLE`, or packet-style field lists in user-facing responses.

## Activation Trigger

Load this skill and execute the full procedure at these points:
1. After scope freeze (post-planning gate): verify the frozen scope and deliverable shape from work-planning before committing to execution.
2. Before any conclusion or recommendation: root-cause analysis, corrective proposals, or consequential advice to user or governing lane.
3. Before executing a plan: verify the plan solves the stated problem before committing resources.
4. After applying a modification: verify the change produced the expected consequence without unintended effects.
5. Before handoff or reporting: handoff and reporting share ONE verification obligation. (Paradigmatic trigger: synthesizing 2+ worker reports into a consolidated conclusion, even when each upstream report was already SV-converged.)
6. Before re-dispatch: when synthesizing upstream results into a downstream dispatch.

**Temporal gate principle:** Self-verification is a gate, not a concurrent annotation. The gated action (reporting, execution, dispatch, handoff) must not begin until verification completes and conclusions survive Critical Challenge. Composing a report in the same response as the SV invocation defeats the gate — if Critical Challenge would change the conclusion, the already-composed output cannot reflect the correction. Complete verification first; compose the gated output from verified conclusions only.

Synthesis and self-verification are separate gates. When worker reports were already synthesized under an existing scope, Trigger 5 verifies that synthesized conclusion directly; it does not re-open work-planning unless Critical Challenge invalidates the frozen scope or the next action will execute, dispatch, mutate, or re-plan.

Note on trigger (1): This trigger fires after work-planning has frozen the request scope, not before work-planning loads. The sequence is always work-planning → self-verification (post-planning gate). Trigger (1) is the post-planning verification gate, not a pre-planning check.

**Same-turn carry-forward:** If this skill was loaded and Critical Challenge executed in the current turn with no intervening consequential modifications since that load, the existing in-turn verification satisfies the current trigger. A second Skill invocation is not required unless the work since the last SV load introduced material that was not already covered by that verification. Carry-forward holds when the agent synthesizes, aggregates, classifies, or restructures already-verified upstream evidence for reporting. Carry-forward resets when new independent conclusions, recommendations beyond what verified evidence supports, file modifications, or consequential dispatch actions (Agent, TaskCreate, assignment-grade SendMessage) are produced after the last SV load. (This mirrors the carry-forward rule in `agents/team-lead.md §RPA-7`.)

Carry-forward reset is mandatory when the new output strengthens the claim class even without new file modification. Treat the following as new consequential conclusions that prior verification does not automatically cover unless the current verification basis explicitly covers them: severity or priority recalibration, phase-close or readiness claims (`complete`, `ready`, `validated`, `no remaining blocker`), worker-state claims (`working`, `completed`, `idle`, `stalled`, `not working`, `message-loss`), and broad scope-closing absence claims (`no issue`, `nothing remains`, `no mismatch found`). These claims require current-turn evidence basis appropriate to the claim type under Step 4.

**Derived-conclusion boundary:** Do not treat prior verification as covering conclusions it did not actually verify. When synthesis, aggregation, classification, or restructuring creates a material conclusion beyond the prior verification basis, that conclusion is not reportable as verified unless the current verification basis covers it. Otherwise narrow it to the verified scope or label it `INFERENCE`/`UNVERIFIED`.

If you are about to state a conclusion, execute a plan, report a completed change, or present consequential status, ask: "Did this survive Critical Challenge?" If not, execute this procedure first.

## Step 1: Scope Match

- Compare output against assigned scope (dispatch instructions + work plan).
- Compare output against explicit user instructions and any user-stated philosophy, doctrine, or operating principles.
- When the user names governing philosophy such as `[GOV-MIN]` or `[PLAN-SV]`, treat it as an evaluation lens first, not as a defect candidate by default.
- Every deliverable item must be addressed or explicitly marked incomplete.
- No unrequested scope additions without justification.
- If a recommendation, diagnosis, or conclusion departs from the user's stated philosophy or constraints, name the mismatch explicitly and justify it or HOLD.
- When evaluating an existing rule, mechanism, structure, process, or policy, verify the result addresses both halves of the question: why the current state exists and whether its current cost, friction, or ambiguity remains proportionate.
- Do not stop at "there was a rationale." Verify whether that rationale is still justified, current, and proportionate to the burden it imposes.
- When the output justifies compression, reorganization, migration, or cleanup, apply `[PRES-FIRST]` and `[CHANNEL]` as explicit scope checks: verify what information, meaning, or habit-channel had to survive, and fail scope match if the conclusion skips that preservation target.
- When the output justifies routing, staffing, or dispatch shape, apply `[PARALLEL]` as an explicit scope check: verify whether independent work surfaces were silently serialized or whether the claimed serial path names a real dependency, boundary uncertainty, or merge basis.
- When the output identifies a valid defect, user correction, or recurrence-worthy miss, apply `[HARDEN]` as an explicit scope check: fail scope match if the conclusion stops at description/apology and leaves corrective hardening, owner, or next action undefined.
- When the output is a user-facing answer, status, or decision, apply `[AUTO-PROC]` and `[CHANNEL]` as explicit scope checks: the verified answer, decision, or blocker must remain the response lead; process narration must not displace the primary user-facing channel.

## Step 2: Role-Specific Checklist

Execute the owning role's pre-handoff self-check:

| Role | Section | Focus |
|------|---------|-------|
| developer | `agents/developer.md §Pre-Handoff Integrity` (principles) + `skills/developer/SKILL.md §Pre-Handoff Integrity` (checklist) | syntax, imports, logic, dead references |
| tester | `skills/tester/SKILL.md §Pre-Handoff Self-Check` | scenarios, commands, proof classification |
| reviewer | `skills/reviewer/SKILL.md §Pre-Handoff Self-Check` | severity, classification, retest, evidence |
| validator | `skills/validator/SKILL.md §Pre-Handoff Self-Check` | verdict evidence, blocking, user fitness |
| researcher | `skills/researcher/SKILL.md §Pre-Handoff Self-Check` | evidence anchoring, UNVERIFIED, cross-verification |
| team-lead | agents/team-lead.md §RPA-1 Checkpoint A (Before Every Response) + IR-2 principle 10 (6 SV activation triggers) | evidence basis for every claim, worker output verified not assumed, self-verification loaded at every applicable trigger boundary |

Record each item as pass or fail.

Additional team-lead routing check:
- If the current plan froze `ROUTING-SIGNAL: team-routing candidate` or `ambiguous-route`, verify that `NEXT-CONSEQUENTIAL-ACTION` is explicit and valid per `skills/work-planning/SKILL.md`.
- If `NEXT-CONSEQUENTIAL-ACTION` is missing, vague, or hides broad further inspection, fail verification and return to `work-planning`. Team routing without an explicit next runtime move is not converged.

### Step 2a: Workflow Phase Gate Check (team-lead only)

Non-lead workers: skip Step 2a entirely and proceed directly to Step 3.

When a governing workflow (e.g., dev-workflow) is active AND the current trigger is "before handoff or reporting" (trigger 5):

1. Read `./.claude/state/procedure-state.json` phase state first. If that state is absent or incomplete, fall back to `./.claude/session-state.md` continuity phase records. Use `$HOME/.claude/session-state.md` only as a legacy migration mirror when the workspace-local continuity surface is unavailable. For the canonical schema and key fields, see `session-boot/reference.md`. (Inline copy removed to prevent staleness; reference.md is authoritative if they diverge.) Use `currentPhase` and `checkpointStatus` per the schema in `session-boot/reference.md §Procedure-State Schema`. If `currentPhase` is null or `checkpointStatus` is absent or empty, treat all phase states as null and proceed to session-state.md fallback.
2. Verify all required phases for the current deliverable type have status `complete`.
3. For executable, user-facing software deliverables, verify:
   - Phase 4 reviewer handoff coordinate: present
   - Phase 4 tester handoff coordinate: present (curl/API-only does NOT satisfy this for web UI deliverables)
   - Validator PASS coordinate: present
4. If any required phase is missing or incomplete → HOLD. Do not proceed to Step 3.

Missing phase state is treated as incomplete phase state.


## Step 3: Critical Challenge

Critical Challenge is the center of this skill. Convergence without adversarial challenge is not enough.

### 3a. Frame Reversal
- Assume your conclusion is wrong. What is the strongest alternative conclusion?
- If the alternative is more honest or solves the fundamental problem better, your original conclusion fails this check.
- When evaluating an existing state under review, test both opposite errors:
  - "This is overbuilt and should be simplified" versus
  - "This exists for a protective or value-preserving reason and should stay as-is."
  If you did not seriously test both, the conclusion is not converged.

### 3b. Self-Deception Detection
- Are you blaming external factors (tools, structure, process, others) when the cause is simpler (own behavior, non-compliance)?
- Are you creating analytical complexity to avoid an uncomfortable simple truth?
- Are you proposing new rules when the real problem is not following existing ones?
- Are you conceding a broader failure than the evidence supports because the user challenged your process?
- Are you labeling completed work as “missing” when the actual defect is narrower (not surfaced, not checkpointed, or wrong phase transition)?
- Are you using apology as a shortcut instead of diagnosing the exact skipped step or wrong authority transition?
- Are you treating "the current state exists for a reason" as sufficient proof that no change is needed, without checking whether the same protection or value could be preserved with less cost or less ambiguity?
- Are you treating repeated friction or delay as sufficient proof that simplification is needed, without confirming what protection or value would be lost?
- Are you classifying findings (defect, design choice, clarification candidate) without first confirming the design intent behind what you are analyzing?
- Did your analytical approach (quantitative metrics, structural comparison, textual pattern matching) bypass qualitative design-intent understanding?

### 3c. Problem-Solution Fit
- If this identified cause is removed, does the original problem actually disappear?
- If not, you have not found the root cause.

### 3d. User-Perspective Criticism
- What would the end user predictably criticize?
- Fix recognizable defects before proceeding.

## Step 4: Evidence Basis Check

- Every claim has supporting evidence.
- Unsupported items labeled UNVERIFIED or removed.
- Claim-Type Evidence Gate: before hardening a claim, classify the claim type and satisfy its minimum evidence burden:
  - `FACT`: direct source coordinate, fresh observation, or current-session tool output.
  - `NEGATIVE` / `NO-ISSUE`: inspected scope, inspection method, and coverage limit.
  - `RUNTIME-STATE`: communication/state-channel evidence appropriate to the state claimed. Repository artifacts, file mutation, or "nothing changed recently" do not satisfy this burden by themselves.
  - `CLASSIFICATION` / `JUDGMENT`: applicable rule or constraint plus considered alternative and rejection basis.
  - `RECOMMENDATION`: problem-solution fit plus basis for rejecting narrower or lower-cost alternatives.
  If the matching burden is not met, downgrade the claim to `INFERENCE` or `UNVERIFIED` instead of hardening it.
- A conclusion inherited from a prior-session summary, compacted conversation, or remembered analysis is a claim, not evidence — treat it as UNVERIFIED until re-confirmed by direct source access (file read, tool output, or fresh observation) in the current session.
- Do not report scope-closing claims as settled from summaries, samples, or incomplete evidence. Claims that assert broad presence, absence, uniqueness, universality, or commonality must be narrowed to the inspected scope or labeled `INFERENCE`/`UNVERIFIED` unless direct evidence supports the full reported scope.
- Negative, no-issue, or "nothing remains" claims must explicitly name the inspected scope, how that scope was checked, and the remaining coverage limit. Without those three surfaces, the claim is not settled.
- Assumptions explicitly stated.
- Verify environment assumptions before using environment-specific evidence paths. If a verification method assumes repository history, git metadata, branch state, or diff surfaces, confirm those surfaces exist first. When the assumption fails, switch to the closest truthful fallback (for example file-based inspection instead of git-based diff) rather than treating the failed assumption itself as a blocker.
- When the user has stated governing philosophy or operating doctrine, check and state whether the analysis aligns with it, partially aligns, or conflicts with it.
- For governance analysis, classify disputed rules in this order: intentional minimal-boundary design, clarification candidate, or real defect. Do not jump to defect naming before checking the governing philosophy fit.
- Root-cause and corrective analysis must be grounded in the user's instructions and philosophy before broader abstractions or convenience-based explanations.
- Use induction first to generate candidate explanations. Then use deduction to decide which candidate, if any, is justified as a consequential conclusion.
- For root-cause claims, policy judgments, structural diagnoses, and corrective recommendations, distinguish what was observed, what rule or constraint applied, what conclusion follows, and what remains inference-grade.
- If the conclusion does not follow from explicit facts plus applicable rules, downgrade it to `INFERENCE` or `UNVERIFIED` instead of presenting it as settled.
- When evaluating an existing state under review, require five explicit evidence surfaces before a "change needed" or "change unnecessary" conclusion is treated as settled. Verify that each surface was derived from its required input per the `work-planning` Step 2 dependency chain (understand → identify protection → classify cost → judge proportionality → assess change risk), not filled independently or in reverse from a pre-formed conclusion:
  - current-state rationale confirmed from an owner surface or direct code path
  - protected value derived from the confirmed rationale above
  - current cost or friction classified as (a) observed or merely inferred AND (b) protective cost (expected price of the stated protected value) or unnecessary overhead — classification requires the protected value as input
  - rationale justification judged explicitly as proportionate, excessive, stale, or unclear — judgment requires both the protected value and cost classification as inputs
  - change risk stated explicitly — requires all above as inputs
- If one of those five surfaces is missing or was not derived from its required input, downgrade the conclusion to `INFERENCE`, `clarification candidate`, or `needs rationale confirmation` instead of hardening it into a final recommendation.
- When reporting or progress text mentions team operation, apply `agents/team-lead.md §RPA-7` state vocabulary. If the strongest evidence is only planning or `NEXT-CONSEQUENTIAL-ACTION`, report only the next action.
- For `[PRES-FIRST]` and `[CHANNEL]` claims about compression, reorganization, migration, wording cleanup, or rule simplification, require explicit evidence of (a) what meaning, information surface, or habit-channel had to survive and (b) how loss was checked. Without both, downgrade the preservation claim to `INFERENCE`.
- For `[PARALLEL]` claims about staffing, serial/parallel choice, or packet shape, require explicit evidence of independence, dependency, or merge-owner basis. If the serial path or worker burden is asserted without that basis, downgrade the claim to `INFERENCE` or `needs routing re-check`.
- For `[HARDEN]` claims, require explicit evidence of the validated defect or miss class plus a concrete corrective owner or next hardening action. If the output only describes the issue, labels it educational, or leaves the correction ownerless, downgrade it to `observation only` instead of treating hardening as complete.
- For `[AUTO-PROC]` and `[CHANNEL]` claims about answer quality, require explicit evidence that the user-facing channel still leads with the verified answer, decision, or blocker. If the response shape would make process narration or packet detail the primary user-facing payload, fail verification until the output is re-channeled.

`Step 4-lite` means: classify the claim type, confirm the minimum evidence burden for that claim class, and downgrade the claim if any required surface is missing. It is not a full Step 4 pass, but it is mandatory on quick-depth paths when the output hardens consequential claims.

## Step 5: Convergence Loop

1. If Step 3 changes the conclusion, stop and restart Steps 1-4 on the corrected conclusion.
2. If Steps 1-4 produce no change and Step 3 survives, the result is converged; proceed to Step 6.
3. Maximum 3 passes. Not converged after 3 → HOLD with explanation.
4. Only converged results may be reported or handed off. Presenting an unconverged or unverified result is a governance failure.

WORK-INTENT invalidation: If Critical Challenge in Step 3 reveals the frozen WORK-INTENT or EXPECTED-OUTPUT is itself wrong (not just a conclusion detail), the convergence loop cannot resolve this gap internally. HOLD immediately with signal: 'WORK-INTENT-INVALIDATED — re-run work-planning with corrected scope before retrying self-verification.' Do not attempt further convergence passes when the fundamental scope is invalid.

## Execution Depth Guide

All depth levels still require formal Skill tool loading. The guide below controls depth after loading:

- **Full procedure (Steps 1-6)**: Before handoff, before consequential recommendation, before user-facing report with factual claims, before governance modification, after applying a consequential modification (governance files, production code, architecture changes).
- **Quick critical challenge (Step 3, all four sub-checks 3a-3d)**: Before intermediate decisions, before dispatch routing (quick depth for standard routing; escalate to full procedure when ACCEPTANCE-RISK is high or critical, or when the dispatch includes governance-sensitive changes), before acknowledging worker status, after applying a trivial modification (typo fix, formatting, non-semantic change). Ask the 4 questions in Step 3; if any answer changes the conclusion, escalate to full procedure. If the output hardens a factual claim, runtime-state claim, absence/no-issue claim, classification/judgment claim, recommendation, or scope-closing status claim, perform `Step 4-lite` before reporting or acting.
- **Minimum**: Never skip Step 3 entirely. `Step 3d`-only minimum applies only to non-consequential commentary that does not harden factual, runtime-state, absence/no-issue, classification/judgment, recommendation, or scope-closing claims. If any of those claim classes are present, quick critical challenge plus `Step 4-lite` is the minimum depth.

### MWEC Phase Depth Mapping

The Mandatory Worker Execution Cycle defines two structural verification phases. Workers may not reclassify these phases to access lower depth levels:
- **MWEC Verify-Plan phase**: Quick critical challenge — Step 3 including all four sub-checks (3a-3d). The Minimum depth (3d only) does not apply to MWEC-defined phases.
- **MWEC Verify-Results phase**: Full procedure (Steps 1-6) — includes convergence checks.

**Trigger 4+5 co-occurrence:** When trigger 4 (after applying a modification) and trigger 5 (before handoff or reporting) co-occur in the same step — that is, a modification is applied and immediately followed by handoff with no intervening changes — a single full-procedure invocation satisfies both triggers. A second Skill invocation is not required for the same completed result.

**Trigger 3+6 co-occurrence:** When trigger 3 (before executing a plan) and trigger 6 (before re-dispatch) co-occur — that is, the plan being executed is itself a dispatch action — a single invocation at the appropriate depth satisfies both triggers. Do not load self-verification twice for the same dispatch action.

## Step 6: Output The Verified Result

- Present only the final verified conclusion to the user or governing lane.
- When reporting a process mistake, state the exact failed step, what valid work exists, and the corrective action. Do not overstate failure scope.
- Do NOT present Steps 1-5 as a separate section in user-facing output.
- For final/audit user-facing reports, include a concise verification outcome surface: verification basis, residual risk/open surfaces, unverified items. State explicitly if nothing material remains open.
- When user instructions or user philosophy materially constrained the analysis, the reported verification basis must make that alignment explicit rather than implying it.
- When the analysis includes root-cause, policy, structural, or corrective conclusions, make the deductive basis explicit in brief form rather than as a long method dump.
- When evaluating an existing state under review, make the user-facing verification basis name both sides of the proportionality judgment: what the current state protects or preserves and what current cost or ambiguity was actually observed.
- If a preferred verification path was unavailable because an environment assumption failed (for example no git repository at the current root), state the fallback evidence path briefly instead of surfacing raw tool noise.
- If the rationale is confirmed but its justification remains unclear, say that explicitly; do not collapse "explained" into "validated."
- The default labels are `Verification basis`, `Residual risk/open surfaces`, and `Unverified items`. Equivalent wording is allowed only when the same meaning remains explicit. Do not use these labels in routine progress commentary, and do not announce routine progress with scaffolding such as `SV converged` or `Checkpoint ...`.
- If Critical Challenge changed the conclusion, present the corrected conclusion directly — not the journey from wrong to right.
- The verification output format below is for agent-to-agent handoff blocks only.

## Verification Output Format (internal handoff only)

Include in agent-to-agent handoff blocks, not in user-facing responses:

```
SELF-VERIFICATION: converged
CONVERGENCE-PASS: 1|2|3
SCOPE-MATCH: yes|partial|no
SV-PLAN-VERIFY: done
ROLE-CHECK: passed/total
CRITICAL-CHALLENGE: survived|conclusion-changed|not-executed
USER-CRITICISM-CHECK: done
UNVERIFIED-ITEMS: none|list
HOLD-REASON: if not converged
```

Unverified or non-converged work must not be reported or handed off as complete. For `MESSAGE-CLASS: handoff|completion`, emit positive-state procedure fields only. If the result is still blocked, unconverged, or under-verified, keep it on `hold`.
