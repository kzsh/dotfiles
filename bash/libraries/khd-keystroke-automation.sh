#!/bin/bash
KHD_KEYSTROKE_AUTOMATION_SOURCED=1

HK_ESCAPE="0x35"
HK_TAB="0x30"
HK_ENTER="0x24"
HK_PERIOD="0x2f"
HK_SPACE="0x31"
HK_BACKSPACE="0x33"
HK_DASH="0x1b"
HK_UPARROW="0x7e"
HK_DOWNARROW="0x7d"
HK_LEFTARROW="0x7b"
HK_RIGHTARROW="0x7c"

function navigate_to_space_A() {
  navigate_to_space "a"
}

function navigate_to_space() {
  case "$(echo "$1" | tr '[:upper:]' '[:lower:]')" in
    q)
      keystrokes="ctrl + alt + cmd - 1"
    ;;
    w)
      keystrokes="ctrl + alt + cmd - 2"
    ;;
    e)
      keystrokes="ctrl + alt + cmd - 3"
    ;;
    r)
      keystrokes="ctrl + alt + cmd - 4"
    ;;
    t)
      keystrokes="ctrl + alt + cmd - 5"
    ;;
    a)
      keystrokes="ctrl + alt + cmd - 6"
    ;;
    s)
      keystrokes="ctrl + alt + cmd - 7"
    ;;
    d)
      keystrokes="ctrl + alt + cmd - 8"
    ;;
    f)
      keystrokes="ctrl + alt + cmd - 8"
    ;;
    g)
      keystrokes="ctrl + alt + cmd - 0"
    ;;
    z)
      keystrokes="shift + ctrl + alt + cmd - 1"
    ;;
    x)
      keystrokes="shift + ctrl + alt + cmd - 2"
    ;;
    c)
      keystrokes="shift + ctrl + alt + cmd - 3"
    ;;
    v)
      keystrokes="shift + ctrl + alt + cmd - 4"
    ;;
    b)
      keystrokes="shift + ctrl + alt + cmd - 5"
    ;;
  esac
  send  "$keystrokes"
  pause 1
}

function navigate_to_upper_left_pane() {
  send "ctrl - h" "ctrl - k"
  pause 0.2
}

function navigate_to_upper_right_pane() {
  send "ctrl - l" "ctrl - k"
  pause 0.2
}

function navigate_to_lower_left_pane() {
  send "ctrl - h" "ctrl - j"
  pause 0.2
}

function navigate_to_lower_right_pane() {
  send "ctrl - l" "ctrl - j"
  pause 0.2
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
    send "- $HK_ENTER"
  done
  pause 0.2
  send "- $HK_ESCAPE"
  pause 0.2
}

function send() {
  for x in "$@"; do
    if [[ -n "$DRY_RUN" ]]; then
      echo "khd -p \"$x\""
    else
      khd -p "$x"
    fi
  done
}

function repeat_send() {
  local command=$1
  local repeat_times
  repeat_times="$2"
  for (( times=0; times<repeat_times; times++ )); do
    send "$command"
  done
}

function send_string() {
  local arg
  local mod
  local arguments
  local i

  arguments="$1"
  for (( i=0; i<${#arguments}; i++ )); do
    mod=
    case "${arguments:$i:1}" in
      "-")
        arg="$HK_DASH"
      ;;
      "#")
        mod="shift"
        arg="3"
      ;;
      "@")
        mod="shift"
        arg="2"
      ;;
      "&")
        mod="shift"
        arg="7"
      ;;
      ".")
        arg="$HK_PERIOD"
      ;;
      " ")
        arg="$HK_SPACE"
      ;;
      [[:upper:]])
        mod="shift"
        arg=$( echo "${arguments:$i:1}" | tr '[:upper:]' '[:lower:]')
      ;;
      *)
        arg="${arguments:$i:1}"
      ;;
    esac

    send "$mod - $arg"
  done
}

function pause() {
  if [[ ! -n "$DRY_RUN" ]]; then
    sleep "$1"
  fi
}
