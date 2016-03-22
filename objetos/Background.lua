local g = require( "globals" )
local cor = 2

function new(  )
	local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	bg:setFillColor( g.colors.b[cor][1],g.colors.b[cor][2],g.colors.b[cor][3]  )
	if cor == 1 then
		cor = 2
	else
		cor = 1
	end

	return bg
	
end

return {
	new = new
}
