MOAISim.openWindow ( "test", 512, 512 )

viewport = MOAIViewport.new ()
viewport:setSize ( 512, 512 )
viewport:setScale ( 512, 512 )


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
Character		= require ( 'objects.Character' )

SparseMapLayer 	= require ( 'objects.map.SparseLayer' )
MapPosition		= require ( 'objects.map.MapPosition' )
Map 			= require ( 'objects.map.Map' )



StateMgr.push ( 'states/TestLevel.lua' )


StateMgr.begin ()

