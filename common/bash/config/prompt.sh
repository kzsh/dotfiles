#!/bin/bash

# Colors
BOLD=$(tput bold)
RESET=$(tput sgr0)
RED=$(tput setaf 1)
SOLAR_YELLOW=$(tput setaf 3)
PURPLE=$(tput setaf 13)
SOLAR_ORANGE=$(tput setaf 9)
SOLAR_BLUE=$(tput setaf 4)
SOLAR_CYAN=$(tput setaf 6)
SOLAR_GREEN=$(tput setaf 2)
SOLAR_WHITE=$(tput setaf 7)

# Prompt styles
style_user="\[${RESET}${SOLAR_YELLOW}\]"
style_host="\[${RESET}${SOLAR_YELLOW}\]"
style_path="\[${RESET}${BOLD}${SOLAR_YELLOW}\]"
style_chars="\[${RESET}${SOLAR_BLUE}\]"
style_important="\[${RESET}${BOLD}${SOLAR_BLUE}\]"
style_branch="${SOLAR_YELLOW}"
style_virtualenv="${BOLD}${SOLAR_ORANGE}"
style_has_jobs="${SOLAR_YELLOW}"
style_job_count="${PURPLE}"
style_last_exit_code_bad="${RED}"
style_last_exit_code_base="${SOLAR_YELLOW}"

style_git_unstaged="${RESET}${SOLAR_GREEN}"
style_git_staged="${RESET}${SOLAR_YELLOW}"
style_git_untracked="${RESET}${SOLAR_CYAN}"

# Misc config

GIT_DIFF_CHAR="•"

# Main methods
__set_prompt() {
  export __KZSH__LAST_EXIT_CODE=$?
  build_ps1
  history -a
  history -c
  history -r
  log_history
}
export PROMPT_COMMAND=__set_prompt

export PROMPT_COMMAND=__set_prompt

build_ps1() {
  # Build the prompt
  PS1="\033]0;\a"
  PS1+="\n"
  if [[ "$SSH_TTY" ]]; then
    PS1+="${style_important}[SSH] " # [SSH]
  fi

  PS1+="\$(has_jobs)"
  PS1+="${style_chars}:: ${style_path}\w" # : directory

  # If not an ssh tty
  if [[ -z "$SSH_TTY" ]]; then
    PS1+="\$(prompt_git)" # Git details
    PS1+="\$(prompt_virtualenv)" # Virtualenv details
  fi

  if [[ "$__KZSH__LAST_EXIT_CODE" != "0" ]]; then
    PS1+=" (${style_last_exit_code_base}\$(last_exit)${style_last_exit_code_base})"
  fi

  PS1+="\n"
  PS1+="${style_chars}\$ \[${RESET}\]"
}

__initialization() {
  if [[ ! -f $HOME/.logs ]]; then
    mkdir -p "$HOME/.logs"
  fi
}

last_exit() {
    echo -ne "${style_last_exit_code_bad}${__KZSH__LAST_EXIT_CODE}"
}

# Local methods
function has_jobs() {
  job_count=$(jobs -l | awk '{ print $3 }' | grep -vc "Done")
  prompt_jobs="[${style_job_count}$job_count${style_has_jobs}] "
  echo -ne "${style_has_jobs}${prompt_jobs}"
}

# Show the name and status of the current git repo
function prompt_git() {
  local status output flags
  status="$(git status 2>/dev/null)"
  [[ $? != 0 ]] && return;

  output="$(echo "$status" | awk '/# Initial commit/ {print "(init)"}')"
  [[ "$output" ]] || output="$(git rev-parse --abbrev-ref HEAD)"
  [[ "$output" == "HEAD" ]] && output="$(git rev-parse --short HEAD)"

  flags="$(
  echo "$status" | awk 'BEGIN {r=""}
    /^Changes to be committed:$/        {r=r "'${style_git_staged}${GIT_DIFF_CHAR}'"}
    /^Changes not staged for commit:$/  {r=r "'${style_git_unstaged}${GIT_DIFF_CHAR}'"}
    /^Untracked files:$/                {r=r "'${style_git_untracked}${GIT_DIFF_CHAR}'"}
    END {print r}'
  )"

  if [[ "$flags" ]]; then
    output="$output[${flags}${style_branch}]"
  fi
  echo -ne "${RESET}${SOLAR_BLUE} on ${style_branch}${output}"
}

# Show the name of the current virtualenv
function prompt_virtualenv() {
  local env_name
  env_name=$(basename "$VIRTUAL_ENV")

  if [[ -n "$env_name" ]]; then
    echo -ne " ${style_virtualenv}[env/${env_name}]"
  fi
}

log_history() {
  if [[ "$(id -u)" -ne 0 ]]; then
    cmd=$(history 1 | awk '{ $1=""; print $0}' | sed 's/^ *//g')
    logfile="$HOME/.logs/bash-history-$(date "+%Y-%m-%d").log"
    data="$(date "+%Y-%m-%d.%H:%M:%S")	$(pwd)	$(last_exit_code)	$cmd"

    # Add entry if it isn't a duplicate of the last entry
    if [[ "$(tail -1 "$logfile" | awk '{ $1=""; print $0 }')" != "$(echo "$data" | awk '{ $1=""; print $0 }')" ]]; then
      echo "$data" >> "$logfile"
    fi
  fi
}

last_exit_code() {
  echo "$__KZSH__LAST_EXIT_CODE"
}

__initialization
