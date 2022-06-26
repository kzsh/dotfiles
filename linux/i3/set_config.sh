#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "" > "$SCRIPT_DIR/config"

find "$SCRIPT_DIR/config.d/" -maxdepth 1 -type f | sort | xargs  "cat" >> "$SCRIPT_DIR/config"

if [[ -n "$1" ]]; then
  find "$SCRIPT_DIR/config.d/$1" -maxdepth 1 -type f | sort | xargs  "cat" >> "$SCRIPT_DIR/config"
fi

i3 reload
