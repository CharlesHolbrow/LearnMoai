
local SparseMapLayer = 	require ( 'objects.map.SparseMapLayer' )
local Map = require ( 'objects.map.Map' )

TiledEditor = {}

--[[------------------------------------------------------------
Make a MOAIGrid object and a corresponding SparseLayer of Rigs
Convert a Tiled Map Editor "layer" with type = "tilelayer" to a MOAIGrid
Input: 
	* tl - a Tiled Map Editor layer Lua table
	* tileRigs - a table of rigs. with 
	* tileWidth - width of a tile in world space
	* tileHeight - height of a tile in world space
--------------------------------------------------------------]]
function TiledEditor.initGrid ( map, tl, tileWidth, tileHeight )

	print ( 'Tilelayer name: ', tl.name )
	local grid = MOAIGrid.new ()
	map.data.grid = grid
	grid.name = tl.name 


	grid:initRectGrid ( tl.width, tl.height, tileWidth, tileHeight ) 
	grid:setRepeat ( false )
	-- Convert tilelayer data to MOAIGrid coordinates
	local i = 1
	for y = tl.height, 1, -1 do
		for x = 1, tl.width do
			Map.setTile ( map, x, y, tl.data [ i ] )
			--grid:setTile ( x, y, tl.data[i] )
			--print ( 'setTile: ', x, y, tl.data[i] )
			i = i + 1
		end
	end
end

--[[------------------------------------------------------------
Create a 2D array of rig tables 
Input
	* tl - a Tile Map Editor "layer" with type = "tilelayer"
--------------------------------------------------------------]]
function TiledEditor.newRigLayer ( tl, tilesetRigs )

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
	map.data.tiledEditorMap = dofile ( tiledEditorMapPath )

	-- Create a 2D array for storing rigs associated with the tilelayer
	map.data.rigGrid = {}
	for i = 1, map.data.tiledEditorMap.layers[ 1 ].width do

		map.data.rigGrid [ i ] = {}

	end

	-- If the tileset image is desert.png, get tileset rigs from desert.lua
	local tileRigsPath = string.match ( 
		map.data.tiledEditorMap.tilesets [ 1 ].image, '(.*)%.[^.]*$' ) .. '.lua' 
	print ( 'Loading TileRigs table from: ' .. tileRigsPath )
	map.data.rigset = dofile ( tileRigsPath )

	-- Assume there is only one tileset
	map.data.tileset = Rig.new ()
	map.data.tileset.deck = TiledEditor.initTileDeck ( map.data.tiledEditorMap.tilesets [ 1 ] )

	-- Convert first layer to a grid. assume it's a tilelayer
	TiledEditor.initGrid ( map, 
						map.data.tiledEditorMap.layers[1], 
					 	map.data.tiledEditorMap.tilewidth, 
					  	map.data.tiledEditorMap.tileheight )





	--map.data.rigLayer = TiledEditor.newRigLayer (map.data.tiledEditorMap.layers [ 1 ], map.data.tileset.rigs )

	local prop  = MOAIProp2D.new ()
	prop:setDeck ( map.data.tileset.deck )
	prop:setGrid ( map.data.grid )

	GameObject.addProp ( map, prop )

	return map
end


return TiledEditor
