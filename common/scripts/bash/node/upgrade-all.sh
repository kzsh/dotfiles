#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
BASE_DIR="$(pwd)"

. "$SCRIPT_DIR/utils.sh"

print_dependencies() {
  local depkey
  depkey="$1"

  cat package.json | jq '.'"$depkey"' // {} | . as $in | keys[] | . + " " + $in[.]'
}

remove_module() {
  local name
  name="$1"
  yarn remove "$name"
}

add_module() {
  local name
  local version
  name="$1"
  version="$2"

  yarn add "$name" "$version"

}

convert_to_version_string() {
  if read -t 0; then
    cat | sed 's/ /@/g' | sed 's/"@"/" "/g'
  else
    echo $* | sed 's/ /@/g' | sed 's/"@"/" "/g'
  fi
}

name_only() {
  if read -t 0; then
    cat | awk '{ print $1 }' | cut -c 2-
  else
    echo $* | awk '{ print $1 }' | cut -c 3-
  fi
}

for x in $@; do
  BANNER "$x"
  cd "$(dirname "$x")"
  echo ""
  echo "DEPS"
  echo "------------------------"
  deps=$(print_dependencies "dependencies")
  echo "$deps" | name_only | xargs yarn remove
  echo "$deps" | convert_to_version_string | xargs yarn add

  echo ""
  echo "DEV DEPS"
  echo "------------------------"
  dev_deps=$(print_dependencies "devDependencies")

  cd $BASE_DIR
done


