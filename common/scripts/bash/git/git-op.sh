#!/bin/bash
PWD=$(pwd)
forEachGitRepo() {
  for r in */; do
    if [ -d "$r/.git" ]; then
      cd $r || exit 1
      escaped=$(echo $r | sed 's/\//\\\//g')
      eval "$1" | sed "s/^/$escaped /g"
      cd .. || exit 1
    fi

  done
}
