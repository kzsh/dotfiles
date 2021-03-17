#!/usr/bin/env bash

function via() {
  local most_recent_grep

  most_recent_grep=$(history | tail -10 | grep "\(\d\+\)\s*\(ag.\?\|rg\|grep\)\s\+.\+" | awk '{$1=""; print $0}' | tail -1)

  echo $most_recent_grep
  if [[ -n $most_recent_grep ]]; then
    most_recent_grep="$most_recent_grep -l"
    nvim -- $(eval $most_recent_grep | xargs)
  else
    echo "no searches recent enough."
  fi
}

alias vima="via"

REMOVE_MATCH=$(cat <<-'EOS' | paste -sd '%' - | sed 's/%/\\|/g'
!
"
#
'
-
:
;
=
\$
\*
\/
\?
\~
andrew
arn
at$
bash
cd
clear
echo
exit
fg
gb
gb -D
git push
git st
git wip
j 
ln
ls
mv
npm
nvim
ocker
qgit
rm
t\s
tig
tree
uarn
uyarn
v$
v\s
vf
vfg
vi
vim
vo
wgit
whence
which
whoami
why
wip
xe
xeit
xirt
xit
xo
y$
yanr
yar
yarb
yuarn
yurn
zs$
zsh
zz
{
|
✅
🎯
🔍
EOS
)

remove_common_history() {
  grep -v "^ *\($REMOVE_MATCH\) *"
}

persist_completions() {
  LANG=C find ~/.logs/* \
  | xargs cat \
  | awk '{xit=$3;$2=$3=""; print xit "	" $0 }' \
  | sed '/^[^0]/d' \
  | cut -d'	' -f2- \
  | sort -k2,1000 -u \
  | sort \
  | cut -d' ' -f2- \
  | sed 's/^ *//' \
  | remove_common_history \
  | fzf +m --tac \
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
