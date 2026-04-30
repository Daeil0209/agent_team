# Work-Planning Evidence Tier
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Evidence quality is hierarchical:
1. external authoritative reference: standards, official docs, best-practice patterns, reference implementations, current web-searched state of practice
2. prior session evidence
3. model prior knowledge
4. intuition

When a higher-tier source is feasible and materially relevant, use it or explicitly freeze why it is deferred. Settling for a lower tier while a materially relevant higher tier is available is a planning-evidence defect.

This rule is especially strict for design, visual, UX, interaction, structural, methodology, and governance-hardening decisions where external practice can move faster than model prior knowledge. If the planning basis stays inside model prior knowledge when current external practice is materially relevant and feasible, the failure mode is "frog-in-well" reasoning: quality becomes bounded by the model's prior state.

The canonical escalation path is `researcher` lane + `benchmark-simulation` skill + WebSearch/WebFetch or equivalent authoritative external-reference research. Failing to invoke that path when materially relevant is a planning-evidence defect, not just an unused option.
