# self-growth-sequence: Repair Decision Guide
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/self-growth-sequence/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false

Use this guide after causal analysis and owner selection.

For failure-mode-specific allowed/prohibited responses (non-compliance, weak-owner, wrong-owner, capability-gap, recurrence), consume `.claude/skills/self-growth-sequence/references/failure-mode-response.md`.

1. If the failure is a missing lookup detail, add it to the owning direct `references/*.md` file and keep the active `SKILL.md` spine small but mandatory.
2. If the failure is a packet or handoff omission, add or tighten the packet field in the packet owner before adding prose-only reminders.
3. If deterministic runtime evidence can catch the defect with low false positives, add or refine hook/settings enforcement only after the semantic owner is correct and non-hook adherence hardening is insufficient. Otherwise keep the barrier in doctrine, checklist, packet, self-verification, or owner-surface guidance.
4. If no existing lane, skill, or reference can handle the recurring work, use Capability-Gap Fast Path; do not create a new skill for a one-off need.

Before closure, verify: no dead cross-reference, no owner-boundary drift, no weakened proof or acceptance path, no duplicate competing procedure, and no hidden always-loaded context increase.

## Resolve Next Owner And Action
- Missing lookup detail opens owning direct reference update.
- Packet or handoff omission opens packet owner correction.
- Low-false-positive deterministic runtime evidence opens hook/settings preflight after semantic owner correction.
- One-off need returns to owner-surface guidance or packet correction.
- Reusable capability gap opens Capability-Gap Fast Path.
- Failed closure verification returns to patch design.
