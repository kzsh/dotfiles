#!/bin/bash
CURRDIR=$($HOME/src/scripts/bash/utils/current_script_directory.sh)
sleep 0.5
CURRENT_BRIGHTNESS=$(/usr/local/bin/brightness -l | tail -1 | cut -d ' ' -f4)
CURRENT_SPACE=$(ls ~/.config/chunkwm/current_space/)

"$CURRDIR/brightness_for_space.sh" "$CURRENT_SPACE" "$CURRENT_BRIGHTNESS"
