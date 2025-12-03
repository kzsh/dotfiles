#!/bin/bash

exit_success() {
  exit_with_message "$1" "0"
}

exit_with_message() {
  local message
  local exit_code
  message=$1

  # exit with given code or 1
  exit_code="${2:-1}"
  echo "$message ($exit_code)"
  exit "$exit_code"
}
