---
name: work-planning
description: Universal work planning procedure for all agents.
user-invocable: false
PRIMARY-OWNER: team-lead
---

## Structural Contract
- Fixed section order: Purpose, Activation Trigger, Step 1: Instruction Confirmation And Work Analysis, Step 2: Scope Freeze, Step 3: Approach Planning, Step 4: Verification Criteria, Step 5: Risk Identification, Planning Output Format, Post-Planning Gate
- PRIMARY-OWNER: team-lead
- Structural changes require governance review.

## Purpose

Use this skill to freeze scope before consequential work begins. The output is an internal execution plan grounded in verified scope, user instructions, and `CLAUDE.md §Team Philosophy` — not assumption.

Quick contract:
- load at work start
- ground plan in `CLAUDE.md §Team Philosophy` and user instructions
- freeze scope before consequential tool use
- define approach, verification, and hold conditions
- freeze the next consequential action when routing implies explicit runtime or worker dispatch
- produce the internal plan block
- then load `self-verification` before execution

Output channel: Steps 1-5 are internal reasoning that produces the frozen scope. The user sees the results of work done from this plan, never the planning procedure itself. If a progress update is needed before execution, keep it to one or two sentences covering only current decision, next action, or blocker — never the full plan block or packet fields.

Boundary:
- this skill governs agent-local execution planning
- dispatch governance, staffing, and workflow selection belong to `task-execution`
- `session-boot` still comes first for the main session when boot is required
- for workflow-governed `team-lead` work, this skill is only a local scope scaffold, not phase authority
- for `team-lead`, this skill must leave the next owner unambiguous enough that Standard/Precision work reaches `task-execution` without silent lead-local compression
- when the task evaluates an existing rule, mechanism, workflow, architecture, or policy, this skill must freeze both the suspected issue and the rationale of the current state under review before defect or optimization conclusions are attempted

## Activation Trigger

Load this skill via the Skill tool and execute the full procedure at work start. Exception: in the main session, complete `session-boot` first when boot is still pending.

1. At task start: when a new assignment or dispatch is received.
2. At reuse/reroute: when a standby worker receives a new assignment via SendMessage.
3. At scope change: when governing lane changes scope, approach, or output target mid-task.

Before the first consequential tool call on any new assignment, reuse, or reroute: confirm work-planning is loaded and scope is frozen.

## Step 1: Instruction Confirmation And Work Analysis

- Read the user's request.
- Read the dispatch or assignment instructions.
- Cross-check scope, purpose, and output target.
- Analyze the work through the following thinking flow before scope freeze:
  · **Q1 (Purpose)**: What is the user trying to achieve? Extract the real goal, not just the surface task.
  · **Q2 (Work Types)**: What types of work does this purpose require? (e.g., software development, document creation, research/analysis, design, engineering calculation)
  · **Q3 (Channels)**: For each work type, identify the governing workflow or methodology skill. Use the Deliverable-Type reference in `task-execution/reference.md` as a guide. If the match is unclear, ask the user before proceeding.
  · **Q4 (Relationships)**: If multiple work types exist, map their relationships: independent, sequential, or interdependent.
  · **Q5 (Supporting Skills)**: Within each stream, identify methodology or domain skills that support the work.
- Q3 results become the `ACTIVE-WORKFLOW` field in the planning output. Q5 results feed `SKILL-RECOMMENDATIONS` at dispatch time.
- If Q1 cannot determine the purpose, HOLD and ask the user for clarification.
- If Q3 cannot confidently match a workflow, ask the user rather than guessing.
- Identify which `CLAUDE.md §Team Philosophy` coordinates apply to this work — these become non-negotiable constraints on the resulting plan.
- If user intent and dispatch conflict, HOLD or escalate before proceeding.

## Step 2: Scope Freeze

Define and record before any tool calls:

- `WORK-INTENT`: one sentence — what this work achieves.
- `EXPECTED-OUTPUT`: what artifact, result, or state will be produced.
- `EXCLUDED-SCOPE`: what is explicitly not part of this work.
- `DONE-CONDITION`: the specific observable state that marks completion.
- When the work involves evaluating, reviewing, analyzing, or judging an existing rule, mechanism, structure, process, or policy, follow this dependency chain before choosing the analytical approach. Each step takes the previous step's output as required input; skipping ahead produces UNVERIFIED conclusions:
  1. **Understand** — read the owner surface and describe what this does and why it was built this way.
     Output: `CURRENT-STATE-RATIONALE`
  2. **Identify protection** — based on the rationale from step 1, name what failure, degradation, or ambiguity this prevents.
     Output: `PROTECTED-VALUE` · Requires: step 1
  3. **Classify cost** — based on the protected value from step 2, classify any observed friction, delay, or burden as (a) observed or merely inferred AND (b) protective cost (expected price of the stated protected value) or unnecessary overhead.
     Output: `CURRENT-COST` · Requires: step 2
  4. **Judge proportionality** — based on the protected value (step 2) and cost classification (step 3), judge whether the current protection level is proportionate, excessive, stale, or unclear.
     Output: `RATIONALE-JUSTIFICATION` · Requires: steps 2–3
  5. **Assess change risk** — based on all above, describe what protection or value would be lost if simplified, merged, removed, or replaced.
     Output: `CHANGE-RISK` · Requires: steps 1–4
  - Classification entry condition: FIX/IMPROVE/ACCEPT or equivalent action classification may begin only after steps 1–5 are complete. An incomplete chain produces UNVERIFIED classifications.
- If the scope includes quantitative targets (reduction percentages, line counts, timelines), those targets must be derived from prior review of the actual target surface. HOLD if review has not been performed.
- Verify the frozen scope and intended approach do not conflict with the `CLAUDE.md §Team Philosophy` coordinates identified in Step 1. If a conflict exists, revise the scope before proceeding.

If scope cannot be frozen without assumptions, HOLD with the exact ambiguity. If dispatched, escalate through the governing lane. If this is the first response to a user request, surface the ambiguity before proceeding.

## Step 3: Approach Planning

Break the work into executable steps before acting:

1. List steps grouped by dependency level: independent steps first, then steps that depend on earlier results.
2. Identify which steps require investigation before execution (uncertain path) vs. direct execution (confirmed path).
3. Flag highest-risk steps — steps with irreversible effects, wide blast radius, or low confidence.
4. For multi-file or multi-concern work: confirm whether steps are parallelizable or must be sequential.
5. Size each step: if a step exceeds one clear purpose, decompose further.
6. Treat methodology skills as approach refinement, not scope authority. If a methodology requirement would change `WORK-INTENT`, `EXPECTED-OUTPUT`, or `EXCLUDED-SCOPE`, re-run Step 2 before continuing. If Step 2 re-freezes and the methodology conflict recurs after one cycle, HOLD with the exact conflict rather than looping further.
7. For each planned step, confirm it derives from a specific user instruction or stated requirement. Steps based solely on agent inference must be labeled as inference and explicitly justified.
8. Before finalizing the step list, challenge it critically: what is missing? what assumptions does this plan make? what would a critical reviewer identify as insufficient or ungrounded?
9. When evaluating an existing state under review, verify the approach includes the Step 2 dependency chain (understand → identify protection → classify cost → judge proportionality → assess change risk) before any action classification.

Team-lead routing pre-signal:

- Before finalizing the step list, classify the current work shape as one of: `lead-local candidate`, `team-routing candidate`, or `ambiguous-route`.
- Use `team-routing candidate` when any of the following is already visible from the request or bounded inspection: 2 or more independent work surfaces, multiple files or governance surfaces, multiple meaningful hypotheses, explicit role separation need, external/user-facing deliverable risk, or likely synthesis bottleneck if one lead handles all phases.
- Use `ambiguous-route` when the work might still be lead-local but the current evidence does not cleanly satisfy all direct-work conditions from `agents/team-lead.md §RPA-2`.
- For `team-routing candidate` or `ambiguous-route`, the next consequential skill after post-planning `self-verification` is `task-execution` unless a bounded blocker is explicit; do not let a large or multi-concern request remain implicitly single-worker just because the current plan block omitted staffing details.
- If the plan already implies delegation, explicit runtime, or worker-owned surfaces, record that implication now instead of leaving it to later interpretation.
- Positive channel rule: when the plan implies team routing, freeze one explicit `NEXT-CONSEQUENTIAL-ACTION` now. Allowed values are `TeamCreate`, `reuse-via-SendMessage`, `Agent`, or `clear-blocker:<exact blocker>`. Do not leave the runtime move as a vague future intention.
- If `NEXT-CONSEQUENTIAL-ACTION` is `clear-blocker:<...>`, the blocker must be concrete, bounded, and immediately relevant to runtime activation, worker reuse, or dispatch packet completion. Broad additional inspection is not a valid blocker.

## Step 4: Verification Criteria

Before beginning execution, define:

- **Self-check items**: what confirms correctness at each step?
- **Handoff evidence**: what concrete evidence will be carried upward?
- **Quality criteria**: what makes the output acceptable from the user's perspective and consistent with the applicable `CLAUDE.md §Team Philosophy` coordinates?
- When evaluating an existing state under review, verification criteria must separately answer:
  - was the current-state rationale actually confirmed from owner surfaces?
  - is that rationale still justified and proportionate under current operating conditions?
  - is the reported issue an observed break, observed cost/friction, static contradiction, or theoretical risk?
  - if a change is proposed, what protection or value remains preserved?

## Step 5: Risk Identification

- Name potential failure points and their likely impact.
- Define HOLD conditions: what findings require stopping and escalating rather than continuing?
- Identify blockers that must be escalated immediately (scope conflict, missing prerequisite, environmental gap, safety risk).
- Define a fallback path if the primary approach is blocked.
- If planning itself reveals the work is infeasible or exceeds charter scope, return HOLD with the blocking discovery rather than producing an unreliable plan.
- Before completing the plan, verify it against three core criteria: (1) does every step trace to a user instruction or stated requirement? (2) does the plan comply with all applicable `CLAUDE.md §Team Philosophy` coordinates? (3) viewed critically, what gaps or weak points remain that must be explicitly acknowledged?
- For `team-lead`, also verify: if this plan would be unsafe, misleading, or bottleneck-prone when executed by one lead pass, mark it as a routing issue now rather than hiding the problem inside `HIGHEST-RISK`.
- For governance analysis, apply `[GOV-MIN]` and `[PLAN-SV]` as interpretation lenses before classifying anything as a defect.
- When evaluating an existing state under review, do not let "currently exists for a reason" collapse into "therefore patch unnecessary." Record both the protected value and the observed or inferred cost so later verification can judge proportionality instead of defaulting to preservation.

## Internal Planning Record

After completing Steps 1–5, freeze the internal plan block in agent-local reasoning before the first execution tool call that follows this skill load. This record is for internal scope control and downstream proof surfaces only. Do not emit it through commentary, progress updates, or any user-facing channel.

```
WORK-INTENT: <one sentence>
EXPECTED-OUTPUT: <artifact or state>
EXCLUDED-SCOPE: <what is out>
DONE-CONDITION: <observable completion signal>
ACTIVE-WORKFLOW: <workflow-id(s)|none|pending-user-clarification>
PHILOSOPHY-CONSTRAINTS: <applicable §Team Philosophy coordinate IDs>
ROUTING-SIGNAL: <lead-local candidate | team-routing candidate | ambiguous-route>
STEPS: <numbered list>
PARALLEL-GROUPS: which steps run concurrently
AGENT-MAP: agent to phase assignment (Required for team-lead plans with delegation. Optional for workers dispatching sub-tasks. May be omitted for single-worker plans with no downstream delegation.)
NEXT-SKILL: <self-verification | task-execution after self-verification | other bounded owner-directed next step>
NEXT-CONSEQUENTIAL-ACTION: <lead-local-none | TeamCreate | reuse-via-SendMessage | Agent | clear-blocker:<exact blocker>>
DISPATCH-BLOCKERS: <none or the concrete blocker that prevents immediate TeamCreate/dispatch once routing is confirmed>
CURRENT-STATE-RATIONALE: <required when evaluating an existing state under review; otherwise n/a>
PROTECTED-VALUE: <required when evaluating an existing state under review; otherwise n/a>
RATIONALE-JUSTIFICATION: <required when evaluating an existing state under review; otherwise n/a>
CURRENT-COST: <required when evaluating an existing state under review; otherwise n/a>
CHANGE-RISK: <required when evaluating an existing state under review; otherwise n/a>
HIGHEST-RISK: <step or condition>
HOLD-CONDITIONS: <escalation triggers>
VERIFICATION: <self-check and handoff evidence>
```

This block governs agent-local execution only; it is not user-facing. The upward proof surface is `PLANNING-BASIS`, not the full plan block.

## Progress Update Surface

When a progress update is actually needed before execution or dispatch:

- Use plain prose only.
- Keep it to one or two sentences.
- Allowed content: current decision, next action, or blocker.
- Forbidden content: field labels, packet schemas, numbered plan blocks, `WORK-INTENT`/`EXPECTED-OUTPUT`/`AGENT-MAP` echoes, or any field-by-field restatement of the internal planning record.

Good:
- `범위를 확정했고, 다음 consequential action은 TeamCreate입니다.`
- `범위를 확정했고, 다음은 self-verification 후 기존 researcher 재사용 여부를 확인합니다.`
- `패치 범위를 좁혔고, 다음은 reviewer 검증입니다.`

Bad:
- `WORK-INTENT: ...`
- `EXPECTED-OUTPUT: ...`
- `AGENT-MAP: ...`
- full or partial reproduction of the internal planning record

Planning record rules:

- `ROUTING-SIGNAL` is mandatory for `team-lead`. Workers may omit it unless the parent packet explicitly asks for routing input.
- If `ROUTING-SIGNAL` is `team-routing candidate`, `AGENT-MAP` must be present or `DISPATCH-BLOCKERS` must name the exact reason it is not yet present.
- If `ROUTING-SIGNAL` is `team-routing candidate` or `ambiguous-route`, `NEXT-CONSEQUENTIAL-ACTION` is mandatory.
- If `ROUTING-SIGNAL` is `team-routing candidate` and `DISPATCH-BLOCKERS` is `none`, `NEXT-CONSEQUENTIAL-ACTION` must be `TeamCreate`, `reuse-via-SendMessage`, or `Agent` — not `lead-local-none`.
- Do not use `NEXT-CONSEQUENTIAL-ACTION: clear-blocker:<...>` as a parking spot for broad lead-local analysis. The blocker must be narrow enough that clearing it immediately returns the path to runtime activation or dispatch.
- If `ROUTING-SIGNAL` is `ambiguous-route`, default `NEXT-SKILL` to `task-execution after self-verification` unless a concrete, bounded reason keeps the work lead-local.
- Do not use an empty or omitted `AGENT-MAP` to silently downgrade obviously multi-surface work into single-worker execution.


## Post-Planning Gate

After completing the planning output, load `self-verification` before execution. This gate requires a fresh Skill tool invocation in the current turn — prior-turn context presence does not satisfy it (`CLAUDE.md` `§Skill Loading Philosophy`).

For `team-lead`:

- If the plan block shows `team-routing candidate`, `ambiguous-route`, `AGENT-MAP`, or non-trivial `DISPATCH-BLOCKERS`, treat that as an explicit handoff basis into `task-execution`; do not continue broad lead-local inspection unless the blocker is named and being cleared.
- If the plan block shows `team-routing candidate` or `ambiguous-route`, verify that `NEXT-CONSEQUENTIAL-ACTION` names the exact runtime move or the exact blocker-clear move. A missing or vague next action is a planning defect.
- If the request is clearly Standard/Precision-shaped but the plan block still looks like a single-worker lightweight plan, treat that as a planning defect and correct the plan before proceeding.
