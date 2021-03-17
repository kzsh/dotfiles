CONFIG_XDA="$HOME/.config/xcctl"
CONFIG_FILE="$CONFIG_XDA/config"

init() {
  mkdir -p "$CONFIG_XDA"
  touch "$CONFIG_FILE"
}

find_upward() {
  result=
  while [[ -z "$result" && "$PWD" != / ]] ; do
    result=$(find "$PWD" -maxdepth 1 -name "$@")
      cd ..
  done
  echo "$result"

}

find_project() {
  find_upward "*.xcodeproj"
}

get_build_setting() {
  PROJECT=$(find_project)
  BUNDLE_NAME="$(xcodebuild -project "$PROJECT" -showBuildSettings -json | jq -r ".[0] | .buildSettings | .[\"$*\"]")"
  echo $BUNDLE_NAME
}

find_local_config() {
  find_upward "xcctlconf"
}

get_config_value() {
  local conf_file
  conf_file=$(find_local_config) || "$CONFIG_FILE"
  if [[ "$conf_file" == "" ]]; then
    conf_file="$CONFIG_FILE"
  fi
  grep  "$1" "$conf_file" | grep -o '=.*' | cut -c 2-
}

get_global_config_value() {
  grep  "$1" "$CONFIG_FILE" | grep -o '=.*' | cut -c 2-
}
