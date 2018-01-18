function log() {
  if [[ -z "$LOGGING" ]]; then
    echo "LOG($0): $1" >> /tmp/chunkwm-integrations.log
  fi
}

