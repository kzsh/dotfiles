#!/usr/bin/env bash
if [[ -z $XDG_CONFIG_HOME ]]; then
  CONFIGS_DIR="$HOME/.config"
else
  CONFIGS_DIR="$XDG_CONFIG_HOME"
fi

export CONFIG_DIR="$CONFIGS_DIR/envrc-cli"
export DEFAULT_CONFIG="$CONFIG_DIR/config"
: "${CONFIG:=$DEFAULT_CONFIG}"

export CONFIG

mkdir -p "$CONFIG_DIR"

if ! [[ -f "$CONFIG" ]]; then
  echo "Missing config (looked in \"$CONFIG\")"
fi

get_config_value() {
  local config
  config="$CONFIG"
  : "${config:=$DEFAULT_CONFIG}"
  grep -i "$1 *=.*" "$config" | cut -d'=' -f2-
}

edit_config() {
  "$EDITOR" "$CONFIG"
  exit 0
}
