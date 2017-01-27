# VIM

. "$HOME/src/scripts/install/bash_debug_functions.sh"

export VIM_DIR="$HOME/.config/nvim"
export PYENV_ROOT=$HOME/.pyenv

eval "$(pyenv init -)"
debug_log "Loaded: pyenv"

eval "$(pyenv virtualenv-init -)"
debug_log "Loaded: virtual-env"


[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
debug_log "Loaded: autojump"

export FZF_DEFAULT_COMMAND='ag -g ""'
