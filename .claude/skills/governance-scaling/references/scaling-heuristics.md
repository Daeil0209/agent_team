---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
---

# Reference Material
## Detection Heuristics Table
These signals indicate a likely tier. They are suggestions for `team-lead` judgment, not automatic project-tier authority. Project-level governance parameters apply only after the project floor is frozen and consumed explicitly. Per-request handling may still be raised autonomously when direct risk signals require a stricter task tier.
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
Local-app fast-path boundary: delivery-surface proof can never be downshifted by tier. A Lightweight local app may use fewer agents and fewer design options, but if it promises double-click/low-touch/browser UI operation, the real launch path and first usable view remain acceptance-critical.
## Freeze And Consume Wiring
When governance depth is active, freeze and consume these fields explicitly:
- `PROJECT-TIER`
- `ACTIVE-REQUEST-TIER`
- `TIER-RAISE-REASON`

Rules:
- `PROJECT-TIER` is the project floor.
- `ACTIVE-REQUEST-TIER` is the current request tier and may stay at the floor or raise above it.
- `TIER-RAISE-REASON` must name `stay` or `raise`; do not leave the request tier implicit.
- A request raise strengthens the active route, proof, and acceptance path without silently rewriting the project floor.
- Tier may reduce unnecessary governance burden, but it must never downshift decisive user-surface proof.
## Governance Parameters Per Tier Table
| Parameter | Lightweight | Standard | Precision |
|---|---|---|---|
| **Default review/proof depth** | `reviewer` gate | `reviewer` + `tester` | `reviewer` + `tester` + `validator` |
| **Review scope** | Code quality | + architecture consistency | + security (`security-review`) + infrastructure |
| **Testing requirements** | Basic verification | Structured testing | E2E + security + performance |
| **Documentation required** | Minimal (inline) | Feature-specific docs | Architecture + design + API docs |
| **Recommended team size** | 1–2 agents | 2–3 agents | Precision 5-lane deployment |
| **Design options** | Optional | Recommended | Required (3 architecture options) |
| **User-input checkpoint candidates** | CP4 only when implementation approval is truly user-owned | CP1, CP3, CP4 only when evidence leaves a true user-owned decision | CP1-CP5 only when evidence leaves a true user-owned decision |
| **Gap analysis** | Optional | Recommended | Required before acceptance |
| **Specialist skills** | None by default | `dev-workflow`; add `external-tool-bridge` when external capability is active | `dev-workflow` + `security-review` + `enterprise-architecture`; add `external-tool-bridge` when external capability is active |
### Checkpoint Semantics
Checkpoint semantics (CP1-CP5) are defined by dev-workflow when active. This skill sizes where user input may become relevant; it does not convert checkpoints or phase gates into user-confirmation stops. dev-workflow mandatory checkpoints still execute at all tiers and auto-resolve when doctrine, frozen request basis, and evidence decide the best owner path.
Acceptance-depth semantics: the table sizes default review and proof depth for project governance. It does not transfer final `PASS/HOLD/FAIL` authority away from the validator lane when a final validation verdict is required by role separation, task risk, or the active workflow.
## Quality Metrics Table
| Metric | Description | Use |
|---|---|---|
| **Design-implementation match score** | How well does the code match the design doc? (0–100 per file or component) | Feed into team-lead's decision to iterate, escalate, or proceed to acceptance |
| **Coverage indicator** | Percentage of design requirements with corresponding implementation | Identify unimplemented surfaces before routing to acceptance chain |
### Governance Trust Score (Input Signal)
A composite score that gives team-lead a quantitative view of project quality trends. This is an INPUT SIGNAL — it does NOT automatically change governance tier or approval gates.
**5 Components (100-point scale):**
| Component | Weight | Measures |
|---|---|---|
| Phase completion rate | 25 pts | How often do development phases complete without rollback? |
| Quality check pass rate | 25 pts | What percentage of reviews/tests pass on first attempt? |
| Error recovery rate | 20 pts | When issues occur, how quickly and cleanly are they resolved? |
| Iteration efficiency | 15 pts | How many iteration cycles needed before acceptance? (fewer = better) |
| Scope stability | 15 pts | How often does scope change after plan approval? (less change = better) |
**Score Interpretation (advisory only):**
| Range | Signal | Team-Lead Action |
|---|---|---|
| 86-100 | Strong execution | Consider lighter oversight for routine work |
| 71-85 | Healthy | Standard governance appropriate |
| 51-70 | Needs attention | Increase checkpoint frequency, review depth |
| 31-50 | Concerning | Full governance pipeline for all work, root cause analysis |
| 0-30 | Critical | Pause and reassess project approach with user |
**Rules:**
- Score is NEVER used to auto-promote or auto-demote governance tier
- Score changes are reported to team-lead as trend signals, not commands
- Team-lead uses score alongside direct evidence and user feedback
- Score calculation happens at phase transitions, not continuously
- If score and direct evidence disagree, direct evidence wins
