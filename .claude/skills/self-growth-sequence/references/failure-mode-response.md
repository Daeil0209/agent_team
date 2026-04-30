# self-growth-sequence: Failure Mode Response Matrix
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

| Failure Mode | Default Meaning | Allowed Response | Prohibited Response |
|---|---|---|---|
| `missing-owner` | No current owner surface governs the recurring behavior. | Assign one owner surface, then add the narrowest rule, skill gate, packet field, or hook path needed to close the gap. | Scatter duplicate doctrine across multiple owner files or let the most familiar lane take ownership by habit. |
| `weak-owner` | The right owner exists, but its wording, gate, checklist, or packet is too weak to prevent recurrence. | Tighten or replace the owning block; add a checklist or packet requirement only when wording alone will not surface the duty. | Create a new sibling doctrine block when an existing owner block can be strengthened. |
| `wrong-owner` | The behavior is governed from the wrong document, lane, or runtime surface. | Re-home the meaning to the correct owner and leave an owner-reference only when local readability requires it. | Preserve a misleading old owner because it is convenient or delete the old text without preserving unique meaning. |
| `non-compliance` | The rule already exists; the failure came from not following it. | Harden adherence through trigger visibility, checklist discipline, packet requirements, hook support, or self-verification gates. | Add duplicate rules that make doctrine larger but do not address why the existing rule was missed. |
| `weak-enforcement` | Doctrine exists, but runtime or packet surfaces cannot reliably expose the obligation. | Add or refine deterministic, low-false-positive hook logic, packet fields, or advisory guidance according to enforcement maturity. | Promote semantic judgment into a hard block before the required fields or low-cost evidence are available. |
| `capability-gap` | No reusable skill, reference, or lane procedure can handle the recurring work credibly. | Use Capability-Gap Fast Path; update an existing owner when sufficient, create a new skill only after the category gate. | Create a skill for a one-off task, style preference, temporary workaround, or duplicate capability. |

Use this matrix before drafting. A patch may involve more than one failure mode, but one primary mode must govern the edit operation and owner choice.
