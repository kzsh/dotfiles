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

  for space in q w e r t a s d f g z x c v b; do
  log "Setting inversion: $new_inversion for space $CURRENT_SPACE..."
  "$CURRDIR/inversion_for_space.sh" "$space" "$new_inversion"
  log "Done"
  done
}

main "$@"
