MOAISim.openWindow ( "test", 512, 512 )

viewport = MOAIViewport.new ()
viewport:setSize ( 512, 512 )
viewport:setScale ( 512, 512 )

package.path = ( '?.lua;lua/?.lua;' )

Rig = require ( 'Rig' )
require ( 'CCResourceCache' )
Loc = require ( 'modules.Loc' )
Map = require ( 'modules.Map' )
Mouse = require ( 'modules.Mouse' )
StateMgr = require ( 'modules.StateMgr' )

--require ( 'CCScene' )

--scene = initScene ( viewport )
--scene:debug ()

deckCache = initResourceCache ()

StateMgr.push ( 'States/TestLevel.lua' )
StateMgr.begin ()
