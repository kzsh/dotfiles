#!/bin/bash

if command -v kubectl  > /dev/null 2>&1; then
  . <(kubectl completion bash)

  # krew
  export PATH="${PATH}:${HOME}/.krew/bin"
fi
