tell application "Finder"
	set screenSize to bounds of window of desktop
	set screenWidth to item 3 of screenSize
	set screenHeight to item 4 of screenSize
end tell

tell application "iTerm" to activate
tell application "iTerm"
	activate
	set modalTerminal to (create window with profile "Modal")

	set windowSize to bounds of modalTerminal 
	set windowXl to item 1 of windowSize
	set windowYt to item 2 of windowSize
	set windowXr to item 3 of windowSize
	set windowYb to item 4 of windowSize

	set windowWidth to windowXr - windowXl
	set windowHeight to windowYb - windowYt

	set bounds of modalTerminal to {(screenWidth - windowWidth) / 2.0, (screenHeight / 2.0) - windowHeight, (screenWidth + windowWidth) / 2.0, (screenHeight / 2.0) + windowHeight}
end tell
