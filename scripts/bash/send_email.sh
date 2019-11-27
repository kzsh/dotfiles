#!/bin/bash
function main() {
  if [[ $# -eq 0 ]] ; then
    usage
    exit 0
  fi

  if [[ -z "$1" ]]; then echo "  Error: Must specify a recipient."
    usage
  fi

  if [[ -z "$2" ]]; then
    echo "  Error: Must specify a subject."
    usage
  fi

  HEADER="To: $1\nSubject: $2\nContent-Type: text/plain; charset=UTF-8"

  BODY="${*:3}"
  echo -e "${HEADER}\n\n${BODY}" | sendmail -t
}

function usage() {
  cat <<-EOS

  Usage: send_email <recipient> <subject> [body]

  recipient	A valid email address
  subject	A valid email subject line
  body		A valid email body (optional)
EOS
}

main "$@"
