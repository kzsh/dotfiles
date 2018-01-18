export PYENV_ROOT=$HOME/.pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
debug_log "Loaded: pyenv"
eval "$(pyenv virtualenv-init -)"
debug_log "Loaded: virtual-env"

