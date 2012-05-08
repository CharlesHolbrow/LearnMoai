require ( 'modules/TiledEditor')

module ( 'Map', package.seeall )

----------------------------------------------------------------
-- A Map stores:
--	* A Tileset
--	* A Single MOAIGrid object
--	* A sparse matrix of CCTile objects 
----------------------------------------------------------------

----------------------------------------------------------------
-- functions
----------------------------------------------------------------
function makeMap ( luaMapPath )

	local map = Rig.init ()
	map.transform = MOAITransform2D.new ()

	function map:wndToCoord ( x, y )
		x, y = CCLocation.wndToObject ( self, x, y )
		return self.grid:locToCoord ( x, y )
	end		
	function map:coordToWorld ( gridX, gridY )
		local objectX, objectY = self.grid:getTileLoc ( gridX, gridY )
		local x, y = CCLocation.getLoc ( self ) 
		return x + objectX, y + objectY
	end

	map.luaMap = dofile ( luaMapPath )

	-- Convert first layer to a grid. assume it's a tilelayer
	map.grid = TiledEditor.initGrid ( map.luaMap.layers[1], 
									  map.luaMap.tilewidth, 
									  map.luaMap.tileheight )
	-- create tileset for first 
	map.tileset = TiledEditor.initTileset ( map.luaMap.tilesets[1] ) 

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
