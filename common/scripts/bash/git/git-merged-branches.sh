#!/bin/bash

upstream=${1:-develop}
echo "Checking branches against $upstream"
sleep 1

git checkout -q $upstream && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do 
  mergeBase=$(git merge-base $upstream $branch) \
    && [[ $(git cherry $upstream $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] \
    && echo "$branch is squash-merged into $upstream and can be deleted"
  done

git remote prune origin --dry-run
