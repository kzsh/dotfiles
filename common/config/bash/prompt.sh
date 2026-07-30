#!/usr/bin/env bash

# Colors
if [[ -n $TERM ]]; then
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
else
BOLD=""
RESET=""
RED=""
YELLOW=""
MAGENTA=""
ORANGE=""
BLUE=""
CYAN=""
GREEN=""
WHITE=""
GRAY=""
fi

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

# The cli-history binary lives next to this file. Falls back to PATH so a copy
# installed elsewhere still works, and so does a shell sourcing these scripts
# from outside the repo.
if [[ -z "$CLI_HISTORY_BIN" ]]; then
  __kzsh_config_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  if [[ -x "$__kzsh_config_dir/cli-history" ]]; then
    CLI_HISTORY_BIN="$__kzsh_config_dir/cli-history"
  else
    CLI_HISTORY_BIN="cli-history"
  fi
  export CLI_HISTORY_BIN
  unset __kzsh_config_dir
fi

# ensure directories
mkdir -p /tmp/i3

# Main methods
__set_prompt() {
  export __KZSH__LAST_EXIT_CODE=$?
  capture_duration
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
    if command -v avahi-resolve-address >/dev/null 2>&1; then
      HOSTNAME="$(avahi-resolve-address 127.0.0.1 | cut -d '	' -f2-)"
    else
      HOSTNAME="$(hostname)"
    fi
    PS1+="${style_important}SSH[${HOSTNAME}] " # [SSH]
  fi

  # PS1+="\$(prompt_git)\$(prompt_kubernetes)\$(prompt_virtualenv)\$(prompt_nodejs_version)\n"
  PS1+="\$(print_envs)\n"
  PS1+="\$(has_jobs)"
  PS1+="${style_path}\w"
  PS1+=" ${style_timestamp}[\$(date -u "+%Y-%m-%dT%H:%M:%S")]"

  if [[ "$__KZSH__LAST_EXIT_CODE" != "0" ]]; then
    PS1+=" ${style_last_exit_code_base}(\$(last_exit)${style_last_exit_code_base})"
  fi

  PS1+="\n"
  PS1+="${style_chars}\$ \[${RESET}\]"
}

__initialization() {
  if [[ ! -d $HOME/.logs ]]; then
    mkdir -p "$HOME/.logs"
  fi

  # Scopes cli-history duplicate suppression to this shell.
  if [[ -z "$CLI_HISTORY_SESSION" ]]; then
    export CLI_HISTORY_SESSION="$(date -u "+%Y%m%dT%H%M%SZ")-$$"
  fi

  # Stamps a start time for every command line without forking. PS0 is expanded
  # after the line is read and before it runs; taking a zero length substring of
  # a set variable evaluates the arithmetic (which performs the assignment) while
  # printing nothing. The variable must be non-empty or bash skips the offset.
  # Requires bash 5 for EPOCHREALTIME.
  if ((BASH_VERSINFO[0] >= 5)); then
    __KZSH__PS0_PAD=x
    PS0='${__KZSH__PS0_PAD:$(( ${__KZSH__CMD_START:=${EPOCHREALTIME//[!0-9]/}} * 0 )):0}'
  fi
}

# Turns the PS0 stamp into a millisecond runtime. Empty when no command ran,
# which is the case for an empty prompt line.
capture_duration() {
  __KZSH__LAST_DURATION_MS=""
  if [[ -n "$__KZSH__CMD_START" ]]; then
    __KZSH__LAST_DURATION_MS=$(( (${EPOCHREALTIME//[!0-9]/} - __KZSH__CMD_START) / 1000 ))
    unset __KZSH__CMD_START
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
  namespace="$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)"

  if [[ -z "$namespace" ]]; then
    return
  fi
  : "${namespace:=default}"

  echo -ne "${style_group}k8s[${style_kubernetes}${context}:${namespace}${style_group}]"
}

# Show the name of the current nvm version
prompt_nodejs_version() {
  local env_name
  if command -v node > /dev/null 2>&1; then
    env_name="$(node --version)"

    if [[ -n "$env_name" ]]; then
      echo -ne "${style_group}node[${style_virtualenv}${env_name}${style_group}]"
    fi
  fi
}

# Show the name of the current virtualenv
prompt_virtualenv() {
  local env_name
  if command -v python >/dev/null 2>&1; then
    if [[ -n "$VIRTUAL_ENV" ]]; then
      if [[ -d $PWD/.venv ]]; then
        echo -ne "${style_group}uv[${style_virtualenv}$(python --version | cut -d ' ' -f2-)${style_group}]"
      else
        echo -ne "${style_group}venv[${style_virtualenv}${VIRTUALENV}${style_group}]"
      fi
    else
      echo -ne "${style_group}python[${style_virtualenv}$(python --version)${style_group}]"
    fi
  fi
}

print_envs() {
  local env_commands output
  env_commands=(
    prompt_git
    prompt_kubernetes
    prompt_virtualenv
    prompt_nodejs_version # too slow
    )

    for c in "${env_commands[@]}"; do
      output="$output $($c)"
    done
    echo "$output" | sed 's/  \+/ /g;s/^ *\(.*\)/\1/;'
}

log_history() {
  [[ "$(id -u)" -eq 0 ]] && return

  CWD="$(pwd)"
  echo "$CWD" > /tmp/i3/cwd

  local cmd
  cmd=$(current_history_entry)
  [[ -z "$cmd" ]] && return

  log_history_plaintext "$cmd"

  if command -v "$CLI_HISTORY_BIN" >/dev/null 2>&1; then
    # Omitted flags are recorded as unknown rather than as a zero exit or a zero
    # runtime, so only pass what was actually measured.
    local -a optional=()
    [[ -n "$__KZSH__LAST_EXIT_CODE" ]] && optional+=(--exit-code "$__KZSH__LAST_EXIT_CODE")
    [[ -n "$__KZSH__LAST_DURATION_MS" ]] && optional+=(--duration-ms "$__KZSH__LAST_DURATION_MS")

    printf '%s' "$cmd" |
      "$CLI_HISTORY_BIN" log --cwd "$CWD" "${optional[@]}"
  fi
}

# The last history entry with its leading number removed, and nothing else
# touched. A multi-line entry keeps every line: awk '{ $1=""; print }' used to
# strip the first field of *each* line, so `shutdown \<newline>-r now` was
# recorded as `shutdown \<newline>now`. HISTTIMEFORMAT is cleared so a configured
# timestamp cannot end up inside the command text.
current_history_entry() {
  local raw
  raw=$(HISTTIMEFORMAT= history 1)

  # `.` matches newlines here, so the capture spans continuation lines.
  if [[ $raw =~ ^[[:space:]]*[0-9]+[[:space:]]+(.*)$ ]]; then
    printf '%s' "${BASH_REMATCH[1]}"
  fi
}

# Legacy tab delimited daily logs, kept in parallel with cli-history for now.
log_history_plaintext() {
  local cmd="$1" logfile data
  logfile="$HOME/.logs/bash-history-$(date "+%Y-%m-%d").log"
  [[ -f "$logfile" ]] || touch "$logfile"
  data="$(date "+%Y-%m-%d.%H:%M:%S")	$CWD	$__KZSH__LAST_EXIT_CODE	$cmd"

  # Add entry if it isn't a duplicate of the last entry
  if [[ "$(tail -1 "$logfile" | awk '{ $1=""; print $0 }')" != "$(echo "$data" | awk '{ $1=""; print $0 }')" ]]; then
    echo "$data" >> "$logfile"
  fi
}

__initialization
