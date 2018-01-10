#!/bin/bash
LAZY_COMMAND="nvm"
function lazy_load_nvm() {
  local original_command
  local args
  original_command="$1"
  args=${*:2}
  debug_log "Lazy loading: $LAZY_COMMAND"
  unalias "$LAZY_COMMAND"

  NVM_DIR=~/.nvm
  export NVM_DIR
  source $(brew --prefix nvm)/nvm.sh

  # shellcheck disable=SC1090
  . "$(brew --prefix $LAZY_COMMAND)/etc/bash_completion.d/$LAZY_COMMAND"

  # shellcheck disable=SC2086
  "$original_command" $args
}

build_aliases "lazy_load_nvm" "$LAZY_COMMAND"
