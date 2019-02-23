-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"

---------------------------------------------------------

--ADVERTISEMENT LABEL
--(will show on all views because in main.lua)

--make ad box image at size of the width of screen X 13% of the height
local AdBoxImage = display.newImageRect( "AdBox.png", display.contentWidth, display.contentHeight*0.14 )
--AdBox centered and at bottom
AdBoxImage.x = display.contentCenterX
AdBoxImage.y = display.actualContentHeight-display.contentHeight*0.14
 
-- show AdBox
AdBoxImage.isVisible = true

----------------------------------------------------------

--TAB BUTTONS

--listener functions for every tab possible in main.lua 
--Use scene tabs hiding/ showing/ will/ did instead of buttons

-- event listeners for tab buttons:
local function onHomeView( event )
	composer.gotoScene( "HomeView" )
end

local function onJoinRoomView( event )
	composer.gotoScene( "JoinRoomView" )
end


local function onMakeRoomView( event )
	composer.gotoScene( "MakeRoomView" )
end


-- create a tabBar widget with not hidden buttons at the top of the screen

-- table to setup buttons
local tabButtons = {
	{ label="homeView", defaultFile="button1.png", overFile="button1-down.png", width = display.contentHeight*0.07, height = display.contentHeight*0.07, onPress=onHomeView, selected=true },
	{ label="JoinRoomView", defaultFile="button1.png", overFile="button1-down.png", width = display.contentHeight*0.07, height = display.contentHeight*0.07, onPress=onJoinRoomView },
	{ label="MakeRoomView", defaultFile="button1.png", overFile="button1-down.png", width = display.contentHeight*0.07, height = display.contentHeight*0.07, onPress=onMakeRoomView },

}

-- create the actual tabBar widget
local tabBar = widget.newTabBar{
	top = display.contentHeight - 525,	-- 50 is default height(placement) for tabBar widget
	buttons = tabButtons
}

onHomeView()	-- invoke first tab button's onPress event manually

---------------------------------------------------------