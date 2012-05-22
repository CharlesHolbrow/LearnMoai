----------------------------------------------------------------
-- Scene methods 
----------------------------------------------------------------
scene = Rig.new () -- TODO: make capital 'Scene'


--[[------------------------------------------------------------
--------------------------------------------------------------]]
function scene:addLayer ( key, layer )
	layer  = layer or MOAILayer2D.new ()
	self.layers [ key ] = layer
	layer:setViewport ( self.viewport )
	MOAISim.pushRenderPass ( layer )
	layer:setCamera ( self.camera )
	return layer
end

--[[------------------------------------------------------------
Iterate over newRigs table. Run methods as needed.
--------------------------------------------------------------]]
function scene:update ()
	for key, rig in pairs ( self.newRigs ) do
		if rig.setLayer then rig:setLayer() end
	end
end

----------------------------------------------------------------
-- Scene init
----------------------------------------------------------------
function initScene ( viewport, layerKey )
	local newScene = Rig.new ( scene )
	newScene.viewport = viewport 
	newScene.camera = MOAICamera2D.new ()
	
	-- Setup some list tables to iterate over
	newScene.newRigs = Rig.new ()
	newScene.layers = Rig.new ()

	newScene:addLayer ( layerKey or 'main' )

	return ( newScene )
end 

return scene