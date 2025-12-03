#!/bin/bash

TODO_FILE="README.md"
cd "$NOTES_DIR" || exit
echo `pwd`
"$EDITOR" "$TODO_FILE"
