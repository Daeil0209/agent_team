#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
"use strict";

const lanes = [
  {
    id: "developer",
    boundedMax: 90,
    acceptsMixedPhase: false,
    requiresBoundary: true,
    requiresRerouteForExternalOwners: true,
  },
  {
    id: "reviewer",
    boundedMax: 80,
    acceptsMixedPhase: false,
    requiresBoundary: true,
    requiresRerouteForExternalOwners: true,
  },
  {
    id: "researcher",
    boundedMax: 95,
    acceptsMixedPhase: false,
    requiresBoundary: true,
    requiresRerouteForExternalOwners: true,
  },
  {
    id: "tester",
    boundedMax: 90,
    acceptsMixedPhase: false,
    requiresBoundary: true,
    requiresRerouteForExternalOwners: true,
  },
  {
    id: "validator",
    boundedMax: 85,
    acceptsMixedPhase: false,
    requiresBoundary: true,
    requiresRerouteForExternalOwners: true,
  },
];

const scenarios = [
  {
    id: "bounded-clean",
    title: "Single-phase bounded packet",
    burden: 48,
    phaseIntents: 1,
    missingBoundary: false,
    contradictoryContract: false,
    externalOwnerAbsorption: false,
    unavoidableLarge: false,
    expected: {
      developer: "execute",
      reviewer: "execute",
      researcher: "execute",
      tester: "execute",
      validator: "execute",
    },
  },
  {
    id: "mixed-phase-overload",
    title: "Implementation + review + proof + validation mixed together",
    burden: 132,
    phaseIntents: 4,
    missingBoundary: false,
    contradictoryContract: false,
    externalOwnerAbsorption: true,
    unavoidableLarge: false,
    expected: {
      developer: "claim-replan",
      reviewer: "claim-replan",
      researcher: "claim-replan",
      tester: "claim-replan",
      validator: "claim-replan",
    },
  },
  {
    id: "boundary-missing",
    title: "Lane is right but write/review/question boundary is ambiguous",
    burden: 64,
    phaseIntents: 1,
    missingBoundary: true,
    contradictoryContract: false,
    externalOwnerAbsorption: false,
    unavoidableLarge: false,
    expected: {
      developer: "hold",
      reviewer: "hold",
      researcher: "hold",
      tester: "hold",
      validator: "hold",
    },
  },
  {
    id: "contradictory-packet",
    title: "Packet asks for a stronger outcome than visible evidence supports",
    burden: 72,
    phaseIntents: 1,
    missingBoundary: false,
    contradictoryContract: true,
    externalOwnerAbsorption: false,
    unavoidableLarge: false,
    expected: {
      developer: "hold",
      reviewer: "hold",
      researcher: "hold",
      tester: "claim-replan",
      validator: "claim-replan",
    },
  },
  {
    id: "large-but-shardable",
    title: "Large but unavoidable surface that should be split or sharded",
    burden: 146,
    phaseIntents: 2,
    missingBoundary: false,
    contradictoryContract: false,
    externalOwnerAbsorption: false,
    unavoidableLarge: true,
    expected: {
      developer: "claim-replan",
      reviewer: "claim-replan",
      researcher: "claim-replan",
      tester: "claim-replan",
      validator: "claim-replan",
    },
  },
  {
    id: "wrong-lane-absorption",
    title: "Packet asks the lane to absorb another owner's work",
    burden: 70,
    phaseIntents: 2,
    missingBoundary: false,
    contradictoryContract: false,
    externalOwnerAbsorption: true,
    unavoidableLarge: false,
    expected: {
      developer: "claim-replan",
      reviewer: "claim-replan",
      researcher: "claim-replan",
      tester: "claim-replan",
      validator: "claim-replan",
    },
  },
];

const bundles = [
  {
    id: "baseline-current",
    title: "Current mixed state",
    genericScopeGate: true,
    explicitClaimReplan: false,
    laneSpecificContradiction: false,
    shardProposal: false,
    ownerBoundaryReroute: false,
    notes: "developer/reviewer mostly hold-only; tester/validator/researcher stronger",
  },
  {
    id: "hold-only-standard",
    title: "Uniform hold only",
    genericScopeGate: true,
    explicitClaimReplan: false,
    laneSpecificContradiction: true,
    shardProposal: false,
    ownerBoundaryReroute: false,
    notes: "safer than baseline but weak on actionable recovery",
  },
  {
    id: "claim-core-lite",
    title: "Shared scope-pressure plus generic replan",
    genericScopeGate: true,
    explicitClaimReplan: true,
    laneSpecificContradiction: false,
    shardProposal: false,
    ownerBoundaryReroute: true,
    notes: "better recovery but still under-classifies contradictions and large-surface shards",
  },
  {
    id: "shared-receipt-claim-core",
    title: "Shared receipt-claim core with lane adapters",
    genericScopeGate: true,
    explicitClaimReplan: true,
    laneSpecificContradiction: true,
    shardProposal: true,
    ownerBoundaryReroute: true,
    notes: "execute bounded work; claim on overscope/contradiction with concrete reroute or shard proposal",
  },
];

function expectedFor(laneId, scenario) {
  return scenario.expected[laneId];
}

function simulate(lane, scenario, bundle) {
  const reasons = [];
  const events = ["dispatch-ack"];

  const overscoped =
    scenario.burden > lane.boundedMax ||
    scenario.phaseIntents > 1 && !lane.acceptsMixedPhase ||
    scenario.unavoidableLarge;

  const missingBoundary = lane.requiresBoundary && scenario.missingBoundary;
  const contradiction = scenario.contradictoryContract;
  const wrongOwner = lane.requiresRerouteForExternalOwners && scenario.externalOwnerAbsorption;

  if (missingBoundary && bundle.genericScopeGate) {
    events.push("hold");
    reasons.push("boundary-ambiguous");
    return {
      outcome: "hold",
      reasons,
      events,
      score: 82,
    };
  }

  if (contradiction) {
    if (bundle.laneSpecificContradiction && (lane.id === "tester" || lane.id === "validator")) {
      events.push("scope-pressure");
      events.push("replan: contract-truthful-reroute");
      reasons.push("contradiction-classified");
      return {
        outcome: "claim-replan",
        reasons,
        events,
        score: 96,
      };
    }
    if (bundle.genericScopeGate) {
      events.push("hold");
      reasons.push("contradiction-not-rerouted");
      return {
        outcome: "hold",
        reasons,
        events,
        score: bundle.explicitClaimReplan ? 76 : 68,
      };
    }
  }

  if (overscoped || wrongOwner) {
    if (bundle.explicitClaimReplan) {
      events.push("scope-pressure");
      if (wrongOwner && bundle.ownerBoundaryReroute) {
        events.push("replan: reroute-to-owning-lane");
        reasons.push("owner-boundary-reroute");
      } else if (scenario.unavoidableLarge && bundle.shardProposal) {
        events.push("replan: shard-or-split");
        reasons.push("shard-proposal");
      } else {
        events.push("replan: split-phase");
        reasons.push("phase-split");
      }
      return {
        outcome: "claim-replan",
        reasons,
        events,
        score: 94,
      };
    }

    if (bundle.genericScopeGate) {
      events.push("hold");
      reasons.push("overscope-held-without-replan");
      return {
        outcome: "hold",
        reasons,
        events,
        score: 64,
      };
    }
  }

  events.push("execute");
  events.push("clean-handoff");
  return {
    outcome: "execute",
    reasons,
    events,
    score: 92,
  };
}

const rows = [];
for (const lane of lanes) {
  for (const scenario of scenarios) {
    for (const bundle of bundles) {
      const result = simulate(lane, scenario, bundle);
      const expected = expectedFor(lane.id, scenario);
      const correct = result.outcome === expected;
      const score = result.score + (correct ? 8 : -28);
      rows.push({
        lane: lane.id,
        scenario: scenario.id,
        bundle: bundle.id,
        expected,
        ...result,
        correct,
        weightedScore: score,
      });
    }
  }
}

function summarizeBundle(bundleId) {
  const subset = rows.filter((row) => row.bundle === bundleId);
  const correct = subset.filter((row) => row.correct).length;
  const avg = subset.reduce((acc, row) => acc + row.weightedScore, 0) / subset.length;
  const execute = subset.filter((row) => row.outcome === "execute").length;
  const hold = subset.filter((row) => row.outcome === "hold").length;
  const claim = subset.filter((row) => row.outcome === "claim-replan").length;
  return {
    total: subset.length,
    correct,
    accuracy: Math.round((correct / subset.length) * 1000) / 10,
    avgScore: Math.round(avg * 10) / 10,
    execute,
    hold,
    claim,
  };
}

function summarizeLane(laneId, bundleId) {
  const subset = rows.filter((row) => row.lane === laneId && row.bundle === bundleId);
  const correct = subset.filter((row) => row.correct).length;
  return {
    total: subset.length,
    correct,
    accuracy: Math.round((correct / subset.length) * 1000) / 10,
  };
}

console.log("=== bundle-summary ===");
for (const bundle of bundles) {
  const s = summarizeBundle(bundle.id);
  console.log(
    `${bundle.id.padEnd(26)} | accuracy=${String(s.accuracy).padStart(5)}% | avg=${String(s.avgScore).padStart(5)} | execute=${String(s.execute).padStart(2)} | hold=${String(s.hold).padStart(2)} | claim=${String(s.claim).padStart(2)} | ${bundle.notes}`,
  );
}

console.log("\n=== lane-accuracy-by-best-bundles ===");
for (const lane of lanes) {
  const lite = summarizeLane(lane.id, "claim-core-lite");
  const core = summarizeLane(lane.id, "shared-receipt-claim-core");
  console.log(
    `${lane.id.padEnd(10)} | claim-core-lite=${String(lite.accuracy).padStart(5)}% | shared-receipt-claim-core=${String(core.accuracy).padStart(5)}%`,
  );
}

console.log("\n=== mismatches-baseline-current ===");
for (const row of rows.filter((row) => row.bundle === "baseline-current" && !row.correct)) {
  console.log(
    `${row.lane.padEnd(10)} | ${row.scenario.padEnd(22)} | expected=${row.expected.padEnd(12)} | actual=${row.outcome.padEnd(12)} | reasons=${row.reasons.join(",") || "none"}`,
  );
}

console.log("\n=== decisive-mismatches-claim-core-lite ===");
for (const row of rows.filter((row) => row.bundle === "claim-core-lite" && !row.correct)) {
  console.log(
    `${row.lane.padEnd(10)} | ${row.scenario.padEnd(22)} | expected=${row.expected.padEnd(12)} | actual=${row.outcome.padEnd(12)} | reasons=${row.reasons.join(",") || "none"}`,
  );
}

console.log("\n=== shared-core-events ===");
for (const row of rows.filter((row) => row.bundle === "shared-receipt-claim-core")) {
  console.log(
    `${row.lane.padEnd(10)} | ${row.scenario.padEnd(22)} | ${row.outcome.padEnd(12)} | events=${row.events.join(" -> ")}`,
  );
}

const assertions = [];
function assert(label, condition) {
  assertions.push({ label, ok: Boolean(condition) });
}

const baseline = summarizeBundle("baseline-current");
const holdOnly = summarizeBundle("hold-only-standard");
const lite = summarizeBundle("claim-core-lite");
const core = summarizeBundle("shared-receipt-claim-core");

assert("shared-core beats baseline accuracy", core.accuracy > baseline.accuracy);
assert("shared-core beats hold-only accuracy", core.accuracy > holdOnly.accuracy);
assert("shared-core beats lite accuracy", core.accuracy > lite.accuracy);
assert("shared-core preserves bounded execute path", rows.some((row) =>
  row.bundle === "shared-receipt-claim-core" &&
  row.scenario === "bounded-clean" &&
  row.outcome === "execute"
));
assert("shared-core claims mixed-phase overload for developer", rows.some((row) =>
  row.bundle === "shared-receipt-claim-core" &&
  row.lane === "developer" &&
  row.scenario === "mixed-phase-overload" &&
  row.outcome === "claim-replan"
));
assert("shared-core claims mixed-phase overload for reviewer", rows.some((row) =>
  row.bundle === "shared-receipt-claim-core" &&
  row.lane === "reviewer" &&
  row.scenario === "mixed-phase-overload" &&
  row.outcome === "claim-replan"
));
assert("shared-core keeps boundary ambiguity as hold", rows.every((row) =>
  row.bundle !== "shared-receipt-claim-core" ||
  row.scenario !== "boundary-missing" ||
  row.outcome === "hold"
));
assert("shared-core gives tester contradiction claim-replan", rows.some((row) =>
  row.bundle === "shared-receipt-claim-core" &&
  row.lane === "tester" &&
  row.scenario === "contradictory-packet" &&
  row.outcome === "claim-replan"
));
assert("shared-core gives validator contradiction claim-replan", rows.some((row) =>
  row.bundle === "shared-receipt-claim-core" &&
  row.lane === "validator" &&
  row.scenario === "contradictory-packet" &&
  row.outcome === "claim-replan"
));
assert("shared-core gives developer wrong-owner reroute", rows.some((row) =>
  row.bundle === "shared-receipt-claim-core" &&
  row.lane === "developer" &&
  row.scenario === "wrong-lane-absorption" &&
  row.reasons.includes("owner-boundary-reroute")
));
assert("shared-core gives shard proposal for unavoidable large surface", rows.some((row) =>
  row.bundle === "shared-receipt-claim-core" &&
  row.scenario === "large-but-shardable" &&
  row.reasons.includes("shard-proposal")
));

const failures = assertions.filter((item) => !item.ok);
console.log(`\nASSERTIONS_PASSED ${assertions.length - failures.length}`);
if (failures.length) {
  console.log(`ASSERTIONS_FAILED ${failures.length}`);
  for (const item of failures) console.log(` - ${item.label}`);
  process.exit(1);
}
NODE
