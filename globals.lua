local globals = 
{
	isCarregado = false,
	isCancelado = false,
	appId = "ec2-54-207-21-98.sa-east-1.compute.amazonaws.com",
	apiKey = "694fa5e9-162f-42ef-9e8a-ee59dd5e321a",
	player = {},
	colors = 
	{
		b = 
		{
			{ 139/255, 225/255, 255/255 },
			{255/255, 139/255, 207/255 },
		},
	},
	
}

function printPlayer()
	print( "===Print Player===" )
	print( "id           ",globals.player.id )
	print( "facebookId   ", globals.player.facebookId )
	print( "name         ", globals.player.name )
	print( "first_name   ", globals.player.first_name )
	print( "last_name    ", globals.player.last_name )
	print( "age_range    ", globals.player.age_range )
	print( "link         ", globals.player.link )
	print( "gender       ", globals.player.gender )
	print( "locale       ", globals.player.locale )
	print( "pictureUrl   ", globals.player.pictureUrl )
	print( "timezone     ", globals.player.timezone )
	print( "updated_time ", globals.player.updated_time )
	print( "pushId       ",globals.player.pushId )
	print( "pushToken    ",globals.player.pushToken )

end

return globals