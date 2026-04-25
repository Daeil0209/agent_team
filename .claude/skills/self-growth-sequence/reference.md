# Self-Growth Sequence: Reference Material
> **Not auto-injected.** This file contains lookup tables, field catalogs, checklists, and schemas for the self-growth-sequence skill. Load explicitly via Read when needed during execution.
## Self-Healing Trigger Matrix
| Trigger Type | Default Interpretation | Required Action |
|---|---|---|
| justified user correction | authoritative defect signal | open self-growth immediately; stabilize active request; harden recurrence path |
| self-detected behavioral defect | real defect unless disproven by stronger evidence | open self-growth immediately; do not wait for user confirmation |
| repeated missed-catch / recurrence | capability or boundary weakness | escalate beyond local patch into checklist, routing, hook, or authority hardening |
| blocked execution due to missing reusable skill | capability gap | use Capability-Gap Fast Path with explicit owner and verification |
First occurrence does not mean "ignore until repeated." Repetition raises the hardening depth, not the existence of the duty.
## Self-Healing Closure Checklist
Before declaring a self-growth round complete, keep all of the following explicit:
1. defect basis was real enough to govern behavior
2. recurrence path was identified or explicitly narrowed
3. correct owner surface was chosen
4. bounded hardening actually landed or was explicitly assigned with owner and boundary
5. fresh evidence was gathered on the affected path
6. the active task resumed under corrected behavior, not pre-correction habit
If one of these remains false, the self-growth round is not closed cleanly.
## Capability-Gap Fast Path
### Required Steps Checklist
When the fast path applies, all six steps remain required:
1. gap confirmation
2. overlap check against existing skills, agents, and rules
3. explicit owner assignment
4. bounded creation scope
5. review of the resulting skill content
6. post-adoption verification that the new skill actually closes the gap
### Default Rapid-Skill Routing
- `researcher` confirms the gap and checks for overlap with existing assets
- `team-lead` fixes owner, scope, and adoption path
- `developer` creates or updates the skill assets
- `reviewer` checks placement, overlap, and information-loss risk
- `validator` is assigned when acceptance risk is meaningful
## Skill Introduction Category Gate
### Categories (exactly one primary category required)
- `repeatable procedure`
  - reusable multi-step workflow that will recur across tasks or sessions
- `specialist judgment surface`
  - recurring expert perspective that sharpens implementation, review, or planning quality
- `integration or environment bridge`
  - reusable external-tool, connector, or setup protocol with stable verification and fallback steps
- `governance or quality hardening`
  - reusable review, validation, migration, or operational-discipline procedure not already owned elsewhere
### Reject criteria
Do not create a new skill when the proposal is primarily:
- a one-off task brief
- project-local knowledge that belongs in local doctrine
- a temporary workaround with no expected reuse
- a duplicate of an existing skill, agent charter, or rule owner
- a style preference with no clear reusable procedure or authority boundary
### Approval packet (must name all of the following)
- category
- expected reuse pattern
- existing-owner overlap result
- chosen owner
- why existing skill expansion was insufficient
- first adoption path
If the proposal cannot survive this category gate cleanly, do not create a new skill. Update the correct existing owner instead.
## Benchmark Protocol Detail
- Comparative self-growth, reusable-ownership, and quality-hardening claims default to benchmark-first discipline. Name the baseline and comparison surface before the hardening claim is allowed to harden into routing or ownership.
- Benchmark conclusions must declare provenance. If benchmark inputs are not directly inspectable or credibly cited, downgrade to `HOLD`, `UNVERIFIED`, or simulator-only status.
- Default preparation sequence: benchmark -> cross-check and anti-hallucination confirmation -> concrete modification proposal -> pre-edit loss-risk gate -> bounded modification -> verification -> only then bounded optimization.
- Early investigation and benchmark stages identify the actual deficiency and determine whether self-growth is warranted. Do not jump from a recurring symptom into edits.
- `BENCHMARK-PROVENANCE: simulator-only` or `CROSS-CHECK-STATUS: simulator-unconfirmed` is still a benchmark-stage `HOLD`, not edit authorization.
- When a self-growth round claims advancement, keep the current readiness label, visible evidence delta, throughput or neighbor-regression visibility, and follow-on optimization closure explicit in the active sequence packet before the round is handed back for lead judgment.
## Patch Classification Map
- `hardening patch`
  - strengthens an existing owner with clearer doctrine, boundary, gate, or evidence rules
- `structural normalization patch`
  - aligns runtime prose, owner documents, and configuration ownership into one coherent target design
- `migration or re-home patch`
  - preserves meaning while moving it from a legacy or temporary location into the correct current owner
- `config-owner standardization patch`
  - keeps one literal owner for a configurable value and converts all other surfaces into references
- `skill-up patch`
  - hardens, expands, or repairs an existing reusable skill under the consuming lane's ownership model
- `new-skill patch`
  - introduces a new reusable skill only after category, reuse need, and owner fit are proven
- `follow-on optimization patch`
  - removes avoidable cost, runtime burden, or redundancy only after the stronger quality bar is already secured
## Failure Mode Response Matrix
| Failure Mode | Default Meaning | Allowed Response | Prohibited Response |
|---|---|---|---|
| `missing-owner` | No current owner surface governs the recurring behavior. | Assign one owner surface, then add the narrowest rule, skill gate, packet field, or hook path needed to close the gap. | Scatter duplicate doctrine across multiple owner files or let the most familiar lane take ownership by habit. |
| `weak-owner` | The right owner exists, but its wording, gate, checklist, or packet is too weak to prevent recurrence. | Tighten or replace the owning block; add a checklist or packet requirement only when wording alone will not surface the duty. | Create a new sibling doctrine block when an existing owner block can be strengthened. |
| `wrong-owner` | The behavior is governed from the wrong document, lane, or runtime surface. | Re-home the meaning to the correct owner and leave an owner-reference only when local readability requires it. | Preserve a misleading old owner because it is convenient or delete the old text without preserving unique meaning. |
| `non-compliance` | The rule already exists; the failure came from not following it. | Harden adherence through trigger visibility, checklist discipline, packet requirements, hook support, or self-verification gates. | Add duplicate rules that make doctrine larger but do not address why the existing rule was missed. |
| `weak-enforcement` | Doctrine exists, but runtime or packet surfaces cannot reliably expose the obligation. | Add or refine deterministic, low-false-positive hook logic, packet fields, or advisory guidance according to enforcement maturity. | Promote semantic judgment into a hard block before the required fields or low-cost evidence are available. |
| `capability-gap` | No reusable skill, reference, or lane procedure can handle the recurring work credibly. | Use Capability-Gap Fast Path; update an existing owner when sufficient, create a new skill only after the category gate. | Create a skill for a one-off task, style preference, temporary workaround, or duplicate capability. |
Use this matrix before drafting. A patch may involve more than one failure mode, but one primary mode must govern the edit operation and owner choice.
## Human-Readable Packet Owners
For `developer` governance-modification execution, keep the governance packet readable here as the semantic packet owner; runtime hooks and dispatch gates may enforce adjacent discipline, but this catalog controls semantic completeness. Current packet surface — **Standard**: `TASK-CLASS: governance-patch`, `CHANGE-BOUNDARY`, `WRITE-SCOPE`. **Structural** (adds): `BASELINE-CLASS: preserved-asset|improvement-target|stability-anchor`, `EDIT-OPERATION: tighten|replace|re-home|merge|append|delete`. For meaning migration: `CHANGE-BOUNDARY` must include source-meaning inventory, destination rationale, and cross-reference update list. High-traffic surfaces add: `SESSION-REVALIDATION: current-session-repo`, `BASELINE-ANCHOR: captured`. Use `.claude/skills/developer/reference.md § Required Dispatch Packet Fields` for the developer dispatch-field baseline.
For consequential solution work, keep the solution-development packet readable here as the semantic packet owner. Current packet surface: `PROBLEM-CLASS: instance|structural|systemic`, `ROOT-CAUSE-BASIS: confirmed|supported|hypothesis|unknown`, `SOLUTION-PASS: 1|2|3`, `DECISION-BASIS`, `REJECTED-OPTIONS`, `CHANGE-BOUNDARY`. When `SOLUTION-PASS: 2|3`, also keep `PASS-DELTA`. When `PROBLEM-CLASS: structural|systemic`, also keep `SELECTED-SCOPE: class-fix|system-fix|staged-class-fix`. When `ROOT-CAUSE-BASIS: hypothesis|unknown`, also keep `COMPETING-HYPOTHESES`. When `SELECTED-SCOPE: staged-class-fix`, also keep `FOLLOW-UP-OWNER`. Use `.claude/skills/developer/reference.md § Required Dispatch Packet Fields` for the developer dispatch-field baseline.
## Self-Growth Constraints
- Do not allow undocumented doctrine drift.
- Do not let self-growth become a hidden excuse for unrelated refactors.
- Do not declare improvement complete without evidence of the actual hardening change.
- Do not introduce a new skill when a bounded update to an existing owner would solve the same problem more cleanly.
- Do not use self-growth, optimization, compression, or rewrite work as justification for removing protected local restatements that keep owner files safe to read in isolation.
- When self-growth affects reusable ownership, protect average-capability and prevent lane hollowing.
