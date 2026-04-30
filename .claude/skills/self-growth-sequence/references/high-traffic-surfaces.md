# self-growth-sequence: High-Traffic Governance Surfaces
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

High-traffic governance surfaces require session revalidation, baseline anchoring, and bounded change scope before modification resumes after interruption.

Active high-traffic surfaces:
- `agents/team-lead.md`
- `CLAUDE.md`
- runtime hooks under `.claude/hooks/`
- `.claude/settings.json`
- `settings.*.json` overlays
- skill files under `.claude/skills/*/`

Runtime hook protection and settings-deny protection are separate layers. Governance-flow protection is enforced through runtime hooks such as `compliance-supervisor.sh` and related hooks. `settings.json` `permissions.deny` is reserved for hard credential and secret paths such as `.env`, `secrets/**`, and `credentials.json`.
