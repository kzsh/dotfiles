# direnv
if command -v direnv > /dev/null 2>&1; then
  eval "$(direnv hook bash)"
  export DIRENV="$COMMON_SCRIPTS/bash/direnv"
  export DIRENV_WARN_TIMEOUT="30s"
fi
