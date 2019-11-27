#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEST_STRING="$("$SCRIPT_DIR/get_test_string.sh")"

echo "$TEST_STRING" | pbcopy
