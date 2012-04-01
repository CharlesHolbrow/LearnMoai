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
--   textbox:setLoc ( mx, my )  -- TODO: needs fix, textbox should not be global
--   textbox:setString ( tostring ( 'X' .. mx .. '\n' .. 'Y' .. my ) )
--   mainLayer:insertProp ( textbox ) -- TODO: don't need to insert prop on EACH pointer event

   --mainMap:worldToTileCoordinates ( mx, my )
end
MOAIInputMgr.device.pointer:setCallback ( onPointerEvent )


--==============================================================
-- Setup Input - Coroutines 
--==============================================================

-- An array of functions that accept deltaTime as an argument. 
-- methods are called seqeuntially each frame
local inputMethods = {}

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


local function playerMovement ( dt )

   playerSpeed = 100 
   dx, dy = 0, 0

   -- Arrow key movement 
   for key, action in pairs ( frameKeyActionMap ) do 
      if MOAIInputMgr.device.keyboard:keyIsDown ( key ) then 
         action ()
      end
   end

   -- Move Player
   p1:moveLoc (dx * playerSpeed * dt, dy * playerSpeed * dt, 0)

end 
table.insert ( inputMethods, playerMovement )

require ( 'lua/Mouse' )
table.insert ( inputMethods, Mouse.update )
table.insert ( inputMethods, Mouse.dragMap )

function callInputMethods ( dt )
   for i, method in ipairs ( inputMethods ) do
      method ( dt )
   end
end


