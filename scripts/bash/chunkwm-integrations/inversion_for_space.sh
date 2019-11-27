#!/bin/bash
if [[ -L $0 ]]; then
  CURRDIR="$(dirname "$(greadlink -f "$0")")"
else
  CURRDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi
. "$CURRDIR/logging.sh"

INVERSION_COMMAND="open -a /Applications/Tranquility.app"
if [[ -z "$(ls /Applications/Tranquility.app/)" ]]; then
  echo "'inversion' command couldn't be found. Install it: (Tranquility.app)."
  exit 1
fi

CHUNKWM_PATH="$HOME/.config/chunkwm"
INVERSION_FILE_NAME="space_inversion"
CURRENT_INVERSION_FILE_NAME="inversion_enabled"
INVERSION_FILE_PATH="$CHUNKWM_PATH/$INVERSION_FILE_NAME"
CURRENT_INVERSION_PATH="$CHUNKWM_PATH/$CURRENT_INVERSION_FILE_NAME"

function main() {
  if [[ ! -s $INVERSION_FILE_PATH ]]; then
    log "Creating missing file $INVERSION_FILE_PATH with default values"
    mkdir -p "$CHUNKWM_PATH"
    cat << EOF > "$INVERSION_FILE_PATH"
q=0
w=0
e=0
r=0
t=0
a=0
s=0
d=0
f=0
g=0
z=0
x=0
c=0
v=0
b=0
EOF
log "Done"
  fi

  current_inversion=$(get_current_inversion)
  if [[ -n "$2" ]]; then
    log "Setting inversion $inversion_setting"
    set_setting_for_space "$1" "$2"
    log "done"
  fi

  inversion_setting=$(get_setting_for_space "$1")
  if [[ "$current_inversion" != "$inversion_setting" ]]; then
    log "Inverting colors"
    set_current_inversion
    log "done"
  else
    log "No change of inversion needed."
  fi
}

function get_current_inversion() {
  echo "$(cat $CURRENT_INVERSION_PATH)"
}

function set_current_inversion() {
  curr="$(cat $CURRENT_INVERSION_PATH)"
  if [[ "$curr" == "1" ]]; then
    curr=0
  else
    curr=1
  fi
  echo "$curr" > "$CURRENT_INVERSION_PATH"
  $INVERSION_COMMAND
}

function get_setting_for_space() {
  local space
  local raw_setting
  local setting
  space=$1
  raw_setting=$(cat "$INVERSION_FILE_PATH" | grep "^$space=.*" )
  setting="${raw_setting:2:5}"
  log "Loading stored inversion setting \"$setting\" for space \"$space\""
  echo "$setting"
}

function set_setting_for_space() {
  local space
  local new_value
  local raw_setting
  local setting
  space=$1
  new_value=$2

  sed -i '' -e 's/'$space'=.*/'$space'='$new_value'/' "$INVERSION_FILE_PATH"

  raw_setting=$(cat "$INVERSION_FILE_PATH" | grep "^$space=.*" )
  setting="${raw_setting:2:5}"
  log "Saving inversion setting \"$setting\" for space \"$space\""
  echo "$setting"
}

main "$@"
