---
name: task-execution
description: Task execution procedures for team-lead work planning, dispatch governance, and delivery verification.
user-invocable: false
PRIMARY-OWNER: team-lead
---

## Structural Contract
- Fixed section order: Activation, Step 1: ENTRY PREREQUISITE, Step 2: DETERMINE TIER, Step 3: EXECUTE PER TIER, Step 4: VERIFY, Intent Framing Method, Request-Fit Freeze And Phase Discipline, Pre-Dispatch Routing Quality Gate, Dispatch Sizing Guard, Pre-Dispatch Scope Check, Dispatch Packet Final Check, Task Decomposition Protocol, Dispatch Packet Compliance, Dispatch Packet And Authority Boundaries, Agent Dispatch Discipline, User-Perspective Acceptance Gate, Checkpoint C: Before Presenting Results
- PRIMARY-OWNER: team-lead
- Structural changes require governance review.

## Activation

Load this skill when the Primary Operating Loop classifies a message as Task request, Correction (after self-growth dispatch), or complex Question requiring Standard or Precision tier execution. agents/team-lead.md §RPA-1 §Tier Routing directs loading this skill after completing the Fresh Turn Dispatch Gate. For Standard/Precision-shaped work, this skill is mandatory, not optional guidance.

## Step 1: ENTRY PREREQUISITE

This skill owns Standard and Precision tier selection, workflow selection, dispatch governance, and delivery verification. It does not satisfy fresh-turn planning discipline by itself.

Fresh-turn operating order is fixed:
1. `Bootstrap Inspection`
2. `Decision Freeze`
3. `Execution Path`

Do not collapse these phases into one reflexive move.

### Bootstrap Inspection

Use only the minimum read-only inspection needed to plan accurately. This surface exists to avoid planning from memory or assumption while still preventing premature execution.

Allowed surface:
- `Read`
- `Grep`
- `Glob`
- `ToolSearch`

Not allowed in Bootstrap Inspection:
- mutation tools
- worker dispatch
- task creation
- consequential completion/reporting actions

If the required next move is still read-only scoping, remain in Bootstrap Inspection. If the next move changes the world, routes work, or claims completion, move to Decision Freeze first.

Quality-spine scope rule: `work-planning` and `self-verification` remain mandatory for consequential paths. They are not meant to re-fire on every read-only bootstrap or bounded task-query hop when the session is still gathering context and has not crossed into dispatch, mutation, task-state change, or completion reporting.

### Decision Freeze

Before any execution-path choice, team-lead must:
- load `work-planning`
- freeze the current request scope
- load `self-verification`
- complete the post-planning SV gate
- decide `lead-local direct` vs `team routing`

### Execution Path

After Decision Freeze, choose exactly one primary path for the current surface:
- `lead-local direct`
- `team routing`

If later evidence changes the fit, reopen planning explicitly rather than drifting across paths without a fresh decision.

Before any fresh-turn `Agent`, `TaskCreate`, or assignment-grade `SendMessage` fan-out, team-lead must have:

1. Loaded `work-planning` and frozen the current request scope.
2. Loaded `self-verification` and completed the post-planning SV gate.
3. Preserved the frozen request-fit packet as the dispatch basis.

If `task-execution` is loaded first to classify tier or inspect workflow fit, stop before dispatch and satisfy the fresh-turn `work-planning` and post-planning `self-verification` markers. `task-execution` may refine the plan; it does not replace those markers.

**Same-turn carry-forward:** If `work-planning` and post-planning `self-verification` were both executed in the current turn and no `Edit`, `Write`, `MultiEdit`, `Agent`, `TaskCreate`, or assignment-grade `SendMessage` occurred since the last SV load, those markers carry forward — `task-execution` Decision Freeze does not require reloading them. If scope changed materially after those markers (e.g., tier reclassification that changes the approach), re-run `work-planning` explicitly before continuing. For the authoritative carry-forward reset conditions, see `skills/self-verification/SKILL.md §Activation Trigger`.

Before any consequential tool use, apply the reference `Consequential Tool Recovery Contract`: answer status-only turns without mutation, do not probe hooks, and do not retry a blocked tool until the hook's `Next:` action has been completed.

## Step 2: DETERMINE TIER

| Workload Tier | Criteria | Agents | Governance |
|------|----------|--------|------------|
| Lightweight | Single-file, single worker, bounded instruction, no external deliverable | 1 | WP → SV quick challenge → dispatch → verify |
| Standard | Multi-concern OR multi-file, 1-2 workers, single deliverable | 1-2 | Fresh-turn WP + SV gate → full pre-dispatch scope check |
| Precision | External deliverable OR 3+ workers OR research required | 2+ | Fresh-turn WP + SV gate → full scope check + explicit acceptance pipeline |

Note: "2 agents" = Standard unless other Precision criteria also apply.
Terminology note: these are workload tiers for this skill. They are not the same as `CLAUDE.md` rule-class labels (`[Rule-Class: mandatory]`/`[Rule-Class: corrective]`) or severity levels (`T0-T3`).

Before finalizing tier, decide whether the work stays lead-local or becomes team-routed:
- If all lead-local direct-work conditions are satisfied, lightweight lead-local execution remains allowed.
- If any team-routing condition is present, tier as Standard or Precision as appropriate and proceed with explicit staffing.
- If ambiguous, choose the team-routed path.
- If the request spans multiple governance surfaces, multiple defect lenses, or a synthesis burden that would bottleneck one lead pass, treat that as Standard or higher unless a bounded reason keeps it lightweight.

## Step 3: EXECUTE PER TIER

**Lightweight**: Satisfy the fresh-turn `work-planning` and post-planning `self-verification` gate, then dispatch with bounded instruction.

**Standard**:
Prerequisite: fresh-turn `work-planning` and post-planning `self-verification` gate is complete.

1. Scope check (REQUEST-INTENT, CORE-QUESTION in 1-2 sentences)
2. SV quick challenge on scope and approach
3. Dispatch with bounded instruction
4. Verify completion

Once Standard is recognized, broad lead-local continuation is not the default path. Continue lead-local only when the bounded reason is explicit and still satisfies the direct-work checklist.

**Precision**:
Prerequisite: fresh-turn `work-planning` and post-planning `self-verification` gate is complete.

1. Request analysis: run the Intent Framing Method, then freeze `REQUEST-INTENT`, `CORE-QUESTION`, `REQUIRED-DELIVERABLE`, `PRIMARY-AUDIENCE`, and `EXCLUDED-SCOPE`
2. Skill Applicability Validation: Validate and activate the `ACTIVE-WORKFLOW` identified in work-planning Step 1.
   - If work-planning produced `ACTIVE-WORKFLOW: <workflow-id>`, load that workflow skill now. Its phase structure governs Step 3 Plan.
   - If work-planning produced `ACTIVE-WORKFLOW: none`, continue with generic tier procedure.
   - If work-planning produced `ACTIVE-WORKFLOW: pending-user-clarification`, resolve the ambiguity before proceeding.
   - If work-planning did not produce an `ACTIVE-WORKFLOW` field (legacy path or lightweight tier), fall back to scanning available skills against `REQUIRED-DELIVERABLE` and `REQUEST-INTENT`. If a governing workflow match is found, load it before planning or dispatch; record `ACTIVE-WORKFLOW: none` if no match.
   - `task-execution` is the sole owner of governing workflow activation for Standard and Precision tier work. Absence of a governing workflow match is valid; do not force a project workflow onto non-project work.
   - For each dispatch sub-plan: identify all applicable technique, methodology, and domain skills and include them as `SKILL-RECOMMENDATIONS` in the dispatch packet so agents can evaluate and select.
   - Skill channel ownership follows `CLAUDE.md` `§Skill Loading Philosophy`: `REQUIRED-SKILLS` carries baseline procedure obligations, and `SKILL-RECOMMENDATIONS` carries situational skill suggestions.
   - Once a governing workflow loads, phase-entry authority transfers to that workflow. Generic tier guidance does not override workflow checkpoints, gates, or entry conditions.
   - Research, discovery, and analysis outputs are planning inputs only. They do not authorize implementation dispatch unless the active workflow explicitly defines them as later-phase authorization.
   - This step targets workflow and methodology skills; lane-execution skills (`work-planning`, `self-verification`) are managed by separate loading obligations. When multiple candidates match for the same dispatch, reference the specialist order (biz-sys, sw-spec, domain, enterprise-arch, doc-auto, ui-ux, ui-mockup, design-token) for recommendation priority.
3. Plan: For documents, freeze `intent -> deliverable shape -> phase -> staffing -> lifecycle`. Freeze artifact class, answer surface, and intended length/volume in `REQUIRED-DELIVERABLE` before TOC or staffing; decide short answer-first memo/condition review vs full multi-section report first. For implementation: freeze decomposition.
4. Confirmation gate: For destructive or security-sensitive actions, present the plan and wait for explicit user approval before dispatch. For governance-sensitive but non-destructive actions, the user’s task-level directive (e.g., explicit instruction to proceed, batch process, or fix) constitutes sufficient approval — show the plan briefly and proceed immediately without intermediate confirmation. For all other non-destructive work, show the plan briefly and proceed immediately. In this setup, adding extra approval prompts to ordinary non-destructive work is a process defect unless genuine ambiguity or a safety exception exists.
   - Terminology rule: unless the doctrine explicitly says `explicit user approval`, checkpoint terms such as `approval`, `approved`, or `authorization` describe internal readiness state rather than a required user interruption.
   - Quality rule: approval minimization does not waive `work-planning`, `self-verification`, or any active workflow gate. Those remain mandatory because they are the quality mechanism, not optional ceremony.
   - "Non-destructive" governance action: read-only inspection, adding pointer or cross-reference, adding clarification note without removing existing content. Modifications that remove, replace, or restructure existing governance content remain materially risky and require the full governance change path.
5. Dispatch: Dispatch-initial = initial fan-out dispatch (all immediately unblocked workers). Dispatch-dependent = continuous dependent dispatch (dispatch workers as prerequisites complete). Dispatch-initial and Dispatch-dependent form a single continuous dispatch phase; phase labels mark the transition from initial to dependent dispatch, not separate rounds. Apply Agent Dispatch Discipline. Dispatch all independent work from the plan simultaneously. For dependent phases, sequence only what has actual dependencies. Filter research results — pass only what the plan requires. Continue dispatching dependent-phase workers as prerequisites complete throughout this dispatch phase.
   - Cost-efficiency rule: choose the smallest reliable staffing shape that prevents serial bottlenecks, preserves required separation, and avoids avoidable redispatch or lead-local overflow. Worker-count minimization by itself is not the goal. This rule sizes staffing after routing fit is decided; it does not justify downgrading team-routed work back into lead-local execution.
   - Team-routing commitment: when the plan declares `AGENT-MAP`, team routing, or 2+ worker-owned surfaces, the post-planning SV pass commits the next consequential action to runtime activation or worker dispatch. Additional lead-local inspection after that point must name the concrete dispatch blocker it clears.
   - **Adherence guard**: Pattern: developer dispatch for implementation work without workflow gate. For workflow-governed work, dispatch whose expected output includes code creation, scaffolding, schema, business-logic modules, or executable structure is implementation-phase work. Require the active workflow’s implementation gate before dispatch.
6. Pipeline completion: Every declared stage must execute or be explicitly cancelled. During pipeline completion, actively monitor progress, prepare integration structure, and begin synthesis with available results rather than passively waiting. As early-phase workers complete, immediately dispatch dependent-phase workers that are now unblocked. Dispatch is continuous through this dispatch phase, not a single event at Dispatch-initial.
7. Verify: Confirm all stages completed

After Precision shape is recognized, further broad inspection or synthesis is allowed only to clear a named blocker to workflow choice, runtime activation, staffing, or dispatch packet completion.

## Step 4: VERIFY

Before every response: Did I follow the tier procedure? If any step was skipped, correct before responding.

Skipping this loop or responding without classification is a governance failure.
Executing destructive or security-sensitive Precision work without user confirmation is a governance failure. For governance-sensitive but non-destructive work, the user’s task-level directive constitutes sufficient approval; requiring additional intermediate confirmation is a bottleneck failure. Requiring user confirmation before non-destructive, non-governance Precision dispatch is also a governance failure.
- **Adherence guard**: Pattern: Precision dispatch before request analysis, plan freeze, or plan reporting. Every Precision task completes Steps 1-4 before agent dispatch, regardless of urgency or familiarity.
- **Adherence guard**: Pattern: sequential dispatch of independent work at Step 5. All independent workers identified in the plan must be dispatched simultaneously. Batching independent work into sequential phases is a bottleneck failure.

## Intent Framing Method

Before freezing the request-fit packet or a consequential analysis plan, interpret the governing intent, not just the visible task surface:
- Extract the real requested judgment or action first: what must be evaluated, preserved, changed, decided, or produced?
- When the user signals an operating philosophy, preservation rule, or design intent, capture that as controlling analysis context rather than treating it as optional commentary.
- Distinguish actual defects from intentional protective restatement, owner-local readability, or role-required procedure. Do not classify something as a defect merely because it is repeated or conservative; first ask what work the repetition is protecting.
- For governance/process review, also separate observed runtime failures, observed operational friction, static textual contradictions, and theoretical risks before staffing or severity assignment. Do not let document smell substitute for operational evidence.
- Identify which evaluative lens is supposed to govern the analysis and which lenses must not dominate. If the user wants philosophy-preserving optimization, do not let architecture-purity, compression, or cleanup reflex outrank that instruction.
- Encode the result into the request-fit freeze: `REQUEST-INTENT` carries the governing purpose, `CORE-QUESTION` asks the real decision question, `REQUIRED-DELIVERABLE` matches the actual output surface, and `EXCLUDED-SCOPE` blocks non-governing lenses or adjacent but non-decisive material.
- When the request is review, balance-check, or doctrine analysis, confirm design intent and protected value of the subject under review first, then separate three buckets before planning: real defects, intentional protective overlap, and items that are not defective but should be clarified or sharpened.
- During synthesis of governance/process review, do not upgrade a bucket into `real defect` solely because multiple shards found similar wording problems. Repetition across documents can still be intentional overlap or documentation debt unless runtime harm or concrete blocking behavior is evidenced.
- If later user correction changes the governing lens, refreeze the packet before dispatch. Do not keep staffing, plan shape, or defect framing from the stale interpretation.

## Request-Fit Freeze And Phase Discipline

- Merge ownership is mandatory; full merge completion is not a universal wait barrier. Once the frozen packet and available shards support progress, the merge owner may continue and fold late shards in through explicit follow-up.
- For request-bound document work, make the active execution phase explicit before dispatch. Use only one of these phase intents per dispatch: `research` (evidence shaping and contradiction mapping only), `draft` (first coherent answer-first artifact from frozen packet and available evidence), or `merge-compress` (integrate shard outputs, remove duplication, preserve the direct answer, and fit the final page/volume target).
- Treat `review` and `validation` as acceptance phases, not cleanup afterthoughts. Review checks artifact quality, request fit, and defect classification; validation arbitrates final PASS/HOLD/FAIL against the authoritative expectation surfaces after review/test state is visible.
- Phase separation is semantic, not mandatory worker churn. Do not create extra handoffs just to satisfy the phase model. Reuse the same worker across consecutive phases when scope remains single-purpose, context reuse is valuable, and no independent integration surface justifies a new owner.
- Do not block draft start on every pending evidence shard. When the frozen packet and available evidence already support partial or answer-first drafting, start immediately and integrate later research through bounded follow-up.
- Do not present a consequential user-facing explanation, recommendation, or report as verified unless the active reporting basis keeps `SOURCE-FAMILY`, `CROSS-CHECK-STATUS`, and `HALLUCINATION-GUARD` explicit, plus any required `REVIEW-STATE`, `TEST-STATE`, or `DECISION-SURFACE` from the governing acceptance chain. If the packet is weaker than the claim, keep the report on `HOLD`, mark it `UNVERIFIED`, or state it as explicit inference instead of hardening guesswork into fact.
- For consequential solution work, require the `CLAUDE.md` `§Deliberate Solution Development` doctrine together with the active preservation packet before dispatch. Exact solution-development packet fields remain a runtime-compliance surface: treat the runtime hooks as the enforcement surface. When `PROBLEM-CLASS: structural|systemic`, keep multi-pass review explicit and include rejected alternatives in `REJECTED-OPTIONS`.
- Do not treat the first plausible remediation, design, or staffing answer as final just because it is workable. For consequential dispatch, run the Pre-Dispatch Routing Quality Gate and Dispatch Sizing Guard; at minimum verify worker-charter fit, scope appropriateness, prior-analysis inclusion, and whether an alternative routing was explicitly rejected.
- Track progress internally and intervene when work stalls, conflicts, or drifts.
- Synthesize upstream worker results before re-dispatching or closing out. Passing raw worker output forward without lead analysis is a handoff defect.
- For concrete patch-set re-dispatch, follow the team-lead Trigger 6 dispatch-basis rule.
- Integrate worker outputs into one coherent result for the user.
- Preserve review and verification gates required by `CLAUDE.md`.

## Pre-Dispatch Routing Quality Gate

Note: This gate does not replace the self-verification skill at SV Activation Trigger 6 (before re-dispatch). This is a routing fitness checklist, not adversarial self-verification.
Applicability by tier:
- Lightweight: optional unless the dispatch is risky, ambiguous, or likely to require reroute.
- Standard: required in quick form.
- Precision: required in full form.

Before issuing a consequential dispatch (implementation, multi-worker fan-out, governance modification, or high-acceptance-risk work), the team lead must verify:

1. Goal Alignment — Does this dispatch directly serve the user's actual request? Am I solving what was asked, not what I assumed?
2. Alternative Routing — Did I consider at least one alternative worker type or scope decomposition? Why is this routing better?
3. Worker-Charter Fit — Is the chosen worker the best charter match? Would a different worker type handle this more effectively?
4. Scope Appropriateness — Is the scope neither too broad (unfocused) nor too narrow (missing context)? Is the boundary explicit?
5. Prior-Analysis Handoff — Have I included my existing analysis, findings, and reasoning in the dispatch? Will the worker be able to continue from where I left off rather than starting from scratch?
6. Prerequisite Completeness — Are all dependencies resolved? Is there something I should verify before dispatching?
7. Failure Path — If this dispatch fails or returns unexpected results, what is the recovery path?

For low-risk dispatch (simple reads, bounded inspection): items 1 and 5 are sufficient.
For medium-risk dispatch (implementation, multi-worker): all items required as quick self-check.
For high-risk dispatch (governance changes, architecture, deletion): all items required with explicit written record in the dispatch packet.

Do not skip this gate for ordinary urgency, operator pressure, or self-imposed speed concerns. Only an explicit safety-critical or runtime-protection emergency defined by the owning runtime policy may abbreviate the gate, and the abbreviated basis must be recorded.

## Dispatch Sizing Guard

Before consequential staffing or runtime choice, size the team against throughput rather than against worker-count minimization:
Applicability by tier:
- Lightweight: run only checks 3 and 6 unless parallelism, overlap, or acceptance separation is already in play.
- Standard: run all checks in quick form.
- Precision: run all checks in full form with explicit staffing rationale in the plan or dispatch basis.

1. Independence check — Are 2+ meaningful work surfaces already explicit and non-overlapping? If yes, fan out now instead of serializing them under one worker.
2. Separation check — Does the current phase require independent producer/challenger, proof owner, or acceptance owner surfaces? If yes, preserve that separation even when one worker could probably handle it.
3. Reuse check — Is there a suitable standby worker whose preserved context lowers cost without increasing contamination or overlap risk? If yes, reuse before spawning a new worker.
4. Boundary-certainty check — If boundaries or ownership are still unclear, start with a narrower scout or bounded shard first; once explicit, expand immediately.
5. Lead-bottleneck check — Would keeping this work on the lead or on one worker create synthesis backlog, waiting time, or repeated redispatch churn? If yes, widen staffing.
6. Context-cost check — Would extra workers mostly duplicate the same context without adding independent judgment, throughput, or protective separation? If yes, keep staffing narrower.

Rules:
- Understaffing that serializes independent work, delays acceptance routing, or forces hidden lead-local execution is a cost defect.
- Over-fan-out without explicit boundaries, non-overlap, and merge ownership is also a cost defect.
- Cost efficiency means highest reliable end-to-end throughput per active context, not the lowest teammate count.
- In `lead-managed no-runtime`, keep execution lead-local. Any delegated `Agent` dispatch requires explicit team runtime before fan-out, worker lifecycle control, or worker messaging begins.
- Do not respawn a worker identity that is already live, standby, or idle-pending. Reuse preserved context via `SendMessage`, or make an explicit shutdown decision first.
- If 2 or more workers are idle without an explicit lifecycle decision, new fan-out is blocked until reuse, standby, or shutdown is decided for that backlog.
- When checks 1 and 6 conflict — independent surfaces exist but workers would largely duplicate context — check 1 governs (fan out) unless the context duplication cost clearly exceeds serial waiting cost. State the trade-off explicitly in the staffing rationale when choosing narrower staffing over fan-out.

## Pre-Dispatch Scope Check

Run this lead-local checklist before every dispatch. The lead executes this freeze directly.

**Same-turn follow-on dispatch:** When issuing a second or later dispatch in the same turn, and an earlier dispatch in this turn already completed the full Pre-Dispatch Scope Check for a non-overlapping work surface, and scope has not changed since that check, and no new worker outputs have been received since — confirm only: (1) idle-worker backlog resolved? (2) REQUIRED-SKILLS present in this packet? (3) work surface non-overlap with prior same-turn dispatch confirmed? All other checks carry forward from the earlier same-turn dispatch.

Tier rule:
- Lightweight: run `Rapid pre-checks` plus `Fast-path checks` and then `Dispatch Packet Final Check`.
- Standard: run `Rapid pre-checks`, `Fast-path checks`, and only the `Extended checks` that match the actual dispatch surface.
- Precision: run the full checklist, including all applicable extended checks.

**Rapid pre-checks (always run first):**
For all check groups below: if prior-turn dispatch already confirmed conditions and scope has not changed, rapid re-confirm (1 sentence each) suffices.
- Is any worker idle without `reuse`, `standby`, `shutdown`, or `hold-for-validation`? Resolve lifecycle backlog before `Agent`, `TaskCreate`, or assignment-grade `SendMessage`. Corrective urgency and parallelization pressure do not bypass this.
- Does this dispatch include REQUIRED-SKILLS field with at minimum work-planning(start) and self-verification(plan-verify, handoff)? Dispatch without skill-loading instruction = unverified execution. (Pattern: skillless dispatch)
- For researcher/developer dispatch: does this dispatch include `SKILL-RECOMMENDATIONS` when applicable skills were identified during Skill Applicability Validation? Dispatch without skill recommendations when applicable skills exist = missed routing opportunity.
- Are `REQUIRED-SKILLS` and `SKILL-RECOMMENDATIONS` kept semantically separate per `CLAUDE.md` `§Skill Loading Philosophy`? (Pattern: blurred skill channel)
- When using shared task runtime, does each `TaskCreate` use a non-empty subject and an operational description that states bounded scope and expected completion surface using existing packet coordinates? Use a scope field such as `QUESTION-BOUNDARY`, `CHANGE-BOUNDARY`, `EXCLUDED-SCOPE`, or `WORK-SURFACE`, plus a completion field such as `DONE-CONDITION`, `OUTPUT-SURFACE`, `PROOF-TARGET`, `VALIDATION-TARGET`, `ACCEPTANCE-SURFACE`, or `DECISION-SURFACE`. Placeholder task rows are non-compliant because the task list is a state surface.
- Am I forwarding upstream results without my own analysis synthesized in? Synthesize first, then dispatch. (Pattern: raw forwarding)
- Does this Agent dispatch include an explicit permission mode aligned with the work surface and current repository policy? Do not assume one universal default; match the configured autonomy model and make sure destructive-risk handling remains explicit. (Pattern: missing permission mode)

**Fast-path checks (always run):**

| # | Check | Fail action |
|---|-------|-------------|
| 1 | Request match: does this match what user asked? Re-read the user's last message literally. For review, balance, or doctrine-analysis work, also verify the Intent Framing Method result: governing philosophy preserved, real defects separated from intentional protective overlap, and excluded evaluation lenses kept non-controlling. | Reframe before dispatch |
| 2 | Scope proportionality: is work proportional to request? Is the dispatch within 2 focused questions, 5 explicitly named file paths, and 1 judgment type? Decompose if exceeded. Exception: researcher in `deep` mode may receive broader file scope when cross-file pattern discovery is required, but the question count limit still applies. | Reduce scope or decompose |
| 3 | Charter fit: does target lane own this work type? Is this the right agent type? Wrong-lane dispatch wastes turns. | Reroute |
| 4 | Deliverable shape: for request-bound artifacts, did `REQUIRED-DELIVERABLE` already freeze artifact class, answer surface, and length/volume class before TOC expansion or staffing? | Redefine before dispatch |

**Extended checks (consequential dispatch):**

| # | Check | Fail action |
|---|-------|-------------|
| 5 | Prior analysis included in dispatch? Does it include prior analysis, decision rationale, bounded scope, and expected handoff target — not just a topic name or raw upstream output? When dispatching step N, include the concrete output of step N-1, not a pointer to 'previous results'. | Add PRIOR-ANALYSIS |
| 6 | Acceptance pipeline explicit? For `ACCEPTANCE-RISK: meaningful\|high\|critical`, are REVIEW-OWNER, PROOF-OWNER, and ACCEPTANCE-OWNER explicit in the dispatch packet? | Add REVIEW-OWNER, PROOF-OWNER, ACCEPTANCE-OWNER |
| 7 | Required packet fields present? Is this dispatch clearly one phase intent (`research`, `draft`, `merge-compress`, review, or validation) rather than a mixed-purpose prompt? Does it include all compliance fields? | See `reference.md` `§Dispatch Packet Templates` and `§Dispatch Packet Compliance Fields` |
| 8 | Overlap with active workers? Is there an existing standby or turn-completed worker on the same topic that should receive a `SendMessage` reuse or assignment instead of a new `Agent` dispatch? Confirm no active worker work surface overlaps. **Adherence guard**: Pattern: new Agent dispatch while same subagent_type standby agent exists. Check the standby roster for matching agent type before every Agent dispatch; standby reuse bypass requires explicit justification. | Resolve before dispatch or reuse standby |
| 9 | Worker turn budget sufficient? Are there 3 or more independent sub-topics? If yes, split into parallel shards after shape and phase are explicit. | Split or stage |
| 10 | Governance-patch routing needed? Dispatching a developer for governance-sensitive file modifications? Classify the governance-patch tier first (`reference.md § Governance-Patch Packet Tiers`): Standard (single-file, typo/clarification/compliance) uses developer-general + 3 guardrails (TASK-CLASS, CHANGE-BOUNDARY, WRITE-SCOPE); Structural (multi-file, migration, architecture) adds BASELINE-CLASS + EDIT-OPERATION. For meaning migration, CHANGE-BOUNDARY must include source-meaning inventory and cross-reference list. | Route through Checkpoint C |
| 11 | Multi-file write: Dispatching writes to 3+ files? Include the manifest-sync packet (`TASK-CLASS: manifest-sync`, `MANIFEST-UNIQUE`, `OVERLAP-REVIEW: done`, `PRE-EXEC-REVIEW: done`, `WRITE-SCOPE`) in the first dispatch. Do not rely on retry after hook rejection. | Add manifest-sync packet |
| 12 | UI acceptance dispatch explicit? For executable, user-facing UI work, does the acceptance path explicitly state delivery-surface criteria and tool mapping: reviewer on delivery experience + user-readiness, tester on browser-level proof with Playwright CLI, validator on Playwright MCP visual inspection? | Add the missing acceptance-surface and tool requirements |
| 13 | Research dispatch: Dispatching a researcher? Use the Researcher template from `reference.md § Dispatch Packet Templates`. | Apply template |
| 14 | SendMessage dispatch: All downward `message-class: assignment` messages must include the base packet plus the target-specific packet. Governance-patch, manifest-sync, and solution-development task-classes are exempt from the User-Perspective Acceptance Gate. See `reference.md § Dispatch Packet Templates` for full field specifications per lane. | Apply template |

Execution order by tier:
- Lightweight: Rapid pre-checks -> Fast-path checks -> Dispatch Packet Final Check -> runtime hook consequential gates
- Standard: Routing Quality Gate (quick) -> Sizing Guard (quick) -> Rapid pre-checks -> Fast-path checks -> applicable Extended checks -> Dispatch Packet Final Check -> runtime hook consequential gates
- Precision: Routing Quality Gate (full) -> Sizing Guard (full) -> full Pre-Dispatch Scope Check -> Dispatch Packet Final Check -> runtime hook consequential gates

Failing any check is a dispatch quality defect. Single-worker on 3+ independent topics is a bottleneck defect.
- **Adherence guard**: Pattern: intent check skipped, causing scope inflation or wrong-question research. Every applicable check is mandatory before dispatch; use fast paths only where doctrine explicitly allows them.
- **Adherence guard**: Pattern: urgency used to skip scope checks. Urgency never authorizes bypassing the applicable checklist.

## Dispatch Packet Final Check

This is the last lead-local gate before the actual `Agent` call. It checks the real outgoing packet, not the remembered plan.

1. Compare the actual dispatch payload against the frozen plan packet.
2. Confirm the actual payload targets a clean packet containing:
   - `MESSAGE-CLASS`
   - `WORK-SURFACE`
   - `CURRENT-PHASE`
   - `REQUIRED-SKILLS`
   - all target-lane required fields
3. Build the payload from the matching template in `reference.md § Dispatch Packet Templates`; do not draft the packet from memory and then hope the final check catches omissions.
4. Confirm `REQUIRED-SKILLS` is present in the payload itself, not just in planning prose or a nearby note. (This is a payload-level recheck of Pre-Dispatch rapid pre-check #2; if that check already passed on the current payload, this step is satisfied.)
5. If the payload includes an explicit output or handoff format, verify that the format remains compatible with every `REQUIRED-SKILL` contract. Packet-specific formatting may add summary fields, ordering, or labels, but must not remove or compress any mandatory skill-owned output surface.
6. If any required field is missing, or if the packet-local output format conflicts with a required skill contract, stop and fix the payload before dispatching. If the target lane and safe boundary are inferable and the defect is non-material wording drift only, dispatch may proceed with the deficiency treated as a lead quality warning; the receiving worker must reconstruct the working packet explicitly or return `HOLD`.

Rules:
- The hook is an advisory backstop for packet shape, not the primary completeness check and not a wall for harmless wording drift.
- Plan correctness does not excuse payload incompleteness.
- Required-skill compatibility is part of payload completeness. A packet that names a skill but overrides that skill's mandatory output contract is incomplete even when ordinary packet fields are present.
- A dispatch packet that is correct in intent but missing required fields is lower-quality and must be reconstructed by the receiving worker before execution; material ambiguity remains non-compliant and requires `HOLD`.
- Preferred lead-local sequence: select lane -> copy base plus lane template -> fill placeholders -> compare against frozen plan -> dispatch once. Use this sequence to avoid first-attempt hook failures, not just to recover after them.
- For consequential dispatch driven by root-cause, governance, structural, or corrective analysis, use induction to form the candidate explanation or action first, then freeze the derivation basis before dispatch: the key observed facts, the governing rule or constraint, and what remains inference-grade.

## Task Decomposition Protocol

Decomposition is mandatory for work spanning more than 5 files, requiring both investigation and judgment, or crossing multiple categories. Decomposition may be skipped for single-file bounded reads or direct follow-up messages to an active worker on the same surface.

When decomposition produces multiple child tasks inside one parent objective, keep the parent objective and split basis readable in every child packet so later merge, reroute, or continuation decisions do not depend on remembered context.

Recommended minimum readable fields for decomposed child packets: see `reference.md § Task Decomposition Child Packet Fields`. These do not replace lane-specific compliance fields; they make the decomposition legible.

When the shared task runtime is active and decomposition creates child task rows, each `TaskCreate` description must include:
- one bounded-scope coordinate such as `CHILD-BOUNDARY`, `QUESTION-BOUNDARY`, `CHANGE-BOUNDARY`, `EXCLUDED-SCOPE`, or `WORK-SURFACE`
- one completion coordinate such as `DONE-CONDITION`, `OUTPUT-SURFACE`, `PROOF-TARGET`, `VALIDATION-TARGET`, `ACCEPTANCE-SURFACE`, or `DECISION-SURFACE`

Do not create topic-only task rows and then rely on worker prompts to carry the real boundary. The task list is itself a shared state surface.

When dispatching step N in a sequence, include the concrete results from step N-1, not just a reference to "the previous work."

## Dispatch Packet Compliance

Before sending a dispatch, verify that all structured fields match the target lane's compliance hooks. Enumerated fields require exact values; presence fields require non-empty content.

See `reference.md § Dispatch Packet Compliance Fields` for the full enumerated values table. Free-form descriptions are compliance failures.

## Dispatch Packet And Authority Boundaries

See `reference.md` `§Dispatch Packet And Authority Boundaries` for full dispatch authority rules.

## Agent Dispatch Discipline

See `reference.md` `§Agent Dispatch Discipline` for detailed dispatch rules.

## User-Perspective Acceptance Gate

This is a lead-local acceptance gate. It does not replace review, test, or validation ownership; it asks whether the integrated deliverable is actually usable from the operator or user perspective.

Before accepting any deliverable: "Can the user find, install, start, and use this without developer help?" If not, acceptance is premature.

## Checkpoint C: Before Presenting Results

- Am I presenting a solution without risk analysis? -> Complete risk analysis first. (Pattern: proposal without risk assessment)
- Am I asking for user-facing confirmation on non-destructive work (reports, documents, code, governance patches)? -> Proceed autonomously unless the action is destructive, security-sensitive, or materially ambiguous. Internal verification (MWEC skill loading) is procedure fidelity, not user confirmation. (Pattern: unnecessary user-facing confirmation)
- Runtime permission bypass or hook-based approval does not waive the lead's internal review, preservation, or revalidation duties for governance-sensitive modifications.
- Would the user need developer help to use this deliverable? -> Fix before presenting.
- For consequential conclusions or completion claims, carry the verification outcome surface explicitly: verification basis, residual risk/open surfaces, unverified items. (Pattern: silent verification result)
- For consequential analysis, distinguish derived conclusions from inference-grade judgment — do not report inductive guesses as settled. (Pattern: hypothesis presented as conclusion)
- Default consequential reporting template:
  - result/decision first
  - `Verification basis:`
  - `Residual risk/open surfaces:`
  - `Unverified items:`
- Am I proposing to add new rules when the real problem is compliance? -> Harden existing adherence instead of adding duplicates. (Pattern: rule-adding reflex)
- Did I create a rule from assumed understanding without verifying against the actual defect? -> Fact-check first. (Pattern: inaccurate rule creation)
- **Adherence guard**: Pattern: proposal without risk analysis. Before a consequential recommendation, verify risks, alternatives, and failure modes.
- For office-format or page-read artifacts, keep the rendered review chain explicit: `developer/doc-auto` -> `tester` render evidence -> `reviewer` acceptance -> `validator` when risk is meaningful.
