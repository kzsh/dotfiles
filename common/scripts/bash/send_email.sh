#!/bin/bash
function main() {
  local recipient subject body
  recipient="$1"
  shift
  subject="$1"
  shift
  body="$*"

  if [[ -z "$recipient" ]]; then 
    echo "Error: Must specify a recipient."
    usage
  fi

  if [[ -z "$subject" ]]; then
    echo "Error: Must specify a subject."
    usage
  fi

  HEADER="To: $recipient\nSubject: $subject\nContent-Type: text/plain; charset=UTF-8"

  echo -e "${HEADER}\n\n${body}" | sendmail -t
}

usage() {
  cat <<-EOS

  Usage: send_email <recipient> <subject> [body]

  recipient	A valid email address
  subject	A valid email subject line
  body		A valid email body (optional)
EOS
}

main "$@"
