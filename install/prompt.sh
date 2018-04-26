#!/bin/bash

# Solarized colors
# https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized
BOLD=$(tput bold)
RESET=$(tput sgr0)
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

style_git_unstaged="${RESET}${SOLAR_GREEN}"
style_git_staged="${RESET}${SOLAR_YELLOW}"
style_git_untracked="${RESET}${SOLAR_CYAN}"

# Show the commit status of the current git repo
function git_repo_state() {
  local status
  status="$(git status 2>/dev/null | tail -n1)"
  [[ $status != *"nothing to commit"* ]] && echo " [!]";
}

function has_jobs() {
  hasjobs=$(jobs -l | awk '{ print $3 }' | grep -v "Done" | wc -l | tr -d ' ')
  if [[ "$hasjobs" == "0" ]]; then
    show_has_jobs=''
  else
    job_count="$((hasjobs))"
    show_has_jobs="[${style_job_count}$job_count${style_has_jobs}] "
  fi
  echo -ne "${style_has_jobs}${show_has_jobs}"
}

# Show the name and status of the current git repo
function prompt_git() {
  local status output flags
  status="$(git status 2>/dev/null)"
  [[ $? != 0 ]] && return;

  output="$(echo "$status" | awk '/# Initial commit/ {print "(init)"}')"
  [[ "$output" ]] || output="$(echo "$status" | awk '/# On branch/ {print $4}')"
  [[ "$output" ]] || output="$(git branch | perl -ne '/^\* (.*)/ && print $1')"

  flags="$(
  echo "$status" | awk 'BEGIN {r=""}
    /^Changes to be committed:$/        {r=r "'${style_git_staged}'•"}
    /^Changes not staged for commit:$/  {r=r "'${style_git_unstaged}'•"}
    /^Untracked files:$/                {r=r "'${style_git_untracked}'•"}
    END {print r}'
  )"

  if [[ "$flags" ]]; then
    output="$output[${flags}${style_branch}]"
  fi
  echo -ne "${RESET}${SOLAR_BLUE} on ${style_branch}${output}" # $(git_repo_state)"
}

# Show the name of the current virtualenv
function prompt_virtualenv() {
  local env_name
  env_name=$(basename "$VIRTUAL_ENV")

  if [[ -n "$env_name" ]]; then
    echo -ne " ${style_virtualenv}[env/${env_name}]"
  fi
}

function tmux_rename_window() {
  case "$TERM" in
    screen*)
      tmux rename-window "$(last_command)"
      ;;
  esac
}

function set_iterm2_profile() {
  is_inverted=$(cat ~/.config/chunkwm/inversion_enabled)
  if [[ -z "$is_inverted" ]]; then
    if [[ "$is_inverted" == "1" ]]; then
      theme="Default Bright"
    else
      theme="Default Dark"
    fi

    if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
      echo -e "\033]50;SetProfile=$theme\a"
    else
      echo ""
    fi
  fi
}

# Build the prompt
PS1="\033]0;\a"
PS1+="\$(tmux_rename_window)"
PS1+="\$(set_iterm2_profile)"
PS1+="\n"
if [[ "$SSH_TTY" ]]; then
  PS1+="${style_important}[SSH] " # [SSH]
fi
PS1+="\$(has_jobs)"
PS1+="${style_user}\u${style_chars}@${style_host}\h" # username@host
PS1+="${style_chars} :: ${style_path}\w" # : directory
if [[ -z "$SSH_TTY" ]]; then
  PS1+="\$(prompt_git)" # Git details
  PS1+="\$(prompt_virtualenv)" # Virtualenv details
fi
PS1+="\n"
PS1+="${style_chars}\$ \[${RESET}\]"
