Pointer = Rig.new ()

Pointer.pressTime = 0
Pointer.x = 0
Pointer.y = 0

----------------------------------------------------------------
-- Add Pointer Actions
----------------------------------------------------------------
Pointer.drag = {}
Pointer.drag.callback = function ( dx, dy ) print ( 'Drag:', dx, dy ) end 

Pointer.press = {}
Pointer.press.actions = {}
setmetatable ( Pointer.press.actions, { __mode = 'kv' } )

----------------------------------------------------------------
-- Register MOAI callbacks
----------------------------------------------------------------
function Pointer:getDownDuration ()
	return MOAISim.getElapsedTime () - self.pressTime
end


local function onTap ( down )
	if down then 
		Pointer.pressTime = MOAISim.getElapsedTime ()
	end
	for k, func in pairs ( Pointer.press.actions ) do 
		func ( down ) 
	end
end
MOAIInputMgr.device.mouseLeft:setCallback ( onTap )

-- TODO: on mobile platforms, call onPointer from an intermediary function
local function onPointer ( x, y )
	local lastX = Pointer.x
	local lastY = Pointer.y
	Pointer.x = x
	Pointer.y = y

	dx = x - lastX
	dy = y - lastY

	if MOAIInputMgr.device.mouseLeft:isDown () and 
		Pointer:getDownDuration () > 0.05 then

		Pointer.drag.callback ( dx, dy )
	end
end
MOAIInputMgr.device.pointer:setCallback ( onPointer )


----------------------------------------------------------------
-- Public functions Stolen from Zipline
----------------------------------------------------------------
function Pointer.down ( )
	
	if MOAIInputMgr.device.touch then	
		
		return MOAIInputMgr.device.touch:down ()
		
	elseif MOAIInputMgr.device.pointer then
		
		return (	
			MOAIInputMgr.device.mouseLeft:down ()
		)
	end
end

function Pointer.isDown ( )
	
	if MOAIInputMgr.device.touch then	
		
		return MOAIInputMgr.device.touch:isDown ()
		
	elseif MOAIInputMgr.device.pointer then
		
		return (	
			MOAIInputMgr.device.mouseLeft:isDown ()
		)
	end
end

function Pointer.up ( )
	
	if MOAIInputMgr.device.touch then	
		
		return MOAIInputMgr.device.touch:up ()
		
	elseif MOAIInputMgr.device.pointer then
		
		return (	
			MOAIInputMgr.device.mouseLeft:up ()
		)
	end
end

return Pointer