#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Local IPv6 Address
# @raycast.mode inline
# @raycast.packageName Internet

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.description Copies the local IPv6 address to the clipboard.

# @author https://github.com/raycast/script-commands/tree/master/commands#ip

ip=$(ifconfig | grep 'inet6.*%en' | awk '{print $2}')
IFS=' ' read -ra array <<< "$ip"
echo ${array[0]} | tr -d '\n' | pbcopy
echo "Copied $ip"
