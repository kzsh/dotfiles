#!/bin/bash
CURRDIR=$("$HOME/src/scripts/bash/utils/current_script_directory.sh")

CURRENT_SPACE=$1
"$CURRDIR/set_space.sh" "$CURRENT_SPACE"
"$CURRDIR/brightness_for_space.sh" "$CURRENT_SPACE"
