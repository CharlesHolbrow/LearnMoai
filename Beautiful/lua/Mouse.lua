Mouse = Rig.new ()

Mouse.pressTime = 0
Mouse.x = 0
Mouse.y = 0

----------------------------------------------------------------
-- Add Pointer Actions
----------------------------------------------------------------
Mouse.drag = {}
Mouse.drag.callback = function ( dx, dy ) print ( 'Drag:', dx, dy ) end 

Mouse.press = {}
Mouse.press.actions = {}
setmetatable ( Mouse.press.actions, { __mode = 'kv' } )

----------------------------------------------------------------
-- Register MOAI callbacks
----------------------------------------------------------------
function Mouse:getDownDuration ()
	return MOAISim.getElapsedTime () - self.pressTime
end


local function onMouseLeft ( down )
	if down then 
		Mouse.pressTime = MOAISim.getElapsedTime ()
	end
	for k, func in pairs ( Mouse.press.actions ) do 
		func ( down ) 
	end
end
MOAIInputMgr.device.mouseLeft:setCallback ( onMouseLeft )


local function onPointer ( x, y )
	local lastX = Mouse.x
	local lastY = Mouse.y
	Mouse.x = x
	Mouse.y = y

	dx = x - lastX
	dy = y - lastY

	if MOAIInputMgr.device.mouseLeft:isDown () and 
		Mouse:getDownDuration () > 0.05 then

		Mouse.drag.callback ( dx, dy )
	end
end
MOAIInputMgr.device.pointer:setCallback ( onPointer )


return Mouse