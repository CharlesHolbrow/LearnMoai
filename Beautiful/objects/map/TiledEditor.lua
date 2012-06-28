
local SparseMapLayer = 	require ( 'objects.map.SparseMapLayer' )
local Map = require ( 'objects.map.Map' )

TiledEditor = {}


----------------------------------------------------------------
-- Convert a tileset output by the tiled editor to a MOAITileDeck2D
-- Input: 
-- 	* ts - a Tiled Map editor tileset lua table
----------------------------------------------------------------
function TiledEditor.initTileDeck ( ts )
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
function TiledEditor.initTileset ( ts )
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

function TiledEditor.new ( tiledEditorMapPath )

	local map = Rig.new () 

	GameObject.init ( map )

	map.name = 'Map-' .. tiledEditorMapPath

	-- Load the lua file exported from the Tiled Map Editor
	map.tiledEditorMap = dofile ( tiledEditorMapPath )

	-- The Tiled Editor Layer - get as much data from here as possible
	-- Use the root of the document as a second resort
	local tl = map.tiledEditorMap.layers [ 1 ]

	-- The width and height of the map in tiles
	map.width = tl.width
	map.height = tl.height

	-- the width and height of a tile in pixels ( getting this from the root, not the layer )
	map.tileWidth = map.tiledEditorMap.tilewidth 
	map.tileHeight = map.tiledEditorMap.tileheight

	-- Create a 2D array for storing rigs associated with the tilelayer
	map.rigGrid = {}
	for i = 1, map.width do

		map.rigGrid [ i ] = {}

	end

	-- If the tileset image is desert.png, get tileset rigs from desert.lua
	local tileRigsPath = string.match ( 
		map.tiledEditorMap.tilesets [ 1 ].image, '(.*)%.[^.]*$' ) .. '.lua' 

	-- Assume there is only one tileset
	map.tileset = {}
	map.tileset.rigs = dofile ( tileRigsPath )
	map.tileset.deck = TiledEditor.initTileDeck ( map.tiledEditorMap.tilesets [ 1 ] )
	-- The map now should have all the info it needs to init the grid 

	print ( 'Tilelayer name: ', tl.name )
	local grid = MOAIGrid.new ()
	map.grid = grid
	grid.name = tl.name 

	grid:initRectGrid ( map.width, map.height, map.tileWidth, map.tileHeight ) 
	grid:setRepeat ( false )
	
	-- Older way to transform x, y coords to tileset index
	--tilesetIndex = tl.data [ ( (tl.height - y ) * tl.width ) + x ]

	-- Convert tilelayer data to MOAIGrid coordinates
	local i = 1
	for y = map.height, 1, -1 do
		for x = 1, map.width do

			Map.setTile ( map, x, y, tl.data [ i ] )
			i = i + 1

		end
	end

	local prop  = MOAIProp2D.new ()
	prop:setDeck ( map.tileset.deck )
	prop:setGrid ( map.grid )

	GameObject.addProp ( map, prop )

	return map
end


return TiledEditor
