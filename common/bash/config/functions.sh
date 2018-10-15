#!/bin/bash
function f() {
  local path
  path="${2%/}"
  find ${path:-.} -iname $1 "${@:3}"
}

function vis() {
  local dir
  dir="$(given_path_or_default "$1")"
  nvim -c ":execute 'Files' '$dir'"
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

alias vimlast="vilast"

# Run yamllint, looking for config files in a series of logical directories
function yaml_lint() {
  paths=(
    "./"
    "$(git_root)"
    "$HOME/.yamllint"
  )

  for path in "${paths[@]}"; do
    config_path="$path/.yamllint"
    [[ -f "$config_path" ]] && "$(which yamllint)" -c "$config_path" $@
  done
}

alias yamllint='yaml_lint'

function logs() {
  ag $@ "$HOME/.logs"
}

function reuse_tig() {
  tig_job=$(jobs | grep -v grep | grep "\[\d\+\][+-]\s*Stopped.*tig\s\?.*" | tail -1 | grep -o "\[\(.\+\)\]" | tr -d "[]")

  echo $tig_job
  if [[ -n "$tig_job" ]]; then
    fg "%${tig_job}"
  else
    /usr/local/bin/tig "$@"
  fi

}

hist() {
  cmd="command rg \".*\" --no-line-number --no-filename $HOME/.logs 2> /dev/null"

    eval "$cmd" \
    | awk '{$1=$2=$3=""; print $0}' \
    | sed 's/^[ \d]*//; s/ *$//;' \
    | ~/src/scripts/ruby/deduplicate.rb \
		| grep -v '^\w\{1,3\}\s*$' \
    | grep -v '^\s*\(vi \|cd \|rm \|j \|f \|ag \|~\||\|exit \)' \
    | fzf \
    | while read -r item; do
    printf '%s ' "$item"
  done
  echo
}

hist-widget() {
  local selected="$(hist)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}

bind -x '"\C-f": "hist-widget"'

find-directory() {
  find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m \
    | while read -r item; do
    printf '%s ' "$item"
  done
}

fd-widget() {
  local selected="$(find-directory)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} - 1 ))
}

bind -x '"\C-n": "fd-widget"'


function given_path_or_default() {
  if [[ -z "$1" ]]; then
    root=$(git_root)

    if [[ "$?" == "0" ]]; then
      dir="$root"
    else
      dir='./'
    fi
  else
    dir="$1"
  fi

  echo "$dir"
}
