#!/bin/bash

# Enable NVM
echo "$NVM_DIR"
if [[ -z "$NVM_DIR" ]]; then
  echo "loading nvm"
  # unalias first since nvm.sh just aliases nvm
  unalias nvm
  export NVM_DIR=~/.nvm
  source $(brew --prefix nvm)/nvm.sh
fi
nvm "$@"
