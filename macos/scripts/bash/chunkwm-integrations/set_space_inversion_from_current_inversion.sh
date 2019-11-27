#!/bin/bash
if [[ -L $0 ]]; then
  CURRDIR="$(dirname "$(greadlink -f "$0")")"
else
  CURRDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

. "$CURRDIR/logging.sh"

# Per-space inversion is disabled for the moment.
function main() {
  sleep 0.5
  CURRENT_INVERSION=$(cat ~/.config/chunkwm/inversion_enabled)
  if [[ $CURRENT_INVERSION == 0 ]]; then
    new_inversion=1
  else
    new_inversion=0
  fi
  CURRENT_SPACE=$(ls ~/.config/chunkwm/current_space/)

  log "Setting inversion: $new_inversion for space $CURRENT_SPACE..."
  "$CURRDIR/inversion_for_space.sh" "$CURRENT_SPACE" "$new_inversion"
  log "Done"
}

main "$@"
