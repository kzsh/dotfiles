# VIM
export VIM_DIR="$HOME/.config/nvim"

export PYENV_ROOT=$HOME/.pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

export FZF_DEFAULT_COMMAND='ag -g ""'
