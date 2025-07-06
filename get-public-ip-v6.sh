#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Public IPv6 Address
# @raycast.mode inline
# @raycast.packageName Internet

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.description Copies the public IPv6 address to the clipboard.

# @author https://github.com/raycast/script-commands/tree/master/commands#ip
ip=$(curl -6s -m 5 https://api.birkhoff.me/v3/ip/ip)

echo $ip | pbcopy

if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Got v4 address instead of v6. Copied $ip"
else
    echo "Copied $ip"
fi
