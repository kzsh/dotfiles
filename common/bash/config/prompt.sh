#!/bin/bash

# Solarized colors
# https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized
BOLD=$(tput bold)
RESET=$(tput sgr0)
SOLAR_YELLOW=$(tput setaf 136)
PURPLE=$(tput setaf 260)
SOLAR_ORANGE=$(tput setaf 166)
SOLAR_BLUE=$(tput setaf 33)
SOLAR_CYAN=$(tput setaf 37)
SOLAR_GREEN=$(tput setaf 64)
SOLAR_WHITE=$(tput setaf 254)

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

GIT_DIFF_CHAR="•"
# Show the commit status of the current git repo
function git_repo_state() {
  local status
  status="$(git status 2>/dev/null | tail -n1)"
  [[ $status != *"nothing to commit"* ]] && echo " [!]";
}

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
  [[ "$output" ]] || output="$(echo "$status" | awk '/# On branch/ {print $4}')"
  [[ "$output" ]] || output="$(git branch | perl -ne '/^\* (.*)/ && print $1')"

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
# Reset to insert mode between prompts
PS1+="\ei"

# PS1+="\$(tmux_rename_window)"
# PS1+="\$(set_iterm2_profile)"
PS1+="\n"
if [[ "$SSH_TTY" ]]; then
  PS1+="${style_important}[SSH] " # [SSH]
fi
PS1+="\$(has_jobs)"
#PS1+="${style_user}\u${style_chars}" # @${style_host}\h" # username@host
PS1+="${style_chars}:: ${style_path}\w" # : directory
if [[ -z "$SSH_TTY" ]]; then
  PS1+="\$(prompt_git)" # Git details
  PS1+="\$(prompt_virtualenv)" # Virtualenv details
fi
PS1+="\n"
PS1+="${style_chars}\$ \[${RESET}\]"