#!/bin/bash
if [[ -z "$1" ]]; then
  echo >&2 "Missing required argument space (e.g. 'a')"
  exit 1
fi

declare -A LETTER_INDEX=(
  ["Q"]=0
  ["W"]=1
  ["E"]=2
  ["R"]=3
  ["T"]=4
  ["A"]=5
  ["S"]=6
  ["D"]=7
  ["F"]=8
  ["G"]=9
  ["Z"]=10
  ["X"]=11
  ["C"]=12
  ["V"]=13
  ["B"]=14
)

LIST_LENGTH=${#LETTER_INDEX[@]}
VAL=${LETTER_INDEX[$1]}

meta_space="$1"
m_tag="<sub>$meta_space</sub>"

cat <<EOM
# Define names for default workspaces for which we configure key bindings later on.
# We use variables to avoid repeating the names in multiple places.
set \$ws1 "$(( 1 + (VAL * LIST_LENGTH) )):Q$m_tag"
set \$ws2 "$(( 2 + (VAL * LIST_LENGTH) )):W$m_tag"
set \$ws3 "$(( 3 + (VAL * LIST_LENGTH) )):E$m_tag"
set \$ws4 "$(( 4 + (VAL * LIST_LENGTH) )):R$m_tag"
set \$ws5 "$(( 5 + (VAL * LIST_LENGTH) )):T$m_tag"
set \$ws6 "$(( 6 + (VAL * LIST_LENGTH) )):A$m_tag"
set \$ws7 "$(( 7 + (VAL * LIST_LENGTH) )):S$m_tag"
set \$ws8 "$(( 8 + (VAL * LIST_LENGTH) )):D$m_tag"
set \$ws9 "$(( 9 + (VAL * LIST_LENGTH) )):F$m_tag"
set \$ws10 "$(( 10 + (VAL * LIST_LENGTH) )):G$m_tag"
set \$ws11 "$(( 11 + (VAL * LIST_LENGTH) )):Z$m_tag"
set \$ws12 "$(( 12 + (VAL * LIST_LENGTH) )):X$m_tag"
set \$ws13 "$(( 13 + (VAL * LIST_LENGTH) )):C$m_tag"
set \$ws14 "$(( 14 + (VAL * LIST_LENGTH) )):V$m_tag"
set \$ws15 "$(( 15 + (VAL * LIST_LENGTH) )):B$m_tag"
# switch to workspace
bindsym \$mod3+q workspace \$ws1
bindsym \$mod3+w workspace \$ws2
bindsym \$mod3+e workspace \$ws3
bindsym \$mod3+r workspace \$ws4
bindsym \$mod3+t workspace \$ws5

bindsym \$mod3+a workspace \$ws6
bindsym \$mod3+s workspace \$ws7
bindsym \$mod3+d workspace \$ws8
bindsym \$mod3+f workspace \$ws9
bindsym \$mod3+g workspace \$ws10

bindsym \$mod3+z workspace \$ws11
bindsym \$mod3+x workspace \$ws12
bindsym \$mod3+c workspace \$ws13
bindsym \$mod3+v workspace \$ws14
bindsym \$mod3+b workspace \$ws15

# move focused container to workspace
bindsym \$mod3+Shift+q move container to workspace \$ws1
bindsym \$mod3+Shift+w move container to workspace \$ws2
bindsym \$mod3+Shift+e move container to workspace \$ws3
bindsym \$mod3+Shift+r move container to workspace \$ws4
bindsym \$mod3+Shift+t move container to workspace \$ws5

bindsym \$mod3+Shift+a move container to workspace \$ws6
bindsym \$mod3+Shift+s move container to workspace \$ws7
bindsym \$mod3+Shift+d move container to workspace \$ws8
bindsym \$mod3+Shift+f move container to workspace \$ws9
bindsym \$mod3+Shift+g move container to workspace \$ws10

bindsym \$mod3+Shift+z move container to workspace \$ws11
bindsym \$mod3+Shift+x move container to workspace \$ws12
bindsym \$mod3+Shift+c move container to workspace \$ws13
bindsym \$mod3+Shift+v move container to workspace \$ws14
bindsym \$mod3+Shift+b move container to workspace \$ws15
EOM
