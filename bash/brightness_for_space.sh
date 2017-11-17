#!/bin/bash
function main() {
  if [[ -n "$2" ]]; then
    brightness_setting=$(set_setting_for_space "$1" "$2")
  else
    brightness_setting=$(get_setting_for_space "$1")
  fi
  /usr/local/bin/brightness "$brightness_setting"
}


function get_setting_for_space() {
  local setting
  setting=$(cat "$HOME/.config/chunkwm/space_brightness" | grep "^$1=.*" )
  echo "${setting:2:5}"
}

function set_setting_for_space() {
  local setting
  sed -i '' -e 's/'$1'=.*/'$1'='$2'/' "$HOME/.config/chunkwm/space_brightness"
  setting=$(cat "$HOME/.config/chunkwm/space_brightness" | grep "^$1=.*" )
  echo "${setting:2:5}"
}

main "$@"
