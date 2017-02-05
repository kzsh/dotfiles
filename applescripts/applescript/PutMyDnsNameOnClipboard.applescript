set the clipboard to do shell script "nslookup `ifconfig en0 | grep 'inet\\s' | awk '{print $2}'` | grep -oh 'name.*$' | awk '{print substr($3, 0, length($3)-1)}'"

