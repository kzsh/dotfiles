#!/bin/bash

# https://github.com/koalman/shellcheck/wiki/SC1090

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export DEBUG_STARTUP=

VIM=$(which nvim)
if [ -z "$VIM" ]; then
  VIM=$(which vim)
fi

if [ -z "$VIM" ]; then
  VIM=$(which vi)
fi

export EDITOR=$VIM

set -o vi
set editing-mode vi
shopt -s globstar

PATH="$PATH:$HOME/bin"

sources=(
  "$BASE_DIR/bash_debug_functions.sh"
  "$BASE_DIR/prompt.sh"
  "$BASE_DIR/chunkwm_vim_compatability.sh"
  "$BASE_DIR/config_bash_history.sh"
  "$BASE_DIR/bash_aliases.sh"
  "$BASE_DIR/bash_functions.sh"
  "$BASE_DIR/load_program_configs.sh"
  "$BASE_DIR/completions.sh"
)

for src in "${sources[@]}"; do
  # -s == if file exists and has size > 0
  if [[ -s $src ]]; then
    #shellcheck disable=1090
    . "$src"
    debug_log "Loaded: $src"
  fi
done
