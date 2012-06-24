local MapPosition =	require ( 'objects.map.MapPosition' )
local TileEditor = 	require ( 'objects.map.TiledEditor')
local GameObject = 	require ( 'objects.GameObject' )
local Rig = 		require ( 'modules.Rig' )


local Map = Rig.new ( GameObject )

--[[------------------------------------------------------------
A Map stores:
	* A Tileset
	* A Single MOAIGrid object
	* A sparse matrix of Tile objects TODO: IMPLEMENT
--------------------------------------------------------------]]


function Map:wndToCoord ( x, y )
	--print ( x, y ) 
	x, y = Loc.wndToModel ( self, x, y )
	--print ( x, y ) 
	--print ( self.data.grid:locToCoord ( x, y ) )
	return self.data.grid:locToCoord ( x, y )
end		


function Map:coordToWorld ( gridX, gridY, position )
	local modelX, modelY = self.data.grid:getTileLoc ( gridX, gridY, position )
	--local x, y = self:getLoc () 
	local x, y = self.data.prop:getLoc ()
	return x + modelX, y + modelY
end


function Map:worldToCoord ( x, y )
	x, y = self.data.prop:worldToModel ( x, y )
	return self.data.grid:locToCoord ( x, y )
end

--TODO: Add a MapPosition to the rig
function Map:addRig ( rig, xCoord, yCoord )
	if rig.data.map then 
		print ( 'WARNING: ' .. rig.name .. ' cannot be added to map: ' ..  self.name )
		print ( '(' .. rig.name .. ' already has a map)' )
		return 
	end
	rig.data.map = self
end

--TODO: move this into MapPosition
--[[------------------------------------------------------------
Move a rig one tile toward another tile
Input:
	rig - the rig to move 
		* must be locatable
		* must have a map
	x - the x grid coordinate to move in toward
	y - the y grid coordinate to move in toward

--------------------------------------------------------------]]
function Map.moveTowardCoord ( rig, x, y )
	local coordX, coordY = rig.data.map:worldToCoord ( rig.data.transform:getLoc () )

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
	x, y = rig.data.map:coordToWorld ( coordX, coordY )
	rig.data.transform:seekLoc ( x, y, 0.1 ) -- TODO: make less HACKy

end


-- TODO: use Props table, setLayer, etc. 
function Map.new ( luaMapPath )

	local map = Rig.new ( Map ) 

	map:initGameObject ()

	map.data.prop =  MOAIProp2D.new ()
	map.name = 'Map-' .. luaMapPath
	
	map.data.luaMap = dofile ( luaMapPath )

	-- Convert first layer to a grid. assume it's a tilelayer
	map.data.grid = TiledEditor.initGrid ( map.data.luaMap.layers[1], 
									  map.data.luaMap.tilewidth, 
									  map.data.luaMap.tileheight )
	-- create tileset for first 
	map.data.tileset = TiledEditor.initTileset ( map.data.luaMap.tilesets[1] ) 

	local prop  = MOAIProp2D.new ()
	prop:setDeck ( map.data.tileset.deck )
	prop:setGrid ( map.data.grid )

	map:addProp ( prop )

	return map
end


--[[------------------------------------------------------------
Input
	* map
		- Has a .grid
		- .layer:getPartition () returns a Partition
	* x - The x position in the grid of tile to check
	* y - The y position in the grid of tile to check
--------------------------------------------------------------]]
function Map.propTableForCoord ( map, x, y )

	local tileXSize, tileYSize = map.data.grid:getCellSize ()
	local tileX, tileY = map:coordToWorld ( x, y, MOAIGridSpace.TILE_LEFT_TOP )
	local upperRightX = tileX + tileXSize - 1
	local upperRightY = tileY + tileYSize - 1
	tileX = tileX + 1
	tileY = tileY + 1

	--print ( 'DEBUG: lower left:')
	--print ( tileX, tileY )
	--print ( upperRightX, upperRightY )
	return { map.data.layer:getPartition ():propListForRect ( tileX, tileY, upperRightX, upperRightY ) } 

end

return Map
