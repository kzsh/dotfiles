#!/bin/bash
TODAY=$(date +"%Y-%m-%d")
PWD=$(pwd)
cd $HOME/TODO

if [ "$(git log -1 --pretty=%B)" == "$TODAY" ]; then
  git add .
  git commit --amend --no-edit
else
  git add .
  git commit -m "$TODAY"
fi

cd $(PWD)
