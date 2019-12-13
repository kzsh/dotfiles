#!/bin/bash

  PARAMS=""
  while (( "$#" )); do

    # normalize
    [[ $1 == --*=* ]] && set -- "${1%%=*}" "${1#*=}" "${@:2}"

    case "$1" in
      -*|--*=) # unsupported flags
        echo x
        shift 2
        ;;
      *) # preserve positional arguments
        echo y
        PARAMS="$PARAMS $1"
        shift
        ;;
    esac
  done
  # set positional arguments in their proper place
  eval set -- "$PARAMS"

file=${1:--}
while IFS= read -r line; do
  printf '%s\n' "$line" 
done < <(cat -- "$file")
