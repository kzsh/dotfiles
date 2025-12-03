#!/bin/bash
set -e

if ! command -v realpath > /dev/null 2>&1; then
  echo "Script requires \`brew install coreutils\` (realpath)"
  exit 1
fi

last_arg="${@: -1}"
if [[ -d "$last_arg" ]]; then
  path="$(realpath "$last_arg")"
  args="${@:1:$#-1}"
else
  path="$(realpath ./)"
  args="$*"
fi
echo $path

while [[ $path != / ]];
do
    find "$path" -maxdepth 1 -mindepth 1 "$args"
    # Note: if you want to ignore symlinks, use "$(realpath -s "$path"/..)"
    path="$(readlink -f "$path"/..)"
done
