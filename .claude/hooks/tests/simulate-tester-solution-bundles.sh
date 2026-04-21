#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
"use strict";

const scenarios = [
  {
    id: "bounded-clean",
    title: "Bounded tester assignment",
    burden: 38,
    phaseIntents: 1,
    proofSurface: "browser-ui",
    strictToolContract: false,
    hookBlocks: 0,
    largeInteractiveSurface: false,
    adaptivePathAvailable: false,
    directInteractionRequired: true,
  },
  {
    id: "mixed-phase-overload",
    title: "Mixed env/proof/report overload like #5b",
    burden: 124,
    phaseIntents: 4,
    proofSurface: "browser-ui",
    strictToolContract: true,
    hookBlocks: 7,
    largeInteractiveSurface: true,
    adaptivePathAvailable: true,
    directInteractionRequired: true,
  },
  {
    id: "large-proof-needs-shards",
    title: "Large interactive proof needing sharding",
    burden: 138,
    phaseIntents: 2,
    proofSurface: "browser-ui",
    strictToolContract: false,
    hookBlocks: 1,
    largeInteractiveSurface: true,
    adaptivePathAvailable: false,
    directInteractionRequired: true,
  },
  {
    id: "tool-contract-drift",
    title: "Tool contract drift temptation",
    burden: 72,
    phaseIntents: 1,
    proofSurface: "browser-ui",
    strictToolContract: true,
    hookBlocks: 3,
    largeInteractiveSurface: true,
    adaptivePathAvailable: true,
    directInteractionRequired: true,
  },
  {
    id: "interaction-gap",
    title: "Navigation-only evidence on interaction-required UI",
    burden: 64,
    phaseIntents: 1,
    proofSurface: "browser-ui",
    strictToolContract: false,
    hookBlocks: 0,
    largeInteractiveSurface: true,
    adaptivePathAvailable: false,
    directInteractionRequired: true,
    interactionCoverageGap: true,
  },
  {
    id: "hook-heavy-but-bounded",
    title: "Bounded assignment with repeated hook friction",
    burden: 58,
    phaseIntents: 1,
    proofSurface: "browser-ui",
    strictToolContract: false,
    hookBlocks: 4,
    largeInteractiveSurface: false,
    adaptivePathAvailable: true,
    directInteractionRequired: true,
  },
];

const bundles = [
  {
    id: "baseline",
    title: "Current behavior",
    intakeSizing: false,
    phaseIntentCheck: false,
    shardProposal: false,
    repeatedBlockEscalation: false,
    toolContractTruth: false,
    interactionTruth: false,
    truthfulHandoffFloor: false,
  },
  {
    id: "overscope-gate",
    title: "Receipt overscope gate only",
    intakeSizing: true,
    phaseIntentCheck: true,
    shardProposal: true,
    repeatedBlockEscalation: false,
    toolContractTruth: false,
    interactionTruth: false,
    truthfulHandoffFloor: false,
  },
  {
    id: "execution-truth",
    title: "Execution truth gates only",
    intakeSizing: false,
    phaseIntentCheck: false,
    shardProposal: false,
    repeatedBlockEscalation: true,
    toolContractTruth: true,
    interactionTruth: true,
    truthfulHandoffFloor: true,
  },
  {
    id: "tester-structural-core",
    title: "Intake + execution truth",
    intakeSizing: true,
    phaseIntentCheck: true,
    shardProposal: true,
    repeatedBlockEscalation: true,
    toolContractTruth: true,
    interactionTruth: true,
    truthfulHandoffFloor: true,
  },
];

function simulate(scenario, bundle) {
  const events = ["dispatch-ack"];
  const reasons = [];
  const burdenBudget = 100;
  const overscoped = scenario.burden > burdenBudget || scenario.phaseIntents > 1;
  const needsShards = scenario.largeInteractiveSurface && scenario.burden > 120;

  if (bundle.intakeSizing && overscoped) {
    events.push("scope-pressure");
    if (needsShards && bundle.shardProposal) {
      events.push("replan: shard-proof + merge-owner");
      return {
        outcome: "hold-with-shard-proposal",
        testerBehavior: "expected",
        reasons: ["overscope-caught", "replanned-for-shards"],
        events,
      };
    }

    if (bundle.phaseIntentCheck) {
      events.push("replan: split-env-proof-report");
      return {
        outcome: "hold-with-replan",
        testerBehavior: "expected",
        reasons: ["overscope-caught", "phase-intent-split"],
        events,
      };
    }
  }

  events.push("execute");

  if (scenario.hookBlocks >= 3) {
    if (bundle.repeatedBlockEscalation) {
      events.push("status-or-hold-after-repeat-block");
      reasons.push("repeat-block-escalated");
    } else {
      events.push("retry-through-hook-friction");
      reasons.push("repeat-block-not-escalated");
    }
  }

  let toolTruth = "matched";
  if (scenario.strictToolContract && scenario.adaptivePathAvailable) {
    if (bundle.toolContractTruth) {
      toolTruth = "mismatched";
      reasons.push("tool-contract-drift-classified");
      events.push("adaptive-proof-with-mismatch-label");
    } else {
      toolTruth = "softened";
      reasons.push("tool-contract-drift-softened");
      events.push("adaptive-proof-softened-as-match");
    }
  }

  let interactionTruth = "matched";
  if (scenario.interactionCoverageGap) {
    if (bundle.interactionTruth) {
      interactionTruth = "partial";
      reasons.push("interaction-gap-classified");
      events.push("interaction-gap-labeled");
    } else {
      interactionTruth = "softened";
      reasons.push("interaction-gap-softened");
      events.push("interaction-gap-softened-as-match");
    }
  }

  if (bundle.truthfulHandoffFloor && (toolTruth !== "matched" || interactionTruth !== "matched")) {
    events.push("handoff-partial-truthful");
    return {
      outcome: "truthful-partial-handoff",
      testerBehavior: "expected",
      reasons,
      events,
    };
  }

  if (overscoped && !bundle.intakeSizing) {
    events.push("handoff-after-overload");
    reasons.push("overscope-executed");
  }

  if (toolTruth === "softened" || interactionTruth === "softened") {
    events.push("softened-handoff");
    return {
      outcome: "softened-handoff",
      testerBehavior: "unexpected",
      reasons,
      events,
    };
  }

  if (reasons.includes("repeat-block-not-escalated")) {
    events.push("costly-handoff");
    return {
      outcome: "costly-but-complete",
      testerBehavior: "weak",
      reasons,
      events,
    };
  }

  events.push("clean-handoff");
  return {
    outcome: "clean-handoff",
    testerBehavior: "expected",
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
      `${row.bundle.padEnd(24, " ")} | behavior=${row.testerBehavior.padEnd(10, " ")} | outcome=${row.outcome.padEnd(26, " ")} | events=${row.events.join(" -> ")} | reasons=${row.reasons.join(",") || "none"}`,
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
  "overscope gate yields replanning before execution on mixed-phase overload",
  ["hold-with-replan", "hold-with-shard-proposal"].includes(
    get("mixed-phase-overload", "overscope-gate").outcome,
  ),
);
assert(
  "structural core yields shard proposal on very large proof",
  get("large-proof-needs-shards", "tester-structural-core").outcome ===
    "hold-with-shard-proposal",
);
assert(
  "execution truth classifies tool drift as truthful partial",
  get("tool-contract-drift", "execution-truth").outcome === "truthful-partial-handoff",
);
assert(
  "execution truth classifies interaction gap as truthful partial",
  get("interaction-gap", "execution-truth").outcome === "truthful-partial-handoff",
);
assert(
  "baseline softens tool drift",
  get("tool-contract-drift", "baseline").outcome === "softened-handoff",
);
assert(
  "baseline retries through repeated hook friction",
  get("hook-heavy-but-bounded", "baseline").outcome === "costly-but-complete",
);
assert(
  "structural core escalates repeated hook friction instead of silently retrying",
  get("hook-heavy-but-bounded", "tester-structural-core").events.includes(
    "status-or-hold-after-repeat-block",
  ),
);
assert(
  "bounded packet remains clean under structural core",
  get("bounded-clean", "tester-structural-core").outcome === "clean-handoff",
);

console.log("\n=== assertions ===");
for (const assertion of assertions) {
  console.log(`${assertion.ok ? "PASS" : "FAIL"} ${assertion.label}`);
}

if (assertions.some((assertion) => !assertion.ok)) process.exit(1);
NODE
