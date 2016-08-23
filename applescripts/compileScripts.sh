#!/bin/bash
JS_SCRIPTS_DIR=javascript
DIST_DIR=dist

rm "$DIST_DIR/"*

for script in $(ls ./javascript); do
  input="${JS_SCRIPTS_DIR}/${script}"
  output="${DIST_DIR}/${script}.scpt"
  echo "Compiling $input to $output"
  osacompile -l JavaScript -o "$output" "$input"
done
