require ( 'CCRig' )
require ( 'CCTiled')
----------------------------------------------------------------
-- A Map stores:
--	* A Tileset
--	* A Single MOAIGrid object
--	* A sparse matrix of CCTile objects 
----------------------------------------------------------------


function initTiledEditorMap ( luaMapPath )
	print ( 'init map!' )
	luaMap = dofile ( luaMapPath )

	local map = CCRig.new ()
	map.transform = MOAITransform2D.new ()

	-- Convert first layer to a grid. assume it's a tilelayer
	map.grid = CCTiled.initGrid ( luaMap.layers[1], luaMap.tilewidth, luaMap.tileheight )
	-- create tileset for first 
	map.tileset = CCTiled.initTileset ( luaMap.tilesets[1] ) 

	map.prop = MOAIProp2D.new ()
	map.prop:setDeck ( map.tileset.deck )
	map.prop:setGrid ( map.grid )

	map.prop:setParent ( map.transform )

	return map
end