#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
"use strict";

const scenarios = [
  {
    id: "bounded-clean",
    title: "Bounded validator assignment",
    burden: 44,
    phaseIntents: 1,
    blockingUpstream: false,
    userSurfaceGap: false,
    contradiction: false,
    unchangedRetry: false,
    reconciliationMissing: false,
  },
  {
    id: "mixed-phase-verdict-overload",
    title: "Validation packet mixes verdict, proof gathering, and remediation closure",
    burden: 126,
    phaseIntents: 4,
    blockingUpstream: false,
    userSurfaceGap: false,
    contradiction: false,
    unchangedRetry: false,
    reconciliationMissing: false,
  },
  {
    id: "blocking-upstream",
    title: "Blocking reviewer/tester state still present",
    burden: 72,
    phaseIntents: 1,
    blockingUpstream: true,
    userSurfaceGap: false,
    contradiction: false,
    unchangedRetry: false,
    reconciliationMissing: false,
  },
  {
    id: "user-surface-gap",
    title: "User-facing acceptance lacks required user-surface evidence",
    burden: 66,
    phaseIntents: 1,
    blockingUpstream: false,
    userSurfaceGap: true,
    contradiction: false,
    unchangedRetry: false,
    reconciliationMissing: true,
  },
  {
    id: "contradictory-upstream",
    title: "Conflicting reviewer/tester acceptance signals",
    burden: 61,
    phaseIntents: 1,
    blockingUpstream: true,
    userSurfaceGap: false,
    contradiction: true,
    unchangedRetry: false,
    reconciliationMissing: true,
  },
  {
    id: "unchanged-retry",
    title: "Repeated verdict attempt without changed evidence",
    burden: 54,
    phaseIntents: 1,
    blockingUpstream: false,
    userSurfaceGap: false,
    contradiction: false,
    unchangedRetry: true,
    reconciliationMissing: false,
  },
];

const bundles = [
  {
    id: "baseline",
    title: "Current behavior",
    intakeSizing: false,
    verdictMonotonicity: false,
    contradictionHold: false,
    retryEscalation: false,
    reconciliationRequired: false,
  },
  {
    id: "receipt-gate",
    title: "Receipt overscope gate only",
    intakeSizing: true,
    verdictMonotonicity: false,
    contradictionHold: false,
    retryEscalation: false,
    reconciliationRequired: false,
  },
  {
    id: "verdict-truth",
    title: "Verdict monotonicity only",
    intakeSizing: false,
    verdictMonotonicity: true,
    contradictionHold: true,
    retryEscalation: true,
    reconciliationRequired: true,
  },
  {
    id: "validator-structural-core",
    title: "Intake + verdict monotonicity",
    intakeSizing: true,
    verdictMonotonicity: true,
    contradictionHold: true,
    retryEscalation: true,
    reconciliationRequired: true,
  },
];

function simulate(scenario, bundle) {
  const events = ["dispatch-ack"];
  const reasons = [];
  const budget = 100;
  const overscoped = scenario.burden > budget || scenario.phaseIntents > 1;

  if (bundle.intakeSizing && overscoped) {
    events.push("scope-pressure");
    events.push("replan: keep-validator-on-verdict-route-missing-proof-to-owner");
    return {
      outcome: "hold-with-replan",
      validatorBehavior: "expected",
      reasons: ["overscope-caught", "validator-kept-single-purpose"],
      events,
    };
  }

  events.push("inspect-evidence");

  if (scenario.blockingUpstream) {
    if (bundle.verdictMonotonicity) {
      events.push("keep-blockers-explicit");
      if (scenario.contradiction && bundle.contradictionHold) {
        events.push("hold-on-contradiction");
        return {
          outcome: "hold-contradiction",
          validatorBehavior: "expected",
          reasons: ["upstream-blockers-preserved", "contradiction-not-softened"],
          events,
        };
      }
      events.push("hold-on-blockers");
      return {
        outcome: "hold-blockers-explicit",
        validatorBehavior: "expected",
        reasons: ["upstream-blockers-preserved"],
        events,
      };
    }

    events.push("softened-pass-despite-blockers");
    return {
      outcome: "softened-pass",
      validatorBehavior: "unexpected",
      reasons: ["upstream-blockers-softened"],
      events,
    };
  }

  if (scenario.userSurfaceGap || scenario.reconciliationMissing) {
    if (bundle.reconciliationRequired) {
      events.push("hold-missing-acceptance-reconciliation");
      return {
        outcome: "hold-missing-acceptance-surface",
        validatorBehavior: "expected",
        reasons: ["acceptance-reconciliation-required"],
        events,
      };
    }

    events.push("pass-on-lower-evidence");
    return {
      outcome: "softened-pass",
      validatorBehavior: "unexpected",
      reasons: ["acceptance-surface-softened"],
      events,
    };
  }

  if (scenario.unchangedRetry) {
    if (bundle.retryEscalation) {
      events.push("hold-after-unchanged-retry");
      return {
        outcome: "hold-after-retry",
        validatorBehavior: "expected",
        reasons: ["retry-escalated"],
        events,
      };
    }

    events.push("retry-stronger-verdict-without-new-evidence");
    return {
      outcome: "softened-pass",
      validatorBehavior: "weak",
      reasons: ["retry-monotonicity-broken"],
      events,
    };
  }

  events.push("handoff-pass");
  return {
    outcome: "clean-pass",
    validatorBehavior: "expected",
    reasons,
    events,
  };
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
      `${row.bundle.padEnd(26, " ")} | behavior=${row.validatorBehavior.padEnd(10, " ")} | outcome=${row.outcome.padEnd(32, " ")} | events=${row.events.join(" -> ")} | reasons=${row.reasons.join(",") || "none"}`,
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
  "receipt gate yields replan before execution on mixed validation overload",
  get("mixed-phase-verdict-overload", "receipt-gate").outcome === "hold-with-replan",
);
assert(
  "verdict truth preserves blocking upstream state",
  get("blocking-upstream", "verdict-truth").outcome === "hold-blockers-explicit",
);
assert(
  "verdict truth holds when user-surface acceptance is missing",
  get("user-surface-gap", "verdict-truth").outcome === "hold-missing-acceptance-surface",
);
assert(
  "verdict truth holds on contradictory upstream evidence",
  get("contradictory-upstream", "verdict-truth").outcome === "hold-contradiction",
);
assert(
  "baseline softens blocking state into pass-like outcome",
  get("blocking-upstream", "baseline").outcome === "softened-pass",
);
assert(
  "structural core escalates unchanged retry instead of strengthening verdict",
  get("unchanged-retry", "validator-structural-core").outcome === "hold-after-retry",
);
assert(
  "bounded packet remains clean under structural core",
  get("bounded-clean", "validator-structural-core").outcome === "clean-pass",
);

console.log("\n=== assertions ===");
for (const item of assertions) {
  console.log(`${item.ok ? "PASS" : "FAIL"} ${item.label}`);
}

if (assertions.some((item) => !item.ok)) process.exit(1);
NODE
