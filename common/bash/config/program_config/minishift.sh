#!/usr/bin/env/bash
export PATH="/Users/andrewhunt/.minishift/cache/oc/v3.11.0/darwin:$PATH"
# Run this command to configure your shell:
if minishift status | grep -q Running; then
  eval "$(minishift oc-env)"
  . <(oc completion bash)
fi
