#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/hook-config.sh"

INPUT="$(cat)"

INPUT_JSON="$INPUT" CLAUDE_HOME="$HOME/.claude" node <<'NODE'
const fs = require("fs");
const path = require("path");

const deny = (reason) => {
  process.stdout.write(JSON.stringify({
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: reason
    }
  }));
};

const normalize = (value) => String(value || "").trim().toLowerCase();

const tryParseJson = (value) => {
  try {
    return JSON.parse(value);
  } catch {
    return null;
  }
};

try {
  const input = JSON.parse(process.env.INPUT_JSON || "{}");
  const toolName = String(input.tool_name || "");
  const toolInput = input.tool_input || {};
  const taskId = String(toolInput.task_id || toolInput.taskId || toolInput.id || "").trim();
  const inputTeamName = String(input.team_name || input.teamName || toolInput.team_name || toolInput.teamName || "").trim();
  const claudeHome = process.env.CLAUDE_HOME || path.join(process.env.HOME || "", ".claude");
  const targetedTools = new Set(["TaskGet", "TaskUpdate", "TaskOutput", "TaskStop"]);

  if (!targetedTools.has(toolName)) {
    process.exit(0);
  }

  if (!taskId) {
    let reason = `${toolName} requires an explicit task id. Use the taskId from the task_assignment packet or inspect TaskList/TaskGet first.`;
    if (toolName === "TaskOutput") {
      reason += " TaskOutput is deprecated upstream; prefer Read on the background task output path when the runtime provides it.";
    }
    deny(reason);
    process.exit(0);
  }

  const taskRoot = path.join(claudeHome, "tasks");
  const teamRoot = path.join(claudeHome, "teams");

  const orderedUnique = (values) => {
    const seen = new Set();
    const ordered = [];
    for (const value of values) {
      if (!value || seen.has(value)) {
        continue;
      }
      seen.add(value);
      ordered.push(value);
    }
    return ordered;
  };

  const readDirectoryNames = (dirPath) => {
    try {
      return fs.readdirSync(dirPath, { withFileTypes: true })
        .filter((entry) => entry.isDirectory())
        .map((entry) => entry.name);
    } catch {
      return [];
    }
  };

  const taskTeamDirs = readDirectoryNames(taskRoot);

  for (const teamName of orderedUnique([inputTeamName, ...taskTeamDirs])) {
    const taskPath = path.join(taskRoot, teamName, `${taskId}.json`);
    if (fs.existsSync(taskPath)) {
      process.exit(0);
    }
  }

  // Highwatermark check: if taskId is numeric and within range, the task
  // existed previously but was cleaned up by the platform after completion.
  const numericTaskId = /^\d+$/.test(taskId) ? parseInt(taskId, 10) : NaN;
  if (!isNaN(numericTaskId)) {
    for (const teamName of orderedUnique([inputTeamName, ...taskTeamDirs])) {
      const hwmPath = path.join(taskRoot, teamName, ".highwatermark");
      try {
        const hwmValue = parseInt(fs.readFileSync(hwmPath, "utf8").trim(), 10);
        if (!isNaN(hwmValue) && numericTaskId <= hwmValue) {
          process.exit(0);
        }
      } catch {
        // .highwatermark not readable, skip
      }
    }
  }

  const teamDirs = readDirectoryNames(teamRoot);

  const splitAgentReference = (value) => {
    if (!value.includes("@")) {
      return { agentName: value, teamName: "" };
    }
    const atIndex = value.lastIndexOf("@");
    return {
      agentName: value.slice(0, atIndex),
      teamName: value.slice(atIndex + 1)
    };
  };

  const buildTaskCandidates = (teamName) => orderedUnique([
    teamName,
    inputTeamName,
    ...taskTeamDirs
  ]);

  const buildTeamCandidates = (teamName) => orderedUnique([
    teamName,
    inputTeamName,
    ...teamDirs
  ]);

  const findLatestTaskAssignment = (agentName, preferredTeamName) => {
    for (const teamName of buildTeamCandidates(preferredTeamName)) {
      const inboxPath = path.join(teamRoot, teamName, "inboxes", `${agentName}.json`);
      if (!fs.existsSync(inboxPath)) {
        continue;
      }
      const entries = tryParseJson(fs.readFileSync(inboxPath, "utf8"));
      if (!Array.isArray(entries)) {
        continue;
      }
      for (let index = entries.length - 1; index >= 0; index -= 1) {
        const entry = entries[index] || {};
        const payload = tryParseJson(String(entry.text || ""));
        if (payload && payload.type === "task_assignment" && payload.taskId) {
          return {
            taskId: String(payload.taskId),
            teamName,
            agentName
          };
        }
      }
    }
    return null;
  };

  const findLatestOwnedTask = (agentName, preferredTeamName) => {
    const normalizedAgentName = normalize(agentName);
    let best = null;
    for (const teamName of buildTaskCandidates(preferredTeamName)) {
      const dirPath = path.join(taskRoot, teamName);
      let entries = [];
      try {
        entries = fs.readdirSync(dirPath, { withFileTypes: true });
      } catch {
        continue;
      }
      for (const entry of entries) {
        if (!entry.isFile() || !entry.name.endsWith(".json")) {
          continue;
        }
        const taskPath = path.join(dirPath, entry.name);
        const task = tryParseJson(fs.readFileSync(taskPath, "utf8"));
        if (!task || normalize(task.owner) !== normalizedAgentName || !task.id) {
          continue;
        }
        const stats = fs.statSync(taskPath);
        if (!best || stats.mtimeMs > best.mtimeMs) {
          best = {
            taskId: String(task.id),
            teamName,
            agentName,
            mtimeMs: stats.mtimeMs
          };
        }
      }
    }
    return best ? { taskId: best.taskId, teamName: best.teamName, agentName: best.agentName } : null;
  };

  const matchAgentReference = (value) => {
    const { agentName, teamName } = splitAgentReference(value);
    if (!agentName) {
      return null;
    }

    if (teamName) {
      const inboxPath = path.join(teamRoot, teamName, "inboxes", `${agentName}.json`);
      const configPath = path.join(teamRoot, teamName, "config.json");
      let configMatch = false;
      if (fs.existsSync(configPath)) {
        const config = tryParseJson(fs.readFileSync(configPath, "utf8"));
        const agents = Array.isArray(config && config.members)
          ? config.members
          : Array.isArray(config && config.agents)
            ? config.agents
            : [];
        configMatch = agents.some((agent) =>
          normalize(agent && agent.agentId) === normalize(value) ||
          normalize(agent && agent.name) === normalize(agentName)
        );
      }
      if (fs.existsSync(inboxPath) || configMatch) {
        return { agentName, teamName };
      }
    }

    for (const candidateTeam of buildTeamCandidates("")) {
      const inboxPath = path.join(teamRoot, candidateTeam, "inboxes", `${agentName}.json`);
      const configPath = path.join(teamRoot, candidateTeam, "config.json");
      let configMatch = false;
      if (fs.existsSync(configPath)) {
        const config = tryParseJson(fs.readFileSync(configPath, "utf8"));
        const agents = Array.isArray(config && config.members)
          ? config.members
          : Array.isArray(config && config.agents)
            ? config.agents
            : [];
        configMatch = agents.some((agent) =>
          normalize(agent && agent.agentId) === normalize(`${agentName}@${candidateTeam}`) ||
          normalize(agent && agent.name) === normalize(agentName)
        );
      }
      if (fs.existsSync(inboxPath) || configMatch) {
        return { agentName, teamName: candidateTeam };
      }
    }

    return null;
  };

  const knownTaskIds = (() => {
    const ids = [];
    for (const teamName of taskTeamDirs) {
      const dirPath = path.join(taskRoot, teamName);
      let entries = [];
      try {
        entries = fs.readdirSync(dirPath, { withFileTypes: true });
      } catch {
        continue;
      }
      for (const entry of entries) {
        if (entry.isFile() && entry.name.endsWith(".json")) {
          ids.push(entry.name.replace(/\.json$/, ""));
        }
      }
    }
    return orderedUnique(ids).slice(0, 8);
  })();

  const agentMatch = matchAgentReference(taskId);
  const assignmentHint = agentMatch
    ? findLatestTaskAssignment(agentMatch.agentName, agentMatch.teamName) || findLatestOwnedTask(agentMatch.agentName, agentMatch.teamName)
    : findLatestOwnedTask(taskId, "");

  if (agentMatch || assignmentHint) {
    const displayTarget = agentMatch ? taskId : String(assignmentHint && assignmentHint.agentName || taskId);
    let reason = `${toolName} is task-scoped and cannot target agent reference '${taskId}'.`;
    if (assignmentHint && assignmentHint.taskId) {
      reason += ` Latest assigned task id for ${displayTarget} is '${assignmentHint.taskId}'. Use that task id for ${toolName}, or use SendMessage for agent-scoped communication.`;
    } else {
      reason += " Use a task id from the task_assignment packet or TaskList. Use SendMessage for agent-scoped communication.";
    }
    if (toolName === "TaskOutput") {
      reason += " TaskOutput is deprecated upstream; prefer Read on the background task output path when the runtime provides it.";
    }
    deny(reason);
    process.exit(0);
  }

  let reason = `BLOCKED: task-state mutation preflight incomplete. Detail: ${toolName} could not find task id '${taskId}' in the current task store. Next: use TaskList, TaskGet, or the task_assignment packet to confirm the exact task id before retrying. Do not retry before Next is complete.`;
  if (knownTaskIds.length > 0) {
    reason += ` Known task ids: ${knownTaskIds.join(", ")}.`;
  }
  if (toolName === "TaskOutput") {
    reason += " TaskOutput is deprecated upstream; prefer Read on the background task output path when the runtime provides it.";
  }
  deny(reason);
} catch (error) {
  deny(`Task validation failed: internal error during validation. Error: ${error && error.message || String(error)}`);
  process.exit(1);
}
NODE
