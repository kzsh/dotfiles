#!/bin/bash

main() {
  src=$1
  dest=$2

  activate_environment
  sync "$src" "$dest"
  deactivate_environment
}

sync() {
  local src=$1
  local dest=$2

  aws s3 sync "$src" "$dest"
}

activate_environment() {
  eval "$(pyenv init -)"
  pyenv activate aws
}

deactivate_environment() {
  pyenv deactivate
}

main "$@"
