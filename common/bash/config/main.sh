#!/bin/bash

# https://github.com/koalman/shellcheck/wiki/SC1090
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export CONFIG_DIR="$BASE_DIR"

export DEBUG_STARTUP=

export EDITOR=/usr/local/bin/nvim

test_available_vim() {
  if ! command -v nvim > /dev/null 2>&1; then
    echo "Neovim not available could not configure editor"
  fi
}

test_available_vim &

shopt -s globstar
shopt -s extglob

PATH="$PATH:$HOME/bin"

# Assume brew prefix to avoid costly `brew --prefix` operation but verify it
# out-of-band and notify if it's not right.

export BREW_PATH=/usr/local
test_brew_prefix() {
  if [[ "$(brew --prefix)" != "$BREW_PATH" ]]; then
    echo "MISMATCHED BREW PREFIX.  Update \$BREW_PATH from '$BREW_PATH', to '$(brew --prefix)'"
  fi

}
test_brew_prefix &

if [ -f "$BREW_PATH/etc/bash_completion" ]; then
  . "$BREW_PATH/etc/bash_completion"
fi

[[ -n "$DEBUG_STARTUP" ]] && . "$BASE_DIR/debug_functions.sh"

sources=(
  "$BASE_DIR/prompt.sh"
  "$BASE_DIR/configure_history.sh"
  "$BASE_DIR/aliases.sh"
  "$BASE_DIR/functions.sh"
  "$BASE_DIR/load_program_configs.sh"
)

for src in "${sources[@]}"; do
  # -s == if file exists and has size > 0
  if [[ -s $src ]]; then
    #shellcheck disable=1090
    . "$src"
    [[ -n "$DEBUG_STARTUP" ]] && debug_log "Loaded: $src"
  fi
done
