#!/bin/bash

forEachGitRepo() {
  for x in *; do
    if [ -d "$x" ]; then
      echo "$x"
      cd "$x" || exit 1
      if [[ -d .git ]]; then
        eval "$@"
      else
        echo "skipping $x"
      fi
      cd .. || exit 1
    fi
  done
}
