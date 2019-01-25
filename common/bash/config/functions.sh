#!/bin/bash
function f() {
  local path
  path="${2%/}"
  path="${path:-./}"
  rg --smart-case --files "$path"** -g $1
  # | fzf -f "$1" --preview="cat"
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

function ff() {
  vim -c "execute \"vimgrep '$1' %\" | execute \"normal \\/$1\<CR>\"" -- $(ag "$1" -l);
}


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

# | ~/src/scripts/ruby/deduplicate.rb \
hist() {
  cmd="command rg \".*\" --no-line-number $HOME/.logs 2> /dev/null"
    eval "$cmd" \
      | awk '{$1=$2=$3=""; gsub(/^ */, "", $0); if(!seen[$0]++) print $0}' \
    | grep -v '^\s*\(n?vim?\|vo\|mv\|echo\|cd\|rm\|j\|f\|ag\|exit\|clear\|yarn\|npm\|ln\|ls\|gb\|gb -D\|fg\|tig\|ocker\)\s*' \
    | fzf +m \
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
