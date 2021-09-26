[[ -s "$BREW_PATH/etc/profile.d/autojump.sh" ]] && . "$BREW_PATH/etc/profile.d/autojump.sh"

# _j() {
#   [[ -n $DEBUG_STARTUP ]] && debug_log "Lazy loading: autojump"

#   unalias j 
#   unalias autojump

# . $(cat <<-EOS
# _autojump() {
#   echo "here"
#   pushd "$(/usr/local/bin/autojump "$@")"
# }
# alias j="_autojump"
# EOS
# )

#   # shellcheck disable=SC2086
#   DEST="$(/usr/local/bin/autojump "$@")"
#   echo "$DEST"
#   cd "$DEST" || exit
# }

# build_aliases "autojump" "_j"
# build_aliases "j" "_j"
