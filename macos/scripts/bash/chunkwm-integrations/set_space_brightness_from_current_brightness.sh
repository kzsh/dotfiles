#!/bin/bash
if [[ -L $0 ]]; then
  CURRDIR="$(dirname "$(greadlink -f "$0")")"
else
  CURRDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

. "$CURRDIR/logging.sh"

function main() {
  sleep 0.5
  CURRENT_BRIGHTNESS=$(/usr/local/bin/brightness -l | tail -1 | cut -d ' ' -f4)
  CURRENT_SPACE=$(ls ~/.config/chunkwm/current_space/)

  log "Setting brightness: $CURRENT_BRIGHTNESS for space $CURRENT_SPACE..."
  "$CURRDIR/brightness_for_space.sh" "$CURRENT_SPACE" "$CURRENT_BRIGHTNESS"
  log "Done"
}

main "$@"
