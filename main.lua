--[[
Basic data structures to be abstracted. 
Represent each with no more than one global variable

Input 
   -- What do we do with input?
   -- Will eventually need windows, focus


World Building 
   -- Load decks 
   -- Create props

   -- Tile Object - Base class for terrain, character, 
   -- Location object - could be many layers of Tiles on a location
   -- Map object - maps are made of many locations

   -- Save and load maps 

]]

--==============================================================
-- init some global settings
--==============================================================
X_SIZE = 900
Y_SIZE = 760

UP_ARROW = 357
DOWN_ARROW = 359
LEFT_ARROW = 356
RIGHT_ARROW = 358
print ( 'LUA_PATH: ' .. package.path )


-- could use load file instead of require, 
-- in that case, I wouln't need to init global variables in another file
require 'lua/setupView'

mainDecks = {}
require 'lua/setupDecks'
require 'lua/setupInput'
require 'lua/character'

--print ( 'char type:' .. type ( character ) ) -- DEBUG

-- Create the tile grid
grid = MOAIGrid.new ()
grid:initHexGrid ( 4, 12, 64 )
--grid:initRectGrid ( 4, 12, 64, 64)
grid:setRepeat ( false )

for y = 1, 12 do
   for x = 1, 4 do
      grid:setTile ( x, y, (x * 2 ) - ( y % 2 ) )
   end
end

tileDeck = MOAITileDeck2D.new ()
tileDeck:setTexture ( "img/terrain4x4.png" )
tileDeck:setSize ( 4, 4, 0.25, 0.216796875 )

prop = MOAIProp2D.new ()
prop:setDeck ( tileDeck )
prop:setGrid ( grid )
prop:setLoc ( 0, 0 )
prop:setLoc ( -440, -330 )
--prop:forceUpdate ()
mainLayer:insertProp ( prop )
--prop:seekLoc ( -500, -330, 4 )

-- Create player prop
-- TODO: create a table of props. update setupInput.lua
p1 = Character:new ()
mainLayer:insertProp ( p1.prop )


-- TODO: make font and textbox local somehow 
local charcodes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'
font = MOAIFont.new ()
font:loadFromTTF ( 'fonts/arialbd.ttf', charcodes, 16, 163 )

textbox = MOAITextBox.new ()
textbox:setFont ( font )
--textbox:setTextSize ( font:getScale () )
textbox:setRect ( -50, -50, 50, 50 )
textbox:setYFlip ( true )


-- TODO: move more of the movement stuff into setupInput
mainRoutine = MOAICoroutine.new ()
mainRoutine:run (
   function ()
      local run = true
      playerSpeed = 75 
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

