#!/bin/bash

function lazy_load_fzf() {
  debug_log "Lazy loading: fzf"
  unalias fzf
  [ -f ~/.fzf.bash ] && . ~/.fzf.bash
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  fzf "$@"
}

alias fzf='lazy_load_fzf'
