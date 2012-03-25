--==============================================================
-- Setup Input  - Callbacks
--==============================================================

local function onKeyboard ( key, down )
   print ( 'key:  ' .. tostring ( key ) )
   print ( 'down: ' .. tostring ( down ) )
end
MOAIInputMgr.device.keyboard:setCallback( onKeyboard )


local function onMouseLeftEvent ( down )

   -- Mouse left press
	if down == true then
		p1:setIndex( ( p1:getIndex () % 3 ) + 1 ) 
      print ( p1:getIndex() )

   -- Mouse left release
	else

	end
end
MOAIInputMgr.device.mouseLeft:setCallback ( onMouseLeftEvent )


local function onPointerEvent ( x, y )
   local mx, my = mainLayer:wndToWorld ( x, y )
   textbox:setLoc ( mx, my )  -- TODO: needs fix, textbox should not be global
   textbox:setString ( tostring ( 'X' .. mx .. '\n' .. 'Y' .. my ) )
   mainLayer:insertProp ( textbox )
   -- print ( 'Pointer:', x, y )
end
MOAIInputMgr.device.pointer:setCallback ( onPointerEvent )


--==============================================================
-- Setup Input - Coroutines 
--==============================================================

local UP_ARROW = 357
local DOWN_ARROW = 359
local LEFT_ARROW = 356
local RIGHT_ARROW = 358
local W_KEY = 119
local A_KEY = 97
local D_KEY = 100
local S_KEY = 115

local dx, dy = 0, 0
local function incLeft () dx = dx - 1 end
local function incRight () dx = dx + 1 end
local function incUp () dy = dy + 1 end
local function incDown () dy = dy - 1 end

local frameKeyActionMap = {
   [A_KEY] = incLeft, 
   [D_KEY] = incRight,
   [W_KEY] = incUp, 
   [S_KEY] = incDown
}

function frameInputRoutine ( dt )

   playerSpeed = 75 
   dx, dy = 0, 0

   for key, action in pairs ( frameKeyActionMap ) do 
      if MOAIInputMgr.device.keyboard:keyIsDown ( key ) then 
         action ()
      end
   end

   p1:moveLoc (dx * playerSpeed * dt, dy * playerSpeed * dt, 0)

   if MOAIInputMgr.device.mouseLeft:down () then
      print 'Mouse Left Pressed'
   end 
end 

