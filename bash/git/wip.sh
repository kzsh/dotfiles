#!/bin/bash
main() {
  if git log --oneline -1 | grep -q "WIP$"; then
    git reset --soft HEAD^ && git reset "$(git_root_path)"
  else
    git add "$(git_root_path)" && git commit -m 'WIP'
  fi
}

git_root_path() {
  echo "$(git rev-parse --show-toplevel)"
}

main "$@"
