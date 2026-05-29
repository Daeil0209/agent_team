const DEFAULT_TEXT_KEYS = [
  "description",
  "summary",
  "prompt",
  "task",
  "assignment",
  "message",
  "content",
  "instructions",
  "goal",
  "brief",
  "context",
  "request",
  "note",
  "notes",
];

function encode(value) {
  return Buffer.from(String(value ?? ""), "utf8").toString("base64");
}

function flattenText(value, preferredKeys = DEFAULT_TEXT_KEYS) {
  if (value == null) return [];
  if (typeof value === "string") return value ? [value] : [];
  if (typeof value === "number" || typeof value === "boolean") return [String(value)];
  if (Array.isArray(value)) return value.flatMap((entry) => flattenText(entry, preferredKeys));
  if (typeof value === "object") {
    const preferred = preferredKeys
      .filter((key) => Object.prototype.hasOwnProperty.call(value, key))
      .flatMap((key) => flattenText(value[key], preferredKeys));
    if (preferred.length) return preferred;
    return Object.entries(value).flatMap(([key, nested]) => {
      const nestedChunks = flattenText(nested, preferredKeys);
      if (!nestedChunks.length) return [String(key)];
      return nestedChunks.map((chunk) => `${key}: ${chunk}`);
    });
  }
  return [];
}

function flattenValueText(value) {
  if (value == null) return [];
  if (typeof value === "string") return value ? [value] : [];
  if (typeof value === "number" || typeof value === "boolean") return [String(value)];
  if (Array.isArray(value)) return value.flatMap(flattenValueText);
  if (typeof value === "object") return Object.values(value).flatMap(flattenValueText);
  return [];
}

function joinUniqueText(chunks) {
  const seen = new Set();
  return chunks
    .map((chunk) => String(chunk || "").trim())
    .filter(Boolean)
    .filter((chunk) => {
      if (seen.has(chunk)) return false;
      seen.add(chunk);
      return true;
    })
    .join("\n");
}

function firstNonEmptyString(...values) {
  for (const value of values) {
    if (typeof value !== "string") continue;
    const trimmed = value.trim();
    if (trimmed) return trimmed;
  }
  return "";
}

// Canonical INPUT_JSON parser for hook node scripts. Each settings-wired hook
// receives tool input as JSON on stdin; the standard bash wrapper passes that
// JSON through the INPUT_JSON env var to an embedded node script.
// `parseInput()` consolidates the try/catch JSON.parse boilerplate
// that hooks otherwise inline. Returns the parsed object on success, an empty
// object `{}` on parse failure or missing env. Optional `envName` arg supports
// non-default env var names (e.g., when a hook stages multiple JSON inputs).
function parseInput(envName = "INPUT_JSON") {
  try {
    return JSON.parse(process.env[envName] || "{}");
  } catch {
    return {};
  }
}

module.exports = {
  DEFAULT_TEXT_KEYS,
  encode,
  flattenText,
  flattenValueText,
  joinUniqueText,
  firstNonEmptyString,
  parseInput,
};
