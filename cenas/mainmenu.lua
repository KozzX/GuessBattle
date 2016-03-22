---------------------------------------------------------------------------------
--
-- mainmenu.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local Botao = require( "objetos.Botao" )
local globals = require( "globals" )
--local Database = require( "Database" )
local Background = require( "objetos.Background" )



-- Load scene with same root filename as this file
local scene = composer.newScene(  )



---------------------------------------------------------------------------------

function scene:create( event )
    local sceneGroup = self.view

 
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then

        bg = Background.new()
        bg:toBack( )
        

    elseif phase == "did" then
        local prevScene = composer.getSceneName( "previous" )
        if (prevScene) then
            composer.removeScene( prevScene )
        end

        local btn1  = Botao.new(globals.player.id, 5)
        local btn2  = Botao.new(globals.player.facebookId, 17)
        local btn3  = Botao.new(globals.player.name, 29)
        local btn4  = Botao.new(globals.player.first_name, 41)
        local btn5  = Botao.new(globals.player.last_name, 53)
        local btn6  = Botao.new(globals.player.age_range, 65)
        local btn7  = Botao.new(globals.player.gender, 77)

        sceneGroup:insert( bg )


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