local MapPosition = {}

--[[------------------------------------------------------------
Whenever a rig is used as an argument here, it must
	* have .transform
	* have .map
--------------------------------------------------------------]]


--[[------------------------------------------------------------
Move a rig one tile toward another tile
Input:
	x - the x grid coordinate to move in toward
	y - the y grid coordinate to move in toward
--------------------------------------------------------------]]
function MapPosition.moveTowardCoord ( rig, x, y )
	local coordX, coordY = Map.worldToCoord ( rig.map, rig.transform:getLoc () )

	--print ( 'Rig Coord', coordX, coordY ) 

	local diffX = x - coordX
	local diffY = y - coordY

	--print ( 'diffXY', diffX, diffY )

	local moveX, moveY = 0, 0
	
	if diffX > 0 then moveX = 1 end
	if diffX < 0 then moveX = -1 end
	if diffY > 0 then moveY = 1 end
	if diffY < 0 then moveY = -1 end

	--print ( 'moveXY', moveX, moveY )

	coordX = coordX + moveX
	coordY = coordY + moveY
	x, y = Map.coordToWorld ( rig.map, coordX, coordY )
	rig.transform:seekLoc ( x, y, 0.1 ) -- TODO: make less HACKy

end

function MapPosition.getCoord ( rig )
	return Map.worldToCoord ( rig.map, rig.transform:getLoc () )
end


return MapPosition