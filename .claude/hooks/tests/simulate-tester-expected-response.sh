#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
"use strict";

const scenarios = [
  {
    id: "small-clean-packet",
    title: "Small bounded packet",
    burden: 42,
    multiPhase: false,
    largeSurface: false,
    toolStrict: false,
    hookFriction: false,
    adaptivePathAvailable: false,
  },
  {
    id: "incident-like-overscope",
    title: "Overscoped tester packet like #5b",
    burden: 122,
    multiPhase: true,
    largeSurface: false,
    toolStrict: true,
    hookFriction: true,
    adaptivePathAvailable: true,
  },
  {
    id: "overscope-no-hook",
    title: "Overscoped packet without hook friction",
    burden: 112,
    multiPhase: true,
    largeSurface: false,
    toolStrict: false,
    hookFriction: false,
    adaptivePathAvailable: false,
  },
  {
    id: "large-proof-surface",
    title: "Inevitable large proof surface",
    burden: 138,
    multiPhase: true,
    largeSurface: true,
    toolStrict: false,
    hookFriction: false,
    adaptivePathAvailable: false,
  },
  {
    id: "contract-drift-temptation",
    title: "Tool contract mismatch with tempting adaptive workaround",
    burden: 74,
    multiPhase: false,
    largeSurface: false,
    toolStrict: true,
    hookFriction: true,
    adaptivePathAvailable: true,
  },
];

const patchBundles = [
  {
    id: "baseline",
    title: "Current baseline",
    receiptOverscopeGate: false,
    contractFidelityGate: false,
    leadAcceptanceBackstop: false,
  },
  {
    id: "receipt-gate",
    title: "Tester receipt overscope gate",
    receiptOverscopeGate: true,
    contractFidelityGate: false,
    leadAcceptanceBackstop: false,
  },
  {
    id: "receipt-plus-contract",
    title: "Tester receipt gate + contract fidelity gate",
    receiptOverscopeGate: true,
    contractFidelityGate: true,
    leadAcceptanceBackstop: false,
  },
  {
    id: "lead-backstop-only",
    title: "Lead acceptance backstop only",
    receiptOverscopeGate: false,
    contractFidelityGate: false,
    leadAcceptanceBackstop: true,
  },
  {
    id: "full-backstop",
    title: "Tester gates + lead acceptance backstop",
    receiptOverscopeGate: true,
    contractFidelityGate: true,
    leadAcceptanceBackstop: true,
  },
];

function simulate(scenario, bundle) {
  const budget = 100;
  const events = [];
  let outcome = "clean-handoff";
  const reasons = [];

  events.push("dispatch-ack");

  const overscoped =
    scenario.burden > budget || scenario.multiPhase || scenario.largeSurface;

  if (bundle.receiptOverscopeGate && overscoped) {
    events.push("scope-pressure");
    if (scenario.largeSurface) {
      events.push("replan-proposal: shard-browser-proof + merge-owner");
    } else if (scenario.multiPhase) {
      events.push("replan-proposal: split env-proof/report");
    } else {
      events.push("replan-proposal: narrow proof target");
    }
    outcome = "hold-before-execution";
    reasons.push("tester-caught-overscope");
    return { outcome, events, reasons };
  }

  events.push("execute-proof");

  if (scenario.hookFriction) {
    reasons.push("hook-friction");
    if (scenario.adaptivePathAvailable) {
      events.push("adaptive-workaround");
      reasons.push("adaptive-path-used");
    } else {
      events.push("blocked-no-workaround");
      outcome = "blocked";
      return { outcome, events, reasons };
    }
  }

  if (scenario.toolStrict && scenario.adaptivePathAvailable) {
    if (bundle.contractFidelityGate) {
      events.push("handoff-with-mismatch");
      outcome = "partial-truthful-mismatch";
      reasons.push("contract-drift-downgraded");
    } else {
      events.push("handoff-softened-as-matched");
      outcome = "softened-mismatch";
      reasons.push("contract-drift-softened");
    }
  } else if (overscoped) {
    events.push("handoff-after-overload");
    outcome = "costly-compliance";
    reasons.push("overscope-executed");
  } else {
    events.push("handoff-clean");
    outcome = "clean-handoff";
  }

  if (
    outcome === "softened-mismatch" &&
    bundle.leadAcceptanceBackstop
  ) {
    events.push("lead-rejects-softened-handoff");
    outcome = "lead-rejected-softening";
    reasons.push("lead-backstop-fired");
  }

  return { outcome, events, reasons };
}

const rows = [];
for (const scenario of scenarios) {
  for (const bundle of patchBundles) {
    rows.push({
      scenario: scenario.id,
      bundle: bundle.id,
      ...simulate(scenario, bundle),
    });
  }
}

function printScenario(id, title) {
  console.log(`\n=== ${id} :: ${title} ===`);
  for (const row of rows.filter((r) => r.scenario === id)) {
    console.log(
      `${row.bundle.padEnd(24, " ")} | outcome=${row.outcome.padEnd(24, " ")} | events=${row.events.join(" -> ")} | reasons=${row.reasons.join(",") || "none"}`,
    );
  }
}

for (const scenario of scenarios) {
  printScenario(scenario.id, scenario.title);
}

const assertions = [];
function assert(label, condition) {
  assertions.push({ label, ok: Boolean(condition) });
}

function get(scenarioId, bundleId) {
  return rows.find((row) => row.scenario === scenarioId && row.bundle === bundleId);
}

assert(
  "receipt gate stops overscope before execution",
  get("incident-like-overscope", "receipt-gate").outcome === "hold-before-execution",
);
assert(
  "receipt gate proposes replanning on large surface",
  get("large-proof-surface", "receipt-gate").events.includes(
    "replan-proposal: shard-browser-proof + merge-owner",
  ),
);
assert(
  "baseline softens contract drift when no contract gate exists",
  get("contract-drift-temptation", "baseline").outcome === "softened-mismatch",
);
assert(
  "contract gate forces truthful partial mismatch",
  get("contract-drift-temptation", "receipt-plus-contract").outcome ===
    "partial-truthful-mismatch",
);
assert(
  "lead backstop alone rejects softened mismatch, but only after execution",
  get("contract-drift-temptation", "lead-backstop-only").outcome ===
    "lead-rejected-softening",
);
assert(
  "full backstop keeps the mismatch truthful before acceptance",
  get("contract-drift-temptation", "full-backstop").outcome ===
    "partial-truthful-mismatch",
);
assert(
  "small clean packet still proceeds cleanly under full backstop",
  get("small-clean-packet", "full-backstop").outcome === "clean-handoff",
);

console.log("\n=== assertions ===");
for (const a of assertions) {
  console.log(`${a.ok ? "PASS" : "FAIL"} ${a.label}`);
}

if (assertions.some((a) => !a.ok)) process.exit(1);
NODE
