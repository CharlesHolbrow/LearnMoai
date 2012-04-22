MOAISim.openWindow ( "test", 512, 512 )

viewport = MOAIViewport.new ()
viewport:setSize ( 512, 512 )
viewport:setScale ( 512, 512 )

package.path = ( 'lua/?.lua;' )
require ( 'CCRig' )
require ( 'CCResourceCache' )
require ( 'CCMap' )
require ( 'CCMouse' )
require ( 'CCScene' )
require ( 'CCLocation' )
require ( 'CCStock' )

scene = initScene ( viewport )
scene:debug ()

deckCache = initResourceCache ()

-- Add a map to the scene
map = initTiledEditorMap ( 'map/desertTest100x100.lua' )
map.layer = scene.layers.main

-- Set a callback for CCMouse drag
CCMouse.drag.callback = function ( dx, dy )
	scene.camera:moveLoc ( dx * -2 , dy * 2 )
end

-- Add a character
local player = CCRig.new ()
player.deck = deckCache:addDeck ( 'img/man_map_3x1.png' )
player.prop = MOAIProp2D.new () 
player.prop:setDeck ( player.deck )
player.setLayer = CCStock.setLayer 
table.insert ( scene.newRigs, player )

-- add any new props to layers if needed
scene:update ()





-- everything below here just for debugging
--map:debug () 
function pploc ( down ) 
	if not down then return end
	print ( 'Window position: ', MOAIInputMgr.device.pointer:getLoc () )
	print ( 'Mouse Actions' )
	for k, v in pairs( CCMouse.press.actions ) do
		print ( k, v ) 
	end
end
table.insert ( CCMouse.press.actions, pploc )

function pgc ( down )
	if not down then return end 
	local x, y = MOAIInputMgr.device.pointer:getLoc ()
	print ( 'Grid Coords:', map:wndToCoord ( x, y ) )
end
table.insert ( CCMouse.press.actions, pgc )

map.transform:moveLoc (-150, -150, 1)
