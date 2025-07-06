#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle iPad Mirroring
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥️

# Documentation:
# @raycast.author birkhoff
# @raycast.authorURL https://raycast.com/birkhoff

set iPadAXIdentifier to "screen-mirroring-device-Sidecar:D7CE6CD0-F7F1-4D3A-AB6D-3334A112F189"

on findLastTargetIndex(targetItem, itemList)
	set lastIndex to 0
	repeat with i from (count of itemList) to 1 by -1
		if item i of itemList is targetItem then
			set lastIndex to i
			exit repeat
		end if
	end repeat
	return lastIndex
end findLastTargetIndex

tell application "System Settings"
	activate
	delay 1.5
	tell application "System Events"
		tell process "System Settings"
			click menu item "Displays" of menu "View" of menu bar item "View" of menu bar 1
			delay 1.2
			tell group 1 of group 2 of splitter group 1 of group 1 of window "Displays"
				try
					click pop up button 1
					delay 0.3
					click menu item 7 of menu 1 of pop up button 1
				on error
					delay 0.3
					click menu item 3 of menu 1 of pop up button 1
				end try
			end tell
		end tell
	end tell
end tell

delay 1.3

tell application "System Settings"
  quit
end tell
