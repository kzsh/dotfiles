#!/bin/bash

DEBUG=

happy="0,255,0,255"
sad="244,66,66,255"
building="244,244,244,255"
sad_text="255,255,255,255"

jenkins_exec="/Users/kzsh/bin/jenkins"
jq_exec="/usr/local/bin/jq"
github_exec="/Users/kzsh/bin/gh"

PROJECT="$1"
REPO="$2"
BRANCH="$3"


jenkins_result="$($jenkins_exec -p $PROJECT get $REPO $BRANCH)"

[[ -n $DEBUG ]] && echo "jenkins_result: $jenkins_result"

build_status="$(echo $jenkins_result | $jq_exec -r '.color')" 

[[ -n $DEBUG ]] && echo "build_status: $build_status"

pr_count=$($github_exec prs $REPO | $jq_exec 'length')

text="$REPO: $pr_count"
font_size=14
if [[ "$build_status" == "red" ]]; then
  font_color="$sad_text"
  background_color="$sad"
elif [[ "$build_status" == "blue_anime" ]]; then
  font_color="$building"
  background_color="75,75,75,255"
else
  font_color="$happy"
  background_color="75,75,75,255"
fi

cat <<EOS
{
  "text":"$REPO $pr_count",
  "font_color": "$font_color",
  "background_color": "$background_color",
  "font_size": "$font_size"
}
EOS
