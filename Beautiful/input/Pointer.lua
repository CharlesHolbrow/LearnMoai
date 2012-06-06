local Pointer = Rig.new ()


-- If pointer moves > DRAG_THRESHOLD pixels in window space from 
-- the origin of a tap during a press, then it is considered a 
-- drag, not a tap
local DRAG_THRESHOLD = 15

-- If Pointer is pressed for > HOLD_THRESHOLD seconds
-- without being a drag, then it's a Hold, and not a Tap
local HOLD_THRESHOLD = 0.33


-- Most recent location of pointer
local pointerX = 0
local pointerY = 0
-- Location of the pointer before the last movement
local lastX = 0
local lastY = 0
-- Location of the pointer on the last press/click
local pressX = nil
local pressY = nil

-- dx dy is the difference between the current pointer position
-- and the position before the last movement
local dx = 0
local dy = 0

-- dragX, dragY represent the amound that pointer was moved in the 
-- current frame during the current drag action. nil when not dragging
local dragX = nil
local dragY = nil

-- drag is true while the pointer is dragging
local drag = false

local pressTime = 0
local releaseTime = 0

local pressElapsedFrames = 0
local releaseElapsedFrames = 0
local moveElapsedFrames = 0
local releaseFromTapElapsedFrames = 0
local releaseFromHoldElapsedFrames = 0

----------------------------------------------------------------
-- Process Input as reported by MOAI Framework. 
----------------------------------------------------------------

-- TODO: on mobile platforms, call pressCallback from an intermediary function
local function pressCallback ( down )

	if down then 

		pressElapsedFrames = MOAISim.getElapsedFrames ()
		pressTime = MOAISim.getElapsedTime ()
		pressX, pressY = pointerX, pointerY


	else

		releaseElapsedFrames = MOAISim.getElapsedFrames ()
		releaseTime = MOAISim.getElapsedTime ()
		releaseX, releaseY = pointerX, pointerY

		-- If we release, and are in the middle of a drag
		if drag then 

			drag = false
			dragX = nil
			dragY = nil

		-- If we release, and are not in the middle of a drag
		else

			-- Did we release from a hold or from a tap
			if releaseTime - pressTime > HOLD_THRESHOLD then 

				releaseFromHoldElapsedFrames = MOAISim.getElapsedFrames ()

			else

				releaseFromTapElapsedFrames = MOAISim.getElapsedFrames ()

			end
		end
	end
end
MOAIInputMgr.device.mouseLeft:setCallback ( pressCallback )

-- TODO: on mobile platforms, call pointerCallback from an intermediary function
local function pointerCallback ( x, y )

	moveElapsedFrames = MOAISim.getElapsedFrames ()

	lastX = pointerX
	lastY = pointerY

	dx = x - lastX
	dy = y - lastY
	
	pointerX = x
	pointerY = y

	if Pointer:isDown () then

		if not drag and 
			Calc.hypotenuse ( x - pressX, y - pressY ) > 
			DRAG_THRESHOLD then 

			-- if this is the first frame of the drag, 'CATCH UP'
			dragX = x - pressX
			dragY = y - pressY
			drag = true

		-- If this is not the first drag frame. 
		elseif drag then

			dragX = dx
			dragY = dy 

		end
	end
end
MOAIInputMgr.device.pointer:setCallback ( pointerCallback )


----------------------------------------------------------------
-- Retrive info about status of input devices
----------------------------------------------------------------

-- Did the pointer press/click in the most recent update 
function Pointer.down ()
	
	if MOAIInputMgr.device.touch then	
		
		return MOAIInputMgr.device.touch:down ()
		
	elseif MOAIInputMgr.device.pointer then
		
		return (	
			MOAIInputMgr.device.mouseLeft:down ()
		)
	end
end

-- XY amount of the pointer's most recent movement
function Pointer.delta ()
	return dx, dy 
end

-- Get delta XY if currently dragging, nil if not dragging
function Pointer.drag ()

	if drag and moveElapsedFrames == MOAISim.getElapsedFrames () then 

		return dragX, dragY 

	end
end

-- How long has the pointer been depressed for 
function Pointer.getDownDuration ()

	if not Pointer.isDown () then return 0 end
	return MOAISim.getElapsedTime () - pressTime

end

-- Is the pointer input currently pressed
function Pointer.isDown ()
	
	if MOAIInputMgr.device.touch then	
		
		return MOAIInputMgr.device.touch:isDown ()
		
	elseif MOAIInputMgr.device.pointer then
		
		return (	
			MOAIInputMgr.device.mouseLeft:isDown ()
		)
	end
end

-- If input is currently a hold, return pressX, pressY.
-- If input is not a hold, return nil
function Pointer.hold ()

	if not drag and Pointer.getDownDuration () > HOLD_THRESHOLD then

		return pressX, pressY 

	end
end

-- Last XY position there was a pointer click/press
function Pointer.pressXY ()

	return pressX, pressY

end

-- If there was a Tap during this update, return coordinates
-- else, return nil
function Pointer.tap ()
	
	if releaseFromTapElapsedFrames == MOAISim.getElapsedFrames () then 

		return pressX, pressY

	end
end

-- Did the pointer unpress/release in the previous update 
function Pointer.up ()
	
	if MOAIInputMgr.device.touch then	
		
		return MOAIInputMgr.device.touch:up ()
		
	elseif MOAIInputMgr.device.pointer then
		
		return (	
			MOAIInputMgr.device.mouseLeft:up ()
		)
	end
end

-- Current or most recent position of the pointer
function Pointer.XY () return pointerX, pointerY end

function Pointer.X () return pointerX end

function Pointer.Y () return pointerY end

return Pointer

