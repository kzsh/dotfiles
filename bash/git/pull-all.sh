#!/bin/bash
. "$HOME/bin/git-op.sh"

operation() {
  branch_match=$(git branch | grep \* | sed -E -e 's/\* (.+) */\1/')
  is_dirty=$(git status --porcelain 2>/dev/null| grep --extended-regexp "^[ \t]*(\?\?|M|D)" | wc -l | tr -d " ")
  if [[ "$branch_match" == "develop" || "$branch_match" == "master" ]]; then
    if [[ "$is_dirty" == "0"  ]]; then
      git checkout master && \
      git pull && \
      git checkout develop && \
      git pull
    else
      echo "Skipping: there are uncommitted changes"
    fi
  else
    echo "Skipping: not on 'develop'"
  fi
}

forEachGitRepo "operation"
