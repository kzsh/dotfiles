#!/usr/bin/env bash

function get_time() {
  python -c 'import time; print(time.time())'
}

LAST_TIME=$(get_time)

debug_log() {
  if [ -n "${DEBUG_STARTUP}" ]; then
    CURRENT_TIME=$(get_time)
    DIFF=$(echo "$CURRENT_TIME - $LAST_TIME" | bc)
    echo -n "$@"
    echo "  $DIFF"
    LAST_TIME=$CURRENT_TIME
  fi
}
