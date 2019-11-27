#!/bin/bash
DRY_RUN="$1"

FOOBAR=$(comm -12 <(git branch | sed 's/^[ *]+//g') <(git remote prune origin --dry-run | grep "prune\(ed\)\?" | sed 's/^.*origin\///g'))

echo "test"
echo "$FOOBAR"

# echo $TO_PRUNE
# if [[ -z "$DRY_RUN" ]]; then
#   echo "$TO_PRUNE"
# else
#   echo "real thing"
#   echo "$TO_PRUNE"
# fi
