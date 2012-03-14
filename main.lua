--==============================================================
-- set up
--==============================================================
X_SIZE = 640
Y_SIZE = 420

UP_ARROW = 357
DOWN_ARROW = 359
LEFT_ARROW = 356
RIGHT_ARROW = 358
print ( 'LUA_PATH: ' .. package.path )
MOAISim.openWindow("Fast Game", X_SIZE, Y_SIZE)

viewport = MOAIViewport.new ()
viewport:setScale ( X_SIZE, Y_SIZE )
viewport:setSize ( X_SIZE, Y_SIZE )

layer = MOAILayer2D.new ()
layer:setViewport ( viewport )
MOAISim.pushRenderPass ( layer )

d1 = MOAIGfxQuad2D.new ()
d1:setTexture ( "img/openlobster.png" )
d1:setRect ( -128, -128, 128, 128 )-- Size of tiles in world space

deckCharacters = MOAITileDeck2D.new ()
deckCharacters:setTexture ( "img/man_map_4x1.png" )
deckCharacters:setSize (4, 1)
deckCharacters:setRect ( -28, -40, 28, 40 )-- Size of tiles in world space


p1 = MOAIProp2D.new ()
p1:setDeck ( deckCharacters )
p1:setIndex ( 1 )
p1:setLoc ( 0, -20 )
layer:insertProp ( p1 )

function onKeyboard ( key, down)
   print ('key:  ' .. tostring ( key ) )
   print ('down: ' .. tostring ( down ) )
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

charcodes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'
font = MOAIFont.new ()
font:loadFromTTF ( 'fonts/arialbd.ttf', charcodes, 16, 163 )

textbox = MOAITextBox.new ()
textbox:setFont ( font )
textbox:setTextSize ( font:getScale () )
textbox:setRect ( -50, -50, 50, 50 )
textbox:setYFlip ( true )

function onPointerEvent ( x, y )
   mx, my = layer:wndToWorld ( x, y )
   textbox:setLoc ( mx, my ) 
   textbox:setString ( tostring ( 'X' .. mx .. '\n' .. 'Y' .. my ) )
   layer:insertProp ( textbox )
   -- print ( 'Pointer:', x, y )
end
MOAIInputMgr.device.pointer:setCallback ( onPointerEvent )

mainRoutine = MOAICoroutine.new ()
mainRoutine:run (
   function ()
      local run = true
      playerSpeed = 50
      while run do

         local dt = coroutine.yield ()
         local dx, dy = 0, 0

         if MOAIInputMgr.device.keyboard:keyIsDown (UP_ARROW) then
            dy = dy + 1
         end
         if MOAIInputMgr.device.keyboard:keyIsDown ( DOWN_ARROW ) then 
            dy = dy - 1
         end
         if MOAIInputMgr.device.keyboard:keyIsDown ( LEFT_ARROW ) then 
            dx = dx - 1
         end
         if MOAIInputMgr.device.keyboard:keyIsDown ( RIGHT_ARROW ) then 
            dx = dx + 1
         end
         p1:moveLoc (dx * playerSpeed * dt, dy * playerSpeed * dt, 0)


         if MOAIInputMgr.device.mouseLeft:down () then
            print 'Mouse Left Pressed'
         end 
      end 
   end
)

