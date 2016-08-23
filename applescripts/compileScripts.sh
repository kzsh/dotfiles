#!/bin/bash

source "$HOME/bin/util.sh"

JS_SCRIPTS_DIR=javascript
DIST_DIR=dist

beginSection "Prep applescript dist"
  rm -r "$DIST_DIR"
  mkdir -p "$DIST_DIR"
endSection

beginSection "Compile scripts"
  for script in $(ls ./javascript); do
    input="${JS_SCRIPTS_DIR}/${script}"
    output="${DIST_DIR}/${script}.scpt"
    echo "Compiling $input to $output"
    osacompile -l JavaScript -o "$output" "$input"
  done
endSection
