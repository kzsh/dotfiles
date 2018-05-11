#!/bin/bash

if ! command -v get_time > /dev/null; then
function get_time() {
  python -c 'import time; print(time.time())'
}
  LAST_TIME=$(get_time)
fi

if ! command -v debug_log > /dev/null; then
  debug_log() {
    if [ -n "${DEBUG_STARTUP}" ]; then
      CURRENT_TIME=$(get_time)
      DIFF=$(echo "$CURRENT_TIME - $LAST_TIME" | bc)
      echo -n "$@"
      echo "  $DIFF"
      LAST_TIME=$CURRENT_TIME
    fi
  }
fi
