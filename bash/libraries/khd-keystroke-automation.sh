#!/bin/bash

HK_ESCAPE="0x35"
HK_TAB="0x30"
HK_ENTER="0x24"

function navigate_to_space_A() {
  send "ctrl + alt + lcmd - 6"
  sleep 0.5
}

function navigate_to_upper_left_pane() {
  send "ctrl - h" "ctrl - k"
  sleep 0.2
}

function navigate_to_upper_right_pane() {
  send "ctrl - l" "ctrl - k"
  sleep 0.2
}

function navigate_to_lower_left_pane() {
  send "ctrl - h" "ctrl - j"
  sleep 0.2
}

function navigate_to_lower_right_pane() {
  send "ctrl - l" "ctrl - j"
  sleep 0.2
}

function perform_standard_mac_search() {
  local search_string
  local nth_result

  search_string=$1
  nth_result=$2
  if [[ -n $nth_result ]]; then
    nth_result=1
  fi

  send "cmd - f" && \
  send_string "$search_string"
  for (( i=1; i<${#2}; i++ )); do
    send "$HK_ENTER"
  done
  sleep 0.2
  send "$HK_ESCAPE"
  sleep 0.2
}

function send() {
  for x in "$@"; do
    khd -p "$x"
  done
  sleep 0.2
}

function send_string() {
  local arg
  local mod
  local arguments

  arguments="$1"
  for (( i=0; i<${#arguments}; i++ )); do
    mod=
    case "${arguments:$i:1}" in
      "-")
        arg="0x1b"
      ;;
      "@")
        mod="shift"
        arg="2"
      ;;
      ".")
        arg="0x2f"
      ;;
      " ")
        arg="0x31"
      ;;
      [[:upper:]])
        mod="shift"
        arg=$( echo "${arguments:$i:1}" | tr '[:upper:]' '[:lower:]')
      ;;
      *)
        arg="${arguments:$i:1}"
      ;;
    esac
    khd -p "$mod - ${arg}"
  done
  sleep 0.2
}
