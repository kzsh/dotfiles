#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

SPACES=QWERTASDFGZXCVB

for (( i=0; i<${#SPACES}; i++ )); do
  "$SCRIPT_DIR/make_space.sh" "${SPACES:$i:1}" > "$SCRIPT_DIR/config.d/${SPACES:$i:1}/1_main"
done
