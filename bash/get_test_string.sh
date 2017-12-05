#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASE_DIR="$SCRIPT_DIR/../"
NAUGHTY_STRINGS_PROJECT_DIR="$BASE_DIR/vendor/big-list-of-naughty-strings"
NAUGHTY_STRINGS_STRING_LIST_JSON="$NAUGHTY_STRINGS_PROJECT_DIR/blns.json"
if [ ! -s "$NAUGHTY_STRINGS_STRING_LIST_JSON" ]; then
  echo "The big-list-of-naughty-strings git submodule must be initialized."
  echo "Run 'git submodule init' from the root of the scripts repo"
  exit 1
fi

if ! brew --prefix jq > /dev/null 2>&1; then
  echo "requires jq to be installed" echo "run brew install jq"
  exit 1
fi

LENGTH=$(jq '. | length' < "$NAUGHTY_STRINGS_STRING_LIST_JSON")
RANDOM_INDEX=$(( RANDOM % LENGTH ))

jq ".[$RANDOM_INDEX]" < "$NAUGHTY_STRINGS_STRING_LIST_JSON"
