export PYENV_ROOT=$HOME/.pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
  debug_log "Loaded: pyenv"

  if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv virtualenv-init -)"
    debug_log "Loaded: virtual-env"
  fi
fi

