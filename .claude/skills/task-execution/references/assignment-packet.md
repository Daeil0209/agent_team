---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# task-execution: Assignment Packet
## Contents
- Downward Assignment Base Packet
- Receipt And Completion Contract
- Session Cross-Continuity Packet Check
- Resolve Next Owner And Action

## Downward Assignment Base Packet
Assignment-grade means `SendMessage` that assigns, reroutes, or reuses bounded work for an existing live team member.
Team-scoped `Agent` creates or reattaches the member address; it is not assignment-grade work delivery.
Shutdown requests, phase-transition packets, and status probes are not assignment-grade.

Runtime shape terms:
- direct `Agent` semantics outside team runtime are owned by `.claude/skills/task-execution/references/runtime-dispatch-law.md` `## Team Runtime Shape` and `## Team-Agent-Only Lane Dispatch`.
- `team-agent runtime` is opened by `TeamCreate` for coordinated teammates with shared task/mailbox state. Team-scoped `Agent` calls use a member-creation envelope to create or reattach a live member address keyed by `team_name` and `name`.
- Assignment-grade work begins only after governed assignment delivery per `.claude/skills/task-execution/references/message-classes.md` reaches that exact live member address.
- Task-row identity and assignment delivery follow `.claude/skills/task-execution/references/message-classes.md` `### Assignment Delivery Contract`.
- `team member address` is the exact live process-backed roster name. A configured role label is not an assignment-delivery address unless the roster contains that exact member with live pane proof.
- `teammate context` is independent. A teammate loads project context such as `CLAUDE.md`, configured MCP servers, and available skills, and receives the lead's spawn/assignment prompt; assignment packets must therefore be self-contained enough for the receiving lane to act without reconstructing prior chat.
- `visible teammate response` is not an assignment, receipt, completion, status, pressure, blocker, problem-report, or shutdown channel. It is UI rendering only. Screen-rendered `SendMessage` state signals are governed by `.claude/skills/task-execution/references/message-classes.md`.
- `SendMessage` is the first receipt transport channel for no-detail ACK, pressure, or blocker state. Retained carriers, non-rendered task state, runtime ledgers, and evidence artifacts carry `problem-report` detail plus large or long-lived payloads.

Every assignment-grade work packet carries:
- `MESSAGE-CLASS`
- `WORK-SURFACE`
- `CURRENT-PHASE`
- `REQUIRED-SKILLS`
- open executable `TASK-ID` from the active task namespace when task tracking is active
- `SEMANTIC-INTENT-BASIS` from the frozen planning/request-bound basis.
- `COMPLETION-STOP-CONDITION` from the frozen planning basis.
- `RECEIPT-COMPLETION-CONTRACT`
- `TARGET-INTENT-BASIS` per `.claude/reference/detailed-design-core-law.md` `[DESIGN-INTENT]`.
- `CLAIM-CEILING` for analysis, critique, governance judgment, review, validation, or patch-worthiness packets. Allowed values are `evidence-only candidates`, `review findings`, `validation verdict input`, `validator-final-verdict`, and `patch-worthiness classification`.
- `validator-final-verdict` is valid only for assignment-grade validator final-arbitration packets.
- `validator-final-verdict` permits validator-owned `VERDICT: PASS|HOLD|FAIL` on the assigned validation surface.
- No claim ceiling grants promotion, final rejection, patch/no-patch, patch-worthiness, or patch-readiness authority outside its named owner.
- Missing claim ceiling means returned items stay evidence-only until reviewer/review-verification/team-lead synthesis lawfully classifies them.
- `UPSTREAM-DECISION-BASIS` for every follow-on, correction, reuse, reroute, validation, patch, continuation, or completion-affecting packet whose work depends on prior reviewed, verified, synthesized, validated, rejected, open, blocker, or correction-ready output.
- Row-granular `SCOPE-BASELINE`, `ACTIVE-SLICE`, and `DEFERRED-SURFACES` when the output can affect completion, review, proof, validation, governance judgment, defect audit, or patch selection.
- Governance audit or defect-sweep packets may ask a lane for high-recall discovery plus lane-local first-pass `candidate-classified` or `rejected:<basis>` states inside the assigned surface. Packets that ask for binding cross-surface filtering, final rejection, promotion, ranking, prioritization, correction priority, removal, patch-worthiness, patch-readiness, or patch/no-patch direction route full workflow activation to `team-lead` or `validator`; assigned `REVIEW-VERIFICATION-LENSES` may supply bounded review packet evidence for that route but do not grant lane binding authority.
- When a packet asserts or relies on PASS-2, review-verification, or lens application, packet preflight carries the actual `Skill(review-verification)` packet/lens basis; equivalent checks, proxy lens mappings, inline PASS wording, and checklist prose open `packet-correction` before assignment send.
- `WRITE-SCOPE` carries bounded write and self-revision authority as one or more allowed write-path prefixes for the receiving lane.
- Receiving lanes include reviewer, validator, tester, researcher, and any non-developer lane that produces a retained-output artifact.
- Allowed prefixes are the frozen `RETAINED-OUTPUT-PATH` and declared, collision-preflighted `claude_doc/<work-name>/` sub-paths.
- Runtime write guards may consume the frozen retained carrier registry as corroborating scope evidence.
- Registry absence does not remove a non-developer lane's authority to create or revise its assigned project output under `claude_doc/<work-name>/`.
- A registry row proving that the target is another lane's retained carrier remains protected-filesystem bypass evidence.
- Scope registry input for `RETAINED-OUTPUT-PATH` and `WRITE-SCOPE` travels through governed assignment/reuse/reroute `SendMessage` packet fields or non-rendered retained carriers, not renderable task-row fields.
- Paths outside these prefixes are out-of-scope for `Write`, `Edit`, `MultiEdit`, and `Bash` artifact mutation.
- Missing `WRITE-SCOPE` on a write-producing lane packet defaults to the frozen `RETAINED-OUTPUT-PATH` only.
- Ambiguous `WRITE-SCOPE` routes `problem-report` before `scope-pressure`.
- Missing or contradictory `RETAINED-OUTPUT-PATH` on a write-producing packet is not inferable by project-folder convention; the receiver repairs one uniquely derivable retained path with recorded basis, otherwise records non-rendered `problem-report` with packet-correction basis before no-detail `scope-pressure` and uses no-detail `hold|blocker` only when no safe correction or replan path remains.
- After assignment-grade `SendMessage` succeeds, any same-`TASK-ID` or same-`WORK-SURFACE` correction/reuse/reroute packet preserves the frozen `RETAINED-OUTPUT-PATH` and `WRITE-SCOPE` from the active assignment.
- Changing `RETAINED-OUTPUT-PATH` for already-dispatched lane work is not packet correction; it requires prior-assignment side-effect reconciliation and a distinct bounded assignment/reuse/reroute with a new open `TASK-ID`.
- A packet that changes `RETAINED-OUTPUT-PATH` while the prior same-`WORK-SURFACE` assignment can still write is duplicate side-effect risk and stops before send.
- A write-producing packet whose `RETAINED-OUTPUT-PATH` already exists must carry a current-run reuse basis that matches `TASK-ID`, `WORK-SURFACE`, binding surface, and completion spine. A mismatch opens `packet-send stop` before assignment delivery.
- Packet assertions that prior artifacts are excluded or absent require quiet artifact-footprint evidence from the frozen output root. A false excluded-source premise opens `packet-send stop` before assignment delivery.

### Receipt And Completion Contract
`RECEIPT-COMPLETION-CONTRACT` is mandatory for assignment-grade work packets.
It binds the receiver's upward outcome and final handoff.
It must require no-detail `dispatch-ack` before long-running lane work, completion-grade `subjob-done` when packet review plus bounded lane work completes in the same execution block, and no-detail `scope-pressure` or `hold|blocker` when truthful start is blocked.
It must define `problem-report` as the mandatory nonclosing non-rendered problem-detail record before `dispatch-ack`, `scope-pressure`, or `hold|blocker` whenever intake finds a concrete problem and a receiver-consumable non-rendered channel is available.
It must define `dispatch-ack` as no-unresolved-objection assignment acceptance and immediate work-start trigger, not a waiting gate.
It must require `scope-pressure` or `hold|blocker` instead of `dispatch-ack` when truthful start remains blocked after `problem-report`.
It must require converged lane work to write the retained completion carrier required by `.claude/skills/task-execution/references/completion-handoff.md`.
It must require converged lane work to send governed `subjob-done` transport to `team-lead` through `SendMessage`.
It must require retained carrier plus governed `subjob-done` handoff instead of disk output, pane/final prose, `status`, or `TaskUpdate` substitutes.
When the assignment requests returned facts, counts, findings, state labels, recommendations, or verdict inputs, the contract must require `VERIFIED-DATA-FEEDBACK` in the retained carrier; unverified returned data is not completion-grade feedback.

### Tester Executable-Proof Schema Floor
For tester assignment-grade dispatch where the proof surface is executable, `ENV-BASIS` and `SCENARIO-SCOPE` are required schema floor.
Executable surfaces include browser-ui, cli, runtime, server, app, and api.
`task-execution` carries this doctrine-owned packet discipline.
Tester raises `scope-pressure` or `hold|blocker` when omission makes truthful proof impossible.
Conditional carve-out has two conditions:
- proof is fully pre-rendered with no live process, browser session, server, or runtime fetch required to inspect the proof surface
- single surface with no scenario, environment, or input variation
When the carve-out applies, mark `ENV-BASIS: not-applicable (<reason>)` and `SCENARIO-SCOPE: not-applicable (<reason>)`.
Env and scenario omission requires an explicit `not-applicable:<basis>` carve-out.
`PROOF-TARGET`, `PROOF-EXPECTATION`, and `PROOF-SURFACE` alone are not sufficient for executable proof.
Env and scenario binding must be explicit.
See `agents/tester.md` RPA-1 for the lane-side restatement.

### Packet Preflight And Correction Routing
Before assignment-grade dispatch, `task-execution` must run packet preflight against the frozen planning/workflow basis, not against gist. Preflight checks:
- consume `message-classes.md` `### Assignment Delivery Contract` before packet-body checks, `TaskCreate`, or assignment-grade `SendMessage`
- missing assignment-delivery or team-scoped member-creation tool-envelope fields send zero dependent calls and open tool-envelope correction
- tool-envelope field placement rule is owned by `message-classes.md` `## Canonical Channel Registry`; preflight verifies that planned team-scoped `Agent`, `TaskCreate`, and `SendMessage` envelope shapes satisfy the canonical placement rule before send
- team-scoped `Agent` envelope preflight consumes `runtime-dispatch-law.md` before the host `Agent` call; the spawn prompt template supplies only the `prompt` field and never satisfies top-level envelope fields
- `Agent` member-creation prompt screen-safety clause per `message-classes.md` Team Member Startup Recognition
- for parallel `Agent` batches, every planned spawn prompt in an atomic same-envelope subgroup passes the screen-safety clause before that subgroup is sent; a failing independent target blocks only that target or subgroup when the remaining subgroup preserves frozen route, cap, lane separation, and proof/acceptance separation
- assignment transport screen-safety clause: no extra visible prose around the governed assignment packet; when display-safe envelope shape is required, render follows `.claude/skills/task-execution/references/message-classes.md` `### Transport Payload` and the packet's required floor plus carrier pointer move to non-rendered task state or retained carriers
- screen suppression never authorizes blank assignment delivery; a short shard packet is valid only when it carries the required packet floor and points to a complete receiver-consumable retained carrier or non-rendered task state
- common base packet floor: `MESSAGE-CLASS`, `WORK-SURFACE`, `CURRENT-PHASE`, `REQUIRED-SKILLS`, `SEMANTIC-INTENT-BASIS`, `COMPLETION-STOP-CONDITION`, `RECEIPT-COMPLETION-CONTRACT`, `TARGET-INTENT-BASIS`, and an open executable `TASK-ID` from the active task namespace when task tracking is active
- write-producing packet preflight verifies the frozen output root and every planned `RETAINED-OUTPUT-PATH` passed quiet artifact-footprint and retained-path collision preflight; existing mismatched artifacts open `packet-send stop: packet-correction` or `route-replan` before send
- `packet-send stop` means team-lead sends no assignment-grade work delivery and opens `packet-correction` when the same frozen boundary remains valid; otherwise it opens `route-replan` or blocker-routing as named by the failed row.
- `REQUIRED-SKILLS` skill-field validity: reject role names, receiving agent-specific skill names, lane-mismatched entries, contradictory entries, non-fitting entries, outside-boundary entries, owner-reserved entries, malformed entries, and full-workflow-only entries before assignment send
- `SKILL-RECOMMENDATIONS` skill-field validity: reject role names, receiving agent-specific skill names, contradictory entries, outside-boundary entries, owner-reserved entries, malformed entries, and full-workflow-only entries before assignment send; ordinary non-fitting recommendations remain receiver-classified as `not-material:<basis>`
- Lane-dispatched `review-verification` uses `REVIEW-VERIFICATION-LENSES` for bounded named lane lenses, or routes full workflow activation to `team-lead` or `validator`.
- `REVIEW-VERIFICATION-LENSES` values use `Skill(review-verification)` `## Named Lane Lens Index`; each uniquely recoverable shorthand or omitted `-lens` suffix may be normalized with recorded basis before assignment send.
- Ambiguous aliases, proxy mappings, inferred equivalence, conflicting values, and ownership-changing lens entries open `packet-send stop: packet-correction`.
- Invalid skill-field entries are normalized before assignment send only when the repair is syntax-only canonicalization of an already valid skill or lens identifier inside the same frozen owner, phase, deliverable, proof/acceptance chain, staffing shape, and agent boundary.
- Non-derivable, contradictory, lane-mismatched, outside-boundary, owner-reserved, or ownership-changing skill-field entries open `packet-send stop: packet-correction` when the same boundary remains unchanged; otherwise open `route-replan`.
- missing `RECEIPT-COMPLETION-CONTRACT` opens `packet-send stop: packet-correction`
- contradictory `RECEIPT-COMPLETION-CONTRACT` opens `packet-send stop: packet-correction`
- a contradictory `RECEIPT-COMPLETION-CONTRACT` permits work without first upward resolution outcome, permits problem-state selection without preceding `problem-report`, permits `dispatch-ack` with unresolved objection, permits `subjob-done` without retained carrier, permits `subjob-done` without `SendMessage` to `team-lead`, or treats disk output, pane/final prose, `status`, or `TaskUpdate` as a completion substitute
- packet field vs loaded skill law conflict: any packet field value that contradicts a binding rule from loaded skill / role-body / trigger-bound reference per `.claude/reference/work-skill-reference-binding-law.md` precedence stack is a packet defect; open `packet-send stop: packet-correction`
- when task tracking is active, consume `message-classes.md` `### Assignment Delivery Contract` for `TASK-ID`, task-row non-owner, and completion-closure rules
- invalid or unverified `TASK-ID` opens `packet-send stop: packet-correction` when the active task exists, otherwise `route-replan`
- analysis, validation, or defect-audit `CLAIM-CEILING`: the packet states one wording ceiling from the allowed-values enumeration above in this reference's schema list; otherwise preflight keeps the packet evidence-only
- completed-task correction/follow-up uses an open executable task whose `TaskCreate` result has returned before dependent dispatch or task mutation
- Already-completed lane confirmation uses retained carrier consumption or distinct new bounded work, not assignment, reuse, reroute, or expanded packet text for the same `TASK-ID`, `WORK-SURFACE`, or `RETAINED-OUTPUT-PATH`.
- This is a lead-side no-send rule; the closed lane remains closed without duplicate proof packets.
- After completion, same-surface details are consumed from the retained carrier; additional lane work requires distinct new bounded work with distinct task/work-surface basis.
- receiving lane additions from the agent-specific skill and lane-detail reference
- target-resolution basis for team runtime: active team name, live process-backed roster, target role, exact member address, tool shape, and resulting truth label (`member-created` for Agent; `assignment-sent` for assignment SendMessage)
- concrete requested action must be executable with the receiving lane's allowed tools and output channel
- when the requested output requires a retained artifact or self-revision, the receiving lane must have `Write` for creation and `Edit`/`MultiEdit` for revision in `tools`, those tools absent from `disallowedTools`, and `RETAINED-OUTPUT-PATH` plus bounded `WRITE-SCOPE`
- artifact writing, state mutation, unavailable-tool use, and output-channel use route only to lanes or owners with that bounded authority
- if the lane cannot produce the requested artifact directly, route the write/mutation to an owner that has the tool or require lane output through `SendMessage`
- request-bound start-closure fields from `.claude/skills/task-execution/references/request-bound-fields.md`; every material axis frozen by planning or workflow is carried, marked `not-applicable:<basis>` where allowed, or routed to `packet-correction` / `route-replan`
- the carried axes include `DERIVED-DEFAULTS`, `REQUEST-BOUND-PACKET-FIELDS`, `SKILL-RECOMMENDATIONS`, governance tier fields, lane phase context, coverage obligations, assigned surfaces, acceptance basis, decisive surface/proof/tool/setup/run-path/burden/decision/validation/environment/scenario fields, and cited Receiver-Surface Contract, Consumption Chain, Boundary Register, and Evidence-Quality Matrix identities when material
- follow-on, correction, reuse, reroute, validation, patch, continuation, or completion-affecting packets carry `UPSTREAM-DECISION-BASIS`; when the current same-boundary basis is uniquely derivable from the frozen plan, current review packet, or retained carrier, repair the packet field once with recorded basis before send
- missing or stale `UPSTREAM-DECISION-BASIS` opens `packet-send stop`; when current basis is uniquely derivable, repair it once with recorded basis before send; when current basis exists but is not uniquely derivable, open `packet-correction`; otherwise open `route-replan` or blocker-routing only when no safe correction or replan path remains
- completion, review, proof, validation, governance-judgment, defect-audit, and patch-selection packets carry row-granular `SCOPE-BASELINE`, `ACTIVE-SLICE`, and `DEFERRED-SURFACES`; when missing rows are uniquely derivable from the frozen basis without changing scope, repair them once with recorded basis before send
- missing row-granular scope rows open `packet-send stop: packet-correction` when the frozen basis contains them but they are not uniquely derivable, otherwise `route-replan`
- wave, sample, priority-tier, or representative-slice packets label that slice as `ACTIVE-SLICE`; `SCOPE-BASELINE`, `COMPLETION-STOP-CONDITION`, `CLAIM-CEILING`, and downstream completion truth remain frozen
- finding counts are retained evidence, not dispatch scope
- Completion contracts request governed upward `subjob-done` `SendMessage` per `.claude/skills/task-execution/references/message-classes.md` `### Transport Payload`; receiver-required detail travels in the retained carrier.
- Receiver-required completion payload travels in the retained carrier per `.claude/skills/task-execution/references/completion-handoff.md` Common Completion Result Spine.
- Assignment packets request data feedback through the retained carrier; team-lead consumes returned data only from the completion spine's `VERIFIED-DATA-FEEDBACK`, `EVIDENCE-BASIS`, and `OPEN-SURFACES`.
- These packet types must carry `RETAINED-OUTPUT-PATH` when expected output includes Communication Plane detail that would pollute transport display:
  - parallel shard dispatches with large shared context use one complete shared retained context plus per-shard packets that carry the required packet floor and point to that context; short means no duplicate large context, not reduced receiver-required basis; `PARALLEL-DISPATCH-LOCK` uses shared retained context instead of serialized large self-contained packet drafting
  - completion packets
- a receiving lane that receives such a packet without the path repairs one uniquely derivable retained path with recorded basis, otherwise records non-rendered `problem-report` with packet-correction basis before no-detail `scope-pressure` and uses no-detail `hold|blocker` only when no safe correction or replan path remains
- for review/test/validation/completion packets, acceptance scope must come from the frozen request, plan, design, or upstream defer record; implemented files/routes/screens/sections populate `ACTIVE-SLICE` only, never substitute for `SCOPE-BASELINE`
- Contract-truth preflight anchors verification packets to the frozen baseline, exact launch/read artifact, operator invocation, termination, cleanup, and defer basis.
- Convenient-subset, inherited server-state, already-running endpoint, or wave-narrowed-without-`SCOPE-BASELINE`-union-record packets route to correction from the frozen basis or reopen the owner.
Multi-wave wave packets consume `SCOPE-BASELINE` union rules in `.claude/skills/work-planning/references/planning-record-fields.md`.
- `FINAL-REJECT` follow-on packet preflight preserves frozen acceptance scope and carries the validator-authored correction packet in `EXECUTION-READINESS-BASIS` before correction or re-evidence dispatch.

Preflight outcome names:
- `packet-correction`: the missing or malformed packet value already exists in the frozen basis and the same owner, phase, deliverable, proof/acceptance chain, staffing shape, and agent boundary remain unchanged. Correct the packet and rerun preflight before sending.
- Post-convergence transport-display defects in delivered completions are not `packet-correction`; consume retained truth and route recurrence cleanup to `Skill(governance-modification)`.
- `route-replan`: the missing, contradictory, or stale basis is absent from the frozen basis or would move a `work-planning` boundary-change axis. Reopen `work-planning`.
- `parallel-continue`: the affected surface is blocked or being corrected while unrelated independent surfaces remain inside the same frozen parallel route. Continue unaffected surfaces while resolving the blocked surface through `packet-correction`, `route-replan`, or proven user-owned blocker.

Packet preflight never invents route facts, tool facts, acceptance facts, or skill openings. It corrects a bounded packet translation defect, reopens the route owner, or keeps independent unblocked work moving.
Target resolution preflight per `runtime-dispatch-law.md` Target-resolution preflight.
If member creation would move a `work-planning` boundary-change axis, reopen `work-planning`.
When the receiving path is team-agent runtime, preflight must also reject packets that rely on lead-only conversation context, unlinked prior reasoning, or implicit upstream decisions. Those facts must be carried as packet fields, task/workflow state, or preserved artifacts before dispatch.
For live owner-document verification assignments, carry the post-execution live diff and owner-document basis as packet facts, task/workflow state, or preserved artifacts, or require returned evidence that proves the receiver used those live owner documents. If that evidence is absent or unproved, the receiver records non-rendered `problem-report` before no-detail `hold|blocker` or marks findings non-authoritative; team-lead uses only proved live-owner-document output as verification evidence.

### Field Format Discipline
Packet field shape follows the line-prefix `KEY: value` form consumed by `hooks/lib/hook-agent-dispatch.sh` field-cache parsing; that hook owns the exact parser expression.
A field counts as "present" only when this form matches its first line.
Fields that look semantically present in prose but fail this format are packet defects.
Warning hooks can flag them as missing.
The primary correction owner is the packet-producing procedure.

Required shape for every dispatch field (assignment, validator, reviewer, tester, phase context):
- field name MUST start the field segment (no leading prose, list bullet, or quote prefix)
- only `[A-Za-z0-9_-]` allowed in the field name
- `:` MUST come directly after the field name (only whitespace allowed between)
- NO parenthetical descriptor, type annotation, or natural-language qualifier between key and colon
- value follows the colon on the same line
- multi-line continuation is allowed on subsequent lines
- numbered lists, bullets, and nested detail are continuation content only
- continuation content is NOT what the parser keys against

| Wrong | Right |
|---|---|
| `EXPECTATION-SOURCES (consolidated frozen criteria - read in this order):` | `EXPECTATION-SOURCES: Consolidated frozen criteria, read in order. (1) ...` |
| `**MESSAGE-CLASS**: assignment` (markdown bold prefix) | `MESSAGE-CLASS: assignment` |
| `- TASK-ID: ...` (list bullet prefix) | `TASK-ID: ...` |

Note on leading whitespace: the compatible packet parser strips leading/trailing whitespace from each segment via `gsub(/^[[:space:]]+|[[:space:]]+$/, "", segment)` before the regex match.
An indented field parses at runtime.
Column-0 starts remain the readable convention.
Indentation alone is not a packet-warning cause.

Recovery discipline: when a packet warning flags a "missing field" you have written into the packet, the format is the likely cause.
Read the field's first-line shape against the rules above before retrying.
Treat same-shape retry as a recurrence-barrier defect, not a parser bug.

Packet skill fields separate required skills from methodology recommendations.
- Use `REQUIRED-SKILLS` for methodology or capability skills frozen as necessary for the receiving lane's bounded work.
- Receiving lanes must load-and-learn every valid `REQUIRED-SKILLS` entry before execution, apply it at the first material work surface where it can shape the assigned result, and record applied basis before completion, or record non-rendered `problem-report` before no-detail `scope-pressure` / `hold|blocker`.
- Use `REQUIRED-SKILLS: []` to record absence of upstream required skills.
- Carry `SKILL-RECOMMENDATIONS` when planning or the active workflow owner froze methodology instructions for the receiving lane.
- The receiver classifies each carried recommendation as applied, not-material, or blocked.
- The receiver load-and-learns material recommendations before the work surface they shape, applies them at the first material work surface where they can shape the assigned result, and records applied basis before completion.
- The receiver records recommendation classification basis in the completion carrier.
- The receiver validates every skill-field entry before loading; invalid, lane-mismatched, contradictory, non-fitting, outside-boundary, owner-reserved, or malformed entries are blocked packet facts, not optional instructions.
- A lane that receives a blocked required-skill entry records non-rendered `problem-report` before no-detail `scope-pressure` or `hold|blocker` before lane work and records the invalid entry as blocked packet truth.
- For lane dispatch, `review-verification` is carried by `REVIEW-VERIFICATION-LENSES` when bounded named lenses are authorized; binding promotion or patch-selection authority routes to the full-workflow owner. Bare `REQUIRED-SKILLS: [review-verification]` is a packet defect.
## Session Cross-Continuity Packet Check
Before assignment-grade dispatch for independent or parallel work, packet construction must apply prior same-session patches, confirmed corrections, recurrence barriers, decisions, contract freezes, lane-charter changes, sibling outputs, and acceptance-contract changes that affect packet fields, owner boundaries, proof burden, or acceptance truth.

If the required prior invariant is missing from the frozen route, reopen `work-planning`. If the packet would contradict a prior invariant, route to packet correction or `work-planning` before dispatch.

Use assignment-grade packets for:
- new assignment
- reroute
- bounded reuse

If an agent is receiving new bounded work in the same execution segment, carry any needed workflow phase context inside the assignment packet instead of sending a separate phase-transition packet.

## Resolve Next Owner And Action
- Passing packet preflight opens `task-execution` dispatch or reuse.
- `packet-correction` opens same-owner packet correction and reruns packet preflight.
- `route-replan` opens `work-planning`.
- `parallel-continue` keeps unaffected lanes moving while the blocked surface resolves.
- Missing target-resolution evidence opens runtime target resolution before dispatch.
- Missing field format truth opens correction in the packet-producing procedure.
- Missing lane-required additions opens lane-addition correction before dispatch.
- Packets relying on lead-only conversation context open packet fact transfer before dispatch.
