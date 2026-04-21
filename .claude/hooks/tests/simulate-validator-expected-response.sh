#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
"use strict";

const scenarios = [
  {
    id: "small-clean-verdict",
    title: "Bounded validator packet with clean upstream evidence",
    burden: 42,
    multiPhase: false,
    blockingUpstream: false,
    missingUserSurface: false,
    contradiction: false,
    unchangedRetry: false,
    reconciliationMissing: false,
  },
  {
    id: "overscoped-validation-packet",
    title: "Validator packet that mixes verdict, proof gathering, and remediation closure",
    burden: 122,
    multiPhase: true,
    blockingUpstream: false,
    missingUserSurface: false,
    contradiction: false,
    unchangedRetry: false,
    reconciliationMissing: false,
  },
  {
    id: "blocking-upstream-temptation",
    title: "Reviewer/tester blockers present but polished output tempts PASS",
    burden: 68,
    multiPhase: false,
    blockingUpstream: true,
    missingUserSurface: false,
    contradiction: false,
    unchangedRetry: false,
    reconciliationMissing: false,
  },
  {
    id: "missing-user-surface",
    title: "Only lower-level support evidence exists for user-facing acceptance",
    burden: 64,
    multiPhase: false,
    blockingUpstream: false,
    missingUserSurface: true,
    contradiction: false,
    unchangedRetry: false,
    reconciliationMissing: true,
  },
  {
    id: "contradictory-upstream",
    title: "Reviewer and tester evidence point in different acceptance directions",
    burden: 58,
    multiPhase: false,
    blockingUpstream: true,
    missingUserSurface: false,
    contradiction: true,
    unchangedRetry: false,
    reconciliationMissing: true,
  },
  {
    id: "verdict-retry-no-change",
    title: "Repeated validation pass without changed evidence",
    burden: 55,
    multiPhase: false,
    blockingUpstream: false,
    missingUserSurface: false,
    contradiction: false,
    unchangedRetry: true,
    reconciliationMissing: false,
  },
];

const bundles = [
  {
    id: "baseline",
    title: "Current baseline",
    receiptOverscopeGate: false,
    verdictMonotonicity: false,
    retryEscalation: false,
  },
  {
    id: "receipt-gate",
    title: "Validator receipt overscope gate",
    receiptOverscopeGate: true,
    verdictMonotonicity: false,
    retryEscalation: false,
  },
  {
    id: "verdict-guard",
    title: "Validator verdict monotonicity guard",
    receiptOverscopeGate: false,
    verdictMonotonicity: true,
    retryEscalation: true,
  },
  {
    id: "validator-structural-core",
    title: "Receipt gate + verdict monotonicity",
    receiptOverscopeGate: true,
    verdictMonotonicity: true,
    retryEscalation: true,
  },
];

function simulate(scenario, bundle) {
  const budget = 100;
  const events = ["dispatch-ack"];
  const reasons = [];
  const overscoped = scenario.burden > budget || scenario.multiPhase;

  if (bundle.receiptOverscopeGate && overscoped) {
    events.push("scope-pressure");
    events.push("replan-proposal: keep-validator-verdict-only + route-proof/remediation-to-owning-lane");
    return {
      outcome: "hold-before-execution",
      events,
      reasons: ["validator-caught-overscope"],
    };
  }

  events.push("inspect-evidence");

  if (scenario.blockingUpstream) {
    if (bundle.verdictMonotonicity) {
      events.push("hold-keeps-upstream-blockers-explicit");
      reasons.push("upstream-blockers-preserved");
      if (scenario.contradiction) reasons.push("contradiction-routed-for-resolution");
      return { outcome: "hold-on-blockers", events, reasons };
    }
    events.push("softened-pass-despite-blockers");
    reasons.push("upstream-blockers-softened");
    return { outcome: "softened-pass", events, reasons };
  }

  if (scenario.missingUserSurface || scenario.reconciliationMissing) {
    if (bundle.verdictMonotonicity) {
      events.push("hold-missing-acceptance-reconciliation");
      reasons.push("acceptance-surface-insufficient");
      return { outcome: "hold-missing-acceptance-surface", events, reasons };
    }
    events.push("pass-on-lower-evidence");
    reasons.push("user-surface-gap-softened");
    return { outcome: "softened-pass", events, reasons };
  }

  if (scenario.unchangedRetry) {
    if (bundle.retryEscalation) {
      events.push("hold-after-unchanged-verdict-retry");
      reasons.push("unchanged-evidence-escalated");
      return { outcome: "hold-after-retry", events, reasons };
    }
    events.push("retry-stronger-verdict-without-new-evidence");
    reasons.push("retry-monotonicity-broken");
    return { outcome: "softened-pass", events, reasons };
  }

  events.push("handoff-pass");
  return { outcome: "clean-pass", events, reasons };
}

const rows = [];
for (const scenario of scenarios) {
  for (const bundle of bundles) {
    rows.push({
      scenario: scenario.id,
      bundle: bundle.id,
      ...simulate(scenario, bundle),
    });
  }
}

for (const scenario of scenarios) {
  console.log(`\n=== ${scenario.id} :: ${scenario.title} ===`);
  for (const row of rows.filter((item) => item.scenario === scenario.id)) {
    console.log(
      `${row.bundle.padEnd(26, " ")} | outcome=${row.outcome.padEnd(30, " ")} | events=${row.events.join(" -> ")} | reasons=${row.reasons.join(",") || "none"}`,
    );
  }
}

const assertions = [];
function assert(label, condition) {
  assertions.push({ label, ok: Boolean(condition) });
}

function get(scenarioId, bundleId) {
  return rows.find((row) => row.scenario === scenarioId && row.bundle === bundleId);
}

assert(
  "receipt gate stops overscoped validation before execution",
  get("overscoped-validation-packet", "receipt-gate").outcome === "hold-before-execution",
);
assert(
  "verdict guard preserves upstream blockers instead of softening PASS",
  get("blocking-upstream-temptation", "verdict-guard").outcome === "hold-on-blockers",
);
assert(
  "baseline softens missing acceptance surface into PASS-like outcome",
  get("missing-user-surface", "baseline").outcome === "softened-pass",
);
assert(
  "verdict guard holds when acceptance reconciliation is missing",
  get("missing-user-surface", "verdict-guard").outcome === "hold-missing-acceptance-surface",
);
assert(
  "validator structural core routes contradiction to HOLD",
  get("contradictory-upstream", "validator-structural-core").outcome === "hold-on-blockers",
);
assert(
  "retry escalation prevents stronger verdict without new evidence",
  get("verdict-retry-no-change", "validator-structural-core").outcome === "hold-after-retry",
);
assert(
  "clean packet remains clean under structural core",
  get("small-clean-verdict", "validator-structural-core").outcome === "clean-pass",
);

console.log("\n=== assertions ===");
for (const item of assertions) {
  console.log(`${item.ok ? "PASS" : "FAIL"} ${item.label}`);
}

if (assertions.some((item) => !item.ok)) process.exit(1);
NODE
