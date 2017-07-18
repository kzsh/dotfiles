if command -v brew >/dev/null 2>&1; then
  [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
  debug_log "Loaded: autojump"
else
  [[ -s /usr/share/autojump/autojump.sh ]] && . /usr/share/autojump/autojump.sh
  debug_log "Loaded: autojump"
fi

