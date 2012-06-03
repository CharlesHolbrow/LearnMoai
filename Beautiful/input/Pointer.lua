local Pointer = Rig.new ()

local pointerX = 0
local pointerY = 0
local pressTime = 0
local pressX = nil
local pressY = nil
local drag = false 
local dragX = nil
local dragY = nil

-- If pointer moves > DRAG_THRESHOLD pixels in window space from 
-- the origin of a tap during a press, then it is considered a 
-- drag, not a tap
local DRAG_THRESHOLD = 20

----------------------------------------------------------------
-- Add Pointer Actions
----------------------------------------------------------------
local dragCallback = function ( mode, dx, dy ) print ( 'Drag:', mode, dx, dy ) end 
local tapCallback = function ( px, py ) print ( 'Tap', px, py ) end

function Pointer.setDragCallback ( func )

	if type ( func ) == 'function' then dragCallback = func end

end

function Pointer.setTapCallback  ( func ) 
	
	if type ( func ) == 'function' then tapCallback = func end	

end

Pointer.press = {}
Pointer.press.actions = {}

----------------------------------------------------------------
-- Process Input as reported by MOAI Framework. 
----------------------------------------------------------------

-- TODO: on mobile platforms, call pressCallback from an intermediary function
local function pressCallback ( down )

	if down then 

		Pointer.pressTime = MOAISim.getElapsedTime ()
		pressX, pressY = pointerX, pointerY

	elseif not drag then 

		tapCallback ( pressX, pressY )

	elseif drag then 		

		drag = false
		dragCallback ( 'STOP', pointerX, pointerY )
		dragX = nil
		dragY = nil

	end

	for k, func in pairs ( Pointer.press.actions ) do 

		func ( down ) 

	end

end
MOAIInputMgr.device.mouseLeft:setCallback ( pressCallback )

-- TODO: on mobile platforms, call pointerCallback from an intermediary function
local function pointerCallback ( x, y )

	local lastX = pointerX
	local lastY = pointerY
	local dx = x - lastX
	local dy = y - lastY
	
	pointerX = x
	pointerY = y

	if Pointer:isDown () then

		local totalX = x - pressX
		local totalY = y - pressY 

		if not drag and Calc.hypotenuse ( totalX, totalY ) > DRAG_THRESHOLD then 

			-- if this is the first frame of the drag, 'CATCH UP'
			dx = x - pressX
			dy = y - pressY
			drag = true
			dragCallback ( 'START', pressX, pressY )

		end

		if drag then

			dragX = dx
			dragY = dy 
			dragCallback ( 'DRAG', dx, dy )

		end
	end
end
MOAIInputMgr.device.pointer:setCallback ( pointerCallback )


----------------------------------------------------------------
-- Retrive info about status of input devices
----------------------------------------------------------------
function Pointer.down ()
	
	if MOAIInputMgr.device.touch then	
		
		return MOAIInputMgr.device.touch:down ()
		
	elseif MOAIInputMgr.device.pointer then
		
		return (	
			MOAIInputMgr.device.mouseLeft:down ()
		)
	end
end

function Pointer:getDownDuration ()

	if not Pointer.isDown () then return 0 end
	return MOAISim.getElapsedTime () - pressTime

end

function Pointer.isDown ()
	
	if MOAIInputMgr.device.touch then	
		
		return MOAIInputMgr.device.touch:isDown ()
		
	elseif MOAIInputMgr.device.pointer then
		
		return (	
			MOAIInputMgr.device.mouseLeft:isDown ()
		)
	end
end

function Pointer.up ()
	
	if MOAIInputMgr.device.touch then	
		
		return MOAIInputMgr.device.touch:up ()
		
	elseif MOAIInputMgr.device.pointer then
		
		return (	
			MOAIInputMgr.device.mouseLeft:up ()
		)
	end
end

function Pointer.XY () return pointerX, pointerY end

function Pointer.X () return pointerX end

function Pointer.Y () return pointerY end

return Pointer

