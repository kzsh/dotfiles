#!/bin/bash
if [[ -L $0 ]]; then
  CURRDIR="$(dirname "$(greadlink -f "$0")")"
else
  CURRDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

CURRENT_SPACE=$1
"$CURRDIR/set_space.sh" "$CURRENT_SPACE"
"$CURRDIR/brightness_for_space.sh" "$CURRENT_SPACE" &

# This behavior is superseded by a broader implementation.
#
# Disabled until it can be made faster
# may be able to compile swift code and invert more directly than using Tranquility.
# swiftc
# "$CURRDIR/inversion_for_space.sh" "$CURRENT_SPACE" &
