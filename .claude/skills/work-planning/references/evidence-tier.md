# Work-Planning Evidence Tier
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
auto-inject: false

Evidence quality has four tiers in descending order:
1. external authoritative reference: standards, official docs, best-practice patterns, reference implementations, current web-searched state of practice
2. prior session evidence
3. model prior knowledge
4. intuition

A feasible, materially-relevant higher-tier source is mandatory.
Deferring a higher-tier source requires an explicit frozen reason.
Settling for a lower tier while a higher tier is feasible-and-relevant is a planning-evidence defect.

Strict tier discipline applies to design, visual, UX, interaction, structural, methodology, and governance-hardening decisions where external practice can move faster than model prior knowledge.

The canonical escalation path is `researcher` lane + `benchmark-simulation` skill + WebSearch/WebFetch or equivalent authoritative external-reference research.
Missing that path when materially relevant is a planning-evidence defect.

## Resolve Next Owner And Action
- Higher-tier evidence need opens the canonical escalation path.
- Feasible lower-tier-only planning records the deferral basis.
- Missing material escalation reopens `work-planning`.
