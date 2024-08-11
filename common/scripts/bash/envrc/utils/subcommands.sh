#!/bin/bash
__UTIL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

__UTIL_SUBCOMMAND_SH_PROJECT_DIR="$__UTIL_DIR/.."

list_subcommands() {
  local project
  project="$__UTIL_SUBCOMMAND_SH_PROJECT_DIR"
  find "$project" -iname "$1*" -print0 | xargs -I{} -0 basename "{}" | sed "s/$1-//g; s/-.*$//g" | grep -v '^envrc$' | grep -v '_usage$' | grep -v '.*\..*' | sort -u
}

subcommand_or_usage() {
  local command_root command project
  command_root="$1"
  command="$2"
  project="$__UTIL_SUBCOMMAND_SH_PROJECT_DIR"

  if ! [[ -f "$project/$command_root-$command" ]]; then
    list_subcommands "$command_root-"
    usage
    exit 1
  fi
}
