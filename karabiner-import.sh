#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set repeat.wait 45
/bin/echo -n .
$cli set repeat.initial_wait 55
/bin/echo -n .
$cli set remap.vimnormal_toggle_fn2fn 1
/bin/echo -n .
/bin/echo
