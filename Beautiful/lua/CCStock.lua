--[[
Conventional rig functions
]]

module(..., package.seeall)


--[[--------------------------------------------------------------
If rig does not have a layer, set it's layer to 
scene.layer [ 'main' ]
Insert rig's prop to layer

Input:
	rig: 
 		- has a prop
		- has a layer OR global var scene.layers['main'] exists
--------------------------------------------------------------]]
function setLayer ( rig )
	if not rig.layer then 
		rig.layer = scene.layers [ 'main' ]
	end
	rig.layer:insertProp ( rig.prop ) 
end
