Y_SIZE = 512
X_SIZE = 1024

MOAISim.openWindow ( "test", X_SIZE, Y_SIZE )

viewport = MOAIViewport.new ()
viewport:setSize ( X_SIZE, Y_SIZE )
viewport:setScale ( X_SIZE, Y_SIZE )


package.path = ( '?.lua;' )

Util			= require ( 'util.Util' )
Pointer		 	= require ( 'input.Pointer' )

StateMgr		= require ( 'modules.StateMgr' )
GameObject		= require ( 'modules.GameObject' )

ResourceCache	= require ( 'modules.ResourceCache' )
deckCache = ResourceCache.new ()

Calc 			= require ( 'modules.Calc' )
Loc 			= require ( 'modules.Loc' )

Rig				= require ( 'objects.Rig' )
--Emelents		= require ( 'modules.Elements' )
Character		= require ( 'objects.Character' )

MapPosition		= require ( 'objects.map.MapPosition' )
Map 			= require ( 'objects.map.Map' )



StateMgr.push ( 'states/TestLevel.lua' )


StateMgr.begin ()

