#!/usr/bin/env bash

function get_time() {
  date +"%s%6N" 
}

LAST_TIME=$(get_time)

debug_log() {
  if [ -n "${DEBUG_STARTUP}" ]; then
    CURRENT_TIME=$(get_time)
    echo -n "$@"
    DIFF=$(echo "$CURRENT_TIME - $LAST_TIME" | bc)
    echo "  $DIFF"
    LAST_TIME=$CURRENT_TIME
  fi
}
