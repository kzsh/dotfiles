[ -f ~/.fzf.bash ] && . ~/.fzf.bash
export FZF_DEFAULT_COMMAND='ag -g "" | cut -d " " -f 2- | sort | uniq'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
debug_log "Lazy loaded: fzf"
