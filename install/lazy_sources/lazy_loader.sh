#!/bin/bash

export LAZY_LOAD_DIR="$HOME/src/scripts/install/lazy_sources"

function lazy_load() {
  command="$1"
  script="$2"
  alias "$command=source $script"
}
