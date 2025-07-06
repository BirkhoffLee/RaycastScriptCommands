#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Public IPv4 Address
# @raycast.mode inline
# @raycast.packageName Internet

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.description Copies the public IPv4 address to the clipboard.

# @author https://github.com/raycast/script-commands/tree/master/commands#ip

ip=$(curl -4s -m 5 https://api.birkhoff.me/v3/ip/ip)
echo $ip | pbcopy
echo "Copied $ip"
