export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT=$HOME/.pyenv
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# function init-pyenv-fn() {
#   eval "$(pyenv init -)"
#   eval "$(pyenv virtualenv-init -)"
# }

# alias init-pyenv="init-pyenv-fn"
