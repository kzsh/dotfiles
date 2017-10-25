#!/bin/bash
function f () {
  if [[ -z "$1" ]]; then
    echo "Provide a search term"
    return
  fi

  find . -iname "$1"
  #mdfind "*$1*" -onlyin -name .
}
function vis() {
  local dir
  if [[ -z "$1" ]]; then
    dir="./"
  else
    dir="$1"
  fi

  nvim $(rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" "$dir" 2> /dev/null  | fzf)
}

alias vims="vis"
