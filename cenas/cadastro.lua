---------------------------------------------------------------------------------
--
-- login.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local Botao = require( "objetos.Botao" )
local globals = require( "globals" )

-- Load scene with same root filename as this file
local scene = composer.newScene(  )
local edtNome



---------------------------------------------------------------------------------
local function textListener( event )

    if ( event.phase == "began" ) then
        -- user begins editing defaultField
        print( event.text )

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        
        print( event.target.text )
        if (#event.target.text > 0) then
            globals.player.name = event.target.text
            composer.gotoScene( "cenas.loading", { effect = "fade", time = 300, params={tipoLogin="local" } } )
        end
        



    elseif ( event.phase == "editing" ) then
        print( #event.text )
        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )
    end
end

function scene:create( event )
    local sceneGroup = self.view
 
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        

        edtNome = native.newTextField( display.contentCenterX, 50, display.contentWidth-50, 50 )
        edtNome.placeholder = "Seu nome..."
        edtNome:addEventListener( "userInput", textListener )
        native.setKeyboardFocus( edtNome )
        sceneGroup:insert( edtNome )                

    elseif phase == "did" then

        
        
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
        edtNome:removeEventListener( "tap", textListener ) 
        display.remove( edtNome )


    elseif phase == "did" then
        -- Called when the scene is now off screen


    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene