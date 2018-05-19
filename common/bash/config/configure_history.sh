#!/bin/bash
export HISTCONTROL=erasedups
export HISTSIZE=100
export HISTFILESIZE=1000000

shopt -s histappend
shopt -s histverify

if [[ ! -f $HOME/.logs ]]; then
  mkdir -p "$HOME/.logs"
fi

export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

# Save and reload the history after each command finishes
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
