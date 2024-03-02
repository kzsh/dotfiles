#!/bin/bash
assert_command() {
  local cmd help_text
  cmd="$1"
  help_text="$2"

  if ! command -v "$cmd" > /dev/null 2>&1 ; then
    >&2 echo "Missing command: \`$cmd\`: $help_text"
    exit 1
  fi
}
