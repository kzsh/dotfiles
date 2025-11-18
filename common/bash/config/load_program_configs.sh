#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

PROGRAMS_DIR="$DIR/program_config"

programs=(
  aws
  brew
  cargo
  direnv
  docker
  fzf
  gh
  git
  gpg
  kubectl
  nvim
  notes
  pass
  scratch
  vim
  zoxide
)

for program in "${programs[@]}"; do
  #shellcheck disable=1090
  if command -v "$program" > /dev/null 2>&1; then
  . "$PROGRAMS_DIR/$program"
    [[ -n "$DEBUG_STARTUP" ]] && debug_log "Loaded: ${PROGRAMS_DIR}/${program}"
  else
    [[ -n "$DEBUG_STARTUP" ]] && debug_log "No command found, skipping: ${program}."
  fi
done

