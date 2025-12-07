#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Transcribe with Superwhisper
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🎤

# Documentation:
# @raycast.description Transcribe the selected file with Superwhisper
# @raycast.author birkhoff
# @raycast.authorURL https://raycast.com/birkhoff

FILEPATH=$(osascript -e 'tell application "Finder" to get POSIX path of (selection as alias)')

open "$FILEPATH" -a superwhisper

