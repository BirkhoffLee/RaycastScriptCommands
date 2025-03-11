#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Current IP Address
# @raycast.mode inline
# @raycast.refreshTime 1m

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author birkhoff
# @raycast.authorURL https://raycast.com/birkhoff

curl -s https://api.birkhoff.me/v3/ip | jq -r '"\(.ip) | \(.city), \(.country) (\(.asorg))"' | awk '{printf "\033[33m%s\033[0m\n", $0}' || {
  echo -e "\033[1;31mFailed to fetch\033[0m"
  exit 1
}
