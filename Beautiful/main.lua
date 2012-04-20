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

scene = initScene ( viewport )
deckCache = initResourceCache ()

-- Add a map to the scene
map = initTiledEditorMap ( 'map/desertTest100x100.lua' )
map.prop:forceUpdate ()

scene:addProp ( map.prop )

-- Set a callback for CCMouse drag
CCMouse.drag.callback = function ( dx, dy )
	scene.camera:moveLoc ( dx * -2 , dy * 2 )
end

-- Add a character
local player = CCRig.new ()
player.deck = deckCache:addDeck ( 'img/man_map_3x1.png' )
player.prop = scene:addProp ( MOAIProp2D.new () )
player.prop:setDeck ( player.deck )

-- everything below here just for debugging
--map:debug () 
function pploc ( down ) 
	print ( MOAIInputMgr.device.pointer:getLoc () )
	print ( 'Actions' )
	for k, v in pairs( CCMouse.press.actions ) do
		print ( k, v ) 
	end
end
table.insert ( CCMouse.press.actions, pploc )
table.insert ( CCMouse.press.actions, function () collectgarbage() end )

pploc = nil	

