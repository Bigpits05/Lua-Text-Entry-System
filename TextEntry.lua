-- 

local heightOfText = 600 -- how high the text appears on the screen
local fontSize = 200 -- the size of the font 

-- error messages that appear when text is being validated 
-- change the text inside the "" to change what error message is displayed
local textTooLong = display.newText("textTooLong", display.contentCenterX, display.contentCenterY - heightOfText, native.systemFont, fontSize)
textTooLong:setFillColor(255, 0, 0, 0) -- sets the text to red (r, g, b, alpha) 
local textEmpty = display.newText("textEmpty", display.contentCenterX, display.contentCenterY - heightOfText, native.systemFont, fontSize)
textEmpty:setFillColor(255, 0, 0, 0)
local textHasSpaces = display.newText("textHasSpaces", display.contentCenterX, display.contentCenterY - heightOfText, native.systemFont, fontSize)
textHasSpaces:setFillColor(255, 0, 0, 0)
local textHasNumbers = display.newText("textHasNumbers", display.contentCenterX, display.contentCenterY - heightOfText, native.systemFont, fontSize)
textHasNumbers:setFillColor(255, 0, 0, 0)

-- hides the error message after it has been displayed by setting the alpha value to 0 
local function hideText()
	textTooLong:setFillColor(255, 0, 0, 0)
	textEmpty:setFillColor(255, 0, 0, 0)
	textHasSpaces:setFillColor(255, 0, 0, 0)
	textHasNumbers:setFillColor(255, 0, 0, 0)
end 

local textField

-- function that listens for text entered
local function textListener( event )
	if ( event.phase == "began" ) then -- before text box has been accessed
	elseif ( event.phase == "ended" or event.phase == "submitted" ) then -- after text has been entered
		print("textEnerted = ", event.target.text ) -- prints the text that was entered
		textEntered = ( event.target.text )
		print( string.find(textEntered, "%s") ) -- prints any spaces found in the console, if none prints "nil"
		local spaces = string.find(textEntered, "%s")
		print( string.find(textEntered, "%d") ) -- prints any numbers found in the console, if none prints "nil"
		local numbers = string.find(textEntered, "%d")
		-- text validation 
		if string.len(textEntered) > 10 then -- if text entered is less than 10 characters 
			textTooLong:setFillColor(255, 0, 0, 1) -- set error message to be visible 
			timer.performWithDelay(2000, hideText) -- after 2000ms hide the text
		elseif string.len(textEntered) < 1 then -- if text box is left empty
			textEmpty:setFillColor(255, 0, 0, 1)
			timer.performWithDelay(2000, hideText)
		elseif spaces ~= nil then -- if the spaces are equal to "nil" (there are no spaces)
			textHasSpaces:setFillColor(255, 0, 0, 1)
			timer.performWithDelay(2000, hideText)
		elseif numbers ~= nil then -- if the numbers are equal to "nil" (there are no numbers)
			textHasNumbers:setFillColor(255, 0, 0, 1)
			timer.performWithDelay(2000, hideText)
		else -- if the entered text passes the validaion this code will be run
			textField:removeSelf() -- remove the text box (if not it will stay on screen indefinitely 
			print("done") -- print "done" in the console
		end 
	elseif ( event.phase == "editing" ) then -- while text is being edited/written
	end
end

local widthOfTextBox = 3000
local heightOfTextBox = 36
textField = native.newTextField(display.contentCenterX, display.contentCenterY, widthOfTextBox, heightOfTextBox) -- creates a text box/field
textField.inputType = "default" -- defines the input type (can be all text, numbers, emoji, etc)
textField.size = 300 -- sets the font size of the text box
textField:resizeHeightToFitFont() -- resizes the text box to fit the font (IMPORTANT!)
textField.align = "center" -- aligns the text to the center of the text box (can also be left or right)
textField.placeholder = "(enter text)" -- the text that is displayed inside the text box before the user starts writing in it
textField:setTextColor( 255, 0, 0) -- sets the colour of the text that the user will eb writing in 
	
textField:addEventListener( "userInput", textListener ) -- adds a listener to run the function when the user starts using the text box