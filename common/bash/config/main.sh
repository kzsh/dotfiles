# https://github.com/koalman/shellcheck/wiki/SC1090
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export DEBUG_STARTUP=

if which nvim > /dev/null 2>&1; then
  EDITOR=$(which nvim)
elif which vim > /dev/null 2>&1; then
  EDITOR=$(which vim)
else
  EDITOR=$(which vi)
fi

export EDITOR

shopt -s globstar

PATH="$PATH:$HOME/bin"

sources=(
  "$BASE_DIR/debug_functions.sh"
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
    debug_log "Loaded: $src"
  fi
done