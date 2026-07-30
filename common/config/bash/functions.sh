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

REMOVE_MATCH=$(cat <<-'EOS' | paste -sd '%' - | sed 's/%/|/g'
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
rm
tig
tree
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
xo
zsh
zz
\{
EOS
)

remove_common_history() {
  grep -E -v '^ *('"$REMOVE_MATCH"')[^a-zA-Z0-9]? *'
}

# NUL delimited variant, for the cli-history pipelines.
remove_common_history_z() {
  grep -zEv '^ *('"$REMOVE_MATCH"')[^a-zA-Z0-9]? *'
}

# Multi-line commands are stored verbatim, but fzf cannot render them and pasting
# a raw newline into the readline buffer would submit part of the line. Backslash
# continuations collapse to a space, any remaining newline becomes '; ', which is
# how bash itself flattens compound commands into a single history entry.
flatten_multiline_z() {
  sed -z -e 's/[[:space:]]*\\\n[[:space:]]*/ /g' -e 's/\n[[:space:]]*/; /g'
}

# cli-history handles the ordering, deduplication and exit code filtering that
# the commented out plaintext pipelines did with awk/cut/sort. Records are NUL
# separated so command lines containing newlines survive the round trip.
#
# Order is chronological, newest first out of cli-history. fzf's default layout
# puts the first record next to the prompt and works upwards into the past, so no
# --tac. Once a query is typed fzf reorders matches by its own score, which is
# what we want; the chronological order is the resting state.
__cli_history_select() {
  # prompt.sh resolves this to the copy sitting beside these scripts; the default
  # keeps the pickers working if only functions.sh is sourced.
  local bin="${CLI_HISTORY_BIN:-cli-history}"
  command -v "$bin" >/dev/null 2>&1 || return

  local selected
  selected=$(
    "$bin" search --format command --unique --null --all "$@" \
      | flatten_multiline_z \
      | remove_common_history_z \
      | fzf --read0 +m
  )

  [[ -n "$selected" ]] && printf '%s ' "$selected"
  echo
}

persist_completions() {
  __cli_history_select
}

persist_successful_completions() {
  __cli_history_select --succeeded
}

dir_specific_completions() {
  __cli_history_select --succeeded --cwd .
}

# persist_completions() {
#   LANG=C find ~/.logs/* \
#   | sort \
#   | xargs cat \
#   | awk '{xit=$3;$2=$3=""; print xit "\t" $0 }' \
#   | cut -d'\t' -f2- \
#   | sort -k2,1000 -u \
#   | sort \
#   | cut -d' ' -f2- \
#   | sed 's/^ *//' \
#   | remove_common_history \
#   | fzf +m --tac \
#   | while read -r item; do
#     printf '%s ' "$item"
#   done
#   echo
# }
#
# persist_successful_completions() {
#   LANG=C find ~/.logs/* \
#   | sort \
#   | xargs cat \
#   | awk '{xit=$3;$2=$3=""; print xit "\t" $0 }' \
#   | sed '/^[^0]/d' \
#   | cut -d'\t' -f2- \
#   | sort -k2,1000 -u \
#   | sort \
#   | cut -d' ' -f2- \
#   | sed 's/^ *//' \
#   | remove_common_history \
#   | fzf +m --tac \
#   | while read -r item; do
#     printf '%s ' "$item"
#   done
#   echo
# }
#
# dir_specific_completions() {
#   LANG=C find ~/.logs/* \
#   | sort \
#   | xargs cat \
#   | grep "$(pwd)[^/]" \
#   | awk '{xit=$3;$2=$3=""; print xit "\t" $0 }' \
#   | sed '/^[^0]/d' \
#   | cut -d'\t' -f2- \
#   | sort -k2,1000 -u \
#   | sort \
#   | cut -d' ' -f2- \
#   | sed 's/^ *//' \
#   | remove_common_history \
#   | fzf +m --tac \
#   | while read -r item; do
#     printf '%s ' "$item"
#   done
#   echo
# }

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

# Named for what it shows: commands that exited 0. It was called
# non-zero-hist-widget while filtering on `sed '/^[^0]/d'`, which kept zero exits.
succeeded-hist-widget() {
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
is_interactive && bind -x '"\C-f": "succeeded-hist-widget"'
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
