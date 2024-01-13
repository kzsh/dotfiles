#!/bin/bash

bold="$(tput bold)"
normal="$(tput sgr0)"

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
