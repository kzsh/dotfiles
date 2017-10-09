completion_sources=(
  "$HOME/src/scripts/bash/completions/git/git-completion.sh"
  "$(brew --prefix pass)/etc/bash_completion.d/pass"
  "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
)

for src in "${completion_sources[@]}"; do
  # -s == if file exists and has size > 0
  if [[ -s $src ]]; then
    # shellcheck disable=1090
    . "$src"
    debug_log "Loaded: $src"
  fi
done
