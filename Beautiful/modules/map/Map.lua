TileEditor = require ( 'modules.map.TiledEditor')

local Map = {}

--[[------------------------------------------------------------
A Map stores:
	* A Tileset
	* A Single MOAIGrid object
	* A sparse matrix of Tile objects TODO: IMPLEMENT
--------------------------------------------------------------]]


--[[------------------------------------------------------------
Move a rig one tile twoard another tile
Input:
	rig - thr rig to move 
		* must be locatable
		* must have a map
	x - the x grid coordinate to move in toward
	y - the y grid coordinate to move in toward

--------------------------------------------------------------]]
function Map.moveTowardCoord ( rig, x, y )
	local coordX, coordY = rig.map:worldToCoord ( rig.data.transform:getLoc () )

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
	x, y = rig.map:coordToWorld ( coordX, coordY )
	rig.data.transform:seekLoc ( x, y, 0.1 ) -- TODO: make less HACKy

end


function Map.new ( luaMapPath )

	local map = Rig.new ()
	map.data.prop =  MOAIProp2D.new ()
	map.name = 'Map-' .. luaMapPath
	
	function map:wndToCoord ( x, y )
		--print ( x, y ) 
		x, y = Loc.wndToModel ( self, x, y )
		--print ( x, y ) 
		--print ( self.data.grid:locToCoord ( x, y ) )
		return self.data.grid:locToCoord ( x, y )
	end		

	function map:coordToWorld ( gridX, gridY, position )
		local modelX, modelY = self.data.grid:getTileLoc ( gridX, gridY, position )
		--local x, y = self:getLoc () 
		local x, y = self.data.prop:getLoc ()
		return x + modelX, y + modelY
	end

	function map:worldToCoord ( x, y )
		x, y = self.data.prop:worldToModel ( x, y )
		return self.data.grid:locToCoord ( x, y )
	end

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
