#!/bin/bash

export FZF_DEFAULT_OPTS='--bind=ctrl-alt-j:down,ctrl-alt-k:up,ctrl-d:page-down,ctrl-u:page-up'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.bash ] && . ~/.fzf.bash
