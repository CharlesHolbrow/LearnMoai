Mouse = {}

Mouse.lastX, Mouse.lastY = 0, 0
Mouse.x, Mouse.y  = 0, 0
Mouse.deltaX, Mouse.deltaY = 0, 0

function Mouse.update () 

	Mouse.x, Mouse.y = MOAIInputMgr.device.pointer:getLoc ()
	Mouse.isDown = MOAIInputMgr.device.mouseLeft:isDown ()
	Mouse.deltaX = Mouse.x - Mouse.lastX
	Mouse.deltaY = Mouse.y - Mouse.lastY

	Mouse.lastX, Mouse.lastY = Mouse.x, Mouse.y

end 



function Mouse.getDelta ()
	return Mouse.deltaX, Mouse.deltaY
end


-- Add this to inputMethods to click and drag map
-- mainCamera must exist
local first = true
function Mouse.dragMap ()
	if Mouse.isDown then 
		if not first then
			mainCamera:moveLoc ( Mouse.getDelta () )
		end	
		first = false
	-- On Mouse Up 
	else 
		first = true
	end
end


-- A better way to do it:
-- When the mouse is clicked, find what was clicked on - clickTarget
-- on mouse drags, send drag command to each target. 
-- on mouse-up, send mouse up, on click, send mouse 
