---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# task-execution: Lane-Specific Additions
## Common Lane-Core Preconditions
Every agent-specific skill inherits these common preconditions:
- Consume the common base packet from `.claude/skills/task-execution/references/assignment-packet.md`.
- Lane-local result checking before completion is `Skill(self-verification)` convergence.
- Classify receipt against the common start closure contract from `.claude/skills/task-execution/references/request-bound-fields.md`.
- Receive the agent-facing packet; the full internal planning record stays with `team-lead`.
- Treat the team-lead assignment as a packetized execution path for the current user's stated instruction intent under `.claude/CLAUDE.md` philosophy chain 1-8, mapped core laws, and active owner procedures; team-lead wording does not create independent authority to bypass user intent, upper philosophy, owner boundaries, required skills, evidence, verification, validation, reporting prohibition, or completion truth.
- Before first lane work, reconcile the carried `SEMANTIC-INTENT-BASIS`, `TARGET-INTENT-BASIS`, `WORK-SURFACE`, assigned action, and team-lead instruction wording against the upper-philosophy-governed user instruction intent.
- If that reconciliation exposes stale intent, missing intent basis, governance-bypass wording, or mismatch between the packetized route and upper-philosophy-governed instruction intent, send `scope-pressure` or `hold|blocker` with the exact mismatch basis and smallest correcting owner; do not execute by local interpretation, team-lead wording alone, or inferred intent.
- Fresh assignment-grade receipt has a mandatory upward outcome: `completion` when packet review plus bounded lane work completes in the same execution block, otherwise `dispatch-ack`, `scope-pressure`, or `hold|blocker` before long-running lane work.
- `dispatch-ack` is the lane-to-team-lead state signal declaring no-objection acceptance; after sending it, the lane starts the assigned work without waiting for another prompt.
- Before first lane work, compare `WORK-SURFACE`, `CLAIM-CEILING`, and assigned action against carried `SCOPE-BASELINE`, `ACTIVE-SLICE`, and `DEFERRED-SURFACES` when those fields are material.
- If a packet omits material scope rows needed for the assigned claim, send `scope-pressure` or `hold|blocker` instead of narrowing scope locally.
- Full-scope completion, validation, promotion, rejection, and patch-selection claims require explicit full-scope basis; wave, sample, priority-tier, or representative-slice wording records `ACTIVE-SLICE` only.
- Upward outcome envelope shape governed by `.claude/skills/task-execution/references/message-classes.md` `### Transport Payload`.
- Lane upward `SendMessage` sets top-level `to: team-lead`.
- Tool envelope satisfaction requires top-level `SendMessage.to`; recipient wording in visible text, `summary`, `message`, or packet fields remains payload text.
- Missing `SendMessage.to` opens envelope-defect packet correction.
- Receipt/start gates verify `dispatch-ack` envelope and packet truth per `.claude/skills/task-execution/references/message-classes.md` when `dispatch-ack` is used.
- `Skill(self-verification)` applies to produced-result and completion surfaces, not receipt/start gates.
- Truthful-start failure sends `scope-pressure` or `hold|blocker` instead of `dispatch-ack` only after intake-stage evidence-backed defaults, lawful reconstruction, and narrow packet-correction routes cannot start the assigned work safely.
- A hook block that enforces positive-pattern, doctrine-shape, or compliance-field presence outside destructive, security-critical, or session-stability-breaking runtime protection per `.claude/reference/work-runtime-boundary-law.md` `## Runtime Boundary Rules` is an over-broad-blocking defect per `.claude/CLAUDE.md` `## 3. Work Execution Philosophy`; the lane sends `scope-pressure` to team-lead naming the hook surface and the exact block message while preserving compliance truth.
- Converged lane work must hand off to `team-lead` through `.claude/skills/task-execution/references/completion-handoff.md`.
- The handoff requires both the retained carrier containing the common completion spine and `MESSAGE-CLASS: completion` sent to `team-lead` through `SendMessage`.
- Required completion handoff uses both retained carrier and `MESSAGE-CLASS: completion`; disk output, pane/final prose, `status`, and `TaskUpdate` remain supporting signals.
- Completion-grade `completion` envelope shape governed by `.claude/skills/task-execution/references/message-classes.md` `### Transport Payload`.
- Immediately apply the same assigned-task `TaskUpdate` closure required by `.claude/skills/task-execution/references/message-classes.md` `### Assignment Delivery Contract` when task tracking is active after `completion`.
- That `TaskUpdate` marks lane handoff closure only; retained-carrier acceptance, synthesis, final verification, and user-facing report admission stay with team-lead and reporting law.
- After `completion`, exact same `TASK-ID` replay with no new defect, carrier, correction, or blocker basis is closed-work replay and the lane sends no further message for that duplicate work.
- Missing or malformed completion carrier, completion-transport defect, or new bounded correction evidence opens distinct bounded `assignment`, `reuse`, `reroute`, or blocker handling instead of silent replay closure.
- This lane-baseline duty executes without packet wording.
- For lane work that touches governance assets (`.claude/` doctrine, agents, skills, settings, hooks, or live-surface mirrors), the lane-side quality contract is the trio plus the operator-emphasized keyword gate.
- Lane governance mutation consumes an active parent `Skill(governance-modification)` boundary, packet-carried `PRE-MUTATION-BASIS`, and completed Patch-Ready Gate basis before `Edit`/`MultiEdit`/`Write`/`Bash` mutation.
- Missing boundary, basis, or gate sends `scope-pressure` or `hold|blocker` instead of local reconstruction or mutation.
- Trio member 1: `Skill(governance-modification)` patch mechanics.
- Trio member 2: lane-local `Skill(self-verification)` produced result truth.
- Trio member 3: consume the assigned `Skill(review-verification)` named lens or lenses on the proposed patch before mutation.
- Governance asset work that needs patch-worthiness synthesis, all mutation-readiness fields, three or more lenses, or top-doctrine/core-law execution-meaning judgment routes full workflow activation to `team-lead` before mutation.
- Before proposing a lower-surface governance patch, the lane applies `.claude/reference/work-execution-core-law.md` governance hierarchy order for the changed meaning.
- Missing top/core coverage routes to the mapped owner or `scope-pressure`.
- The pre-mutation `Skill(review-verification)` gate requires pre-mutation review; post-execute lane-local `Skill(self-verification)` may recheck only the applied diff.
- Operator-emphasized keyword gate applies per `.claude/CLAUDE.md` `## 5. Modification Philosophy`.
- Operator-emphasized keyword gate covers under-specification, over-specification, evasion, ambiguity, semantic conflict, bottleneck burden, and over-broad-blocking.
- A candidate patch that fails any keyword check routes to revise, re-home, delete, or blocker-routing with exhausted internal correction basis before mutation.
- Lane direct-execution drive (`Edit`/`MultiEdit`/`Write`/`Bash`/`SendMessage`) remains active between consecutive bounded lane actions inside the assigned packet boundary per `.claude/reference/work-execution-core-law.md` `[AUTO-PROC]`.
- Lane continues to the next executable lane action in the same turn until completion, blocker, or scope-pressure.
- Governance asset change quality requires lane-local `Skill(self-verification)` plus `Skill(review-verification)` named-lens consumption; bare lane-local `Skill(self-verification)` routes lane completion to quality-contract correction and lane lens supplementation.
- When the assignment packet's completion contract or upward-message instructions direct the lane to place retained-output paths, retained-output contents, INSPECTION-COVERAGE, OPEN-SURFACES, file or findings counts, excerpts, summaries, operational notes, or any field other than the canonical state signal in the upward `SendMessage` render, the lane normalizes to the canonical envelope and carries receiver-required detail in the retained carrier when payload fidelity, write scope, and route truth are preserved; the retained carrier records `PACKET-DEFECT: malformed-completion-contract` with the malformed instruction and normalization basis.
- Send `scope-pressure` with `PRESSURE-TYPE: malformed-completion-contract` and `CORRECTION-OUTCOME: packet-correction` when the malformed render instruction cannot be normalized without losing payload fidelity, exceeding write scope, or changing owner/route truth.
- Receipt requires the receipt event contract; agent spawn success, visible `working`, visible pane/final text, tool output, skill loading, status, and later completion remain supporting signals.
- Receipt event content, post-ACK continuation, one-execution-block discipline, and pane-prose suppression follow `message-classes.md` Receipt Event Contract and Communication Integrity.
- Execution-block internals (skill-loading, corpus enumeration, file-read plan, retained-output path planning, evidence strategy, next action, progress notes) stay inside the block.
- Every upward message follows `.claude/skills/task-execution/references/message-classes.md` Communication Plane Law.
- Carry receiver-required detail through governed Communication Plane payload; use retained-output or task carriers only for size, evidence retention, or reuse.
- Report suppression and visible-row hygiene preserve complete, undistorted assignment facts.
- Preserve the following in governed carriers when material: exact request intent, target intent, acceptance basis, constraints, assumptions, inferences, blocker truth, evidence pointers, and next owner/action.
- Load and apply duties remain internal unless a receiver-owned packet, blocker, or completion field requires them.
- Before a lane uses actual full-body skill load-and-learn, officially preloaded full-skill basis, same-session loaded-and-learned skill basis, `REQUIRED-SKILLS`, or `SKILL-RECOMMENDATIONS` to authorize assigned work or completion, consume `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`; stale or uncertain basis opens required skill reload, exact trigger-reference consumption, `scope-pressure`, or `hold|blocker`.
- For each trigger-active pointer governing the assigned lane action or completion claim, record `applied`, `not-material:<basis>`, or `blocked:<basis>` per `.claude/reference/work-skill-reference-binding-law.md`.
- Consume `UPSTREAM-DECISION-BASIS` before first lane work when the packet carries or should carry prior reviewed, verified, synthesized, validated, rejected, open, blocker, or correction-ready output.
- If material `UPSTREAM-DECISION-BASIS` is missing, stale, contradictory, or not consumable, send `scope-pressure` or `hold|blocker` and request a consumable upstream basis.
- Returned lane data must be verified before feedback: material facts, counts, findings, state labels, recommendations, and verdict inputs go in retained-carrier `VERIFIED-DATA-FEEDBACK` with evidence basis, or in `OPEN-SURFACES` / `scope-pressure` / `hold|blocker` when not verified.
- Verified data feedback requires retained-carrier evidence; lane-visible prose, status, tool output, and undocumented memory remain non-verification signals.
- When lane work names candidates, findings, defects, removal, patch-worthiness, patch readiness, or issue counts, consume `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law` and `.claude/skills/task-execution/references/completion-handoff.md` `Common finding basis` before classifying or completing the output.
- Governance audit, doctrine cleanup, or defect-sweep lanes may complete high-recall discovery plus lane-local first-pass `candidate-classified` or `rejected:<basis>` states inside the assigned surface; binding cross-surface filtering, final rejection, promotion, ranking, prioritization, correction-priority, removal, patch-worthiness, patch-readiness, or patch/no-patch selection requires team-lead/validator full workflow basis, and assigned `Skill(review-verification)` lenses supply bounded evidence only.
- Lane outputs may maximize candidate recall, but they preserve `candidate-evidence` or `candidate-classified` state until a current full-workflow defect-promotion basis proves the promoted state.
- Lane outputs report raw candidate volume and confirmed defect volume as separate counts.
- Lane outputs use `confirmed-defect`, `patch-worthy`, or `patch-ready` only when the consumed promotion basis proves that exact state.
- This finding-state duty executes as lane baseline without packet wording.
- Receipt opens same-turn packet classification before lane work.
- Continue into lane work only after packet intake classifies as `execute` or lawful `reconstruct-with-inference`; `scope-pressure` and `hold|blocker` stop only the unsafe lane-local execution surface, carry attempted intake default/correction basis plus exact resume need, and are not completion or lane abandonment.
- Packet intake classifies into one of 4 states: `execute`, `reconstruct-with-inference`, `scope-pressure`, or `hold|blocker`.
- `execute` applies when packet bounds (owner, phase, proof, acceptance, deliverable) are unambiguous for the lane's work.
- `reconstruct-with-inference` applies only when inferred surface preserves the common boundary axes (owner, phase, proof, acceptance, deliverable) plus the lane-specific axes named in the lane's `agent-<lane>/SKILL.md`.
- `scope-pressure` routes mixed-phase, wrong-owner, shardable overload, hidden-prerequisite, or packet-field-vs-skill-law-conflict packets per `.claude/reference/work-skill-reference-binding-law.md` precedence stack.
- `hold|blocker` routes materially ambiguous decisive basis or non-derivable missing fields.
- Skill-field intake precedes first lane work.
- Classify every `REQUIRED-SKILLS` entry as `valid-loaded-and-learned`, `blocked:<basis>`, or `not-yet-applied:<basis>` before first lane execution; completion must resolve every valid lane-executable entry to `applied` with full-body load-and-learn evidence and applied-rule mapping, or `blocked:<basis>`.
- Classify every `SKILL-RECOMMENDATIONS` entry as `material-loaded-and-learned`, `not-material:<basis>`, `blocked:<basis>`, or `not-yet-applied:<basis>` before first lane execution; completion must resolve every material entry to `applied` with full-body load-and-learn evidence and applied-rule mapping, or `blocked:<basis>`.
- Lane-mismatched, contradictory, non-fitting, outside-boundary, owner-reserved, malformed, or full-workflow-only required-skill entries are blocked packet facts; return `scope-pressure` or `hold|blocker` instead of treating them as optional local omissions.
- When packet or retained-context wording offers equivalent checks, proxy lens mappings, inline PASS wording, or checklist prose in place of actual `Skill(review-verification)` packet/lens basis, send `scope-pressure` before lane work or completion.
- Silence when assigned specialist-surface structure is weak is a lane failure.
- The lane surfaces the gap to team-lead through Communication Plane.
- A retry is materially changed when evidence basis, blocker route, or fix/strategy/scope changes.
- A retry with no material change is a materially similar retry.
- A materially similar retry routes to `scope-pressure` or `hold|blocker` with the unchanged evidence basis, blocker route, and attempted fix/strategy/scope.
- Preserve global routing, staffing, and acceptance ownership from packet basis.
- If frozen host-authorized parallel-agent work collapses multiple independent surfaces onto one lane, send `scope-pressure` with `PRESSURE-TYPE: parallel-split-needed` and `CORRECTION-OUTCOME: route-replan`.
- Reconcile completion-grade output against the common end closure contract in `.claude/skills/task-execution/references/completion-handoff.md`.
- Before completion, load and run lane-local `Skill(self-verification)` convergence on the exact produced result, outgoing claim, and retained completion carrier.
- Completion records `UPSTREAM-DECISION-BASIS-CONSUMPTION`; missing consumption blocks completion-grade handoff when upstream decision basis was material.
- Lane-local `Skill(self-verification)` convergence verifies producer-owned result truth at the applicable frozen claim strength, including `CLAIM-CEILING` when the packet carries one.
- PASS-2 remains blocked until the lane has a current `review_verification_packet` from actual `Skill(review-verification)` Step 14 for the exact produced result and outgoing claim; evidence-only claim ceilings narrow authority only and never replace PASS-2.
- Packet quantitative scope specs (`PASS-2-MANDATE` lens count, `REVIEW-VERIFICATION-LENSES` enumeration, `COMPLETION-STOP-CONDITION` axis count, similar) are MINIMUM lane coverage within the same assigned review question, target, corpus, scope, claim ceiling, and lane authority, not maximum; lane extends without new packet authorization when produced-surface risk profile, domain breadth, or upstream evidence indicates deeper application of assigned named lenses, additional defeater enumeration, or coverage axis extension within that same bounded scope is material per `.claude/reference/review-and-verification-core-law.md` `## Evidence Law` substantive failure-mode probing rule, records the extension basis and exact applied lenses in the retained carrier, and treats packet-as-ceiling interpretation as the failure mode that `Skill(self-verification)` Step 3 PASS-2 fails on shallow verification; extension that would change target, corpus, bounded question, scope, claim ceiling, owner authority, or binding promotion/patch-selection authority requires `scope-pressure`, route-replan, or full-workflow activation per `.claude/skills/review-verification/SKILL.md` `## Activation` bounded-packet-evidence rule, not self-authorization.
- For AC-supporting rendered evidence, open every cited screenshot or full-page capture directly via the multimodal `Read` tool before claiming the rendered surface; AC-supporting proof requires the opened rendered surface. Routine non-AC baseline captures stay cite-only when they are unrelated to verdict support and defect evidence.
- Team-lead owns synthesis `Skill(self-verification)` convergence.
- Consume the agent-specific skill only for consequential lane-owned work.
- Receipt, status, shutdown, phase, or clarification messages activate it only when they assign or reopen work.
- Once consumed, the agent-specific skill outranks packet capability skills inside the lane.
- Run capability fit through these axes:
  - `SEMANTIC-INTENT-BASIS`
  - `COMPLETION-STOP-CONDITION`
  - `DERIVED-DEFAULTS`
  - `TARGET-INTENT-BASIS` per `[DESIGN-INTENT]`
  - assigned surface
  - `CLAIM-CEILING`
  - `SCOPE-BASELINE`
  - `ACTIVE-SLICE`
  - `DEFERRED-SURFACES`
  - common finding basis for critique/removal/patch-worthiness
  - skill basis
  - material tool or rendered/runtime needs
- If meaning-dependent work lacks a usable `SEMANTIC-INTENT-BASIS`, treat literal-text execution as unsafe and return `scope-pressure` or `hold|blocker` instead of narrowing the task by local interpretation.
- Every valid `REQUIRED-SKILLS` entry must be full-body loaded-and-learned before first lane execution and applied at the first material work surface where it can shape the assigned result; completion must preserve full-body load-and-learn evidence, applied-rule mapping, and applied or blocked truth.
- `REQUIRED-SKILLS` entries use skill identifiers; agent-specific skills come from the assigned lane.
- A blocked required entry sends `scope-pressure` when packet correction or replanning can restore execution.
- A blocked required entry sends `hold|blocker` when truthful execution remains blocked.
- A non-fitting, lane-mismatched, contradictory, or outside-boundary required entry is a packet or route defect.
- A required entry defect routes to packet correction or replacement-basis handling before local skill omission.
- Lane dispatch names `review-verification` through assigned lenses or routes full-workflow activation to the authorized owner.
- A lane dispatch that needs `review-verification` names the exact assigned lens or lenses from `Skill(review-verification)` `## Named Lane Lens Index`.
- For each uniquely recoverable shorthand or omitted `-lens` suffix, normalize to the canonical lens value and record the basis before lane work.
- For ambiguous aliases, proxy mappings, inferred equivalence, conflicting values, or ownership-changing entries, send `scope-pressure` with `CORRECTION-OUTCOME: packet-correction`.
- Full `review-verification` workflow routes to `team-lead` except validator final-arbitration or final-acceptance assignments that explicitly require validator-owned full workflow under `Skill(agent-validator)`.
- A bare full-workflow skill entry is a packet defect when the skill reserves full activation to another owner.
- If the lane already accepted or completed after receiving bare `REQUIRED-SKILLS: [review-verification]`, the lane defect is failure to surface the packet defect before work, not failure to run a full workflow it did not own.
- `SKILL-RECOMMENDATIONS` are use-if-fit execution prompts, not optional decoration.
- If a recommended, packet-implied, or newly discovered skill fits the assigned lane surface, the lane loads it immediately and applies it at the first material work surface inside the lane boundary.
- If a recommended skill mismatches the lane need but another available skill fits, the lane uses the fitting skill and records the replacement basis.
- If the skill mismatches the lane need or is unusable, mark it `not-material:<basis>` or `blocked:<basis>` before completion.
- Owner wording limits claim authority, not fitting skill use.
- Capability fit requires applying the fitting skill to the work surface.
- Lane claims require loaded-and-applied skill evidence on the assigned work surface or `not-material:<basis>` / `blocked:<basis>`; packet wording, skill names, labels, tool-call presence, style language, and procedure-shaped text remain background signals.
- When a selected capability skill's `SKILL.md` names a direct reference that owns material method detail for the assigned surface, capability fit includes loading and applying that reference, or marking it `not-material` / blocked with basis.
- During lane work, a newly discovered skill need is lane-local refinement only when it stays inside the same owner, phase, work surface, deliverable shape, proof/acceptance chain, and staffing route.
- During lane work, a newly discovered tool need opens `Skill(tool-acquisition)` when the current toolset cannot satisfy the assigned surface and the need stays inside the same owner, phase, work surface, deliverable shape, proof/acceptance chain, and staffing route.
- Lane-local refinement applies the skill or verified tool path immediately inside that boundary and records the basis in completion.
- A discovered need that changes any boundary above routes to `scope-pressure` / `hold|blocker` or reopened planning.
- If a required skill, decisive tool, rendered/runtime surface, or domain method is missing, unavailable, or outside the packet boundary, send `scope-pressure` / `hold|blocker` with the smallest correcting owner instead of downgrading quality.
- `CLAUDE.md`, role boundaries, `task-execution`, `work-planning`, and `self-verification` remain higher authority.

## Lane-Specific Additions
The common base packet is extended by lane-specific required fields:
- `developer`: change boundary plus downstream review/proof/acceptance-owner context fields
- `researcher`: question and evidence boundary
- `reviewer`: review boundary plus acceptance-evidence surface
- `tester`: proof and scenario boundary
- `validator`: verdict and expectation boundary

Each lane's agent-specific skill and lane-detail reference own exact assignment additions, lane-specific blocker conditions, and lane-specific completion extras.
They carry direct pointers to common transport and completion law instead of restating the common result spine.
Lane role documents own always-loaded lane identity, boundary, and routing conditions; they are not packet catalogs.

For session-side controlled packet value tables and lane-specific presence hints, see `.claude/skills/team-session-sequences/references/dispatch-packet-compliance.md` for assignment-side values such as `RESEARCH-MODE`, `BENCHMARK-MODE`, `PLAN-STATE`, `ACCEPTANCE-RISK`, `PROOF-OWNER`, `PREREQ-STATE`, `REVIEW-STATE`, and `TEST-STATE`; see `.claude/skills/team-session-sequences/references/upward-handoff.md` for upward lane-owned state such as `VERDICT`. Those reference sections are lookup indexes. `team-session-sequences` owns session-sequence indexes and dispatch-detail lookups, not packet schema or agent-specific additions. Runtime spine stays with `session-boot`, closeout with `session-closeout`, and packet schema with `task-execution`. Hooks guard runtime integrity as last-resort checks; normal agent behavior stays with the owning procedure.

## Resolve Next Owner And Action
- Satisfied common preconditions open lane-owned work.
- Defective receipt opens `scope-pressure` or `hold|blocker`.
- Missing lane-specific additions return to packet correction before dispatch.
- Missing required capability-skill consumption opens capability-skill consumption or `scope-pressure`.
- Boundary-changing discovered skill or tool need opens `scope-pressure`, `hold|blocker`, or `work-planning`.
- Completion-grade lane output opens completion-contract reconciliation.
