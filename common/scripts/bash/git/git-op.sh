#!/bin/bash

forEachGitRepo() {
  for r in */; do
    if [ -d "$r/.git" ]; then
      cd $r || exit 1
      echo ""
      echo "$r"
      echo "=============="
      eval $1
      cd .. || exit 1
    fi

  done
}
