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


function Map.wndToCoord ( map, x, y )

	x, y = Loc.wndToModel ( map, x, y )
	return map.data.grid:locToCoord ( x, y )

end		


function Map.coordToWorld ( map, gridX, gridY, position )

	local modelX, modelY = map.data.grid:getTileLoc ( gridX, gridY, position ) 
	local x, y = map.data.transform:getLoc ()
	return x + modelX, y + modelY

end


function Map.worldToCoord ( map, x, y )

	x, y = map.data.transform:worldToModel ( x, y )
	return map.data.grid:locToCoord ( x, y )

end

--TODO: Add a MapPosition to the rig
function Map.addRig ( map, rig, xCoord, yCoord )

	if rig.data.map then 

		print ( 'WARNING: ' .. rig.name .. ' cannot be added to map: ' ..  map.name )
		print ( '(' .. rig.name .. ' already has a map)' )
		return 
	end

	rig.data.map = map

end



-- TODO: use Props table, setLayer, etc. 
function Map.new ( luaMapPath )

	local map = Rig.new () 

	GameObject.init ( map )

	map.name = 'Map-' .. luaMapPath
	
	map.data.luaMap = dofile ( luaMapPath )

	-- Convert first layer to a grid. assume it's a tilelayer
	map.data.grid = TiledEditor.initGrid ( map.data.luaMap.layers[1], 
									  map.data.luaMap.tilewidth, 
									  map.data.luaMap.tileheight )
	-- create tileset for first 
	map.data.tileset = TiledEditor.initTileset ( map.data.luaMap.tilesets[1] ) 

	-- Get the table containing info about the "tileset"
	map.data.tileTable = dofile ( string.gsub ( luaMapPath, '(%.[Ll][Uu][Aa])$', '_Tiles%1' ) )

	local prop  = MOAIProp2D.new ()
	prop:setDeck ( map.data.tileset.deck )
	prop:setGrid ( map.data.grid )

	GameObject.addProp ( map, prop )

	return map
end


--[[------------------------------------------------------------
Input
	* map
		- Has a data.grid
		- data.layer:getPartition () returns a Partition
	* x - The x position in the grid of tile to check
	* y - The y position in the grid of tile to check

NOTE: Returns a list, not a table
--------------------------------------------------------------]]
function Map.propListForCoord ( map, x, y )

	local tileXSize, tileYSize = map.data.grid:getCellSize ()
	local tileX, tileY = Map.coordToWorld ( map, x, y, MOAIGridSpace.TILE_LEFT_TOP )
	local upperRightX = tileX + tileXSize - 1
	local upperRightY = tileY + tileYSize - 1
	tileX = tileX + 1
	tileY = tileY + 1

	--print ( 'DEBUG: lower left:')
	--print ( tileX, tileY )
	--print ( upperRightX, upperRightY )
	return map.data.layer:getPartition ():propListForRect ( tileX, tileY, upperRightX, upperRightY ) 

end

--[[------------------------------------------------------------
Return a Table of containing a rig for each prop at the specified
coordinates. Don't include the map itself.  

Input
	- Same as Map.propListForCoord
--------------------------------------------------------------]]
function Map.rigTableForCoord ( map, x, y )

	local rigs = {}
	local props = { Map.propListForCoord ( map, x, y ) }

	for i, prop in ipairs ( props ) do

		if prop.rig and prop.rig ~= map then 

			table.insert ( rigs, prop.rig ) 

		end

	end

	return rigs
end

--[[------------------------------------------------------------
High level Tile Query!
Return a list of rigs at the specified location. Get a psuedo 
Rig from looking at the the map.data.tileTable 

Input
	- Same as Map.propListForCoord
	- ALSO: map must have data.tileTable indexes corresponding 
	  to the Map tile indexes (increment right from upper left)
--------------------------------------------------------------]]
function Map.queryCoord ( map, x, y )

	local tile = map.data.tileTable [ map.data.grid:getTile ( x, y ) ] 
	local rigs  = Map.rigTableForCoord ( map, x, y )
	table.insert ( rigs, tile ) 

	return rigs

end


return Map
