#!/bin/bash
if [[ -L $0 ]]; then
  CURRDIR="$(dirname "$(greadlink -f "$0")")"
else
  CURRDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

. "$CURRDIR/logging.sh"

BRIGHTNESS_COMMAND=/usr/local/bin/brightness
if [[ -z "$BRIGHTNESS_COMMAND" ]]; then
  echo "'brightness' command couldn't be found. Install it: (brew install brightness)."
  exit 1
fi

CHUNKWM_PATH="$HOME/.config/chunkwm"
BRIGHTNESS_FILE_NAME="space_brightness"
BRIGHTNESS_FILE_PATH="$CHUNKWM_PATH/$BRIGHTNESS_FILE_NAME"

function main() {
  if [[ ! -s $BRIGHTNESS_FILE_PATH ]]; then
    "$CURRDIR/set_global_brightness.sh" "0.5"
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

function get_setting_for_space() {
  local space
  local raw_setting
  local setting
  space=$1
  raw_setting=$(cat "$HOME/.config/chunkwm/space_brightness" | grep "^$space=.*" )
  setting="${raw_setting:2:5}"
  log "Loading stored brightness setting \"$setting\" for space \"$space\""
  echo "$setting"
}

function set_setting_for_space() {
  local space
  local new_value
  local raw_setting
  local setting
  space=$1
  new_value=$2
  sed -i '' -e 's/'$space'=.*/'$space'='$new_value'/' "$BRIGHTNESS_FILE_PATH"
  raw_setting=$(cat "$BRIGHTNESS_FILE_PATH" | grep "^$space=.*" )
  setting="${raw_setting:2:5}"
  log "Saving brightness setting \"$setting\" for space \"$space\""
  echo "$setting"
}

main "$@"
