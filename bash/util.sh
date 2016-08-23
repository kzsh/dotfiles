#!/bin/bash

ESC_SEQ="\x1b["
COLOR_RESET=$ESC_SEQ"39;49;00m"
COLOR_RED=$ESC_SEQ"31;01m"
COLOR_GREEN=$ESC_SEQ"32;01m"
COLOR_YELLOW=$ESC_SEQ"33;01m"
COLOR_CYAN=$ESC_SEQ"36;01m"

function echoSuccess() {
  echo -e "${COLOR_GREEN}${1}${COLOR_RESET}"
}

function echoInfo() {
  echo -e "${COLOR_CYAN}${1}${COLOR_RESET}"
}

function echoDebug() {
  if [ -n "$IS_DEBUGGING" ]; then
    echo -e "[DEBUG]${1}"
  fi
}

function echoWarn() {
  echo -e "${COLOR_YELLOW}${1}${COLOR_RESET}"
}

function echoError() {
  >&2 echo -e "${COLOR_RED}${1}${COLOR_RESET}"
}

function goToPath() {
  cd "$1" || exitError "could not reach directory $1"
}


function beginSection() {
 echoInfo "================================================================================"
 echoInfo " $1"
 echoInfo "================================================================================"
}

function endSection() {
 echoInfo ""
}


function exitSuccess() {
  echoSuccess "$1"
  exit
}

function exitError() {
  echoError "${COLOR_RED}${1}${COLOR_RESET}"
  if [ -n "$2" ]; then
    exit "$2"
  else
    exit 1
  fi
}

