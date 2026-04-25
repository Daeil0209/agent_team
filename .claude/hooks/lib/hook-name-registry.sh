#!/usr/bin/env bash

normalize_registry_name() {
  local raw="${1-}"
  printf '%s' "$raw" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//'
}

_write_registry_line() {
  local temp_file="${1:?temp file required}"
  local raw_name="${2-}"
  local normalized_name=""

  normalized_name="$(normalize_registry_name "$raw_name")"
  [[ -n "$normalized_name" ]] || return 0
  printf '%s\n' "$normalized_name" >> "$temp_file"
}

build_agent_name_registry() {
  local temp_file=""
  local doc_file=""
  local agent_name=""

  mkdir -p "$(dirname "$AGENT_NAME_REGISTRY_FILE")"
  temp_file="$(make_atomic_temp_file "$AGENT_NAME_REGISTRY_FILE")"
  : > "$temp_file"

  if [[ -d "$AGENT_DOCS_ROOT" ]]; then
    while IFS= read -r doc_file; do
      [[ -n "$doc_file" ]] || continue
      agent_name="$(basename "$doc_file")"
      agent_name="${agent_name%.md}"
      _write_registry_line "$temp_file" "$agent_name"
    done < <(find "$AGENT_DOCS_ROOT" -mindepth 1 -maxdepth 1 -type f -name '*.md' | sort)
  fi

  sort -u "$temp_file" -o "$temp_file"
  atomic_replace_file "$temp_file" "$AGENT_NAME_REGISTRY_FILE"
}

build_skill_name_registry() {
  local temp_file=""
  local skill_file=""
  local skill_name=""

  mkdir -p "$(dirname "$SKILL_NAME_REGISTRY_FILE")"
  temp_file="$(make_atomic_temp_file "$SKILL_NAME_REGISTRY_FILE")"
  : > "$temp_file"

  if [[ -d "$PROJECT_SKILLS_ROOT" ]]; then
    while IFS= read -r skill_file; do
      [[ -n "$skill_file" ]] || continue
      skill_name="$(basename "$(dirname "$skill_file")")"
      _write_registry_line "$temp_file" "$skill_name"
    done < <(find "$PROJECT_SKILLS_ROOT" -mindepth 2 -maxdepth 2 -type f -name 'SKILL.md' | sort)
  fi

  sort -u "$temp_file" -o "$temp_file"
  atomic_replace_file "$temp_file" "$SKILL_NAME_REGISTRY_FILE"
}

build_role_name_registry() {
  local temp_file=""
  local doc_file=""
  local role_name=""
  local skill_file=""

  mkdir -p "$(dirname "$ROLE_NAME_REGISTRY_FILE")"
  temp_file="$(make_atomic_temp_file "$ROLE_NAME_REGISTRY_FILE")"
  : > "$temp_file"

  if [[ -d "$AGENT_DOCS_ROOT" ]]; then
    while IFS= read -r doc_file; do
      [[ -n "$doc_file" ]] || continue
      role_name="$(basename "$doc_file")"
      role_name="${role_name%.md}"
      _write_registry_line "$temp_file" "$role_name"
    done < <(find "$AGENT_DOCS_ROOT" -mindepth 1 -maxdepth 1 -type f -name '*.md' | sort)
  fi

  if [[ -d "$PROJECT_SKILLS_ROOT" ]]; then
    while IFS= read -r skill_file; do
      [[ -n "$skill_file" ]] || continue
      if grep -qiE 'you are the [a-z0-9_-]+ lane' "$skill_file" 2>/dev/null; then
        role_name="$(basename "$(dirname "$skill_file")")"
        _write_registry_line "$temp_file" "$role_name"
      fi
    done < <(find "$PROJECT_SKILLS_ROOT" -mindepth 2 -maxdepth 2 -type f -name 'SKILL.md' | sort)
  fi

  sort -u "$temp_file" -o "$temp_file"
  atomic_replace_file "$temp_file" "$ROLE_NAME_REGISTRY_FILE"
}

refresh_name_registry() {
  build_agent_name_registry
  build_role_name_registry
  build_skill_name_registry
}

ensure_agent_name_registry() {
  if [[ ! -f "$AGENT_NAME_REGISTRY_FILE" ]] || [[ -d "$AGENT_DOCS_ROOT" && "$AGENT_NAME_REGISTRY_FILE" -ot "$AGENT_DOCS_ROOT" ]]; then
    build_agent_name_registry
  fi
}

ensure_skill_name_registry() {
  if [[ ! -f "$SKILL_NAME_REGISTRY_FILE" ]] || [[ -d "$PROJECT_SKILLS_ROOT" && "$SKILL_NAME_REGISTRY_FILE" -ot "$PROJECT_SKILLS_ROOT" ]]; then
    build_skill_name_registry
  fi
}

ensure_role_name_registry() {
  if [[ ! -f "$ROLE_NAME_REGISTRY_FILE" ]] \
    || [[ -d "$AGENT_DOCS_ROOT" && "$ROLE_NAME_REGISTRY_FILE" -ot "$AGENT_DOCS_ROOT" ]] \
    || [[ -d "$PROJECT_SKILLS_ROOT" && "$ROLE_NAME_REGISTRY_FILE" -ot "$PROJECT_SKILLS_ROOT" ]]; then
    build_role_name_registry
  fi
}

ensure_name_registry() {
  ensure_agent_name_registry
  ensure_role_name_registry
  ensure_skill_name_registry
}

agent_registry_has_name() {
  local candidate=""
  candidate="$(normalize_registry_name "${1-}")"
  [[ -n "$candidate" ]] || return 1
  ensure_agent_name_registry
  grep -qxF "$candidate" "$AGENT_NAME_REGISTRY_FILE" 2>/dev/null
}

skill_registry_has_name() {
  local candidate=""
  candidate="$(normalize_registry_name "${1-}")"
  [[ -n "$candidate" ]] || return 1
  ensure_skill_name_registry
  grep -qxF "$candidate" "$SKILL_NAME_REGISTRY_FILE" 2>/dev/null
}

role_registry_has_name() {
  local candidate=""
  candidate="$(normalize_registry_name "${1-}")"
  [[ -n "$candidate" ]] || return 1
  ensure_role_name_registry
  grep -qxF "$candidate" "$ROLE_NAME_REGISTRY_FILE" 2>/dev/null
}

canonical_agent_alias() {
  local candidate=""
  candidate="$(normalize_registry_name "${1-}")"

  case "$candidate" in
    teamlead|lead)
      printf 'team-lead'
      return 0
      ;;
    integration-operator)
      printf 'external-tool-bridge'
      return 0
      ;;
    val-ref)
      printf 'validator'
      return 0
      ;;
  esac

  return 1
}

canonical_registered_agent_name() {
  local candidate=""
  local prefix=""
  local alias_name=""

  candidate="$(normalize_registry_name "${1-}")"
  [[ -n "$candidate" ]] || return 1

  if agent_registry_has_name "$candidate"; then
    printf '%s' "$candidate"
    return 0
  fi

  prefix="$(printf '%s' "$candidate" | sed -n 's/^\([a-z0-9_-]*\):.*/\1/p')"
  if [[ -n "$prefix" ]] && agent_registry_has_name "$prefix"; then
    printf '%s' "$prefix"
    return 0
  fi

  if alias_name="$(canonical_agent_alias "$candidate" 2>/dev/null)"; then
    printf '%s' "$alias_name"
    return 0
  fi

  if [[ -n "$prefix" ]] && alias_name="$(canonical_agent_alias "$prefix" 2>/dev/null)"; then
    printf '%s' "$alias_name"
    return 0
  fi

  return 1
}

canonical_registered_skill_id() {
  local candidate=""
  local prefix=""

  candidate="$(normalize_registry_name "${1-}")"
  prefix="$(printf '%s' "$candidate" | sed -n 's/^\([a-z0-9_-]*\):.*/\1/p')"

  if [[ -n "$prefix" ]] && skill_registry_has_name "$prefix"; then
    printf '%s' "$prefix"
    return 0
  fi

  if [[ "$candidate" == */skill.md ]]; then
    candidate="$(basename "$(dirname "$candidate")")"
  elif [[ "$candidate" == */* ]]; then
    candidate="$(basename "$candidate")"
  else
    candidate="${candidate##*:}"
  fi

  candidate="$(normalize_registry_name "$candidate")"
  [[ -n "$candidate" ]] || return 1

  if skill_registry_has_name "$candidate"; then
    printf '%s' "$candidate"
    return 0
  fi

  return 1
}

canonical_registered_role_name() {
  local candidate=""
  local prefix=""
  local alias_name=""

  candidate="$(normalize_registry_name "${1-}")"
  prefix="$(printf '%s' "$candidate" | sed -n 's/^\([a-z0-9_-]*\):.*/\1/p')"

  if role_registry_has_name "$candidate"; then
    printf '%s' "$candidate"
    return 0
  fi

  if [[ -n "$prefix" ]] && role_registry_has_name "$prefix"; then
    printf '%s' "$prefix"
    return 0
  fi

  if alias_name="$(canonical_agent_alias "$candidate" 2>/dev/null)"; then
    printf '%s' "$alias_name"
    return 0
  fi

  if [[ -n "$prefix" ]] && alias_name="$(canonical_agent_alias "$prefix" 2>/dev/null)"; then
    printf '%s' "$alias_name"
    return 0
  fi

  return 1
}
