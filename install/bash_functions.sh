#!/bin/bash
function f () {
  if [[ -z "$1" ]]; then
    echo "Provide a search term"
    return
  fi

  find . -iname "$1"
  #mdfind "*$1*" -onlyin -name .
}
