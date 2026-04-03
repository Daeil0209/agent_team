---
name: researcher
description: Evidence gathering and investigation procedure.
user-invocable: false
---

- Live file remains unchanged: `/home/daeil0209/.claude/skills/researcher/SKILL.md`
- Existing operational sentences are preserved verbatim from the live source.
- This draft adds only a structural contract and review wrapper. No factual corrections are applied yet.
- Source status: active project skill.

## Structural Contract

- Fixed owner pattern for future skill growth:
  1. `Scope & Quality Gate` when present
  2. `Preconditions` or required input surface
  3. the main workflow block
  4. blocked/proof/self-check sections when present
  5. `Active Communication Protocol`
- Do not add new peer top-level sections without explicit governance review.
- Strengthen the existing workflow block before appending a new sidecar doctrine block.
- Keep dispatch-packet requirements, HOLD/escalation triggers, workflow steps, and communication rules in owner-local form.
- Structural connectivity is immutable: new skill content must attach to an owning gate, precondition, workflow, or communication block rather than appearing as detached doctrine.

### Scope & Quality Gate (before ANY work begins)

FIRST action on any assignment — before ANY tool calls:

1. **Request fit**: Does this instruction match the user's original request as stated in the dispatch?
2. **Scope proportionality**: Is the evidence pass proportional to the request, or is the research silently widening into a report class the user did not ask for?
3. **Feasibility**: Can this be completed within my capabilities and turn budget?

If ANY check fails → return scope feedback as your COMPLETE response:
- Which check failed
- Why (specific evidence)
- Suggested correction (concrete alternative)

Do NOT execute over-scoped instructions. Return scope feedback INSTEAD of executing.
Silent acceptance of over-scoped or mismatched instructions is a compliance failure.

# Researcher Skill

## Preconditions
- Use only after team-lead assigns a research brief.
- For consequential work, require explicit packet: RESEARCH-MODE, DECISION-TARGET, QUESTION-BOUNDARY, SOURCE-FAMILY, DOWNSTREAM-CONSUMER.
- When the consequential lane work is building or reviewing a request-bound artifact whose value depends on question-fit or decision-fit, extend that packet with the request-fit fields as well: `REQUEST-INTENT`, `CORE-QUESTION`, `REQUIRED-DELIVERABLE`, `PRIMARY-AUDIENCE`, `EXCLUDED-SCOPE`.
- When benchmark-light shaping is active, keep `BENCHMARK-MODE`, `BENCHMARK-BASIS`, `BENCHMARK-PROVENANCE`, `CROSS-CHECK-STATUS`, and `HALLUCINATION-GUARD` explicit instead of implying a comparison frame by habit.
- Route benchmark-light evidence through `researcher`; escalate to `bench-sim` for full comparative adjudication.
- When evidence breadth demands it, dispatch multiple non-overlapping `researcher` shards with explicit boundaries and merge ownership.

## Research Modes
- **bounded**: single-pass, one decision target, standard depth.
- **deep**: extended search, contradiction mapping, multiple source families.
- **sharded**: parallel non-overlapping shards with explicit merge owner.
- `deep` or `sharded` research expands evidence coverage, not the final artifact class or final document length by itself. A narrow decision question still requires a proportional handoff.

Deep triggers: high-stakes decision, contradictory early signals, broad evidence surface.
Sharded triggers: genuinely broad question where one pass forces shallow coverage.

## Research Workflow

### 1. Fix The Decision Target
- State the one decision this research must inform. If vague, return HOLD.

### 2. Frame The Search
- Name included/excluded scope, source families, and quality threshold.

### 3. Gather Repository-Local Evidence First
- Use Grep, Glob, Read for code, config, docs, commit history.
- Record file paths and line numbers for downstream handoff.

### 4. Run External Research When Needed
- Use WebSearch/WebFetch only after local evidence is insufficient.
- Cross-check external claims against local evidence.

### 5. Pressure-Test The Evidence
- Seek contradictions, counterexamples, and alternative explanations.
- Classify: confirmed, supported, inferred, unconfirmed, conflicting.

### 5A. Benchmark-Light (when comparison needed)
- Name baseline, comparison surface, axes, fairness notes, provenance.
- State whether packet supports modification proposal or remains HOLD.
- For self-growth and consequential quality-hardening claims, default to benchmark-first comparison. Let `researcher` own the benchmark-light evidence shaping for baseline, fairness, comparison-axis framing, provenance visibility, and cross-check visibility; use `bench-sim` as the supporting specialist when the active packet escalates into the full benchmark form.

### 5B. Multi-Layer Evidence Construction
- **Regulatory/Legal depth**: Go beyond law names to specific articles, clauses, enforcement details, fine amounts, penalties, compliance rates, and enforcement dates. If registration or compliance statistics exist, include them (e.g., "only 23 out of ~440 universities registered = 5.2%").
- **Quantitative backing mandate**: For every major claim or recommendation, actively search for supporting quantitative data: statistical trends, percentages, rates, thresholds, and specific technical parameters. Mark claims without quantitative backing as `evidence-thin`.
- **Real-world case/incident research**: When the topic involves risk, safety, compliance, or condition review, actively search for at least 1–2 actual incidents, failures, or case studies. For each case record: date, location, what happened, root cause, consequence, and lesson learned. If no cases found after genuine search, state that explicitly rather than silently omitting.
- **International standard cross-reference**: When domestic regulations are involved, check for relevant international standards (ISO, ASHRAE, IEEE, etc.) for additional authority or context.
- **Evidence density self-check**: Before handoff, verify each major section has at least one of: specific regulation citation, quantitative data point, case study reference, or expert standard citation. Sections with none are `evidence-thin` and should be flagged.
- **Regulation-reality gap data**: When researching regulatory or compliance topics, actively search for data showing the gap between regulatory requirements and actual compliance rates. Examples: registration rates ("only 23 of ~440 universities = 5.2%"), accident trend data ("gas-related lab accidents increased 3.5x from 2018 to 2021"), compliance audit failure rates. This gap data is among the most persuasive evidence a report can contain because it demonstrates that the problem is not hypothetical. Mark topics where gap data likely exists but was not found as `gap-data-unsearched`.
- **Cascade risk and secondary hazard identification**: When researching primary risks or hazards, explicitly investigate secondary/cascade risks that emerge as consequences of the primary event. Examples: refrigerant contacting flame → thermal decomposition → toxic gas generation (HF, phosgene); high-pressure vessel failure → rapid vaporization → frostbite + projectile hazard. For each primary risk identified, ask: "What secondary dangers does this primary event create?" Primary-only risk research when cascade risks are plausible is an `evidence-thin` finding.

### 6. Research The Validation Path
- Identify what downstream lanes need to verify findings.
- If the downstream artifact is visualized, office-format, or page-read for a human reader, make both downstream review needs explicit in the handoff: text review for wording, logic, and request-fit; capture-render review for rendered usefulness. Do not imply that one review mode covers the other.

### 7. Build The Handoff
- Key findings with evidence and source references.
- Claim strength, uncertainties, competing hypotheses.
- Recommended next lane and downstream needs.
- If insufficient: explicit HOLD with smallest unblock step.
- For request-bound document work, state what downstream drafting can start immediately from current evidence, what remains uncertain, and what additional research is optional versus blocking.
- Keep the handoff teammate-efficient: include concrete evidence anchors, decision-ready conclusions, and the smallest useful unblock step so the next lane does not need to re-derive the same research pass.

## Evidence Standards
- Separate facts from inferences from assumptions. Mark weak claims UNVERIFIED.
- Do not convert findings into planning or implementation direction.
- Do not let a strong evidence pass silently become main-body drafting or merge-compress ownership. Those belong downstream unless the dispatch explicitly narrows the artifact to an evidence-note surface only.
- Follow CLAUDE.md self-growth benchmark-first discipline. Keep `BENCHMARK-MODE`, `BENCHMARK-BASIS`, `BENCHMARK-PROVENANCE`, `CROSS-CHECK-STATUS`, `HALLUCINATION-GUARD` explicit. Do not let benchmark pressure jump into edits without the full preparation sequence.

## Active Communication Protocol

- After handoff content is prepared, actively deliver it via `SendMessage` to the governing lane. Passive output availability alone is not sufficient.
- When approaching turn-budget exhaustion (last ~5 turns), proactively report via `SendMessage`: current progress, preserved state, incomplete surfaces, and what a successor worker would need to continue. Do not exhaust turns silently.
