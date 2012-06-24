MOAISim.openWindow ( "test", 512, 512 )

viewport = MOAIViewport.new ()
viewport:setSize ( 512, 512 )
viewport:setScale ( 512, 512 )


package.path = ( '?.lua;' )

Util			= require ( 'util.Util' )
Rig				= require ( 'modules.Rig' )
GameObject		= require ( 'modules.GameObject' )
ResourceCache	= require ( 'modules.ResourceCache' )
deckCache = ResourceCache.new ()

Calc 			= require ( 'modules.Calc' )
Pointer		 	= require ( 'input.Pointer' )
Loc 			= require ( 'modules.Loc' )

require ( 'objects.Character' ) --Character		= require ( 'objects.Character' )

SparseMapLayer 	= require ( 'objects.map.SparseLayer' )
Map 			= require ( 'objects.map.Map' )
StateMgr		= require ( 'modules.StateMgr' )


StateMgr.push ( 'states/TestLevel.lua' )


StateMgr.begin ()

