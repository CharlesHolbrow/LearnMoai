local Rig = {}
Rig.__index = Rig



--[[------------------------------------------------------------
Add tables to rig that make it a GameObject
--------------------------------------------------------------]]
function Rig:initGameObject ()

	self.data = {} 
	self.data.props = {}
	self.data.transform = MOAITransform2D.new ()

end

--[[------------------------------------------------------------
Create a new rig instance, optionally derriving from another rig
--------------------------------------------------------------]]
function Rig.new ( initial )

	newRig = {}

	local mt = initial or Rig

	setmetatable ( newRig,  { __index = mt } )

	return newRig

end 


--[[------------------------------------------------------------
Set rig.layer

If rig has layer and prop. remove the prop from the layer

Insert props from  data.props table into layer. 
--------------------------------------------------------------]]
function Rig:setLayer ( layer )

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
function Rig:addProp ( prop )
	
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


return Rig 