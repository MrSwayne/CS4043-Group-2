local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"

mainMenu = audio.loadSound("Assets/Sounds/Music/Extra1.mp3", {channel = 1});
audio.play( mainMenu )


--After pressing play, level 1 initiates
local function PlayButtonTouch()
	composer.gotoScene( G.levels.."level1", "fade", 500 )
	return true
end

local function SettingsTouch()
	composer.gotoScene( G.levels.."settings")
	return true
end

function scene:create( event )
	local sceneGroup = self.view


	local background = display.newImageRect( G.backgrounds.."menu.jpg", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	


	local titleLogo = display.newImageRect( G.misc.."logo.png", 1200, 800)
	titleLogo.x = display.contentCenterX
	titleLogo.y = 400
	
	-- create a widget button (which will loads level1.lua on release)
	local playButton = widget.newButton
		{
			label = "Play Now",
			labelColor = { default={255}, over={128} },
			default = G.misc.."button.png",
			over = G.misc.."button-over.png",
			fontSize = 90,
			width = 154, height=40,
			onRelease = PlayButtonTouch
		}
		playButton.x = display.contentCenterX
		playButton.y = display.contentHeight - 600
		
	local settings = widget.newButton
	{
		label = "Settings",
		labelColor = { default = {255}, over = {128} },
		default = G.misc.."button.png",
		over = G.misc.."button-over.png",
		fontSize = 90,
		width = 154, height=40,
		onRelease = SettingsTouch
	}
	
		settings.x = display.contentCenterX
		settings.y = display.contentHeight - 450
	
	
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( playButton )
	sceneGroup:insert( settings )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
	composer.removeScene(G.levels.."level1")
	composer.removeScene(G.levels.."dead")
	end	
end

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
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	if playButton then
		playButton:removeSelf()	-- widgets must be manually removed
		playButton = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
