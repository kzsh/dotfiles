#!/bin/bash
# for file in $(find . -type f --max-depth 1 .); do
  # directory=$(dirname -- "$file")
  # filename=$(basename -- "$file")
  # extension="${filename##*.}"
  # filename="${filename%.*}"
# done

make_and_move() {
  local path file
  file="$1"
  path="$2"

  mkdir -p "$path"

  index=1

  dest="$file"
  while [[ -f "$path/$dest" ]]; do
    dest="$file-$index"
    index=$(( index + 1 ))
  done

  mv "$file" "$path/$dest"
}

find . -maxdepth 1 -type f -print0 | while IFS= read -r -d $'\0' file; do
  # directory=$(dirname -- "$file")
  filename=$(basename -- "$file")

  [[ "$filename" == '.'* ]] && continue

  extension="${filename##*.}"
  filename="${filename%.*}"

  if [[ "$extension" == "" ]]; then
    make_and_move "$file" "./misc"
  else
    make_and_move "$file" "./$extension"
  fi

done
