DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# shellcheck disable=1090
. "$HOME/src/scripts/install/bash_debug_functions.sh"

# shellcheck disable=1090
. "$DIR/program_config/vim.sh"
# shellcheck disable=1090
. "$DIR/program_config/autojump.sh"
# shellcheck disable=1090
. "$DIR/program_config/fzf.sh"
