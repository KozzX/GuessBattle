---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

local globals = require( "globals" )
local composer = require( "composer" )
local coronium = require( "mod_coronium" )
local Database = require( "utils.Database" )

coronium:init({ appId = globals.appId, apiKey = globals.apiKey })
coronium.showStatus = true

local cor = 1--math.random( 1,#globals.colors.b )
display.setDefault( "background", globals.colors.b[cor][1], globals.colors.b[cor][2], globals.colors.b[cor][3])

-- This function gets called when the user opens a notification or one is received when the app is open and active.
-- Change the code below to fit your app's needs.
function DidReceiveRemoteNotification(message, additionalData, isActive)
    if (additionalData) then
        if (additionalData.discount) then
            native.showAlert( "Discount!", message, { "OK" } )
            -- Take user to your app store
        elseif (additionalData.actionSelected) then -- Interactive notification button pressed
            native.showAlert("Button Pressed!", "ButtonID:" .. additionalData.actionSelected, { "OK"} )
        elseif (additionalData.shop) then
            store.purchase("remove_ads")
        elseif (additionalData.like) then
            if(not system.openURL("fb://page/1083605381668906")) then
                system.openURL("http://www.facebook.com/opressoroculos")
            end
        elseif (additionalData.update) then   
            system.openURL("https://play.google.com/store/apps/details?id=com.athgames.oculosopressor")
        elseif(additionalData.minigame) then
            system.openURL("https://play.google.com/store/apps/details?id=com.athgames.minigameracer")
        end
    else
        native.showAlert("OneSignal Message", message, { "OK" } )
    end
end

local OneSignal = require("plugin.OneSignal")
OneSignal.Init("326db8a3-0864-4a20-ae44-f9af74fd9f89", "125948127213", DidReceiveRemoteNotification)


local function selectCallback( event )
    local result = event.result
    print(result)
    if result ~= nil then
        print( "tem" )
        globals.player = 
        {
            id = result[1].id,
            facebookId = result[1].facebookId,
            userId = result[1].userId,
            pushToken = result[1].pushToken,
            name = result[1].name,
            first_name = result[1].first_name,
            last_name = result[1].last_name,
            age_range = result[1].age_range,
            link = result[1].link,
            gender = result[1].gender,
            locale = result[1].locale,
            pictureUrl = result[1].pictureUrl,
            timezone = result[1].timezone,
            updated_time = result[1].updated_time,
        }
        print( result[1].id, result[1].facebookId, result[1].name )
        if (globals.player.facebookId=="offline") then
            print( "local" )
            composer.gotoScene( "cenas.loading", { effect = "fade", time = 300, params={tipoLogin="local" } } )
        else
            print( "faceboook" )
            composer.gotoScene( "cenas.loading", { effect = "fade", time = 300, params={tipoLogin="facebook" } } )
        end

    else
        print( "não tem" )
        composer.gotoScene( "cenas.login", "fade", 500 )
    end
end

function IdsAvailable(userId, pushToken)
    print("userId:" .. userId)
    globals.player.pushId = userId
    if (pushToken) then -- nil if there was a connection issue or on iOS notification permissions were not accepted.
        print("pushToken:" .. pushToken)
        globals.player.pushToken = pushToken 
    end  
end

OneSignal.IdsAvailableCallback(IdsAvailable)

local function iniciarGame( )
    local lista = listarJogadores()
    if (#lista <= 0) then
        print( "não tem db " )
        composer.gotoScene( "cenas.login", "fade", 500 )        
    else
        print( "tem db" )
        if ( #lista == 1) then
            globals.player.id = lista[1].id
            globals.player.facebookId = lista[1].facebookId
            globals.player.name = lista[1].name
            print( globals.player.id )
            coronium:run( "selectPlayer", globals.player, selectCallback )
        end
    end
end
iniciarGame()

