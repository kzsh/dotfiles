#!/bin/bash
TODAY=$(date +"%Y-%m-%d")
PWD=$(pwd)
cd "$NOTES_DIR" || exit 1

make docs
git add .

if [ "$(git log -1 --pretty=%B)" == "$TODAY" ]; then
  git commit --amend --no-edit
else
  git commit -m "$TODAY"
fi

cd "$PWD" || exit 1
