#!/bin/bash
export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=1000000                   # big big history
export HISTFILESIZE=1000000               # big big history

shopt -s histappend                      # append to history, don't overwrite it
shopt -s histverify

mkdir -p "$HOME/.logs"

export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

# Save and reload the history after each command finishes
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# fh - search command history in ~/.logs (all history)
fh() {
  rg -o -e "\s?\d+\s{2}.*" -e "\s{2}.*" $(ls -lrt -d -1 $HOME/.logs/{*,.*} | grep -v "\.logs\/\.") | awk '{$1=""; $2=""; print $0}' | fzf --tac^C
}
