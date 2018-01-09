#!/bin/bash

if [[ -L $0 ]]; then
  echo "$(dirname "$(greadlink -f "$0")")"
else
  echo "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

