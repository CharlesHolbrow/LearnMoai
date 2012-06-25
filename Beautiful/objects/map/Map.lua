local MapPosition =	require ( 'objects.map.MapPosition' )
local TileEditor = 	require ( 'objects.map.TiledEditor')
local GameObject = 	require ( 'modules.GameObject' )
local Rig = 		require ( 'objects.Rig' )


local Map = {}

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



-- TODO: use Props table, setLayer, etc. 
function Map.new ( luaMapPath )

	local map = Rig.new () 

	GameObject.init ( map )

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

	GameObject.addProp ( map, prop )

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
	local tileX, tileY = Map.coordToWorld ( map, x, y, MOAIGridSpace.TILE_LEFT_TOP )
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
