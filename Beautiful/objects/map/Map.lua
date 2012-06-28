local MapPosition =		require ( 'objects.map.MapPosition' )
local GameObject = 		require ( 'modules.GameObject' )
local SparseMapLayer = 	require ( 'objects.map.SparseMapLayer' )
local Rig = 			require ( 'objects.Rig' )


local Map = {}

--[[------------------------------------------------------------
A Map stores:
	* .tileset
	* .tileset.deck - A MOAITileDeck2D 
	* .tileset.rigs - A Rig for each tile in the MOAITileDeck2D
	* .grid - A Single MOAIGrid object
	* A sparse matrix of Tile objects TODO: IMPLEMENT
--------------------------------------------------------------]]


function Map.wndToCoord ( map, x, y )

	x, y = Loc.wndToModel ( map, x, y )
	return map.grid:locToCoord ( x, y )

end		


function Map.coordToWorld ( map, gridX, gridY, position )

	local modelX, modelY = map.grid:getTileLoc ( gridX, gridY, position ) 
	local x, y = map.transform:getLoc ()
	return x + modelX, y + modelY

end


function Map.worldToCoord ( map, x, y )

	x, y = map.transform:worldToModel ( x, y )
	return map.grid:locToCoord ( x, y )

end

--TODO: Add a MapPosition to the rig
function Map.addRig ( map, rig, xCoord, yCoord )

	if rig.map then 

		print ( 'WARNING: ' .. rig.name .. ' cannot be added to map: ' ..  map.name )
		print ( '(' .. rig.name .. ' already has a map)' )
		return 
	end

	rig.map = map

end





--[[------------------------------------------------------------
Input
	* map
		- Has a .grid
		- .layer:getPartition () returns a Partition
	* x - The x position in the grid of tile to check
	* y - The y position in the grid of tile to check

NOTE: Returns a list, not a table
--------------------------------------------------------------]]
function Map.propListForCoord ( map, x, y )

	local tileXSize, tileYSize = map.grid:getCellSize ()
	local tileX, tileY = Map.coordToWorld ( map, x, y, MOAIGridSpace.TILE_LEFT_TOP ) -- actually gets bottom left
	local upperRightX = tileX + tileXSize - 1
	local upperRightY = tileY + tileYSize - 1
	tileX = tileX + 1
	tileY = tileY + 1

	--print ( 'DEBUG: lower left:')
	--print ( tileX, tileY )
	--print ( upperRightX, upperRightY )
	return map.layer:getPartition ():propListForRect ( tileX, tileY, upperRightX, upperRightY ) 

end


--[[------------------------------------------------------------
High level Tile Query!
Return a table of rigs at the specified location. Get a psuedo 
Rig for the tile instead of the map itself. 

Input
	- Same as Map.propListForCoord
	- ALSO: map must have .tileTable indexes corresponding 
	  to the Map tile indexes (increment right from upper left)
--------------------------------------------------------------]]
function Map.queryCoord ( map, x, y )

	local rigs = { Map.getTileRig ( map, x, y ) }

	local props = { Map.propListForCoord ( map, x, y ) }

	for i, prop in ipairs ( props ) do

		if prop.rig and prop.rig ~= map then 

			table.insert ( rigs, prop.rig ) 

		end

	end

	return rigs
end


--[[------------------------------------------------------------
Set the Tile at a certain coordinate to a tileSetIndex

Input
	* map
		- Has .tileset.deck that is a MOAIDeck2D 
		- Has .tileset.rigs with indexes corresponding to tileset
		- Has .grid That is a MOAIGrid
		- Has .rigGrid that is a large enough array of arrays
	* x - is a valid x-coordinate within the .grid, rigGrid
	* y - is a valid y-coordinate within the .grid, rigGrid
	* tileIndex - valid index for tileset.deck AND tileset.rigs
--------------------------------------------------------------]]
function Map.setTile ( map, x, y, tileIndex )

	map.grid:setTile ( x, y, tileIndex )
	map.rigGrid [ x ] [ y ] = map.tileset.rigs [ tileIndex ]

end

function Map.getTileRig ( map, x, y )

	return map.rigGrid [ x ] [ y ]
end



return Map
