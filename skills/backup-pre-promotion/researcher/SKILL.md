---
name: researcher
description: Standard evidence-gathering procedure for the researcher lane when the team needs repository discovery, source triage, contradiction checks, external reference checks, or compact decision-ready research handoffs.
user-invocable: false
---

# Researcher

This skill defines the repeatable research procedure for the `researcher` lane.

Keep role identity, authority boundaries, and completion ownership in `.claude/agents/researcher.md`.
Use this skill for the detailed workflow that the `researcher` should follow while gathering evidence for `team-lead`, delegated `planner`, or downstream worker lanes.

## Procedure Preconditions

- Use only after `team-lead` or an active delegated `planner` has assigned a bounded research target.
- Use when evidence gathering, source triage, contradiction checks, dependency tracing, reproduction support, or external reference checks should be separated from planning and implementation.
- Keep the research target bounded to the active decision, blocker, or execution need.
- Researcher-owned reproduction support means investigative triage, reproduction-method design, dependency tracing, and evidence shaping; runnable reproduction and executable proof remain `tester` ownership.

## Research Depth Doctrine

- Default to quality-first research. Do not trade away decision-useful breadth or contradiction resolution merely to keep the pass light.
- Keep the smallest credible scope, but do not force false narrowness when the downstream decision genuinely depends on broad coverage.
- If the evidence need is both broad and consequential, prefer explicit sharding or a deeper pass over a shallow single sweep.
- Research cost optimization happens after credible coverage is secured; it does not justify shallow evidence on consequential work.

### Research Modes

- `bounded`
  - default mode for one clearly bounded question with limited contradiction risk
- `deep`
  - use when the consequence, contradiction density, or method ambiguity requires heavier evidence shaping before downstream action
- `sharded`
  - use when the research target contains multiple non-overlapping bounded questions that can be answered in parallel without weakening merge quality

### Deep-Research Triggers

Escalate from `bounded` to `deep` when any of the following is true:

- the research output will directly shape planning, approval, or acceptance for consequential work
- the evidence surface is broad enough that a shallow pass would likely miss decisive contradictions or hidden conditions
- local and external sources disagree or the question is materially recency-sensitive, version-sensitive, or source-quality-sensitive
- the validation method itself is unclear and downstream lanes need a credible method packet before acting
- the requested handoff must do more than list facts and instead shape escalation, risk framing, or decision order credibly

### Sharded-Research Triggers

Escalate from one-researcher mode to `sharded` research when any of the following is true:

- 2 or more bounded research questions can be investigated independently
- local evidence review, external source checking, contradiction resolution, and validation-path design would otherwise overload one pass
- breadth is genuinely required for the operator's quality target and narrowing the question would materially weaken the result
- one researcher would be forced into shallow coverage across multiple source families or decision surfaces

### Sharded-Research Rules

- `team-lead` owns the default decision to fan out multiple researcher lanes.
- A clearly delegated `planner` may coordinate researcher sharding only inside delegated management scope.
- Every shard must declare:
  - bounded question
  - include/exclude logic
  - expected source family or evidence surface
  - explicit non-overlap boundary
  - expected merge dependency when known
- Do not dispatch multiple researchers onto the same evidence surface without an explicit reason such as independent contradiction checking.
- The merge owner stays with `team-lead` by default, or with delegated `planner` when the delegated scope explicitly includes merge coordination.
- Each researcher shard must report its own unresolved contradictions, confidence limits, and cross-shard dependencies instead of assuming another shard will absorb them.

### Shard Merge Output Contract

When the work is `sharded`, each shard handoff should expose:

- shard id
- bounded question answered
- evidence families actually covered
- unresolved contradiction or dependency list
- what the merge owner still needs from sibling shards
- whether the shard result is `decision-usable`, `partial`, or `HOLD`

## Expansion Trigger Rules

- Keep this skill as the single researcher procedure file.
- Do not load separate researcher rule files; apply additional sections in this same document when their trigger conditions are true.
- Evaluate triggers during `Fix The Decision Target`, before broad collection begins.
- If multiple triggers are true, apply all matching sections in this file.
- If trigger status is uncertain and under-research risk is higher than the cost of extra analysis, apply the heavier section.

### Trigger A: Evidence Triangulation

Apply the advanced evidence triangulation sections later in this file when any of the following is true:

- a consequential claim depends on external evidence
- multiple sources disagree or appear non-independent
- the question is recency-sensitive, version-sensitive, or source-quality-sensitive
- the downstream decision depends on whether a claim is confirmed, merely supported, weak, or insufficient

### Trigger B: Reporting Or Escalation Shaping

Apply the advanced reporting and escalation sections later in this file when any of the following is true:

- the downstream consumer is making a plan, approval, or acceptance decision rather than just reading facts
- tester-ready procedure, method packet, breadth filter, upper-bound packet, delta note, or lane-weakness note may be needed
- the hardest part is not collection but how to frame the handoff or escalation credibly
- the research packet is shaping a visualized, office-format, or page-read human-facing artifact whose acceptance depends on both textual correctness and rendered usefulness

### Trigger C: Comparative Benchmark-Light Discipline

Apply the comparative benchmark-light sections later in this file when any of the following is true:

- the decision depends on before/after comparison rather than one-path explanation
- the operator or lead wants to compare the current path to a leaner neighboring path, incumbent owner, or simpler baseline
- fairness, comparison-axis choice, or benchmark evidence quality will materially affect routing confidence
- the work is not yet at formal benchmark adjudication, but the team still needs baseline and comparison discipline before acting

## Escalation Routing

- If the downstream artifact is visualized, office-format, or page-read for a human reader, make both review needs explicit in the research handoff: text review for wording/logic/request-fit and capture-render review for rendered usefulness. Do not imply that one review mode covers the other.

- If the research target is underspecified, stop and escalate to `team-lead`.
- If `planner` is actively managing the assigned scope, report the issue through that lane as well.
- If the request is too broad for one credible pass, recommend narrowing or explicit sharded research rather than silently collecting low-signal material.
- If evidence remains materially contradictory or insufficient for a safe downstream decision, hand off with an explicit `HOLD` recommendation instead of flattening uncertainty.

## Research Request Packet Contract

Before meaningful collection begins, the controlling lane should make the request packet explicit enough that the researcher does not have to guess hidden scope or decision intent.

### Minimum Packet Fields

- research mode
  - `bounded`, `deep`, or `sharded`
- decision target
  - the downstream decision, blocker, or execution surface this packet must support
- bounded question
  - the specific question this pass is answering
- include / exclude logic
  - what evidence families, files, or external surfaces are in scope and what is intentionally out of scope
- expected source family
  - repository-local, external authoritative, mixed, contradiction resolution, validation-path, or equivalent
- downstream consumer
  - `team-lead`, delegated `planner`, `developer`, `reviewer`, `tester`, or `validator`

### Human-Facing Artifact Additions

When the research packet supports a request-bound artifact whose value depends on answering a defined question or supporting a defined decision, also require:

- `REQUEST-INTENT`
  - what operator ask or downstream action this artifact is meant to serve
- `CORE-QUESTION`
  - the single dominant question the artifact must answer first
- `REQUIRED-DELIVERABLE`
  - what artifact form the downstream lane is expected to produce
- `PRIMARY-AUDIENCE`
  - who will read or use the artifact
- `EXCLUDED-SCOPE`
  - what surrounding context is intentionally out of scope unless it becomes necessary for safe interpretation

### Comparative Packet Additions

When comparative benchmark-light discipline is active, the request packet should also name:

- `BENCHMARK-MODE`
  - `light` when the researcher is shaping comparative evidence or fairness notes
  - `full` only when the researcher is explicitly preparing evidence for a downstream full benchmark path rather than issuing the final benchmark verdict here
- `BENCHMARK-BASIS`
  - the baseline, incumbent path, or simpler neighboring path being compared
- `BENCHMARK-SURFACE`
  - what is being compared
- `BENCHMARK-AXIS`
  - the comparison axes that matter for the downstream decision
- `BENCHMARK-PROVENANCE`
  - `repo-observed`, `authoritative-external`, `mixed`, or `simulator-only`
- `CROSS-CHECK-STATUS`
  - `repo-confirmed`, `authority-confirmed`, `mixed-confirmed`, or `simulator-unconfirmed`
- `HALLUCINATION-GUARD`
  - `cite-or-hold`

If comparative fields are materially missing, return `HOLD` or a clarification request instead of inventing an implicit benchmark frame.

Comparative benchmark-light output does not itself authorize direct edits. If the downstream team wants to move toward modification, make it explicit whether the evidence is only evidence-shaping or strong enough to support a downstream concrete modification proposal.

Do not treat an after-only clean rerun or a single favorable current-state read as proof that a lane advanced or became promotion-ready. That conclusion still needs an inspectable baseline, fair comparison conditions, and a visible claimed delta.

When the active topic is self-growth, start from the observed deficiency signal rather than from a fixed category menu. Use path labels later only as minimal routing guides after the evidence picture is clearer.

When the active topic is self-growth, state whether the observed deficiency appears growth-critical or merely local friction before downstream execution routing hardens.

If the likely deficiency is in team-lead management, coordination, adjudication, monitoring, or sequence discipline, say so explicitly rather than reframing it as a worker-only flaw.

If `BENCHMARK-PROVENANCE` remains `simulator-only` or `CROSS-CHECK-STATUS` remains `simulator-unconfirmed`, keep the packet in evidence-shaping or `HOLD`; do not present it as self-growth edit authorization.

### Consequential Packet Rule

- When the topic is consequential, broad, contradiction-prone, or likely to require sharding, do not accept a vague "go research this" brief as sufficient.
- If key fields are missing, return a clarification request or `HOLD` packet rather than silently inventing the target shape.

### Sharded Packet Additions

Every sharded researcher packet should also name:

- shard id
- non-overlap boundary
- merge owner
- expected merge dependency
- expected top-line question that this shard will help answer

### Packet Anti-Patterns

- vague breadth without a decision target
- multiple unrelated bounded questions hidden in one packet
- omitted exclude logic that makes every possible source look in-scope
- missing merge owner for sharded research
- hidden acceptance pressure disguised as "just gather facts"
- comparative claims without an explicit baseline, comparison surface, or fairness frame
- remembered or citation-free benchmark examples presented as if they were inspectable evidence

## Research Workflow

### 1. Fix The Decision Target

- Identify the exact downstream decision, blocker, or implementation question the research must support.
- When the downstream surface is a request-bound artifact, freeze the single dominant question before broad collection starts and mark what information is merely supporting context versus part of the required answer.
- Distinguish:
  - confirmed facts
  - working inferences
  - assumptions
  - unknowns
- Evaluate the expansion trigger rules immediately.
- Do not start with unbounded collection when the real question can be narrowed first.

### 2. Frame The Search

- Define the smallest research question that would unblock planning, implementation, review, or testing.
- Establish a compact include / exclude logic before broad intake.
- For request-bound artifact research, split the intake into:
  - direct-answer evidence
  - qualifier evidence that materially changes or limits the answer
  - non-core background that should stay out unless the lead explicitly widens scope
- If the evidence packet fits only one subtype of a broader ask, label that as a branch or assumption instead of silently converting the research question.
- When multiple questions exist, decompose them into distinct bounded questions rather than one overloaded search pass.
- When the operator or lead genuinely needs broad coverage, prefer explicit sharding over false narrowing.
- If parallel research is active, keep question ownership non-overlapping.

### 3. Gather Repository-Local Evidence First

- Inspect only the local materials needed to answer the active question.
- Use `Bash` only for read-only inspection, search, or reproducible observation support.
- When repository context is being reconstructed from weak continuity, verify branch topology before branch-to-branch git comparisons. Do not assume `main` or `master`; discover existing refs first or use `bash "$HOME/.claude/hooks/inspect-repo-context.sh" "<repo-root>"`.
- Use local evidence to identify:
  - existing implementation patterns
  - dependencies and consumer surfaces
  - plans, specs, schedules, or reports that shape execution
  - gaps or contradictions that require external checking
- Prefer repository-local signals before escalating to external references when the question can be answered locally.

### 4. Run External Research When Needed

- Use `WebSearch` or `WebFetch` only when local evidence is insufficient, stale, or missing.
- Prefer authoritative or primary sources when the downstream decision carries material risk.
- Check recency when the topic is version-sensitive, operationally unstable, or date-dependent.
- Do not present a single weak web source as settled fact for an important decision.

### Web Query Construction

Use compact query patterns that fit the research intent.

| Intent | Query pattern |
|---|---|
| Official documentation | `[tool/library] [version] [topic] site:[official-domain]` |
| Implementation pattern | `[language/framework] [pattern] example code` |
| Error resolution | `\"[exact error]\" [tool/library] solution` |
| Benchmark or comparison | `[A] vs [B] [current year or recent]` |
| Standards or specification | `[standard/RFC name] specification` |
| Freshness-sensitive topic | `[topic] after:YYYY-MM-DD` |

### Query Rules

- Start specific and broaden only if necessary.
- Quote exact errors or distinctive phrases.
- Include version numbers when behavior depends on version.
- Add `site:` constraints when official sources matter more than tutorial noise.

### 5. Pressure-Test The Evidence

- Look for contradictions, counterexamples, and hidden conditions that could break the first plausible explanation.
- Separate:
  - directly supported claims
  - bounded inferences
  - unsupported assumptions
  - unresolved conflicts
- If evidence quality is weak, narrow the conclusion rather than padding confidence.
- When `Trigger A` is true, apply the evidence triangulation section before finalizing claim strength.

### 5A. Apply Benchmark-Light Comparative Discipline When Triggered

- When `Trigger C` is true, explicitly name:
  - the active baseline or incumbent path
  - the comparison surface
  - the comparison axes
  - the provenance class of each benchmark input
  - the cross-check state of the comparative claim
  - fairness notes that could distort the comparison
  - what remains unproven without a downstream full benchmark path
- Own the evidence-shaping portion of comparative work here. Do not silently turn researcher output into the final competitiveness, promotion, or durable ownership verdict.
- Use `HALLUCINATION-GUARD: cite-or-hold` literally. If a comparative claim depends on uninspectable memory, uncited external examples, or weak benchmark folklore, do not upgrade it into a clean comparative handoff.
- If the active request truly needs final comparative adjudication, route the evidence packet downstream to the `bench-sim` specialist path rather than stretching the researcher lane into a benchmark judge.
- If no fair baseline exists yet, return `HOLD` instead of flattering the preferred path with a weak comparison frame.

### Core Evidence Strength Rule

- Prefer primary or authoritative sources when the downstream decision is consequential.
- Treat a claim as stronger when it is corroborated across source families rather than repeated within one weak family.
- If a consequential claim depends only on weak or low-trust sources, keep the claim `UNVERIFIED` or move the handoff to `HOLD`.

### 6. Research The Validation Path

- When the team does not yet know how a claim can be validated, treat the validation path itself as a first-class research target.
- If tester follow-on is likely, hand off:
  - exact steps to run
  - what each step would prove
  - what remains unproven even after those steps
- If `Trigger B` is true, apply the reporting and escalation section before final handoff.

### 6A. Protect Role Boundaries While Interpreting Evidence

- Convert findings into planning or execution implications only as bounded recommendations, not as hidden ownership transfer.
- If the evidence points to a likely plan change, design correction, or acceptance risk, state that implication explicitly and route it to the appropriate owner instead of silently deciding it here.
- Do not flatten "the evidence suggests X" into "the team will do X".

### 7. Build The Handoff Packet

- Produce a compact handoff that another lane can reuse without rereading the entire search process.
- Structure the handoff in decision order rather than search order.
- Include:
  - research mode used: `bounded`, `deep`, or `sharded`
  - decision or blocker being supported
  - key findings
  - evidence basis
  - uncertainties or contradictions
  - implications for the next step
  - claim strength or confidence level
  - suggested downstream lane when obvious
- When comparative benchmark-light discipline is active, also include:
  - `BENCHMARK-MODE`
  - baseline or incumbent path
  - comparison surface
  - comparison axes
  - provenance class
  - fairness notes
  - claimed before/after delta when self-growth or capability hardening is in scope
  - throughput or neighboring-lane regression still unproven
  - explicit statement of whether downstream `bench-sim` adjudication is still required
- Mark unsupported material as `UNVERIFIED`.
- Make the handoff usable for explicit reuse, standby, retask, or release decisions when the active runtime keeps workers live after task completion.
- If `Trigger B` was used, say so explicitly in the handoff so downstream lanes know the packet was shaped for decision support or escalation.
- If the work was one shard of a broader research fan-out, identify the shard boundary and any unresolved cross-shard dependency or contradiction explicitly.
- If the packet is not yet credible for safe downstream action, make the top-line state `HOLD` and state the smallest evidence step that would clear the hold.

### Recommended Handoff Skeleton

- `Mode`
- `Decision target`
- `Bounded question`
- `Top-line state`
  - `decision-usable` or `HOLD`
- `Key findings`
- `Evidence basis`
- `Contradictions / uncertainties`
- `Implications for next lane`
- `Needed unblock step`
  - required when top-line state is `HOLD`
- `Shard notes`
  - required for `sharded` mode

## Research Question Quality Standard

- Phrase questions neutrally rather than to confirm a preferred answer.
- Prefer falsifiable questions over vague fishing.
- Separate fact-finding questions from judgment questions.
- State what is already known, what is unknown, and what evidence would change the downstream decision.
- If the prompt is too broad for a credible pass, narrow it explicitly instead of hiding behind delay.

## Recipient-Aware Research Standard

- Identify the primary downstream decision-maker or recipient when that changes what evidence must be surfaced first.
- Distinguish factual needs from recipient-specific acceptance needs.
- Keep recipient adaptation truth-preserving; do not bend or soften evidence to fit audience preference.

## Evidence Challenge Standard

- Distinguish evidence that supports a hypothesis from evidence that weakens it.
- Note when a conclusion depends on a single fragile source or a weak inference chain.
- Raise explicit uncertainty when the available evidence is insufficient for a strong recommendation.
- Prefer a smaller defensible conclusion over a larger speculative one.
- Do not flatten challenged or weak claims into the same confidence voice as well-corroborated claims.

## Evidence Triangulation Execution

Use this section when `Trigger A` is true.

### Evidence Sufficiency Thresholds

| Level | Criteria | Handoff action |
|---|---|---|
| `Strong` | 2 or more independent authoritative sources agree and no material contradiction remains | hand off as confirmed and name corroboration anchors |
| `Moderate` | 1 authoritative source plus 1 corroborating source from a different family | hand off as supported inference and state the gap |
| `Weak` | single source only, or multiple sources from the same family without true independence | `HOLD` the specific claim or attach an explicit caveat |
| `Insufficient` | material contradictions unresolved, or only weak sources exist for a consequential claim | `HOLD` the handoff and escalate with the contradiction or source-quality gap |

- Apply sufficiency thresholds per claim, not per entire handoff.
- The top-line handoff confidence should not exceed the strongest claim set that is actually decision-critical.
- These sufficiency levels are a researcher-local intake/output aid, not a second competing evidence taxonomy. Map them back to the canonical cross-lane statuses in `CLAUDE.md`: `Strong -> confirmed`, `Moderate -> supported`, `Weak -> inferred|unconfirmed` depending on directness, `Insufficient -> conflicting|unconfirmed` depending on whether contradiction is present.

### Source Classification Tiers

| Tier | Typical sources | Signal |
|---|---|---|
| `Tier 1` | official documentation, language/framework specs, RFCs, standards, peer-reviewed papers | maintained by source authority, versioned, corrigible |
| `Tier 2` | recognized-author books, maintainer blogs, accepted high-signal technical Q&A, established technical publishers | attributed expertise and meaningful review signal |
| `Tier 3` | tutorials, commercial product docs, attributed blogs, talk transcripts | useful but single-author and weakly reviewed |
| `Tier 4` | anonymous blogs, undated SEO pages, unattributed summaries, low-trust AI summaries | no durable authorship or review signal |

### Tier Rules

- When a source straddles tiers, assign the lower tier unless there is a clear reason not to.
- If a Tier 2 source conflicts with Tier 1 on a factual claim, investigate scope, version, or recency before trusting the lower source.
- Recency matters. An older high-tier source may need fresher corroboration for fast-moving technology.

### Cross-Family Triangulation

- Documentation family shows what is intended or specified.
- Implementation family shows what is actually present or working.
- Experience family shows what breaks or surprises appear in practice.
- Standards family shows what should hold in principle.
- A claim corroborated across families is stronger than repeated claims from one family only.

### Contradiction Mapping

When material evidence points in different directions, record:

- claim
- source A and what it says
- source B and what it says
- likely cause of divergence
- whether the divergence is trivial, material, or direct contradiction
- current resolution or explicit unresolved state
- recommendation:
  - use with caveat
  - `HOLD`
  - escalate

### Triangulation Escalation Triggers

- Tier 1 sources contradict each other on a material claim
- a consequential downstream claim rests only on Tier 3 or Tier 4 evidence
- multiple incompatible interpretations exist and the downstream decision depends on which is correct
- the question is recency-critical and the available evidence is stale
- the contradiction map exposes a gap that cannot be resolved from available sources

### Triangulation Anti-Patterns

- counting sources instead of checking independence
- treating absence of contradiction as confirmation
- upgrading sufficiency level just to avoid `HOLD`
- flattening weak claims into the same confidence voice as strong claims

## Reporting And Escalation Shaping

Use this section when `Trigger B` is true.

### When-Relevant Handoff Packets

- Include a `breadth filter note` when high-impact evidence was retained and lower-impact material was intentionally deferred or dropped.
- Include a `failure-prevention packet` when likely defect classes, boundary risks, or minimal prevention anchors should be surfaced before implementation or review.
- Include a `method packet` when validation ambiguity exists. State:
  - direct proof
  - proxy proof
  - blocked proof
  - can prove now
  - cannot prove here
  - irreducible manual check
- Include a `tester-ready procedure` when tester follow-on is likely. State the exact steps, what each step proves, and which retest gate each step closes.
- Include a `pre-reference hypothesis packet` when the task asks for practical software-system design and early surface or contract inference matters.
- Include an `upper-bound packet` when benchmarking against stronger external references matters. State which references are genuinely stronger, why, and which structural gaps they expose.
- Include a `delta note` when later references materially change the working picture. Distinguish:
  - confirmed
  - missed but inferable
  - genuinely hidden
  - intentionally unchanged
- Include a `lane-weakness note` when the research lane itself missed on scope control, decomposition, or evidence throughput and a later skill hardening pass should address it.

### Decision-Support Report Standard

When the downstream artifact is a decision-support handoff or report:

- Start with the decision question and intended reader.
- Define a compact method-shaped search frame before broad intake:
  - concept axes
  - source families to cover
  - include / exclude logic
- Organize findings by reader decision order, not by raw collection order.
- Evaluate claims at the claim level rather than the source level.
- Keep a compact trace of:
  - source families checked
  - important included evidence
  - intentionally excluded low-signal evidence
  - cross-check status
- Keep an update-ready trace that notes what should be revisited first if the question, environment, or market state changes materially.
- Do not turn the handoff into a second giant report that downstream lanes must summarize again.

### Escalation Signal Selection

- Use a `blocker note` when the lane is over-scoped, under-specified, or currently evidence-blocked.
- Use a `revision request` when the main problem is that the request exceeds the lane's role boundary or current evidence-processing capacity before credible work can begin.
- Use a `pre-execution objection` when the received manager-side instruction is contradictory, unsafe, structurally weak, or foreseeably harmful before work starts.
- Use a `manager-facing issue proposal` after work has started when a recurring or newly verified upstream instruction defect is causing drift, contradiction, rereading, or throughput loss.
- Use `HOLD` when the evidence packet is not yet credible enough for downstream planning or execution.

### Blocker And Hold Protocol

- Use a blocker note when the lane is over-scoped, under-specified, or evidence-blocked.
- A blocker note must state:
  - the current blocker
  - what narrowing or clarification is needed
  - the smallest credible next step
  - the expected completion path
- Use `HOLD` when planning or execution should not continue because the evidence base is materially insufficient, contradictory, or still missing stronger references.

### HOLD Packet Minimum Fields

When returning `HOLD`, always state:

- blocked decision or downstream surface
- why the current evidence is not credible enough
- blocker class
  - breadth
  - contradiction
  - weak-single-source
  - method ambiguity
  - missing local context
- smallest credible unblock step
- which lane should act next
  - `team-lead`, delegated `planner`, `tester`, or another named downstream owner

## Handoff Boundary

- Hand off when the evidence base is decision-useful, key constraints are surfaced, and unresolved gaps are explicit.
- Use explicit `HOLD` when:
  - evidence is insufficient for planning or execution
  - core sources still conflict materially
  - stronger references were reasonably available but not pursued despite acceptance risk
  - the planning handoff is not yet credible even if partial progress exists
- `HOLD` may coexist with a blocker note or escalation signal, but it remains the handoff-gating decision rather than a generic complaint or progress label.

## Skill Maintenance Rule

- When this skill itself is being patched, preserve role-owned research procedure here and keep shared doctrine in `CLAUDE.md`.
- If a proposed addition mostly restates team-wide doctrine, trim it or move it back to the correct owning document.
