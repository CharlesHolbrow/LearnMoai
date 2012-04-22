require ( 'CCRig' )
require ( 'CCTiled')
require ( 'CCStock' )
----------------------------------------------------------------
-- A Map stores:
--	* A Tileset
--	* A Single MOAIGrid object
--	* A sparse matrix of CCTile objects 
----------------------------------------------------------------

local Map = CCRig.new ()

function initTiledEditorMap ( luaMapPath )
	luaMap = dofile ( luaMapPath )

	local map = CCRig.new ( Map )
	map.transform = MOAITransform2D.new ()

	-- Convert first layer to a grid. assume it's a tilelayer
	map.grid = CCTiled.initGrid ( luaMap.layers[1], luaMap.tilewidth, luaMap.tileheight )
	-- create tileset for first 
	map.tileset = CCTiled.initTileset ( luaMap.tilesets[1] ) 

	map.prop = MOAIProp2D.new ()
	map.prop:setDeck ( map.tileset.deck )
	map.prop:setGrid ( map.grid )

	map.prop:setParent ( map.transform )

	-- The scene manager will call rig:setLayer() if possible
	map.setLayer = CCStock.setLayer

	-- Register the map to be processed by the scene manager
	table.insert ( scene.newRigs, map )

	return map
end

function Map:wndToCoord ( x, y )
	x, y = CCLocation.wndToObject ( self, x, y )
	return self.grid:locToCoord ( x, y )
end



