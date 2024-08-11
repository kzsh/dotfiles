#!/bin/bash
. $COMMON_SCRIPTS/bash/completions/git/git-completion.sh
# function lazy_load_git() {
#   local original_command
#   local args
#   original_command="$1"
#   args=${*:2}
#   debug_log "Lazy loading: git"
#   unalias "git"
# . "$COMMON_SCRIPTS/bash/completions/hub/hub.bash_completion.sh"
# eval "$(hub alias -s)"

#   # shellcheck disable=SC1090
#   . "$HOME/.dotfiles/common/bash/completions/git/git-completion.sh"

#   # shellcheck disable=SC2086
#   "$original_command" $args
# }

# build_aliases "lazy_load_git" "git"
