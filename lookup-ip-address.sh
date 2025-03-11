#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Lookup IP Address
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🛜
# @raycast.argument1 { "type": "text", "placeholder": "IP Address" }

# Documentation:
# @raycast.author birkhoff
# @raycast.authorURL https://raycast.com/birkhoff

if [ -z "$1" ]; then
  echo "No IP address provided. Please provide an IP address as an argument."
  exit 1
fi

curl -s https://api.birkhoff.me/v3/ip/$1?pretty | jq -C . || {
  echo "Failed to fetch IP address information."
  exit 1
}
