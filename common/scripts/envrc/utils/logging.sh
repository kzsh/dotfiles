#!/bin/bash

if [ -t 1 ] && command -v tput >/dev/null 2>&1; then
  bold="$(tput bold)"
  normal="$(tput sgr0)"
else
  bold=""
  normal=""
fi

vlog() {
  if [[ -n $VERBOSE ]]; then
    log "$*" | sed "s/^/${bold}$(basename "$0"): ${normal}/"
  fi
}

log() {
  echo "${bold}$*${normal}"
}

highlight_match() {
  sed "s|\($1\)|${bold}\1${normal}|g"
}
