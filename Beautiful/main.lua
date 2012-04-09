MOAISim.openWindow ( "test", 512, 512 )

viewport = MOAIViewport.new ()
viewport:setSize ( 512, 512 )
viewport:setScale ( 512, 512 )

layer = MOAILayer2D.new ()
layer:setViewport ( viewport )
MOAISim.pushRenderPass ( layer )

camera = MOAICamera2D.new ()
layer:setCamera ( camera )

package.path = ( 'lua/?.lua;' .. package.path )
require ( 'CCRig' )
require ( 'CCMap' )
require ( 'CCMouse' )


map = initTiledEditorMap ( 'map/desertTest100x100.lua' )
map.prop:forceUpdate ()
layer:insertProp ( map.prop )

CCMouse.drag.callback = function ( dx, dy )
	camera:moveLoc ( dx * -2 , dy * 2 )
end

-- everything below here just for debugging
map:debug () 




