DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

build_aliases() {
  local target_function
  target_function=$1
  aliased_functions=${*:2}

  for target in "${aliased_functions[@]}"; do
    # -s == if file exists and has size > 0
    debug_log "Configuring lazy load for: $target_function ($target)"
    alias $target="$target_function $target"
  done
}

programs_dir="$DIR/program_config"

programs=(
  "$programs_dir/pyenv.sh"
  "$programs_dir/nvm.sh"
  "$programs_dir/git.sh"
  "$programs_dir/pass.sh"
  "$programs_dir/vim.sh"
  "$programs_dir/autojump.sh"
  "$programs_dir/fzf.sh"
  "$programs_dir/direnv.sh"
)

for program in "${programs[@]}"; do
  #shellcheck disable=1090
  . "$program"
done
