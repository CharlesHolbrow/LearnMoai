--==============================================================
-- set up
--==============================================================
X_SIZE = 640
Y_SIZE = 420

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
font:loadFromTTF ( 'arialbd.ttf', charcodes, 16, 163 )

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

-- I'm doomed perhaps there's a  better . checking  noe .... 