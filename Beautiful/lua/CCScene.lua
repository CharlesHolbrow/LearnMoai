require ( 'CCRig' )

----------------------------------------------------------------
-- Scene methods 
----------------------------------------------------------------
local scene = CCRig.new ()

function scene:addProp ( prop )
	table.insert ( self.props, prop )
	local layer = self.layers[table.maxn ( self.layers )]
	layer:insertProp ( prop )
	return prop
end

function scene:addLayer ( layer )
	layer  = layer or MOAILayer2D.new ()
	table.insert ( self.layers, layer )
	layer:setViewport ( self.viewport )
	MOAISim.pushRenderPass ( layer )
	layer:setCamera ( self.camera )
	return layer
end


----------------------------------------------------------------
-- Scene init
----------------------------------------------------------------
function initScene ( viewport )
	local newScene = CCRig.new ( scene )
	newScene.viewport = viewport 
	newScene.camera = MOAICamera2D.new ()
	
	-- Setup some list tables to iterate over
	newScene.props = CCRig.new ()
	newScene.layers = CCRig.new ()

	newScene:addLayer ()

	return ( newScene )
end 
