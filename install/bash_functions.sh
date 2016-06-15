#!/bin/bash
function f () {
  if [[ -z "$1" ]]; then
    echo "Provide a search term"
    return
  fi

  find . -iname "*$1*"
  #mdfind "*$1*" -onlyin -name .
}

function upgrade_cask() {
  brew cask uninstall "$1" && brew cask install "$1"
}

function upgrade_all_casks() {
  for cask in $(brew cask list); do
    upgrade_cask "$cask"
  done
}


