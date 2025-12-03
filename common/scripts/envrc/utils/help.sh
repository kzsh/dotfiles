#!/bin/bash
__UTIL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
__UTIL_HELP_SH_PROJECT_DIR="$__UTIL_DIR/.."

. "$__UTIL_DIR/logging.sh"

fn_exists() {
  local cmd
  cmd="$1"
  LC_ALL=C type "$cmd" | grep -q 'shell function'
}

print_params() {
  local cmd project
  project="$__UTIL_HELP_SH_PROJECT_DIR"
  cmd="$1"
  vlog "Printing params for \`$project/$cmd\`"
  grep -B1 'meta-parse-summary' "$project/$cmd" | sed 's/.*# meta-parse-summary/      /g;s/^--//; s/|--/, --/; s/--\([^ ]\+\))/--\1/'
}

list_parameters() {
  local cmd project
  cmd="$1"
  project="$__UTIL_HELP_SH_PROJECT_DIR"

  vlog "Listing params for \`$cmd\`"
  if [[ -f "$project/$cmd" ]] && [[ "$cmd" != "envrc" ]]; then
    print_params "$cmd"
    echo
    print_params "envrc"
  else
    print_params "envrc"
  fi
}

usage() {
  local cmd
  cmd="$1"

  vlog "Printing usage for \`$cmd\`"
  cat <<EOM

Usage: ${cmd//-/ } [OPTION] command [SUB-COMMAND | OPTION]]

Options:
$(list_parameters "$cmd" | sed 's/^//')

Subcommands:
$(list_subcommands "$cmd" | sed 's/^/    /')
EOM
}

manpage() {
  local cmd
  cmd="$1"

  vlog "Printing manpage for \`$cmd\`"
  cat <<EOM
.TH envrc "a command" "envrc" "1" "May 2022"

.SH SYNOPSIS
${cmd//-/ } [OPTION] command [SUB-COMMAND | OPTION]]

.SH OPTIONS
$(list_parameters "$cmd" | sed 's#^ *-\(.\+\)$#.HP\\fB-\1\\fR .IP#;s/-/\\-/g')

.SH SUBCOMMANDS
$(list_subcommands "$cmd" | sed 's/^/    /')
EOM
}
#
