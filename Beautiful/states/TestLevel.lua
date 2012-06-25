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
	self.map = Map.new ( 'map/desertTest100x100.lua' ) 
	GameObject.setLayer ( self.map, ( layer ) )

	self.player = newCharacter ()
	self.player:setLayer ( layer )

	Map.addRig ( self.map, self.player )

	-- add newly created player to layer
	--layer:insertProp ( self.player.prop )

	-- DEBUG:
	self.map.data.transform.moveLoc (0, 0, 1)
	
	--MOAIDebugLines.setStyle ( MOAIDebugLines.PROP_MODEL_BOUNDS, 2, 0.1, 0.1, 1 )
	--MOAIDebugLines.setStyle ( MOAIDebugLines.PARTITION_CELLS, 4, 0, 0 )
	--MOAIDebugLines.setStyle ( MOAIDebugLines.PROP_WORLD_BOUNDS, 2, 0.75, 0.75, 0.75 )

	--self.map.data.grid:setTileFlags ( 2, 2, MOAIGridSpace.TILE_HIDE )
	--self.map.data.grid:setTileFlags ( 3, 3, MOAIGridSpace.TILE_HIDE )
	--self.map.data.grid:setTileFlags ( 4, 3, MOAIGridSpace.TILE_HIDE )

	MapPosition.moveTowardCoord ( self.player, 1, 1 )
end 

state.onInput = function ( self )

	local dragX, dragY = Pointer.drag ()
	local tapX, tapY = Pointer.tap ()
	local holdX, holdY = Pointer.hold () 

	if dragX then

		--print ( 'TestLevel: Drag ', dragX, dragY )
		self.camera:moveLoc ( dragX * -2 , dragY * 2 )

	end

	if tapX then

		--print ( 'TestLevel: Tap', tapX, tapY )
		local x, y = Map.wndToCoord ( self.map, tapX, tapY )

		print ( 'TestLevel: Map Coord', x, y )
		print ( 'Player Position: ', MapPosition.getCoord ( self.player ) )
		local props  = Map.propTableForCoord ( self.map, x, y )

		for i, prop in ipairs ( props ) do 

			print ( prop.rig.name ) 

			if prop.rig.talk then 

				prop.rig:talk ()

			end

		end 

		MapPosition.moveTowardCoord ( self.player, x, y ) 
		--self.player:setIndex ( ( self.player.props [ 1 ] :getIndex () % 4 ) + 1 )

	end

	if holdX then

		print ( 'TestLevel: Hold', holdX, holdY )
		
	end

end


state.onUnload = function ( self )
end

state.onUpdate = function ( self )
end

state.onFucus = function ( self )
end


return state