MOAISim.openWindow ( "test", 512, 512 )

viewport = MOAIViewport.new ()
viewport:setSize ( 512, 512 )
viewport:setScale ( 512, 512 )

package.path = ( '?.lua;lua/?.lua;' )

Rig 		= require ( 'modules.Rig' )
Calc 		= require ( 'modules.Calc' )
require ( 'CCResourceCache' )
Pointer 	= require ( 'input.Pointer' )
Loc 		= require ( 'modules.Loc' )
Map 		= require ( 'modules.Map' )
StateMgr	= require ( 'modules.StateMgr' )

deckCache = initResourceCache ()

StateMgr.push ( 'States/TestLevel.lua' )
StateMgr.begin ()
