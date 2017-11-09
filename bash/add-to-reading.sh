#!/bin/bash
HEADER="To: andrew@hunt.li\nSubject: [automated] reading\nContent-Type: text/plain"

if [[ "$1" == "--dry-run" ]]; then
  BODY="${*:2}"
  echo -e "${HEADER}\n\n${BODY}"
else
  BODY="${*}"
  echo -e "${HEADER}\n\n${BODY}" | sendmail -t
fi

