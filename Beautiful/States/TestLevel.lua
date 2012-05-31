local state = {}
state.layerTable = nil

state.onLoad = function ( self ) 
	
	-- Create the state's layerTable, and make a local reference, 'layer' 
	self.camera = MOAICamera2D.new ()
	local layer = MOAILayer2D.new ()
	layer:setViewport ( viewport ) 
	layer:setCamera ( self.camera ) 
	self.layerTable = {}
	self.layerTable [ 1 ] = { layer } -- Why is this a table?


	-- Add a map to the scene
	self.map = Map.new ( 'map/desertTest100x100.lua' ) -- TODO: make map local
	self.map.layer = layer
	layer:insertProp ( self.map.prop )
	
	-- Set a callback for Mouse drag
	self.drag = function ( dx, dy )
		self.camera:moveLoc ( dx * -2 , dy * 2 )
	end
	Mouse.drag.callback = self.drag

	-- Add a character
	local player = Rig.new ()
	player.deck = deckCache:addDeck ( 'img/man_map_3x1.png' )
	player.prop = MOAIProp2D.new () 
	player.prop:setDeck ( player.deck )
	player.map = self.map

	-- add newly created player to layer
	layer:insertProp ( player.prop )

	-- DEBUG:
	self.map.transform:moveLoc (-150, -150, 1)

	-- Another Debug Mouse test. TODO: move this somewhere proper
	function state.walkToClick ( down ) 

		if down then return end
		local x, y = MOAIInputMgr.device.pointer:getLoc ()
		x, y = self.map:wndToCoord ( x, y )
		Map.moveTowardCoord ( player, x, y ) 
		
	end
	table.insert ( Mouse.press.actions, state.walkToClick )

end 

state.onInput = function ( self )
end

state.onUnload = function ( self )
end

state.onUpdate = function ( self )
end

state.onFucus = function ( self )
end


return state