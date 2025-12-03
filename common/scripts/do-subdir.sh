#!/bin/bash
for x in *; do
  # printf "\\n\\n\
  # =======================================================\\n\
  # %s/\\n\
  # =======================================================\\n" "$x"
  if cd "$x"; then
    $@ | sed "s/^/$x\\//"
    if [ $? ]; then
      cd ..
    else
      echo $?
      echo ERROR
      exit 1
    fi
  fi
done
