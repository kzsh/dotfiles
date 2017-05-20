# VIM

. "$HOME/src/scripts/install/bash_debug_functions.sh"

export VIM_DIR="$HOME/.config/nvim"


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

if command -v brew >/dev/null 2>&1; then
  [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
  debug_log "Loaded: autojump"
else

  [[ -s /usr/share/autojump/autojump.sh ]] && . /usr/share/autojump/autojump.sh
  debug_log "Loaded: autojump"
fi

export FZF_DEFAULT_COMMAND='ag -g ""'
