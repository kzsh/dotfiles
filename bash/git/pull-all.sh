#!/bin/bash
. "$HOME/bin/git-op.sh"

operation() {
  master_branch_match=$(git branch | grep \* | sed -E -e 's/\* (.+) */\1/')
  is_dirty=$(git status --porcelain 2>/dev/null| grep --extended-regexp "^[ \t]*(\?\?|M|D)" | wc -l | tr -d " ")
  if [[ "$master_branch_match" == "master" ]]; then
    if [[ "$is_dirty" == "0"  ]]; then
      git pull
    else
      echo "Skipping: there are uncommitted changes"
    fi
  else
    echo "Skipping: not on 'master'"
  fi
}

forEachGitRepo "operation"


