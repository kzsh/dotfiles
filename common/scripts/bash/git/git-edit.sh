#!/bin/bash

echo first: $1
echo second: $2
DRY_RUN="$2"
TYPE="$1"

main() {
  case "$TYPE" in
    conflict)
      edit "$(conflict)"
      ;;
    c)
      edit "$(conflict)"
      ;;
    staged)
      edit "$(staged)"
      ;;
    s)
      edit "$(staged)"
      ;;
    notstaged)
      edit "$(not_staged)"
      ;;
    n)
      edit "$(not_staged)"
      ;;
    untracked)
      edit "$(untracked)"
      ;;
    u)
      edit "$(untracked)"
      ;;
    modified)
      edit "$(modified)"
      ;;
    m)
      edit "$(modified)"
      ;;
    *)
      edit "$(all)"
  esac
}

all() {
  echo '^..'
}

conflict() {
  echo '^UU'
}

modified() {
  echo '^M'
}

not_staged() {
  echo '^ [^ ]'
}

staged() {
  echo '^[^ ] '
}

untracked() {
  echo '^??'
}


edit() {
  local restriction
  restriction="$1"

  if [[ -n "$DRY_RUN" ]]; then
    echo "Dry Run"
    git status --porcelain | grep "$restriction" | awk '{ print $2}'
  else
    nvim -- $(git status --porcelain | grep "$restriction" | awk '{ print $2}')
  fi
}

main "$@"

# !nvim -- "$(git st --porcelain | awk '{ print $2}')"

# $EDITOR edit = !nvim --
