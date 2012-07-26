local GameObject = {}


--[[------------------------------------------------------------
Add tables to rig that make it a GameObject
--------------------------------------------------------------]]
function GameObject.init ( rig )
	
	rig.props = {}
	rig.transform = MOAITransform2D.new ()

end

--[[------------------------------------------------------------

--------------------------------------------------------------]]
function GameObject.setIndex ( rig, deckIndex, propIndex )

	 	rig.props [ propIndex or 1 ]:setIndex ( deckIndex )

end

--[[------------------------------------------------------------
Set rig.layer

If rig has layer and prop. remove the prop from the layer

Insert props from  .props table into layer. 
--------------------------------------------------------------]]
function GameObject.setLayer ( rig, layer )

	-- If the rig already has a layer, remove all props from 
	-- that layer
	if rig.layer then

		for i, prop in ipairs ( rig.props ) do 

			rig.layer:removeProp ( prop )
			
		end
	end

	-- Add all props to the new layer
	for i, prop in ipairs ( rig.props ) do 

		print ( 'setLayer - layer:insertProp' )
		layer:insertProp ( prop )
		
	end 

	rig.layer = layer

end

--[[------------------------------------------------------------
Add prop to rig.props
Set prop.rig

If the rig has a layer, add prop to the layer
If the rig has a transform, parent the prop to the transform. 
--------------------------------------------------------------]]
function GameObject.addProp ( rig, prop )
	
	-- Add new prop to layer
	if rig.layer then

		print ( 'addProp - layer:insertProp')
		rig.layer:insertProp ( prop )

	end

	-- Parent to transform 
	if rig.transform then

		prop:setParent ( rig.transform )
	end

	prop.rig = rig
	table.insert ( rig.props, prop )

end


return GameObject 