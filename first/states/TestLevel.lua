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
	--self.map = Map.new ( 'map/desert05.lua' ) 
	self.map = TiledEditor.new ( 'map/desertTest100x100.lua' ) 
	
	GameObject.setLayer ( self.map, ( layer ) )

	self.player = Character.new ()
	GameObject.setLayer ( self.player, layer )

	Map.addRig ( self.map, self.player )

	-- DEBUG:
	self.map.transform.moveLoc (0, 0, 1)

	--self.map.grid:setTileFlags ( 2, 2, MOAIGridSpace.TILE_HIDE )
	--self.map.grid:setTileFlags ( 3, 3, MOAIGridSpace.TILE_HIDE )
	--self.map.grid:setTileFlags ( 4, 3, MOAIGridSpace.TILE_HIDE )

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

		local rigs = Map.queryCoord ( self.map, x, y )

		for i, rig in ipairs ( rigs ) do 

			print ( rig.name ) 

			if rig.talk then  rig:talk () end
			if rig.text then  print ( rig.text ) end

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