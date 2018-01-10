#!/bin/bash

function lazy_load_pass() {
  local original_command
  local args
  original_command="$1"
  args=${*:2}
  debug_log "Lazy loading: pass"
  unalias "pass"

  # shellcheck disable=SC1090
  . "$(brew --prefix pass)/etc/bash_completion.d/pass"

  "$original_command" $args
}

build_aliases "lazy_load_pass" "pass"
