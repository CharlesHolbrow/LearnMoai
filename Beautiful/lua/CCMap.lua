require ( 'CCRig' )
require ( 'CCTiled')
----------------------------------------------------------------
-- A Map stores:
--	* A Tileset
--	* A Single MOAIGrid object
--	* A sparse matrix of CCTile objects 
----------------------------------------------------------------

local Map = CCRig.new ()

function initTiledEditorMap ( luaMapPath )
	print ( 'init map!' )
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

	return map
end


-- TODO: major update. revame this using the CCLocations module
function Map:wndToCoord ( x, y )
	x, y = scene.layers[1]:wndToWorld ( x, y ) -- TODO: avoide dependence on golbal 'scene' variable
	selfX, selfY =  self.prop:getWorldLoc()
	x = x - selfX
	y = y - selfY
	x, y = self.grid:locToCoord ( x, y )
	return x, y
end



