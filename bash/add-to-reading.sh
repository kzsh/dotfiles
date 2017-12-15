#!/bin/bash
if [[ -L $0 ]]; then
  SCRIPT_DIR="$(dirname "$(greadlink -f "$0")")"
else
  SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

BODY="${*}"

"$SCRIPT_DIR/send_email.sh" "andrew@hunt.li" "[automated] reading" "$BODY"
