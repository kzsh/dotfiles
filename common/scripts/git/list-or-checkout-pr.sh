#!/bin/bash
if [[ "$1" ]]; then
  hub pr checkout "$1"
else
  hub pr list
fi
