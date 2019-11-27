export LOG_FILE=
export LOG_CONFIG_SHOW_PATH=

function log() {
  if [[ -n "$2" ]]; then
    log_type="$2"
  else
    log_type="INFO"
  fi

  echo "$log_type: $1"
}

function configure_log() {
  LOG_FILE="$1"
  LOG_CONFIG_SHOW_PATH="$2"
}

function log_to_path() {
  if [[ -n "$LOG_CONFIG_SHOW_PATH" ]]; then
    echo log "$@"
  else
    log "$@"
  fi
}


function log_info() {
  log "$1" "INFO"
}

function log_debug() {
  log "$1" "DEBUG"
}

function log_error() {
  log "$1" "ERROR"
}

