require ( 'CCRig' )

CCMouse = CCRig.new ()
CCMouse.pressTime = 0
CCMouse.x = 0
CCMouse.y = 0

----------------------------------------------------------------
-- Add Pointer Actions
----------------------------------------------------------------
CCMouse.drag = {}
CCMouse.drag.callback = function ( dx, dy ) print ( 'Drag:', dx, dy ) end 


----------------------------------------------------------------
-- Register MOAI callbacks
----------------------------------------------------------------
function CCMouse:getDownDuration ()
	return MOAISim.getElapsedTime () - self.pressTime
end


local function onMouseLeft ( down )
	if down then 
		CCMouse.pressTime = MOAISim.getElapsedTime ()
	end
end
MOAIInputMgr.device.mouseLeft:setCallback ( onMouseLeft )


local function onPointer ( x, y )
	local lastX = CCMouse.x
	local lastY = CCMouse.y
	CCMouse.x = x
	CCMouse.y = y

	dx = x - lastX
	dy = y - lastY

	if MOAIInputMgr.device.mouseLeft:isDown () and 
		CCMouse:getDownDuration () > 0.05 then

		CCMouse.drag.callback ( dx, dy )
	end
end
MOAIInputMgr.device.pointer:setCallback ( onPointer )


