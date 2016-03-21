local facebook = require( "plugin.facebook.v4" )
local json = require( "json" )
local globals = require( "globals" )


--local params = { fields = "id,first_name,last_name" }
local params = { fields = "id,name,first_name,last_name,age_range,link,gender,locale,picture{url},timezone,updated_time,verified" }
local player = {}


local function inTable( table, item )
	for k,v in pairs( table ) do
		if v == item then
			return true
		end
	end
	return false
end

function printTable( t, label, level )
	if label then print( label ) end
	level = level or 1

	if t then
		for k,v in pairs( t ) do
			local prefix = ""
			for i=1,level do
				prefix = prefix .. "\t"
			end

			print( prefix .. "[" .. tostring(k) .. "] = " .. tostring(v) )
			if type( v ) == "table" then
				print( prefix .. "{" )
				printTable( v, nil, level + 1 )
				print( prefix .. "}" )
			end
		end
	end
end


local function facebookCallback( event )
	if event.type == "session" then
		--options are "login", "loginFailed", "loginCancelled", or "logout"
		if event.phase ~= "login" then
			globals.isCancelado = true
			print( "Não logou" )
			return
		else
            facebook.request( "me", "GET", params )
			print( "Logou" )
		end
	elseif event.type == "request" then
		if ( not event.isError ) then
			print( event.response )
			local response = json.decode( event.response )
            if response.id then
                globals.player.facebookId = response.id
                globals.isCarregado = true
            end
            if response.name then
                globals.player.name = response.name
            end
            if response.first_name then
                globals.player.first_name = response.first_name
            end
            if response.last_name then
                globals.player.last_name = response.last_name
            end
            if response.age_range.min then
                globals.player.age_range = response.age_range.min
            end
            if response.link then
                globals.player.link = response.link
            end
            if response.gender then
                globals.player.gender = response.gender
            end
            if response.locale then
                globals.player.locale = response.locale
            end
            if response.picture.data.url then
                globals.player.pictureUrl = response.picture.data.url
            end
            if response.timezone then
                globals.player.timezone = response.timezone
            end
            if response.updated_time then
                globals.player.updated_time = response.updated_time
            end

            printTable(globals.player, "Jogador") 
           
		end
	end
end

local function userOffline()
	
	globals.player.facebookId = "000001"
	globals.player.name = "Corona SDK"
	globals.player.first_name = "Corona"
	globals.player.last_name = "SKD"
	globals.player.age_range = "21"
	globals.player.link = "0"
	globals.player.gender = "male"
	globals.player.locale = "0"
	globals.player.pictureUrl = "0"
	globals.player.timezone = "0"
	globals.player.updated_time = "0"
	
	globals.isCarregado = true

end


function facebookLogin( )
	if facebook.isActive then
		local accessToken = facebook.getCurrentAccessToken()
		if accessToken == nil then
			print( "Need to log in" )
			if system.getInfo("platformName") ~= "Win" then
				facebook.login( facebookCallback )
			else
				userOffline()
			end
		else
			print( "Already logged in with needed permissions" )
			facebook.login( facebookCallback )
			printTable( accessToken, "Access Token Data" )
		end
	else
		print( "Please wait for facebook to finish initializing before checking the current access token" );
	end
end
