node_version=$(node --version)
desired_version=''

#!/bin/bash
if [ -s ./.nvmrc ]; then
  while IFS='' read -r version || [ -n "$version" ]; do
    desired_version="$version"
  done < ./.nvmrc
fi

if [ -n "$desired_version" ]; then
  desired_version="v$desired_version"

  if [ "$node_version" != "$desired_version" ]; then
    echo "Changing $node_version to $desired_version"
    source "$(brew --prefix nvm)/nvm.sh"
    nvm use
  fi
fi
