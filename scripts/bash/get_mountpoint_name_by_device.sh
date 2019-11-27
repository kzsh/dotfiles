#!/bin/bash
main () {
  local device
  device="$1"
  diskutil list -plist external physical | plutil -convert json -o - - | jq -r ".AllDisksAndPartitions[] | select(.DeviceIdentifier==\"$device\") | .MountPoint"
}

main "$@"
