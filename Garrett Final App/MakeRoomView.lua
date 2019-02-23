-----------------------------------------------------------------------------------------
--
-- MakeRoomView.lua
--
-----------------------------------------------------------------------------------------

local widget = require "widget"
local composer = require "composer"
local scene = composer.newScene()
local txtRoomName
local txtRoomCode
function scene:create( event )
	local sceneGroup = self.view
	
	-- Called when the scene's view does not exist.
	-- --------------------------------------------------------------------
	--Making Database

	loggedIn = false
	--by not using local every LUA file you use can use this variable

	local lblWelcome = display.newText("Welcome!", display.contentWidth*.5, display.contentHeight*.1, native.systemFont,25)
	lblWelcome:setFillColor( 0, 0, 0 )

	local lblRoomInstructions = display.newText("Enter room name below! ", display.contentWidth*.5, display.contentHeight*.15, native.systemFont,25)
	lblRoomInstructions:setFillColor( 0, 0, 0 )

	--display Roomname label and input text field
	lblRoomName = display.newText("RoomName: ", display.contentWidth*.25, display.contentHeight*.25, native.systemFont,25)
	lblRoomName:setFillColor( 0, 0, 0 )
	txtRoomName = native.newTextField(display.contentWidth*.70, display.contentHeight*.25, display.contentWidth*.50, display.contentHeight*.08)
	lblRoomName:setFillColor( 0, 0, 0 )

	--display RoomCode label and input text field
	lblRoomCode = display.newText("RoomCode: ", display.contentWidth*.25, display.contentHeight*.40, native.systemFont,25)
	lblRoomCode:setFillColor( 0, 0, 0 )
	txtRoomCode = native.newTextField(display.contentWidth*.70, display.contentHeight*.40, display.contentWidth*.50, display.contentHeight*.08)


	--listeners for Roomname & RoomCode
	txtRoomName:addEventListener("userInput", txtRoomName)
	txtRoomCode:addEventListener("userInput", txtRoomCode)

	--Database code

	-- load the required SQL Library
	 sqlite3 = require("sqlite3")

	-- Create a file for the database and provide a path to the file
	-- If you are running the app for the first time, CORONA will create the database for you
	path = system.pathForFile("data.db", system.DocumentsDirectory)

	--open the database based on the above path
	 db = sqlite3.open(path)

	--this code will create the table if it doesn't exist
	tableSetup = [[CREATE TABLE IF NOT EXISTS tblLoginInfo (ID INTEGER PRIMARY KEY autoincrement, RoomName, RoomCode, LastLogin);]]
	db:exec(tableSetup)

	--Create a custom function that inserts the values the user types into the Roomname and RoomCode textfields
	function insertData(tmpRoomname, tmpRoomCode)
	insertQuery = "INSERT into tblLoginInfo VALUES (null, '" .. tmpRoomname .. "', '" .. tmpRoomCode .. "', '" .. os.date("%x") .. "')"
		print(insertQuery)

		--execute the insertQuery query
		db:exec(insertQuery)

		--lblInstructions.text = "Account created!"

	end

	function pullData()
		-- create our SQL statement that will pull the data
		-- select everything for tblLoginInfo
		pullSQL = "SELECT * FROM tblLoginInfo WHERE Roomname='".. txtRoomName.text .."' AND RoomCode='" .. txtRoomCode.text .. "' "

		--Loop through the dataset
		for row in db:nrows(pullSQL) do
			print("-------------------------------")
			print("Roomname: " .. row.RoomName)
			print("RoomCode: " .. row.RoomCode)
			print("LastLogin: " .. row.LastLogin)
			print("-------------------------------")
			txtRoomName.text = row.RoomName
			txtRoomCode.text = row.RoomCode
		end

		lblWelcome.text = "Welcome to " .. txtRoomName.text
		lblRoomInstructions.text = "Connected!"
		loggedIn = true
	end


	-- Create the function to handle button press
	function handleButtonEvent(event)
		if(event.phase == "ended") then
			print("button pressed")

			insertData(txtRoomName.text, txtRoomCode.text)
		end
	end

	function handleButtonEventPull(event)
		if(event.phase == "ended") then
			print("button pressed")

			pullData()
			--insertData(txtRoomName.text, txtRoomCode.text)

		end
	end

	-- Create the Button 
	button1 = widget.newButton(
			{
				left = 65,
				top = 350,
				id = "button1",
				label = "Create Room",
				onEvent = handleButtonEvent


			}

		)

	buttonPullInformation = widget.newButton(
			{
				left = 65,
				top = 400,
				id = "button2",
				label = "Join Room",
				onEvent = handleButtonEventPull

			}

		)

---------------------------------------------------
	
	-- create a white background to fill screen
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white
	
	-- create some text
--[[	local title = display.newText( "Make Room View", display.contentCenterX, 125, native.systemFont, 32 )
	title:setFillColor( 0 )	-- black

	local newTextParams = { text = "Loaded by the Make Room tab's\n\"onPress\" listener\nspecified in the 'tabButtons' table", 
							x = display.contentCenterX + 10, 
							y = title.y + 215, 
							width = 310, 
							height = 310, 
							font = native.systemFont, 
							fontSize = 14, 
							align = "center" }
	local summary = display.newText( newTextParams )
	summary:setFillColor( 0 ) -- black
	]]
	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( lblWelcome )
	sceneGroup:insert( lblRoomInstructions )
	sceneGroup:insert( lblRoomName )
	sceneGroup:insert( txtRoomName )
	sceneGroup:insert( lblRoomCode )
	sceneGroup:insert( txtRoomCode )
	sceneGroup:insert( button1 )
	sceneGroup:insert( buttonPullInformation )
--[[	sceneGroup:insert( title )
	sceneGroup:insert( summary )]]
end
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen

	elseif phase == "did" then
		-- Called when the scene is now on screen
	end
end
---------------------------------------------------------------------------------

-- Listener setup


-----------------------------------------------------------------------------------------


function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
		if(txtRoomName ~= nil) then
			txtRoomName:removeSelf()
		--txtRoomName=nil
		end
		if(txtRoomCode ~= nil) then
			txtRoomCode:removeSelf()
		--txtRoomCode=nil
		end
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- -- Recycle the scene (its view is removed but its scene object remains in memory)

composer.removeScene( MakeRoomView , true )
return scene
