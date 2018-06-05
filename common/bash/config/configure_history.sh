#!/bin/bash

export HISTCONTROL=ignoredups,ignorespace
export HISTSIZE=100
export HISTFILESIZE=1000000               # big big history

shopt -s histappend                      # append to history, don't overwrite it
shopt -s histverify

export PROMPT_COMMAND="history -a; history -c; history -r;$PROMPT_COMMAND"
