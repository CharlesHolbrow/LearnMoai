TileEditor = require ( 'modules.map.TiledEditor')

local Map = {}

----------------------------------------------------------------
-- A Map stores:
--	* A Tileset
--	* A Single MOAIGrid object
--	* A sparse matrix of Tile objects TODO: IMPLEMENT
----------------------------------------------------------------

----------------------------------------------------------------
-- functions
----------------------------------------------------------------
function Map.new ( luaMapPath )

	local map = Rig.new ()
	map.transform = MOAITransform2D.new ()

	function map:wndToCoord ( x, y )
		x, y = Loc.wndToObject ( self, x, y )
		return self.grid:locToCoord ( x, y )
	end		
	function map:coordToWorld ( gridX, gridY )
		local objectX, objectY = self.grid:getTileLoc ( gridX, gridY )
		local x, y = Loc.getLoc ( self ) 
		return x + objectX, y + objectY
	end
	function map:worldToCoord ( x, y )
		x, y = Loc.worldToObject ( self, x, y )
		return self.grid:locToCoord ( x, y )
	end

	map.luaMap = dofile ( luaMapPath )

	-- Convert first layer to a grid. assume it's a tilelayer
	map.grid = TiledEditor.initGrid ( map.luaMap.layers[1], 
									  map.luaMap.tilewidth, 
									  map.luaMap.tileheight )
	-- create tileset for first 
	map.tileset = TiledEditor.initTileset ( map.luaMap.tilesets[1] ) 

	map.prop = MOAIProp2D.new ()
	map.prop:setDeck ( map.tileset.deck )
	map.prop:setGrid ( map.grid )

	map.prop:setParent ( map.transform )

	return map
end


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
	local coordX, coordY = rig.map:worldToCoord ( Loc.getLoc ( rig ) )

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
	rig.prop:seekLoc ( x, y, 0.1 )
end

return Map
