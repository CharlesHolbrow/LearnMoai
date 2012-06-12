Loc = {}




----------------------------------------------------------------
--  Get the relative location of a point in window coordinates to a rig 
-- Output: 
--	* x, y are relative location in world coordinates
-- Input:
-- 	* rig: 	
--		- has worldToModel method, 
-- 		- has a layer
--		- has no rotation ?? <-- double check, think about
-- 	* x, y 
-- 		- a point in window coordinates
----------------------------------------------------------------
function Loc.wndToModel ( rig, x, y )

	--print ( x, y )
	local worldX, worldY = rig.data.layer:wndToWorld ( x, y )
	--print ( worldX, worldY )
	--print ( rig.data.transform:worldToModel ( worldX, worldY ) )
	return rig.data.transform:worldToModel ( worldX, worldY )

end


----------------------------------------------------------------
--  Find the difference between to locatables
----------------------------------------------------------------
function Loc.diff ( startingRig, endingRig )
	return endingRig:getLoc () - startingRig:getLoc ()
end



----------------------------------------------------------------
--  
----------------------------------------------------------------

return Loc