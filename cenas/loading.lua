---------------------------------------------------------------------------------
--
-- login.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local Facebook = require( "utils.Facebook" )
local globals = require( "globals" )
local coronium = require( "mod_coronium" )
local Database = require( "utils.Database" )
local SpinIcon = require ( "objetos.SpinIcon" )

coronium:init({ appId = globals.appId, apiKey = globals.apiKey })
coronium.showStatus = true

-- Load scene with same root filename as this file
local scene = composer.newScene(  )
local spinIcon


---------------------------------------------------------------------------------
local function insertCallback( event )
    local result = event.result
    if result.affected_rows > 0 then
        globals.player.id = result.insert_id
        adicionarJogador(globals.player.id, globals.player.facebookId, globals.player.name)
        composer.gotoScene( "cenas.mainmenu", "fade", 500 ) 
    end
end

local function procuraFacebookCallback( event )
    local result = event.result
    print(result)
    if result ~= nil then
        print( "Facebook Tem" )
        globals.player.id = result[1].id 
        adicionarJogador(globals.player.id, globals.player.facebookId, globals.player.name)
        printPlayer()
        composer.gotoScene( "cenas.mainmenu", "fade", 500 ) 
    else
        print( "Não tem Facebok" )
        coronium:run("insertGuessPlayer", globals.player, insertCallback)
    end
end

local function localUser( )
    globals.player.facebookId = "offline"
    printPlayer()
    timerLocal = timer.performWithDelay( 1500, function (  )
        if (globals.player.id == nil) then
            coronium:run("insertGuessPlayer", globals.player, insertCallback)            
        else
            composer.gotoScene( "cenas.mainmenu", "fade", 500 )         
        end
    end , 1 )
    
    --Ações para tratar usuário local    
    
end

local function facebookUser( )
    facebookLogin( )
    local cont = 0
    timer1 = timer.performWithDelay( 1500, function (  )
        cont = cont + 1
        print( cont )
        if (globals.isCarregado == true) then
            printPlayer()
            coronium:run("procuraFacebook", globals.player, procuraFacebookCallback)
            timer.cancel( timer1 )
        elseif (globals.isCancelado == true) then
            timer.cancel( timer1 )
        end  
    end, -1)
end

function scene:create( event )
    local sceneGroup = self.view
 
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    local extras = event.params

    if phase == "will" then

        spinIcon = SpinIcon.new()

    elseif phase == "did" then

        

        if (extras.tipoLogin == "facebook") then
            facebookUser()
        elseif
            (extras.tipoLogin == "local") then
            localUser()
        end
        sceneGroup:insert( spinIcon )
        
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
        remover()
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