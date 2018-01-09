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

function kb() {
  local curr_dir
  curr_dir=$(pwd)
  cd "$HOME/kb" || exit "kb not found"
  vis "$@"
  cd "$curr_dir" || exit "Could not return to dir from which kb was launched"
}

function vilast() {
  local most_recent_grep
  most_recent_grep=$(tail -r -50 ~/.bash_history | grep "^\(ag\|rg\|grep\) .\+" | grep -v " -l " | head -1)
  if [[ -n $most_recent_grep ]]; then
    nvim -- "$(rg -l "$(echo "$most_recent_grep" | awk '{first = $1; $1 = ""; sub(/^[ \t]+/, ""); print $0}')")"
  else
    echo "no searches recent enough."
  fi
}

function vimlast() {
  vilast "$@"
}
