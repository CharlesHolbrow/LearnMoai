MOAISim.openWindow ( "test", 512, 512 )

viewport = MOAIViewport.new ()
viewport:setSize ( 512, 512 )
viewport:setScale ( 512, 512 )

layer = MOAILayer2D.new ()
layer:setViewport ( viewport )
MOAISim.pushRenderPass ( layer )



require ( 'lua/Rig' )


-- Convert a tileset output by the tiled editor to a MOAIGrid
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
	map.grid = MOAIGrid.new ()
	map.grid:initRectGrid ( 4, 4, 32, 32 )
	map.grid:setRepeat ( false )

	map.grid:setRow ( 1, 1, 2, 3, 4 )
	map.grid:setRow ( 2, 1, 2, 3, 4 )
	map.grid:setRow ( 3, 1, 2, 3, 4 )
	map.grid:setRow ( 4, 1, 2, 3, 4 )

	--map.deck = MOAITileDeck2D.new ()
	--map.deck:setTexture ( 'map/desert.png' )
	--map.deck:setSize ( 8, 6 )

	map.deck = tilesetToDeck ( luaMap.tilesets[1] )

	map.prop = MOAIProp2D.new ()
	map.prop:setDeck ( map.deck )
	map.prop:setGrid ( map.grid )
	map.prop:setLoc ( 0, 0 )
	return map
end

map = initMap ( 'map/desert05.lua' )
map.prop:forceUpdate ()
layer:insertProp ( map.prop )

-- try to load a lua map
--luaMap = dofile ( 'map/desert05.lua' )
--print ('map type', luaMap )

-- everything below here just for debugging
map:debug () 

--gfxQuad = MOAIGfxQuad2D.new ()
--gfxQuad:setTexture ( "map/desert.png" )
--gfxQuad:setRect ( -128, -128, 128, 128 )
--gfxQuad:setUVRect ( 0, 0, 1, 1 )

--prop = MOAIProp2D.new ()
--prop:setDeck ( gfxQuad )
--layer:insertProp ( prop )


