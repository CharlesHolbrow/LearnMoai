local Rig = {}
Rig.__index = Rig


function Rig.new ( initial )
	newRig = {}
	local mt = initial or Rig
	
	setmetatable ( newRig,  { __index = mt } )
	return newRig
end 

--[[------------------------------------------------------------
Set rig.prop 
Set rig.prop.rig

if the rig has a prop, apply it's .getLoc() to the new prop
if the rig has a layer, add prop to the layer, remove old prop

currently does not apply rotation and scale from the old prop
--------------------------------------------------------------]]
function Rig:setProp ( prop )

	-- Get old prop coordinates, apply to new prop
	if self.prop then
		
		prop:setLoc ( self.prop:getLoc () )

	end

	-- Remove old prop from layer
	if self.layer and self.prop then

		self.layer:removeProp ( self.prop )

	end

	-- Add new prop to layer
	if self.layer then

		print ( 'setProp - layer:insertProp')
		self.layer:insertProp ( prop )

	end

	prop.rig = self
	self.prop = prop

end

--[[------------------------------------------------------------
Set rig.layer

if rig has layer and prop. remove the prop from the layer

If the rig has a .prop, insert it into layer. 
--------------------------------------------------------------]]
function Rig:setLayer ( layer )

	-- If the rig has a layer and a prop
	if self.layer and self.prop then
		self.layer:removeProp ( self.prop )
	end

	if self.prop then
		print ( 'setLayer - layer:insertProp' )
		layer:insertProp ( self.prop )
	end 

	self.layer = layer

end


return Rig 