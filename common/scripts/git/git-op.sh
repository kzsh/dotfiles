#!/bin/bash

CURRENT_DIR="$(pwd)"

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

# Utility Functions
banner() {
  columns="$(tput cols)"
  printf "\n"
  printf "\n"
  printf "%b" "${BOLD}"
  printf "%0.s=" $(seq 1 $columns)
  printf "\n"
  echo "$*"
  printf "%0.s=" $(seq 1 $columns)
  printf "%b" "${NORMAL}"
}

echo_bold() {
  echo "${BOLD}$*${NORMAL}"
}

forEachGitRepo() {
  COMMAND="$*"
  for r in */; do
    if [ -d "$r/.git" ]; then
      cd "$r" || exit 1
      echo
      banner "$r"
      eval "${COMMAND}"
      # escaped=$(echo $r | sed 's/\//\\\//g')
      # eval "$1" | sed "s/^/$escaped /g"
      cd "$CURRENT_DIR" || exit 1
    fi

  done
}

forEachGitRepo "$*"
