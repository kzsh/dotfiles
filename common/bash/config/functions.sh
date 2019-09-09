#!/bin/bash
function f() {
  local path
  path="${2:-./}"
  match=$(echo $1 | sed 's/\*/.*/g')
  rg --smart-case --files "$path" -g $1 \
    | rg "$match"
}

function via() {
  local most_recent_grep
  most_recent_grep=$(tail -r -10 ~/.bash_history | grep "^\(ag\|rg\|grep\)\s\+.\+" | grep -v " -l " | head -1)
  normalized_grep_value="$(echo "$most_recent_grep" | awk '{$1=""; print $0}' | cut -d';' -f1 | sed -e "s/^ *'(.+)'$/\1/")"
  echo $most_recent_grep
  echo $normalized_grep_value
  if [[ -n $normalized_grep_value ]]; then
    nvim -- $(rg -l $normalized_grep_value | xargs)
  else
    echo "no searches recent enough."
  fi
}

alias vima="via"

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
REMOVE_MATCH=$(cat <<-'EOS' | paste -sd '%' - | sed 's/%/\\|/g'
nvim
vim
vi
vo
mv
echo
cd
rm
j
f
ag
exit
clear
yarn
npm
ln
ls
gb
gb -D
fg
tig
ocker
git st
git push
git wip
qgit
:
\/
\~
|
{
yarb
yuarn
yar
arn
yanr
yurn
uarn
uyarn
vfg
vf
v\s
v$
y$
zs$
why
wip
which
whence
wgit
whoami
tree
zz
✅
🎯
🔍
xe
t\s
xeit
xirt
xit
xo
zsh
bash
\$
!
-
=
\?
;
'
"
\*
at$
#
EOS
)

remove_common_history() {
  grep -v "^ *\($REMOVE_MATCH\) *"
}

persist_completions() {
  find ~/.logs/* \
  | xargs cat \
  | awk '{xit=$3;$2=$3=""; print xit$0 }' \
  | LANG=C sed '/^[^0]/d' \
  | LANG=C sed 's/ +[ 0-9.]+/	/' \
  | LANG=C cut -c 2- \
  | LANG=C sort -k2 -u \
  | LANG=C sort -ru \
  | awk '{$1=""; print $0}' \
  | fzf +m \
  | while read -r item; do
    printf '%s ' "$item"
  done
  echo
}


hist() {
  cmd="cat $HOME/.custom-history-completions/completions 2> /dev/null"
    eval "$cmd" \
    | fzf +m \
    | awk '{$1=""; print $0}' \
    | while read -r item; do
    printf '%s ' "$item"
  done
  echo
}

hist-widget() {
  local selected="$(persist_completions)"
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

inject-into-command-line() {
  command="$@"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$command${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#command} ))
}


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
