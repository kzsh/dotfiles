#!/bin/bash

CURRENT_BRIGHTNESS=$(/usr/local/bin/brightness -l | tail -1 | cut -d ' ' -f4)
sleep 0.5
CURRENT_SPACE=$(ls ~/.config/chunkwm/current_space/)

"$HOME/src/scripts/bash/brightness_for_space.sh" "$CURRENT_SPACE" "$CURRENT_BRIGHTNESS"

