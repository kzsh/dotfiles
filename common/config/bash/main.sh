#!/usr/bin/env bash

# https://github.com/koalman/shellcheck/wiki/SC1090
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export CONFIG_DIR="$SCRIPT_DIR"
export REPO_ROOT="$SCRIPT_DIR/../../.."
export COMMON_SCRIPTS="$REPO_ROOT/common/scripts"
export MACOS_SCRIPTS="$REPO_ROOT/macos/scripts"
export LINUX_SCRIPTS="$REPO_ROOT/linux/scripts"

export DEBUG_STARTUP=

XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME
export EDITOR=/usr/local/bin/nvim
export PAGER=less

if ! command -v nvim > /dev/null 2>&1; then
  echo "Neovim not available could not configure editor"
fi

# shopt -s globstar
# shopt -s extglob
shopt -s direxpand

if [ -f "$BREW_PATH/etc/bash_completion" ]; then
  . "$BREW_PATH/etc/bash_completion"
fi

# test_brew_prefix &
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

if [ -f /etc/profile.d/bash_completion.sh ]; then
  . /etc/profile.d/bash_completion.sh
fi

# for completion in "$HOME/bin/__completions/"*; do
#   [[ -r "${completion}" ]] && source "${completion}"
# done

PATH="$HOME/bin:$PATH"

[[ -n "$DEBUG_STARTUP" ]] && . "$SCRIPT_DIR/debug_functions.sh"

sources=(
  "$SCRIPT_DIR/prompt.sh"
  "$SCRIPT_DIR/configure_history.sh"
  "$SCRIPT_DIR/functions.sh"
  "$SCRIPT_DIR/load_program_configs.sh"
  "$SCRIPT_DIR/aliases.sh"
)

for src in "${sources[@]}"; do
  # -s == if file exists and has size > 0
  if [[ -s $src ]]; then
    #shellcheck disable=1090
    source "$src"
    [[ -n "$DEBUG_STARTUP" ]] && debug_log "Loaded: $src"
  fi
done

PATH="$HOME/bin:$PATH"
