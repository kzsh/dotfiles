#!/bin/bash

# Enable NVM
echo "$NVM_DIR"
if [[ -z "$NVM_DIR" ]]; then
  echo "loading nvm"
  # unalias first since nvm.sh just aliases nvm
  unalias nvm
  export NVM_DIR=~/.nvm

  if command -v brew >/dev/null 2>&1; then
    . $(brew --prefix nvm)/nvm.sh
  else
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  fi

fi
nvm "$@"
