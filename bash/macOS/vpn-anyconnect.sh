KEYSTORE_PASSWORD_LABEL="$1"
DOMAIN="$2"

VPN_APPLICATION="Cisco AnyConnect Secure Mobility Client"

main() {
/usr/bin/env osascript <<-EOS
if application "$VPN_APPLICATION" is running
	quit application "$VPN_APPLICATION"
	error number -128
end if

tell application "$VPN_APPLICATION"
	activate
end tell

repeat until application "$VPN_APPLICATION" is running
	delay 1
end repeat

tell application "System Events"
	repeat until (window 1 of process "$VPN_APPLICATION" exists)
		delay 1
	end repeat
	tell process "$VPN_APPLICATION"
		keystroke ("$DOMAIN" as string)
		keystroke return
	end tell
	repeat until (window 2 of process "$VPN_APPLICATION" exists)
		delay 1
	end repeat
	tell process "$VPN_APPLICATION"
		set PWScript to "security find-generic-password -l \"$KEYSTORE_PASSWORD_LABEL\" -w"
		set passwd to do shell script PWScript
		keystroke (passwd as string)
		keystroke return
	end tell
end tell
EOS
}

main > /dev/null 2>&1
