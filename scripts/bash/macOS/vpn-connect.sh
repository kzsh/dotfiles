#!/bin/bash
KEYSTORE_PASSWORD_LABEL="$1"
VPN_NAME="$2"
USER_NAME="$3"
function vpn-toggle-connect {
/usr/bin/env osascript <<-EOF
set vpn_name to "'$VPN_NAME'"
set user_name to "$USER_NAME"
set keystore_password_label to "$KEYSTORE_PASSWORD_LABEL"

tell application "System Events"
  set rc to do shell script "scutil --nc status " & vpn_name
  if rc starts with "Connected" then
    do shell script "scutil --nc stop " & vpn_name

    display notification with title "Disconnected from " & vpn_name
    do shell script "echo Disonnected from " & vpn_name
  else
    set PWScript to "security find-generic-password -l \"$KEYSTORE_PASSWORD_LABEL\" -w"
    set passwd to do shell script PWScript

    do shell script "scutil --nc start " & vpn_name & " --user " & user_name

    set the clipboard to passwd
    delay 5
    set the clipboard to ""

    display notification with title "Connected to " & vpn_name
    do shell script "echo Connected to " & vpn_name
  end if
end tell
EOF
}

vpn-toggle-connect
