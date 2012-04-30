require ( 'CCRig' )
require ( 'Rig' )
require ( 'CCTiled')
require ( 'CCStock' )
----------------------------------------------------------------
-- A Map stores:
--	* A Tileset
--	* A Single MOAIGrid object
--	* A sparse matrix of CCTile objects 
----------------------------------------------------------------

local Map = {}

function Map:setTiledLuaFile ( luaMapPath )

	self.luaMap = dofile ( luaMapPath )

	-- Convert first layer to a grid. assume it's a tilelayer
	self.grid = CCTiled.initGrid ( self.luaMap.layers[1], 
								   self.luaMap.tilewidth, 
								   self.luaMap.tileheight )
	-- create tileset for first 
	self.tileset = CCTiled.initTileset ( self.luaMap.tilesets[1] ) 

	self.prop = MOAIProp2D.new ()
	self.prop:setDeck ( self.tileset.deck )
	self.prop:setGrid ( self.grid )

	self.prop:setParent ( self.transform )

	-- The scene manager will call rig:setLayer() if possible
	self.setLayer = CCStock.setLayer

	-- Register the self to be processed by the scene manager
	table.insert ( scene.newRigs, self )

	return self
end

function Map:wndToCoord ( x, y )
	x, y = CCLocation.wndToObject ( self, x, y )
	return self.grid:locToCoord ( x, y )
end

function Rig:initMap ()
	local map = Rig.init ( self )
	map.transform = MOAITransform2D.new ()
	for k, v in pairs ( Map ) do map [ k ] = v end
	return map
end