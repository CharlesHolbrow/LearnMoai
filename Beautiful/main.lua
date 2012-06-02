MOAISim.openWindow ( "test", 512, 512 )

viewport = MOAIViewport.new ()
viewport:setSize ( 512, 512 )
viewport:setScale ( 512, 512 )

package.path = ( '?.lua;lua/?.lua;' )

Rig 		  = require ( 'modules.Rig' )
ResourceCache = require ( 'modules.ResourceCache' )
deckCache = ResourceCache.new ()

Calc 		= require ( 'modules.Calc' )
Pointer 	= require ( 'input.Pointer' )
Loc 		= require ( 'modules.Loc' )
Map 		= require ( 'modules.Map' )
StateMgr	= require ( 'modules.StateMgr' )


StateMgr.push ( 'States/TestLevel.lua' )

deckCache:debug ()

StateMgr.begin ()
