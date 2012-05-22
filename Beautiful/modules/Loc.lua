--[[
For rig position related functions
Introduces concept of "Object" coordinates:
	The location of a point relative to an object. 
]]

Loc = {}

----------------------------------------------------------------
-- Get the location of a rig in world coordinates
-- Input:
-- 	* rig: 
-- 		- has a transform OR prop
----------------------------------------------------------------
function Loc.getLoc ( rig )
	local locatable = rig.transform or rig.prop
	return locatable:getLoc ()
end

----------------------------------------------------------------
-- Get the relative location of a point to a locatable
-- Input:
-- 	* rig is a legal target for getLoc
--	* x, y are a point in world coordinates
----------------------------------------------------------------
function Loc.worldToObject ( rig, x, y )
	local originX, originY = Loc.getLoc ( rig )
	x = x - originX
	y = y - originY
	return x, y
end

----------------------------------------------------------------
--  Get the relative location of a point in window coordinates to a rig 
-- Output: 
--	* x, y are relative location in world coordinates
-- Input:
-- 	* rig: 	
--		- a legal target for worldToObject, 
-- 		- has a layer
--		- has no rotation ?? <-- double check, think about
-- 	* x, y 
-- 		- a point in window coordinates
----------------------------------------------------------------
function Loc.wndToObject ( rig, x, y )
	local targetX, targetY = rig.layer:wndToWorld ( x, y )
	return Loc.worldToObject ( rig, targetX, targetY )
end


----------------------------------------------------------------
--  Find the difference between to locatables
----------------------------------------------------------------
function Loc.diff ( startingRig, endingRig )
	return Loc.getLoc ( endingRig ) - getLoc ( startingRig )
end



----------------------------------------------------------------
--  
----------------------------------------------------------------

return Loc