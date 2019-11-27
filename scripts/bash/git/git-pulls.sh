#!/bin/bash
ACCESS_TOKEN=$1
DEFAULT_REPO=$(git remote show origin \
  | grep '[Pp]ush.*\(http\|git\@\)' \
  | sed 's/^.*\.com\/\(.\+\)\.git/\1/')
REPO="${2:DEFAULT_REPO}"
HOST="https://github.com"
API_BASE="api/v3/repos/"
QUERY_STRING="access_token=$ACCESS_TOKEN"

echo "$HOST/$API_BASE?$QUERY_STRING"
# curl "$HOST/$API_BASE?$QUERY_STRING"
