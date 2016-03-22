---------------------------------------------------------------------------------
--
-- cadastro.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )
local Botao = require( "objetos.Botao" )
local globals = require( "globals" )
local Background = require( "objetos.Background" )

-- Load scene with same root filename as this file
local scene = composer.newScene(  )
local edtNome
local btnBack
local btnCadastrar
local inputNome = ""



---------------------------------------------------------------------------------
local function cadastrar( event )
    
    if ( event.phase == "began" ) then
        -- user begins editing defaultField
        print( event.text )

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        
        print( event.target.text )
        if (#event.target.text > 0) then
            globals.player.name = event.target.text
            composer.gotoScene( "cenas.loading", { effect = "crossFade", time = 300, params={tipoLogin="local" } } )
        end
        

    elseif ( event.phase == "editing" ) then
        print( #event.text )
        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )
        inputNome = event.text
    end

    if (event.target.name == "cadastrar") then
        if (#inputNome > 0) then
            globals.player.name = inputNome
            composer.gotoScene( "cenas.loading", { effect = "crossFade", time = 300, params={tipoLogin="local" } } )
        end
    end
end

local function voltar( event )
    
    -- If the "back" key was pressed on Android or Windows Phone, prevent it from backing out of the app
    if ( event.keyName == "back" ) then
        local platformName = system.getInfo( "platformName" )
        if ( platformName == "Android" ) or ( platformName == "WinPhone" ) then
            composer.gotoScene( "cenas.login", "slideRight", 500 ) 
        end
    end
    print( event.target.name )
    if (event.target.name == "voltar") then
        composer.gotoScene( "cenas.login", "slideRight", 500 )            
    end
    
        

    -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
    -- This lets the operating system execute its default handling of the key
    return false
end



function scene:create( event )
    local sceneGroup = self.view
 
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then

        bg = Background.new()
        bg:toBack( )

        edtNome = native.newTextField( display.contentCenterX, 50, display.contentWidth-50, 50 )
        edtNome.placeholder = "Seu nome..."
        native.setKeyboardFocus( edtNome )
        btnBack = Botao.new("Voltar", 90)
        btnBack.name = "voltar"
        btnCadastrar = Botao.new( "Cadastrar", 15 )
        btnCadastrar.name = "cadastrar"
        sceneGroup:insert( bg )
        sceneGroup:insert( btnCadastrar )
        sceneGroup:insert( btnBack )
        sceneGroup:insert( edtNome )                

    elseif phase == "did" then

        local prevScene = composer.getSceneName( "previous" )
        if (prevScene) then
            composer.removeScene( prevScene )
        end
        edtNome:addEventListener( "userInput", cadastrar )
        btnCadastrar:addEventListener( "tap", cadastrar )
        btnBack:addEventListener( "tap", voltar )
        Runtime:addEventListener( "key", voltar )
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
        edtNome:removeEventListener( "tap", cadastrar ) 
        btnCadastrar:removeEventListener( "tap", cadastrar )
        btnBack:removeEventListener( "tap", voltar )
        Runtime:removeEventListener( "key", voltar )


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