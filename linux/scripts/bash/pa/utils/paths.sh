#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# provides $CONFIG, $DEFAULT_CONFIG, get_config_value
. "$SCRIPT_DIR/config.sh"

change_dir() {
  local project_path
  project_path="$(get_config_value "${1}_path")"
  shift

  if [[ -n "$1" ]]; then
    project_path="$project_path/$1"
    shift
  fi

  if ! cd "$project_path"; then
    echo >&2 "Error: Could not change to directory: \`$project_path\`"
    exit 1
  fi
}
