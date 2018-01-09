#!/bin/bash
CHUNKWM_DIR="$HOME/.config/chunkwm"
CURRENT_SPACE_DIR="$CHUNKWM_DIR/current_space"
mkdir -p "$CURRENT_SPACE_DIR"
rm "$CURRENT_SPACE_DIR"/*
touch "$CURRENT_SPACE_DIR/$1"
