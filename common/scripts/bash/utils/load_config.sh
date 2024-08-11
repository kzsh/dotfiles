MAC_CONFIG_PATH="$HOME/Library/Application Support"
XDG_CONFIG_PATH="$XDG_CONFIG_HOME"

DEFAULT_CONFIG_NAME="config"

function locate_config() {
  local program_name="$1"
  local config_file_name="${1:-$DEFAULT_CONFIG_NAME}"

  if [[ -f "$XDG_CONFIG_PATH/$program_name/$config_file_name" ]]; then
    echo "$XDG_CONFIG_PATH/$program_name/$config_file_name"
  elif [[ -f "$MAC_CONFIG_PATH/$config_file_name" ]]; then
    echo "$MAC_CONFIG_PATH/$config_file_name" 
  elif [[  -f "$HOME/.${program_name}rc" ]]; then
    echo "$HOME/.${program_name}rc"
  else
    echo "no config found" >&2
    exit 1
  fi

}
