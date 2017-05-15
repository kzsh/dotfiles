#!/bin/bash

if [[ -z "$LOADED_DEBUG_FUNCTIONS" ]]; then
  function get_time() {
    echo $(python -c 'import time; print time.time()')
  }

  LAST_TIME=$(get_time)

  function debug_log() {

    if [ -z ${DEBUG_STARTUP+x} ]; then
      CURRENT_TIME=$(get_time)
      DIFF=$(echo "$CURRENT_TIME - $LAST_TIME" | bc)
      echo -n "$@"
      echo "  $DIFF"
      LAST_TIME=$CURRENT_TIME
    fi
  }
  LOADED_DEBUG_FUNCTIONS=1
fi

