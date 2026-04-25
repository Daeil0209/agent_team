#!/usr/bin/env bash
# Shared tool response utilities for PostToolUse hooks.
# Extracted from duplicated implementations in 4 hook files.

tool_response_succeeded() {
  if [[ "$SUCCESS_VALUE" == "false" || "$IS_ERROR_VALUE" == "true" ]]; then return 1; fi
  if [[ -n "$ERROR_VALUE" && "$ERROR_VALUE" != "null" && "$ERROR_VALUE" != "undefined" ]]; then return 1; fi
  return 0
}
