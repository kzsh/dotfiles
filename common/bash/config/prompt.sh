#!/usr/bin/env bash

# Colors
BOLD=$(tput bold)
RESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
MAGENTA=$(tput setaf 13)
ORANGE=$(tput setaf 9)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
GREEN=$(tput setaf 2)
WHITE=$(tput setaf 7)
GRAY=$(tput setaf 240)

# Prompt styles
style_user="\[${RESET}${YELLOW}\]"
style_host="\[${RESET}${YELLOW}\]"
style_path="\[${RESET}${BOLD}${YELLOW}\]"
style_chars="\[${RESET}${BLUE}\]"
style_important="\[${RESET}${BOLD}${BLUE}\]"
style_group="${RESET}${YELLOW}"
style_timestamp="${RESET}${GRAY}"
style_branch="${RESET}${MAGENTA}"
style_virtualenv="${RESET}${MAGENTA}"
style_kubernetes="${RESET}${MAGENTA}"
style_has_jobs="${RESET}${YELLOW}"
style_job_count="${RESET}${MAGENTA}"
style_last_exit_code_bad="${RESET}${RED}"
style_last_exit_code_base="${RESET}${YELLOW}"

style_git_unstaged="${RESET}${GREEN}"
style_git_staged="${RESET}${YELLOW}"
style_git_untracked="${RESET}${CYAN}"
style_git_deleted="${RESET}${RED}"

# Misc config

GIT_DIFF_CHAR="•"

# ensure directories
mkdir -p /tmp/i3

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

build_ps1() {
  # Build the prompt
  PS1="\033]0;\a"
  PS1+="\n"

  if [[ "$SSH_TTY" ]]; then
    PS1+="${style_important}[SSH] " # [SSH]
  fi

  # If not an ssh tty
  if [[ -z "$SSH_TTY" ]]; then
    PS1+="\$(prompt_git)\$(prompt_kubernetes)\$(prompt_virtualenv)\n"
    PS1+="\$(has_jobs)"
    PS1+="${style_path}\w"
    PS1+=" ${style_timestamp}[\$(date -u "+%Y-%m-%dT%H:%M:%S")]"
  fi

  if [[ "$__KZSH__LAST_EXIT_CODE" != "0" ]]; then
    PS1+=" ${style_last_exit_code_base}(\$(last_exit)${style_last_exit_code_base})"
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
has_jobs() {
  job_count=$(jobs -l | awk '{ print $3 }' | grep -vc "Done")
  if [ $job_count -gt 0 ]; then
    prompt_jobs="[${style_job_count}$job_count${style_has_jobs}]"
    echo -ne "${style_has_jobs}${prompt_jobs} "
  else
    echo -ne ""
  fi
}

build_flags() {
  local status flags s us ut
  status="$(git status --porcelain)"
  [[ $? != 0 ]] && return;

  while IFS=  read -r line ; do
    case $line in
      ' M '* |' D '*)
        us=1
        ;;
      # order matters here
      'M '*|'D '*)
        s=1
        ;;
      '??'*)
        ut=1
        ;;
    esac
  done <<< "$status"

  [[ -n $s ]] && flags+="${style_git_staged}${GIT_DIFF_CHAR}"
  [[ -n $us ]] && flags+="${style_git_unstaged}${GIT_DIFF_CHAR}"
  [[ -n $ut ]] && flags+="${style_git_untracked}${GIT_DIFF_CHAR}"

  if [[ -n "$flags" ]]; then
    echo "$flags"
  fi
}

# Show the name and status of the current git repo
prompt_git() {
  local output flags

  if ! git rev-parse HEAD > /dev/null 2>&1; then
    return
  fi

  [[ "$output" ]] || output="$(git rev-parse --abbrev-ref HEAD)"
  [[ "$output" == "HEAD" ]] && output="$(git rev-parse --short HEAD)"

  # flags=$(build_flags)
  # [[ "$flags" ]] && output+=" ${flags}"

  echo -ne "${style_group}git[${style_branch}${output}${style_group}]"
}

# Show the name and status of the current k8s context
prompt_kubernetes() {
  local context
  context=$(kubectl config current-context 2>/dev/null)
  namespace="$(kcl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)"

  if [[ -z "$namespace" ]]; then
    return
  fi
  : "${namespace:=default}"

  [[ "$?" != 0 ]] && return;
  echo -ne " ${style_group}k8s[${style_kubernetes}${context}:${namespace}${style_group}]"
}

# Show the name of the current virtualenv
prompt_virtualenv() {
  local env_name
  env_name=$(basename "$VIRTUAL_ENV")

  PIPENV_ACTIVE=1

  if [[ -n "$env_name" ]]; then
    echo -ne " ${style_group}venv[${style_virtualenv}${env_name}${style_group}]"
  fi
}

log_history() {
  if [[ "$(id -u)" -ne 0 ]]; then
    CWD="$(pwd)"
    echo $CWD > /tmp/i3/cwd
    cmd=$(history 1 | awk '{ $1=""; print $0}' | sed 's/^ *//g')
    logfile="$HOME/.logs/bash-history-$(date "+%Y-%m-%d").log"
    data="$(date "+%Y-%m-%d.%H:%M:%S")	$CWD	$(last_exit_code)	$cmd"

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
