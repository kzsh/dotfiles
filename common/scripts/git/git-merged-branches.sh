#!/bin/bash

usage() {
  cat <<EOM
usage: merged-branches [arguments] [upstream] [remote]

upstream defaults to "master"

Arguments:
    --dry-run)
      print the command to be run instead of running it
    -h|--help)
      show this help page
EOM
}

## Gather Arguments
PARAMS=""
while (( "$#" )); do

  [[ $1 == --*=* ]] && set -- "${1%%=*}" "${1#*=}" "${@:2}"

  case "$1" in
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --) # end argument parsing
      shift
      break
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

## set positional arguments in their proper place
PARAMS="$(echo $PARAMS $@ | xargs)"

eval set -- "$PARAMS"

UPSTREAM=${1:-integration}
REMOTE=${2:-origin}

echo "Checking branches against $UPSTREAM on $REMOTE"
sleep 1

git checkout -q "$UPSTREAM" && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do
  MERGEBASE=$(git merge-base "$UPSTREAM" "$branch")
  if [[ "$(git cherry "$UPSTREAM" "$(git commit-tree "$(git rev-parse "$branch"'^{tree}')" -p "$MERGEBASE" -m _)")" == "-"* ]]; then
    if [[ -n $DRY_RUN ]]; then
      echo "$branch is squash-merged into $UPSTREAM and can be deleted"
    else
      git branch -D "$branch"
    fi
  fi
done
if [[ -n $DRY_RUN ]]; then
  git remote prune "$REMOTE" --dry-run
else
  git remote prune "$REMOTE"
fi

