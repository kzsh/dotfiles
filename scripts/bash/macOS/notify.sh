#!/bin/bash
if [[ 0 -eq $# ]]; then
  while read line
  do
    args=("${args[@]}" $line)
  done
else
  for x in "$@"; do
    args=("${args[@]}" $x)
  done
fi

TITLE=${args[0]}

CONTENT=("${args[@]:1}")

osascript -e "display notification \"${CONTENT[*]}\" with title \"$TITLE\""
