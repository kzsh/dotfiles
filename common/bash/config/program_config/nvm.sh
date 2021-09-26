export NVM_DIR="$HOME/.nvm"

nvm() {
  # local original_command
  # local args
  # original_command="$1"
  # args=${*:2}
  [[ -n $DEBUG_STARTUP ]] && debug_log "Lazy loading: nvm"
  unalias "nvm"

  NVM_DIR=~/.nvm

  # shellcheck disable=SC1090
  . "$NVM_DIR/nvm.sh"


  # shellcheck disable=SC2086
  "$@"
  # "$original_command" $args
}

# shellcheck disable=SC1090
. "$NVM_DIR/bash_completion"

build_aliases "nvm" "nvm"
