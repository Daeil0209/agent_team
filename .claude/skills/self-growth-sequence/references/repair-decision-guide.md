# self-growth-sequence: Repair Decision Guide
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Use this guide after causal analysis and owner selection.

1. If the correct rule already exists and the failure was non-compliance, do not add duplicate doctrine. Harden the trigger, checklist, packet field, hook warning, or self-verification catch that makes the existing rule harder to miss.
2. If the right owner exists but wording is too weak, tighten or replace that owner-local block.
3. If the rule is in the wrong place, re-home the meaning to the correct owner and leave only a narrow pointer where local readability needs it.
4. If the failure is a missing lookup detail, add it to the owning direct `references/*.md` file and keep the active `SKILL.md` spine small but mandatory.
5. If the failure is a packet or handoff omission, add or tighten the packet field in the packet owner before adding prose-only reminders.
6. If deterministic runtime evidence can catch the defect with low false positives, add or refine hook/settings enforcement only after the semantic owner is correct.
7. If no existing lane, skill, or reference can handle the recurring work, use Capability-Gap Fast Path; do not create a new skill for a one-off need.

Before closure, verify: no dead cross-reference, no owner-boundary drift, no weakened proof or acceptance path, no duplicate competing procedure, and no hidden always-loaded context increase.
