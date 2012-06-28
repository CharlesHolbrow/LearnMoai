Loc = {}

--[[------------------------------------------------------------
 Get the relative location of a point in window coordinates to a rig 
Output: 
	* x, y are relative location in world coordinates
Input:
	* rig: 	
		- has transform, 
		- has a layer
		- has no rotation ?? <-- double check, think about
	* x, y 
		- a point in window coordinates
--------------------------------------------------------------]]
function Loc.wndToModel ( rig, x, y )

	local worldX, worldY = rig.layer:wndToWorld ( x, y )
	return rig.transform:worldToModel ( worldX, worldY )

end


--[[------------------------------------------------------------
 Find the difference between to rigs with transforms
--------------------------------------------------------------]]
function Loc.diff ( startingRig, endingRig )

	return endingRig.transform:getLoc () - startingRig.transform:getLoc ()

end


return Loc