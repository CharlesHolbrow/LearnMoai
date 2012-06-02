local Pointer = Rig.new ()

local pointerX = 0
local pointerY = 0
local pressTime = 0
local pressX = nil
local pressY = nil
local drag = false 

-- If pointer moves > DRAG_THRESHOLD pixels in window space from 
-- the origin of a tap during a press, then it is considered a 
-- drag, not a tap
local DRAG_THRESHOLD = 20

----------------------------------------------------------------
-- Add Pointer Actions
----------------------------------------------------------------
Pointer.drag = {}
Pointer.drag.callback = function ( dx, dy ) print ( 'Drag:', dx, dy ) end 

Pointer.tap = {}
Pointer.tap.callback = function ( px, py ) print ( 'Press', px, py ) end

Pointer.press = {}
Pointer.press.actions = {}
setmetatable ( Pointer.press.actions, { __mode = 'kv' } )

----------------------------------------------------------------
-- Register MOAI callbacks
----------------------------------------------------------------
function Pointer:getDownDuration ()
	return MOAISim.getElapsedTime () - pressTime
end

-- TODO: on mobile platforms, call onPress from an intermediary function
local function onPress ( down )

	if down then 

		Pointer.pressTime = MOAISim.getElapsedTime ()
		pressX, pressY = pointerX, pointerY

	elseif not drag then 

		Pointer.tap.callback ( pressX, pressY )

	elseif drag then 		

		drag = false

	end

	for k, func in pairs ( Pointer.press.actions ) do 
		
		func ( down ) 

	end

end
MOAIInputMgr.device.mouseLeft:setCallback ( onPress )

-- TODO: on mobile platforms, call onPointer from an intermediary function
local function onPointer ( x, y )
	local lastX = pointerX
	local lastY = pointerY
	pointerX = x
	pointerY = y
	dx = x - lastX
	dy = y - lastY

	if Pointer:isDown () then
		local totalX = x - pressX
		local totalY = y - pressY 
		if not drag and Calc.hypotenuse ( totalX, totalY ) > DRAG_THRESHOLD then 
			-- if this is the first frame of the drag, 'CATCH UP'
			dx = x - pressX
			dy = y - pressY
			drag = true
		end
		if drag then
			Pointer.drag.callback ( dx, dy )
		end
	end
end
MOAIInputMgr.device.pointer:setCallback ( onPointer )


----------------------------------------------------------------
-- Public functions, some stolen from Zipline
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

function Pointer.XY ()

	return pointerX, pointerY

end

function Pointer.X () return pointerX end
function Pointer.Y () return pointerY end


return Pointer