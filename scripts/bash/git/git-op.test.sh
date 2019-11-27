#!/bin/bash

. git-op.sh

operation() {
  echo "is git"
  ls .git
}

forEachGitRepo "operation"
