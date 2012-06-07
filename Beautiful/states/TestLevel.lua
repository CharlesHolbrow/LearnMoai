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
	self.map.layer = layer
	-- A partition is automaticly created when inserting a prop
	layer:insertProp ( self.map.prop )
	self.map.partition = layer:getPartition ()
	

	self.player = Character.new ()
	self.player.map = self.map

	-- add newly created player to layer
	layer:insertProp ( self.player.prop )

	-- DEBUG:
	self.map.transform:moveLoc (-150, -150, 1)

end 

state.onInput = function ( self )

	local dragX, dragY = Pointer.drag ()
	local tapX, tapY = Pointer.tap ()
	local holdX, holdY = Pointer.hold () 

	if dragX then

		print ( 'TestLevel: Drag ', dragX, dragY )
		self.camera:moveLoc ( dragX * -2 , dragY * 2 )

	end

	if tapX then

		print ( 'TestLevel: Tap', tapX, tapY )
		local x, y = self.map:wndToCoord ( tapX, tapY )
		Map.moveTowardCoord ( self.player, x, y ) 
		self.player:setIndex ( ( self.player.prop:getIndex () % 4 ) + 1 )

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