---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/governance-scaling/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
---

# Reference Material
## Detection Heuristics Table
These signals indicate a likely tier. They inform `team-lead` judgment. Project-tier authority comes from the frozen project floor. Project-level governance parameters apply after the project floor is frozen and consumed explicitly. Per-request handling raises autonomously when direct risk signals require a stricter task tier.
| Signal | Likely Tier |
|---|---|
| `terraform/`, `k8s/`, `docker-compose.yml` present in repo | Precision |
| Security-sensitive changes, auth systems, secrets management | Precision |
| MCP server, external advisory tool, credential/session bridge, or external-tool capability promotion | Standard; Precision if credentials, security boundary, blocking authority, or final-acceptance authority changes |
| API integration, third-party service wiring, multi-file feature | Standard |
| Structured development project with spec or design doc | Standard |
| Single page, simple script, isolated config change, typo fix | Lightweight |
| Single-user local app/tool/dashboard with bounded features, local data, no auth, no multi-tenant deployment, and no infrastructure orchestration | Lightweight by default; Standard if multi-feature business logic or persistence risk is material |
| Multi-source market, technology, patent, standards, or evidence-bound report automation | Standard; Precision if legal status, safety, regulatory, high-stakes decision, or source freshness materially affects acceptance |
| Engineering calculation, design, simulation, standards, unit, tolerance, or safety-margin critical path | Standard; Precision if standards compliance, safety, irreversible design choice, or high-stakes numeric output materially affects acceptance |
Local-app fast-path boundary: delivery-surface proof remains acceptance-critical at every tier. A Lightweight local app uses fewer agents and fewer design options only inside that proof floor. If it promises double-click/low-touch/browser UI operation, the real launch path and first usable view remain acceptance-critical.
## Freeze And Consume Wiring
When governance depth is active, freeze and consume these fields explicitly:
- `PROJECT-TIER`
- `ACTIVE-REQUEST-TIER`
- `TIER-RAISE-REASON`

Rules:
- `PROJECT-TIER` is the project floor.
- `ACTIVE-REQUEST-TIER` is the current request tier and stays at the floor or raises above it.
- `TIER-RAISE-REASON` must name `stay` or `raise`; do not leave the request tier implicit.
- A request raise strengthens the active route, proof, and acceptance path while preserving the project floor.
- Tier reduces unnecessary governance burden only inside the preserved proof and acceptance floor.
- Decisive user-surface proof remains fixed by the promised delivery surface.
## Governance Parameters Per Tier Table
| Parameter | Lightweight | Standard | Precision |
|---|---|---|---|
| **Default review/proof depth** | `reviewer` gate | `reviewer` + `tester` | `reviewer` + `tester` + `validator` |
| **Review scope** | Code quality | + architecture consistency | + security (`security-review`) + infrastructure |
| **Testing requirements** | Basic verification | Structured testing | E2E + security + performance |
| **Documentation required** | Minimal (inline) | Feature-specific docs | Architecture + design + API docs |
| **Default team size** | 1–2 agents | 2–3 agents | Precision 5-lane deployment |
| **Design options** | Conditional | Default | Required (3 architecture options) |
| **User-input checkpoint candidates** | CP4 only when implementation approval is truly user-owned | CP1, CP3, CP4 only when evidence leaves a true user-owned decision | CP1-CP5 only when evidence leaves a true user-owned decision |
| **Gap analysis** | Conditional | Default | Required before acceptance |
| **Specialist skills** | None by default | `dev-workflow`; add `external-tool-bridge` when external capability is active | `dev-workflow`; add `security-review`, `enterprise-architecture`, or `external-tool-bridge` only when each skill's activation criteria is true |
### Checkpoint Semantics
Checkpoint semantics (CP1-CP5) are defined by dev-workflow when active. This skill sizes where user input becomes relevant. Checkpoints and phase gates remain governed by their owning workflow. dev-workflow mandatory checkpoints still execute at all tiers and auto-resolve when doctrine, frozen request basis, and evidence decide the best owner path.
Acceptance-depth semantics: the table sizes default review and proof depth for project governance. The validator lane retains final `PASS/HOLD/FAIL` authority when a final validation verdict is required by role separation, task risk, or the active workflow.
## Quality Metrics Table
| Metric | Description | Use |
|---|---|---|
| **Design-implementation match score** | How well does the code match the design doc? (0–100 per file or component) | Feed into team-lead's decision to iterate, escalate, or proceed to acceptance |
| **Coverage indicator** | Percentage of design requirements with corresponding implementation | Identify unimplemented surfaces before routing to acceptance chain |
### Governance Trust Score (Input Signal)
A composite score gives team-lead a quantitative view of project quality trends. This is an INPUT SIGNAL. Tier and approval-gate changes require owner judgment and direct evidence.
**5 Components (100-point scale):**
| Component | Weight | Measures |
|---|---|---|
| Phase completion rate | 25 pts | How often do development phases complete with no rollback? |
| Quality check pass rate | 25 pts | What percentage of reviews/tests pass on first attempt? |
| Error recovery rate | 20 pts | When issues occur, how quickly and cleanly are they resolved? |
| Iteration efficiency | 15 pts | How many iteration cycles needed before acceptance? (fewer = better) |
| Scope stability | 15 pts | How often does scope change after plan approval? (less change = better) |
**Score Interpretation (advisory only):**
| Range | Signal | Team-Lead Action |
|---|---|---|
| 86-100 | Strong execution | Reduce oversight only after direct evidence confirms routine low-risk work |
| 71-85 | Healthy | Standard governance appropriate |
| 51-70 | Needs attention | Increase checkpoint frequency, review depth |
| 31-50 | Concerning | Full governance pipeline for all work, root cause analysis |
| 0-30 | Critical | Pause and reassess project approach with user |
**Rules:**
- Score is advisory for tier review.
- Score changes are reported to team-lead as trend signals.
- Team-lead uses score alongside direct evidence and user feedback
- Score calculation happens at phase transitions, not continuously
- If score and direct evidence disagree, direct evidence wins

## Resolve Next Owner And Action
- Return governance tier signals, scoring trend, direct-evidence conflicts, and oversight recommendations to the active governance-scaling workflow.
- If scaling changes phase gates, checkpoint frequency, lane use, or review depth, reopen the owning planning path before execution continues.
