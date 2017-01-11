#!/bin/bash

main() {
  src=$1
  dest=$2

  sync "$src" "$dest"
}

sync() {
  local src=$1
  local dest=$2

  aws s3 sync "$src" "$dest"
}

main "$@"
