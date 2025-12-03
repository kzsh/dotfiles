#!/usr/bin/env bash

TYPE="$1"
VERSION="$2"

read -r -p "add envrc? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 0
touch ./.envrc
echo "\$DIRENV/$TYPE $VERSION" >> ./.envrc
direnv allow
