#!/bin/bash
BRIGHTNESS_PATH="$HOME/.config/chunkwm/space_brightness"
BRIGHTNESS_FILE="space_brightness"
function main() {
  if [[ -s $BRIGHTNESS_PATH/$BRIGHTNESS_FILE ]]; then
    mkdir -p $BRIGHTNESS_PATH
    cat << EOF > "$BRIGHTNESS_FILE"
q=0.5
w=0.5
e=0.5
r=0.5
t=0.5
a=0.5
s=0.5
d=0.5
f=0.5
g=0.5
z=0.5
x=0.5
c=0.5
v=0.5
b=0.5
EOF
  fi

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
