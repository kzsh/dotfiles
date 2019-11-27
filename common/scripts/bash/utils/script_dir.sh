#!/usr/bin/env bash

# USAGE: call from sourced scripts (1 layer deep, it's fragile)
# to get the sourcer's directory

EXEC_DIR="$( cd "$( dirname "${BASH_SOURCE[-2]}" )" && pwd )"
