module( 'TiledEditor' , package.seeall)

local SparseMapLayer = 	require ( 'objects.map.SparseMapLayer' )

----------------------------------------------------------------
-- Convert a Tiled Map Editor "layer" with type = "tilelayer" to a MOAIGrid
-- Input: 
-- 	* tl - a Tiled Map Editor layer Lua table
--	* tileWidth - width of a tile in world space
--	* tileHeight - height of a tile in world space
----------------------------------------------------------------
function initGrid ( tl, tileWidth, tileHeight )
	print ( 'Tilelayer name: ', tl.name )
	local grid = MOAIGrid.new ()
	grid:initRectGrid ( tl.width, tl.height, tileWidth, tileHeight ) 
	grid:setRepeat ( false )
	-- Convert tilelayer data to MOAIGrid coordinates
	local i = 1
	for y = tl.height, 1, -1 do
		for x =  1, tl.width do
			grid:setTile ( x, y, tl.data[i] )
			--print ( 'setTile: ', x, y, tl.data[i] )
			i = i + 1
		end
	end
	return grid
end

--[[------------------------------------------------------------
Create a 2D array of rig tables 
Input
	* tl - a Tile Map Editor "layer" with type = "tilelayer"
--------------------------------------------------------------]]
function newRigLayer ( tl, tilesetRigs )

	local sparseLayer = SparseMapLayer.new ()
	local tilesetIndex = nil

	for x = 1, tl.width  do 
		for y = 1, tl.height do

			tilesetIndex = tl.data [ ( (tl.height - y ) * tl.width ) + x ]
			print ( tilesetIndex )
			print ( x, y, tilesetRigs [ tilesetIndex ] )
			sparseLayer:addRig ( tilesetRigs [ tilesetIndex ], x, y )

		end
	end

	return sparseLayer
end

----------------------------------------------------------------
-- Convert a tileset output by the tiled editor to a MOAITileDeck2D
-- Input: 
-- 	* ts - a Tiled Map editor tileset lua table
----------------------------------------------------------------
function initTileDeck ( ts )
	if ts.margin ~= ts.spacing then 
		print ( 'Error: tileset margin and spacing do not match')
		return
	end
	-- tileset dimentions 
	local xTileCount = ( ts.imagewidth - ts.spacing ) / ( ts.tilewidth + ts.spacing )
	local yTileCount = ( ts.imageheight - ts.spacing ) / ( ts.tileheight + ts.spacing )
	print ( 'TileCount:', xTileCount, yTileCount )
	-- cell width in pixels
	local cellWidthPix =  ( ts.imagewidth - ts.spacing ) / xTileCount
	local cellHeightPix = ( ts.imageheight - ts.spacing ) / yTileCount
	print ('Cell Pixels:', cellWidthPix, cellHeightPix )

	local tileDeck = MOAITileDeck2D.new ()
	tileDeck:setTexture ( ts.image )
	tileDeck:setSize ( xTileCount, yTileCount, 
		cellWidthPix / ts.imagewidth, cellHeightPix / ts.imageheight, 
		ts.spacing / ts.imagewidth, ts.spacing / ts.imageheight, 
		ts.tilewidth / ts.imagewidth, ts.tileheight / ts.imageheight )

	return tileDeck
end

----------------------------------------------------------------
-- Create a Tileset Rig that stores 
-- 	* a MOAITileDeck2D
--  * properties of the tiles
-- Input:
-- 	* ts - a Tiled Map editor tileset lua table
----------------------------------------------------------------
function initTileset ( ts )
	local tileset = Rig.new ()
	tileset.deck = initTileDeck ( ts )

	-- Get properties from the TiledEditor lua file
	--tileset.properties = {}
	--for k, v in pairs ( ts.tiles ) do
	--	tileset.properties[v.id] = v.properties
	--end

	-- Alternative: save properties in additional lua file
	tileset.properties = dofile ( )

	return tileset
end



