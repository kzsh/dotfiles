#!/bin/bash

if [[ -L $0 ]]; then
  CURRDIR="$(dirname "$(greadlink -f "$0")")"
else
  CURRDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi
. "$CURRDIR/logging.sh"

CHUNKWM_PATH="$HOME/.config/chunkwm"
BRIGHTNESS_FILE_NAME="space_brightness"
BRIGHTNESS_FILE_PATH="$CHUNKWM_PATH/$BRIGHTNESS_FILE_NAME"

main() {
  local brightness
  brightness="$1"

  if [[ ! -s $BRIGHTNESS_FILE_PATH ]]; then
    log "Creating missing file $BRIGHTNESS_FILE_PATH with default values"
    mkdir -p "$CHUNKWM_PATH"
    cat <<EOF > "$BRIGHTNESS_FILE_PATH"
q=$brightness
w=$brightness
e=$brightness
r=$brightness
t=$brightness
a=$brightness
s=$brightness
d=$brightness
f=$brightness
g=$brightness
z=$brightness
x=$brightness
c=$brightness
v=$brightness
b=$brightness
EOF
log "Done"
  fi

  if [[ -n "$2" ]]; then
    brightness_setting=$(set_setting_for_space "$1" "$2")
  else
    brightness_setting=$(get_setting_for_space "$1")
  fi

  log "Setting brightness $brightness_setting"
  $BRIGHTNESS_COMMAND "$brightness_setting"
  log "done"
}

main "$@"
