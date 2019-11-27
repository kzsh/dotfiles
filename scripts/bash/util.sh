#!/bin/bash

ESC_SEQ="\x1b["
COLOR_RESET=$ESC_SEQ"39;49;00m"
COLOR_RED=$ESC_SEQ"31;01m"
COLOR_GREEN=$ESC_SEQ"32;01m"
COLOR_YELLOW=$ESC_SEQ"33;01m"
COLOR_CYAN=$ESC_SEQ"36;01m"


echo_error() { >&2 echo -e "${COLOR_RED}${1}${COLOR_RESET}"; }
echo_info() { echo -e "${COLOR_CYAN}${1}${COLOR_RESET}"; }
echo_success() { echo -e "${COLOR_GREEN}${1}${COLOR_RESET}"; }
echo_warn() { echo -e "${COLOR_YELLOW}${1}${COLOR_RESET}"; }
echo_debug() {
  if [ -n "$IS_DEBUGGING" ]; then
    echo -e "[DEBUG]${1}"
  fi
}

log_debug() { echo_debug "$@"; }
log_error() { echo_error "$@"; }
log_info() { echo_info "$@"; }
log_success() { echo_success "$@"; }
log_warn() { echo_warn "$@"; }

goToPath() {
  cd "$1" || exit_error "could not change to directory $1"
}

begin_section() {
 echoInfo "================================================================================"
 echoInfo " $1"
 echoInfo "================================================================================"
}

end_section() {
 echo_info ""
}


exit_success() {
  echo_success "$1"
  exit
}

exit_error() {
  echo_error "${COLOR_RED}${1}${COLOR_RESET}"
  if [ -n "$2" ]; then
    exit "$2"
  else
    exit 1
  fi
}
