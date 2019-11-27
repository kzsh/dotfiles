#!/bin/bash
CHUNKWM_DIR="$HOME/.config/chunkwm"
CURRENT_SPACE_DIR="$CHUNKWM_DIR/current_space"
if [[ -z $CURRENT_SPACE_DIR ]]; then
  echo "CURRENT_SPACE_DIR not correctly set.  Exiting"
  exit 1
fi
mkdir -p "$CURRENT_SPACE_DIR"

if [ "$(ls -A $CURRENT_SPACE_DIR)" ]; then
  rm "$CURRENT_SPACE_DIR"/*
fi

touch "$CURRENT_SPACE_DIR/$1"
