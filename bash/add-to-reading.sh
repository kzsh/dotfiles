#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BODY="${*}"

"$SCRIPT_DIR/send_email.sh" "andrew@hunt.li" "[automated] reading" "$BODY"
