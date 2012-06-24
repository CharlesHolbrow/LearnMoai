local GameObject = Rig.new ()


--[[------------------------------------------------------------
Add tables to rig that make it a GameObject
--------------------------------------------------------------]]
function GameObject:initGameObject ()

	self.data = {} 
	self.data.props = {}
	self.data.transform = MOAITransform2D.new ()

end

--[[------------------------------------------------------------

--------------------------------------------------------------]]
function GameObject:setIndex ( deckIndex, propIndex )

	 	self.data.props [ propIndex or 1 ]:setIndex ( deckIndex )

end

--[[------------------------------------------------------------
Set rig.layer

If rig has layer and prop. remove the prop from the layer

Insert props from  data.props table into layer. 
--------------------------------------------------------------]]
function GameObject:setLayer ( layer )

	-- If the rig already has a layer, remove all props from 
	-- that layer
	if self.data.layer then

		for i, prop in ipairs ( self.data.props ) do 

			self.data.layer:removeProp ( prop )
			
		end
	end

	-- Add all props to the new layer
	for i, prop in ipairs ( self.data.props ) do 

		print ( 'setLayer - layer:insertProp' )
		layer:insertProp ( prop )
		
	end 

	self.data.layer = layer

end

--[[------------------------------------------------------------
Add prop to rig.data.props
Set prop.rig

If the rig has a layer, add prop to the layer
If the rig has a transform, parent the prop to the transform. 
--------------------------------------------------------------]]
function GameObject:addProp ( prop )
	
	-- Add new prop to layer
	if self.data.layer then

		print ( 'addProp - layer:insertProp')
		self.data.layer:insertProp ( prop )

	end

	-- Parent to transform 
	if self.data.transform then

		prop:setParent ( self.data.transform )
	end

	prop.rig = self
	table.insert ( self.data.props, prop )

end


return GameObject 