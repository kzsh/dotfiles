#!/bin/bash

CWD="$(pwd)"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$HOME/bin/util.sh"

goToPath "$DIR/.."
BASE_DIR="$PWD"
SCRIPT_DIST_DIR="$BASE_DIR/applescripts/dist"


function main() {
  goToPath "$BASE_DIR/applescripts"
  ./compileScripts.sh


  goToPath "$BASE_DIR/automator"

  script_file_names=$(ls "$SCRIPT_DIST_DIR/"*.service.js.scpt)
  for file_name in $script_file_names; do
    buildWorkflowWrapper "$file_name"
  done

  goToPath "$CWD"
}

function buildWorkflowWrapper() {
  local script_config
  local target_application
  local file_name="$1"

  script_config=$(head -n1 "$file_name" | awk '{ print $2 " " $3}')
  target_application=$(echo "$script_config" | cut -d'=' -f2 | tr -d '"' )
  ./makeWorkflow.sh "$file_name" "$target_application"
}

main "$@"
