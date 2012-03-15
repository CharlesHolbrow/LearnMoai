--==============================================================
-- Setup Input  - Callbacks
--==============================================================

function onKeyboard ( key, down )
   print ( 'key:  ' .. tostring ( key ) )
   print ( 'down: ' .. tostring ( down ) )
end
MOAIInputMgr.device.keyboard:setCallback( onKeyboard )


function onMouseLeftEvent ( down )

   -- Mouse left press
	if down == true then
		p1:setIndex( ( p1:getIndex () % 3 ) + 1 ) 
		print ( p1:getIndex() )

   	-- Mouse right press
	else

	end
end
MOAIInputMgr.device.mouseLeft:setCallback ( onMouseLeftEvent )


function onPointerEvent ( x, y )
   mx, my = mainLayer:wndToWorld ( x, y )
   textbox:setLoc ( mx, my )  -- TODO: needs fix, textbox should not be global
   textbox:setString ( tostring ( 'X' .. mx .. '\n' .. 'Y' .. my ) )
   mainLayer:insertProp ( textbox )
   -- print ( 'Pointer:', x, y )
end
MOAIInputMgr.device.pointer:setCallback ( onPointerEvent )


--==============================================================
-- Setup Input - Coroutines 
--==============================================================

-- TODO: add
