#!/bin/bash
export HISTCONTROL=erasedups
export HISTSIZE=100
export HISTFILESIZE=1000000               # big big history

shopt -s histappend                      # append to history, don't overwrite it
shopt -s histverify

if [[ ! -f $HOME/.logs ]]; then
  mkdir -p "$HOME/.logs"
fi

export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

# fh - search command history in ~/.logs (all history)
fh() {
  rg -o -e "\s?\d+\s{2}.*" -e "\s{2}.*" $(ls -lrt -d -1 $HOME/.logs/{*,.*} \
    | grep -v "\.logs\/\.") \
    | awk '{$1=""; $2=""; print $0}' \
    | fzf --tac \
    | while read -r item; do
      printf '%q ' "$item"
    done
    echo
}

fh-widget() {
  local selected="$(hist)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}

bind -x '"\C-f": "fh-widget"'
