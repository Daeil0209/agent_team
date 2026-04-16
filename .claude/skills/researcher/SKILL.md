---
name: researcher
description: Evidence gathering and investigation procedure.
user-invocable: false
PRIMARY-OWNER: researcher
---

## Structural Contract

- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Research Modes, Research Workflow, Evidence Standards, Active Communication Protocol
- PRIMARY-OWNER: researcher
- Structural changes require governance review.
- New content must attach to an owning gate, precondition, workflow, or communication block.

### Scope & Quality Gate
Before ANY work:
1. **Request fit**: Does instruction match user's original request?
2. **Scope proportionality**: Is work scope proportional to request?
3. **Charter fit**: Does this work belong inside the researcher lane, or is it actually drafting, implementation, proof, validation, or orchestration work?
4. **Feasibility**: Can this be completed within capabilities and turn budget?

If ANY fails → return scope feedback. Do NOT execute over-scoped instructions.

### User-Perspective Gate

Apply this gate whenever research shapes a user-facing deliverable or operator workflow. It is a researcher-local evidence-completeness gate, not drafting, proof, or acceptance ownership.

1. Does the handoff explain how the intended user or operator will access, start, and use the deliverable?
2. Does it surface user-access blockers, onboarding assumptions, or usability-critical gaps instead of stopping at technical correctness?
3. If there is no direct user workflow in scope, is that absence explicit so downstream lanes do not invent one by habit?

If these checks are missing, the research is incomplete. Technically correct but user-inaccessible research is not finish-ready.

## Preconditions
- Use only after team-lead assigns a research brief.
- For consequential work, require explicit packet: RESEARCH-MODE, DECISION-TARGET, QUESTION-BOUNDARY, SOURCE-FAMILY, DOWNSTREAM-CONSUMER. Consequential research: dispatched through explicit team runtime, involving 3+ source files, producing findings that drive implementation or governance decisions, or marked high/critical ACCEPTANCE-RISK. Single-file factual lookups may omit RESEARCH-MODE and DOWNSTREAM-CONSUMER, but must always include QUESTION-BOUNDARY and OUTPUT-SURFACE.
- When the assigned artifact is request-bound and depends on question-fit or decision-fit, also include `REQUEST-INTENT`, `CORE-QUESTION`, `REQUIRED-DELIVERABLE`, `PRIMARY-AUDIENCE`, `EXCLUDED-SCOPE`.
- When benchmark-light shaping is active, keep `BENCHMARK-MODE`, `BENCHMARK-BASIS`, `BENCHMARK-SURFACE`, `BENCHMARK-AXIS`, `BENCHMARK-PROVENANCE`, `CROSS-CHECK-STATUS`, and `HALLUCINATION-GUARD` explicit instead of implying the comparison frame.
- Route benchmark-light evidence through `researcher`; load the bench-sim skill for full comparative adjudication when needed.
- When evidence breadth demands it, dispatch multiple non-overlapping `researcher` shards with explicit boundaries and merge ownership.

## Research Modes
- **bounded**: single-pass, one decision target, standard depth.
- **deep**: extended search, contradiction mapping, multiple source families.
- **sharded**: parallel non-overlapping shards with explicit merge owner.
- `deep` or `sharded` research expands evidence coverage, not final artifact class or document length. A narrow decision question still needs a proportional handoff.

Deep triggers: high-stakes decision, contradictory early signals, broad evidence surface.
Sharded triggers: genuinely broad question where one pass forces shallow coverage.

## Research Workflow

### 1. Fix The Decision Target
- State the one decision this research must inform. If vague, return HOLD.

### 2. Frame The Search
- Name included/excluded scope, source families, and quality threshold.

### 2A. Skill Recommendation Evaluation
- This loop evaluates situational skills only. Baseline MWEC loads remain mandatory per `CLAUDE.md` `§Skill Loading Philosophy`.
- If the dispatch packet includes `SKILL-RECOMMENDATIONS`, evaluate each recommended skill against the researcher's role:
  - **Evaluation baseline**: Cross-reference the user's original instructions with the dispatch packet's `REQUEST-INTENT`, `CORE-QUESTION`, and `REQUIRED-DELIVERABLE`. Skill evaluation must serve both the user's stated intent and the role-based criteria below — technical fit alone is insufficient if the skill does not advance the user's actual goal.
  1. **Investigation fit**: Will this skill's methodology produce stronger evidence for the decision target?
  2. **Proportionality**: Does the investigation scope warrant this methodology's depth, or would standard research workflow be more effective?
  3. **Downstream value**: Will the downstream consumer benefit from this methodology's structured output?
- **Applicable and beneficial** → load the skill to guide evidence gathering (e.g., `biz-sys` for business rule extraction, `eng-spec` for engineering constraints).
- **Applicable but disproportionate** → note the skill's availability without loading; proceed with standard research workflow.
- **No recommendation fits** → independently search available skill descriptions for a better alternative. If found, report upward via SendMessage before loading.
- **No recommendations provided** → independently scan available skills for methodology or domain skills applicable to this investigation.
- Record which skill was selected or rejected (with rationale) in the handoff.
- Governance rules for methodology skill loading:
  - Load at most one governing methodology skill per work phase. When multiple candidates are applicable, select the highest-fit skill based on the evaluation criteria above.
  - When SKILL-RECOMMENDATIONS is explicitly "none", the team-lead searched and found no applicable skills to recommend. The worker may still independently search if the work context suggests a methodology skill would be beneficial, but is not obligated to. Independent search is expected when the SKILL-RECOMMENDATIONS field is absent from the dispatch.
  - Self-verification Critical Challenge takes precedence over methodology skill quality criteria. Methodology skills provide additional checks, not replacement for convergence verification.
  - On reuse with new SKILL-RECOMMENDATIONS, treat previously loaded methodology skills as inactive reference. New evaluation based on the fresh dispatch takes precedence.

### 2B. Plan Verification
Load `self-verification` and execute Critical Challenge on the plan (SV Trigger 3: before executing a plan). The plan is unverified until it survives Critical Challenge.

### 3. Gather Repository-Local Evidence First
- Use Grep, Glob, Read for code, config, docs, commit history.
- Record file paths and line numbers for downstream handoff.

### 4. Run External Research When Needed
- Use WebSearch/WebFetch only after local evidence is insufficient.
- Cross-check external claims against local evidence.

### 5. Pressure-Test The Evidence
- Seek contradictions, counterexamples, and alternative explanations.
- Classify: confirmed, supported, inferred, unconfirmed, conflicting.
- Apply evidence classification and claim-strength standards from §Evidence Standards.

### 5A. Benchmark-Light (when comparison needed)
- Keep `BENCHMARK-BASIS`, `BENCHMARK-SURFACE`, `BENCHMARK-AXIS`, `BENCHMARK-PROVENANCE`, `CROSS-CHECK-STATUS`, and `HALLUCINATION-GUARD` explicit so the comparison frame remains inspectable.
- State whether packet supports modification proposal or remains HOLD.
- For self-growth and consequential quality-hardening claims, default to benchmark-first comparison. `researcher` owns benchmark-light shaping for baseline, fairness, axis framing, provenance visibility, and cross-check visibility; use `bench-sim` when the packet escalates to full benchmark form.

### 5B. Evidence Hardening Patterns
Use when a single-pass sweep would leave the question shallow, weakly supported, or easy to misread. Evidence collection and shaping only; interpretation, threshold-setting, and acceptance judgment belong to the relevant specialist or downstream owner.

| Pattern | Trigger | Action | Standard |
|---------|---------|--------|----------|
| Authoritative-source depth | Formal requirements, authoritative rules, or normative constraints in scope | Go beyond source names to decisive section, clause, threshold, date, scope condition, or enforcement surface | `UNVERIFIED` if controlling detail not found; keep claim narrow |
| Quantitative backing | Magnitude, trend, threshold, rate, or scale would materially affect conclusion | Actively seek numerical evidence for major claims | `evidence-thin` if numbers absent |
| Concrete case evidence | Risk, failure, compliance, adoption, or operational credibility in scope | Find concrete incidents, enforcement actions, case studies, or real deployments; keep anchor explicit (source context, event, mechanism, consequence, relevance) | State explicitly if no evidence found after genuine search |
| Cross-source normative references | Formal constraints in scope | Check standards, specifications, official guidance for contradiction or material change; do not assume one source family sufficient | Contradiction must be surfaced explicitly |
| Evidence density self-check | Before handoff | Verify each major conclusion anchored by decisive source detail, quantitative data, concrete case, or normative reference | Flag `evidence-thin` if major conclusion lacks strong evidence surface |
| Requirement-vs-practice gap | Topic involves formal requirements, expected process, or declared policy | Seek evidence of actual adoption, compliance, enforcement, or operating reality; state gap if unverified | Do not imply compliance-by-default; state if search was inconclusive |
| Secondary-effect tracing | Topic involves hazards, failures, dependencies, or chain reactions | Investigate material downstream effects beyond first-order events | `evidence-thin` for first-order-only research on cascading topics |
| Specialist-boundary preservation | Conclusion depends on domain-specific interpretation or acceptance thresholds | Surface need to governing lane; identify relevant specialist or downstream owner | Do not harden specialist judgment inside research lane |

### 5C. Operational Reality Classification

When the assignment is governance analysis, process review, workflow balance, or runtime-policy critique, classify each issue by evidence class before assigning severity or recommending corrective urgency.

Required evidence classes:

| Evidence class | Meaning | Allowed claim strength |
|----------------|---------|------------------------|
| observed-runtime-break | Current-session failure, reproduced block, wrong runtime behavior, or direct tool/hook error was observed | May support `real defect` and T1/T2 when impact is evidenced |
| observed-operational-friction | Work completed, but measurable cost, delay, retry churn, or operator confusion was directly observed | May support optimization, simplification, or T2/T3 depending on burden |
| static-contradiction | Textual mismatch, duplicated rule, ambiguous wording, or cross-reference inconsistency found in docs/config | Do not present as runtime break unless linked to observed behavior |
| theoretical-risk | Plausible failure path inferred from rules or code but not observed in this session | Must stay `INFERENCE` or `clarification candidate` unless stronger evidence appears |

Severity discipline for governance/process analysis:
- Do not assign T1 merely because a path looks complex, repetitive, or easy to misread.
- T1/T2 requires either `observed-runtime-break` evidence or a tight deductive chain from explicit code/runtime policy to a concrete blocking failure mode with no meaningful ambiguity.
- Static contradiction by itself is usually `clarification candidate`, documentation debt, or T3 unless it already caused observed operational harm.
- If current-session evidence disproves an initially suspected deadlock or bottleneck, downgrade the claim and state that the session observed successful passage.
- Separate "works but costly" from "fails to work". Performance or token burden is not the same class as correctness failure.

### 6. Research The Downstream Verification Path
- Identify what downstream lanes need to verify findings.
- If the downstream artifact is visualized, office-format, or page-read for a human reader, make both downstream review needs explicit in the handoff: text review for wording, logic, and request-fit; capture-render review for rendered usefulness. Do not imply that one review mode covers the other.

### 6A. Retry Governance
- Before repeating a materially similar research pass, state what evidence gap, contradiction, or failed path blocked the prior pass and what new search basis changed.
- Do not repeat the same ineffective research pattern more than 3 times without narrowing the question boundary or escalating with `HOLD`.
- Escalate to team-lead via SendMessage with message-class: hold and the specific retry exhaustion context.

### 6B. Pre-Handoff Self-Check
1. Every major conclusion anchored by at least one strong evidence surface.
2. UNVERIFIED labels applied where empirical confirmation is missing.
3. Cross-verification performed for consequential claims.
4. Evidence in downstream-consumer-ready form.
5. Research gaps and limitations explicit, not omitted.
6. Load `self-verification`, run full procedure including Critical Challenge; include verification output format in handoff block.
7. If the dispatch packet provides an explicit output format, confirm that it is compatible with the mandatory researcher handoff contract before using it.

### 7. Build The Handoff
Build the full handoff block (fields below) and send via SendMessage to team-lead. Do not write to `./.claude/session-state.md` or `$HOME/.claude/session-state.md` directly — team-lead owns all continuity surfaces.
- Packet-local formatting instructions may add summary fields or presentation ordering, but they must preserve the mandatory handoff contract below and the evidence-class requirements in §Evidence Standards.
- If the dispatch packet's requested output format conflicts with the mandatory researcher handoff contract or suppresses required evidence surfaces, do not emit a completion-style report in that conflicting format. Return `MESSAGE-CLASS: hold` and identify the packet-format conflict in `OPEN-SURFACES`.
- Key findings with evidence and source references.
- Claim strength, uncertainties, competing hypotheses.
- Recommended next lane and downstream needs.
- If insufficient: explicit HOLD with smallest unblock step.
- For request-bound document work, state what downstream drafting can start immediately from current evidence, what remains uncertain, and what additional research is optional versus blocking.
- Keep the handoff teammate-efficient: include concrete evidence anchors, decision-ready conclusions, and the smallest useful unblock step so the next lane does not re-derive the same research pass.
- For consequential `SendMessage` reports with `MESSAGE-CLASS: handoff|completion|hold`, keep one completion-grade evidence block explicit.
- Include `REQUESTED-LIFECYCLE: standby|shutdown|hold-for-validation` in that shared block. Default to `standby` unless `shutdown` is the honest request. It is a request, not authority.
```
- TASK-ID: <assigned-id|none>
- OUTPUT-SURFACE: <research topic>
- EVIDENCE-BASIS: <sources examined and cross-check status>
- OPEN-SURFACES: <unresolved questions or gaps>
- RECOMMENDED-NEXT-LANE: <suggested next worker>
- SKILL-RECOMMENDATIONS: <skill and rationale or none>
- PLANNING-BASIS: loaded
- SV-PLAN-VERIFY: done
- SELF-VERIFICATION: converged
- CONVERGENCE-PASS: 1|2|3
- REQUESTED-LIFECYCLE: standby|shutdown|hold-for-validation
- If any of those procedure states is not true yet, use `MESSAGE-CLASS: hold` and explain the blocked surface in `OPEN-SURFACES` instead of formatting the report as completion-ready.
```
- Use the task id from the runtime assignment packet whenever one exists. Do not substitute a worker name, inferred chronology, or remembered topic label.

## Evidence Standards
- Separate facts from inferences from assumptions. Mark weak claims UNVERIFIED.
- For governance/process findings, keep `observed-runtime-break`, `observed-operational-friction`, `static-contradiction`, and `theoretical-risk` explicit so downstream synthesis does not promote document-only concerns into false runtime defects.
- Do not convert findings into planning or implementation direction.
- Do not let a strong evidence pass silently become main-body drafting or merge-compress ownership unless the dispatch explicitly narrows to an evidence-note surface.
- Follow the self-growth benchmark-first sequence owned by `skills/self-growth-sequence/SKILL.md` and `skills/self-growth-sequence/reference.md` `§Benchmark Protocol Detail`. Keep the benchmark packet fields explicit: `BENCHMARK-MODE`, `BENCHMARK-BASIS`, `BENCHMARK-SURFACE`, `BENCHMARK-AXIS`, `BENCHMARK-PROVENANCE`, `CROSS-CHECK-STATUS`, and `HALLUCINATION-GUARD`. Do not let benchmark pressure jump into edits before the full preparation sequence.
- On workflow-governed work, research output is evidence input to the governing lane's next phase, not implementation authority. Requirements summaries, workbook analysis, and business-rule extraction support planning or design but must not be framed as approval to begin implementation. [Rule-Class: mandatory]

- When the research surface is discovery or requirements clarification, state explicitly whether the result supports planning only, design refinement, or remains insufficient. Do not imply implementation readiness unless the dispatch explicitly asked for that judgment. [Rule-Class: corrective]

## Active Communication Protocol

- Consequential `handoff|completion|hold` must use the completion-grade evidence block above, including `REQUESTED-LIFECYCLE`.
