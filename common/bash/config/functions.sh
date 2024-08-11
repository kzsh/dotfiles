#!/usr/bin/env bash

is_interactive() {
  test -n "$PS1";
}

function via() {
  local most_recent_search

  most_recent_search=$(history | tail -10 | grep '^ *[0-9]\+ * \(fd\|rg\|ag\|grep\) \+.\+' | tail -1 | awk '{$1=""; print $0}')

  if [[ -n $most_recent_search ]]; then

    # If the previous search was not fd, we convert
    # it to list the matched files
    if [[ "$most_recent_search" != *'fd '* ]]; then
      most_recent_search="$most_recent_search -l"
    fi

    nvim -- $(eval $most_recent_search | xargs)
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
  grep -v "^ *\($REMOVE_MATCH\)[^a-zA-Z0-9] *"
}

persist_completions() {
  LANG=C find ~/.logs/* \
  | xargs cat \
  | awk '{xit=$3;$2=$3=""; print xit "	" $0 }' \
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

persist_successful_completions() {
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

dir_specific_completions() {
  LANG=C find ~/.logs/* \
  | xargs cat \
  | grep "$(pwd)[^/]" \
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
  local selected
  selected="$(persist_completions)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}

non-zero-hist-widget() {
  local selected
  selected="$(persist_successful_completions)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}

dir-specific-hist-widget() {
  local selected
  selected="$(dir_specific_completions)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}

is_interactive && bind -x '"\C-g": "dir-specific-hist-widget"'
is_interactive && bind -x '"\C-f": "non-zero-hist-widget"'
is_interactive && bind -x '"\C-e": "hist-widget"'

find-directory() {
  find ${1:-~} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m \
    | while read -r item; do
    printf '%s ' "$item"
  done
}

fd-widget() {
  local selected
  selected="$(find-directory)"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} - 1 ))
}

is_interactive && bind -x '"\C-n": "fd-widget"'

if command -v unicodeemoji > /dev/null 2>&1; then
  uni-widget() {
    local selected
    selected="$(unicodeemoji)"
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
  }

  if is_interactive; then
    stty kill undef
    bind -x '"\C-y": "uni-widget"'
  fi
fi

inject-into-command-line() {
  local command
  command="$*"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$command${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#command} ))
}
