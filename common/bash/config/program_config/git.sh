#!/bin/bash

# function lazy_load_git() {
#   local original_command
#   local args
#   original_command="$1"
#   args=${*:2}
#   debug_log "Lazy loading: git"
#   unalias "git"
eval "$(hub alias -s)"

#   # shellcheck disable=SC1090
#   . "$HOME/src/scripts/bash/completions/git/git-completion.sh"

#   # shellcheck disable=SC2086
#   "$original_command" $args
# }

# build_aliases "lazy_load_git" "git"
