MOAISim.openWindow ( "test", 512, 512 )

viewport = MOAIViewport.new ()
viewport:setSize ( 512, 512 )
viewport:setScale ( 512, 512 )

package.path = ( '?.lua;lua/?.lua;' )
require ( 'CCRig' )
require ( 'Rig' )
require ( 'CCResourceCache' )
require ( 'modules/location' )
require ( 'modules/Map' )
require ( 'CCMouse' )
require ( 'CCScene' )
require ( 'CCStock' )

scene = initScene ( viewport )
scene:debug ()

deckCache = initResourceCache ()

-- Add a map to the scene
require ( 'modules/location' )
map = Map.makeMap ( 'map/desertTest100x100.lua' )
map.layer = scene.layers.main

-- Set a callback for CCMouse drag
CCMouse.drag.callback = function ( dx, dy )
	scene.camera:moveLoc ( dx * -2 , dy * 2 )
end

-- Add a character
local player = Rig.init ()
player.deck = deckCache:addDeck ( 'img/man_map_3x1.png' )
player.prop = MOAIProp2D.new () 
player.prop:setDeck ( player.deck )
player.setLayer = CCStock.setLayer 
table.insert ( scene.newRigs, player )

local function walkToClick ( down ) 
	if down then return end
	local x, y = MOAIInputMgr.device.pointer:getLoc ()
	x, y = map:wndToCoord ( x, y )
	x, y = map:coordToWorld ( x, y )
	player.prop:seekLoc ( x, y, 0.1 )
end
table.insert ( CCMouse.press.actions, walkToClick )

-- add any new props to layers if needed
scene:update ()

-- everything below here just for debugging
--map:debug () 
-- function pploc ( down ) 
-- 	if not down then return end
-- 	print ( 'Window position: ', MOAIInputMgr.device.pointer:getLoc () )
-- 	print ( 'Mouse Actions' )
-- 	for k, v in pairs( CCMouse.press.actions ) do
-- 		print ( k, v ) 
-- 	end
-- end
-- table.insert ( CCMouse.press.actions, pploc )

map.transform:moveLoc (-150, -150, 1)
