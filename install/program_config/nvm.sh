#!/bin/bash
function lazy_load_nvm() {
  local original_command
  local args
  original_command="$1"
  args=${*:2}
  debug_log "Lazy loading: nvm"
  unalias "nvm"

  NVM_DIR=~/.nvm
  export NVM_DIR
  . /usr/local/opt/nvm/nvm.sh


  # shellcheck disable=SC1090
  . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

  # shellcheck disable=SC2086
  "$original_command" $args
}

build_aliases "lazy_load_nvm" "nvm"
