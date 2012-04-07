require ( 'lua/CCRig' )

-- Convert a Tiled Map Editor "layer" with type = "tilelayer" to a MOAIGrid
-- tl is a Tiled Map Editor layer Lua table
local function tilelayerToGrid ( ls )
	print ( 'Tilelayer name: ', ls )
	local grid = MOAIGrid.new ()
	grid:initRectGrid ( ls.width, ls.height, 32, 32 ) -- TODO: fix static 32
	grid:setRepeat ( false )
	-- Convert tilelayer data to MOAIGrid coordinates
	local i = 1
	for y = ls.height, 1, -1 do
		for x =  1, ls.width do
			grid:setTile ( x, y, ls.data[i] )
			--print ( 'setTile: ', x, y, ls.data[i] )
			i = i + 1
		end
	end
	return grid
end

-- Convert a tileset output by the tiled editor to a MOAITileDeck2D
-- ts is a Tiled Map editor tileset lua table
local function tilesetToDeck ( ts )
	if ts.margin ~= ts.spacing then 
		print ( 'Error: tileset margin and spacing do not match')
		return
	end
	print ('Tileset name:', ts.name )
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


function initMap ( luaMapPath )
	print ( 'init map!' )
	luaMap = dofile ( luaMapPath )
	-- Get Params from Lua 


	local map = CCRig.new ()
	map.grid = tilelayerToGrid ( luaMap.layers[1] )
	map.deck = tilesetToDeck ( luaMap.tilesets[1] )

	map.prop = MOAIProp2D.new ()
	map.prop:setDeck ( map.deck )
	map.prop:setGrid ( map.grid )
	map.prop:setLoc ( 0, 0 )
	return map
end
