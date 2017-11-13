#!/bin/bash

# shellcheck source=./libraries/khd-keystroke-automation.sh
if [[ -z "$KHD_KEYSTROKE_AUTOMATION_SOURCED" ]]; then
  . "$HOME/src/scripts/bash/libraries/khd-keystroke-automation.sh"
fi

send "cmd - $HK_SPACE"
send_string "desktop & screen saver"
send "- $HK_ENTER"
pause 1
repeat_send "- $HK_TAB" 2
repeat_send "- $HK_UPARROW" 5
repeat_send "- $HK_DOWNARROW" 2
repeat_send "- $HK_TAB" 4
send "- $HK_SPACE"
repeat_send "- $HK_TAB" 9
send "- $HK_BACKSPACE"
send_string "$1"
repeat_send "cmd - w" 2
