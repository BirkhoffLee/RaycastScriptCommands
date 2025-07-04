#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open with Shottr
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖼️

# Documentation:
# @raycast.author birkhoff
# @raycast.authorURL https://raycast.com/birkhoff

tell application "Finder"
    set theSelection to selection
    if theSelection is not {} then
        set theFile to item 1 of theSelection as alias
        tell application "Shottr"
            open theFile
            activate
        end tell
    else
        display alert "No file selected in Finder."
    end if
end tell
