Loc = {}


--[[------------------------------------------------------------
 Get the relative location of a point in window coordinates to a rig 
Output: 
	* x, y are relative location in world coordinates
Input:
	* rig: 	
		- has transform, 
		- has a layer data
		- has no rotation ?? <-- double check, think about
	* x, y 
		- a point in window coordinates
--------------------------------------------------------------]]
function Loc.wndToModel ( rig, x, y )

	local worldX, worldY = rig.data.layer:wndToWorld ( x, y )
	return rig.data.transform:worldToModel ( worldX, worldY )

end


--[[------------------------------------------------------------
 Find the difference between to rigs with transform data
--------------------------------------------------------------]]
function Loc.diff ( startingRig, endingRig )

	return endingRig.data.transform:getLoc () - startingRig.data.transform:getLoc ()

end


return Loc