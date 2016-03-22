local widget = require( "widget" )

function new( texto,y )
	local options = {
		x=display.contentCenterX,
		y=display.contentHeight / 100 * y,
		width=display.contentWidth / 100 * 60,
		height=display.contentHeight / 100 * 7,
		label=texto,
		labelColor = { default={0.3,0.3,0.3}, over={0,0,0} },
		emboss=true,
		fontSize=35,
		labelAlign="center",
		font=native.systemFont,
		shape="rect",
		cornerRadius=10,
		fillColor = { default={1,1,1}, over={0.3,0.3,0.3} },
		--strokeColor = { default={0,0,0}, over={0,0,0} },
		--strokeWidth = 3
	}
	local botao = widget.newButton( options )
	botao:scale( 0, 0 )
	transition.scaleTo( botao, {xScale=1,yScale=1,time=100} )
	
	
	return botao
end

function newFacebook( texto,y )
	local options = {
		x=display.contentCenterX,
		y=display.contentHeight / 100 * y,
		width=display.contentWidth / 100 * 60,
		height=display.contentHeight / 100 * 7,
		label=texto,
		labelColor = { default={1,1,1}, over={0,0,0} },
		emboss=true,
		fontSize=35,
		labelAlign="center",
		font=native.systemFont,
		shape="rect",
		cornerRadius=10,
		fillColor = { default={45/255,67/255,130/255}, over={0.3,0.3,0.3} },
		--strokeColor = { default={0,0,0}, over={0,0,0} },
		--strokeWidth = 3
	}
	local botao = widget.newButton( options )
	botao:scale( 0, 0 )
	transition.scaleTo( botao, {xScale=1,yScale=1,time=100} )
	
	return botao
end

return {
	new = new,
	newFacebook = newFacebook
}
