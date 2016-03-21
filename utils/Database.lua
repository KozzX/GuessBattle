local sqlite3 = require( "sqlite3" )

-- Open "data.db". If the file doesn't exist, it will be created
local path = system.pathForFile( "data.db", system.DocumentsDirectory )
local db = sqlite3.open( path )   

-- Handle the "applicationExit" event to close the database
local function onSystemEvent( event )
    if ( event.type == "applicationExit" ) then              
        db:close()
    end
end

-- Set up the table if it doesn't exist
local tablesetup = [[CREATE TABLE IF NOT EXISTS JOGADOR (
						id integer primary key,
						facebookId text, 
						name text
					);]]

print( tablesetup )
db:exec( tablesetup )

function jogadorExiste( id )
	local primeiro = true
	for row in db:nrows("SELECT id FROM JOGADOR WHERE id = "..id) do
		primeiro = false
	end	
	return primeiro
end

function salvarFacebookId( facebookId, id )
	local tableupdate = [[UPDATE JOGADOR SET facebookId=']]..facebookId..[[' WHERE id = ]].. id ..[[;]]
	print(tableupdate)
	db:exec( tableupdate )	
end

function salvarname( name, id )
	local tableupdate = [[UPDATE JOGADOR SET name=']]..name..[[' WHERE id = ]].. id ..[[;]]
	print(tableupdate)
	db:exec( tableupdate )	
end

function adicionarJogador( id, facebookId, name )
	local tablefill = [[INSERT INTO JOGADOR VALUES(]]..id..[[, ']].. facebookId .. [[', ']].. name ..[[');]]
	print( tablefill )
	db:exec( tablefill )
end

function buscarJogador( id )
	local result = {}
	for row in db:nrows("SELECT id, facebookId, name FROM JOGADOR WHERE id = " .. id) do
	    result = 
	    {
	    	id = row.id,
	    	facebookId=row.facebookId,
	    	name=row.name,
		}    
	end
	return result
end

function listarJogadores( )
	local result = {}
	local i = 1
	for row in db:nrows("SELECT id, facebookId, name FROM JOGADOR ORDER BY id") do
	    result[i] = 
	    {
	    	id = row.id,
	    	facebookId=row.facebookId,
	    	name=row.name,
		}
		i = i + 1	    
	end
	return result
end

local tablesetup = [[DROP TABLE JOGADOR;]]
print( tablesetup )
--db:exec( tablesetup )

-- Setup the event listener to catch "applicationExit"
Runtime:addEventListener( "system", onSystemEvent )

