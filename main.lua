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

-- could use load file instead of require, 
-- in that case, I wouln't need to init global variables in another file
require 'lua/Class'
require 'lua/setupView'

mainDecks = {}
require 'lua/setupDecks'
require 'lua/setupInput'
require 'lua/Map'
require 'lua/Character'

-- create hex map
mainMap = Map:new ()
mainLayer:insertProp ( mainMap.prop )

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


mainRoutine = MOAICoroutine.new ()
mainRoutine:run ( 
function () 
   local run = true
   while run do

      local dt = coroutine.yield ()
      callInputMethods ( dt )

   end
end )

