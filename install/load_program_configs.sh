DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function build_aliases() {
  local target_function
  target_function=$1
  aliased_functions=${*:2}

  for target in "${aliased_functions[@]}"; do
    # -s == if file exists and has size > 0
    debug_log "Configuring lazy load for: $target_function ($target)"
    alias $target="$target_function $target"
  done
}

# shellcheck disable=1090
# disable load pyenv.  It should now be loaded via .envrc with projects that use it.
# . "$DIR/program_config/pyenv.sh"

# shellcheck disable=1090
. "$HOME/src/scripts/install/bash_debug_functions.sh"

# shellcheck disable=1090
. "$DIR/program_config/vim.sh"

# shellcheck disable=1090
. "$DIR/program_config/autojump.sh"

# shellcheck disable=1090
. "$DIR/program_config/fzf.sh"

# shellcheck disable=1090
. "$DIR/program_config/direnv.sh"
