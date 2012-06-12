MOAISim.openWindow ( "test", 512, 512 )

print ( type ( MOAIProp2D.new () ) )

viewport = MOAIViewport.new ()
viewport:setSize ( 512, 512 )
viewport:setScale ( 512, 512 )


package.path = ( '?.lua;lua/?.lua;' )

Util			= require ( 'util.Util' )
Rig				= require ( 'modules.Rig' )
ResourceCache	= require ( 'modules.ResourceCache' )
deckCache = ResourceCache.new ()

Calc 			= require ( 'modules.Calc' )
Pointer		 	= require ( 'input.Pointer' )
Loc 			= require ( 'modules.Loc' )
Character		= require ( 'gameObjects.Character' )
SparseMapLayer 	= require ( 'modules.map.SparseLayer' )
Map 			= require ( 'modules.map.Map' )
StateMgr		= require ( 'modules.StateMgr' )


StateMgr.push ( 'states/TestLevel.lua' )


StateMgr.begin ()

