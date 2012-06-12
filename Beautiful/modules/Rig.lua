local Rig = {}
Rig.__index = Rig


function Rig.new ( initial )

	newRig = {}

	-- Don't create a data table when deriving
	-- Consider if this is really the best option:
	-- Perhaps it would be useful to hold each rig responsible
	-- for maintaining it's own data table
	if not initial then 

		newRig.data = {} 
		newRig.data.props = {}
		newRig.data.transform = MOAITransform2D.new ()

	end

	local mt = initial or Rig

	setmetatable ( newRig,  { __index = mt } )


	return newRig

end 



--[[------------------------------------------------------------
Set rig.layer

if rig has layer and prop. remove the prop from the layer

If the rig has a data.props table, insert props into layer. 
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