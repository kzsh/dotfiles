#!/bin/bash
read -r -d '' applescriptCode <<EOF
   set dialogText to text returned of (display dialog "$1" default answer "")
   return dialogText
EOF

echo $(osascript -e "$applescriptCode");
