MOAISim.openWindow ( "test", 512, 512 )

viewport = MOAIViewport.new ()
viewport:setSize ( 512, 512 )
viewport:setScale ( 512, 512 )

package.path = ( '?.lua;../?.lua;' )
Util = require ( 'util.Util' )



print ( '--- Testing SparseMapLayer ---' )

SparseMapLayer = dofile ( 'modules/map/SparseLayer.lua' )
local sparseLayer = SparseMapLayer.new ()
local rig = Rig.new ()
local result = nil

print ( 'Adding Rig at 3, 4' )
sparseLayer:addRig ( rig, 3, 4 )

print ( 'Testing getRigs' )
result = sparseLayer:getRigs ( 3, 4 )
assert ( result [1] == rig )

print ( 'Testing getRigs at 3, 3 (Should return nil)' )
result = sparseLayer:getRigs ( 3, 3 )
assert ( result == nil )

print ( 'emptying table at 3, 4' )
sparseLayer.columns [ 3 ] [ 4 ] = {}
print ( 'Checking that getRigs 3, 4 returns nil' )
result = sparseLayer:getRigs ( 3, 4 )
assert ( result == nil )




print ( '\n--- Testing Rig ---' )
Rig = require ( 'modules.Rig' )

l0 = MOAILayer2D.new () 
l0:setViewport ( viewport )
MOAISim.pushRenderPass ( l0 )

l1 = MOAILayer2D.new ()
l1:setViewport ( viewport )
MOAISim.pushRenderPass ( l1 )

l2 = MOAILayer2D.new ()
l2:setViewport ( viewport )
MOAISim.pushRenderPass ( l2 )

d1 = MOAITileDeck2D.new ()
d1:setTexture ( 'img/man_map_3x1.png' )
d1:setSize ( 3, 1 )
d1:setRect ( -16, -16, 16, 16 )

d2 = MOAITileDeck2D.new ()
d2:setTexture ( 'img/man_map_3x1' )
d2:setSize ( 21, 10 )
d2:setRect ( -16, -16, 16, 16 )


r1 = Rig.new ()
r2 = Rig.new ()
r3 = Rig.new ()

p1 = MOAIProp2D.new ()
p1:setDeck ( d1 )

p2 = MOAIProp2D.new ()
p2:setDeck ( d1 )
p2:setIndex ( 2 )

p3 = MOAIProp2D.new ()
p3:setDeck ( d1 )
p3:setIndex ( 3 )
p3:moveLoc ( 32, 0 )


function makePixelProp ( index )
	local pixel = MOAIProp2D.new ()
	pixel:setDeck ( d2 )
	pixel:setIndex ( index or 87 )
	return pixel
end

pix1 = makePixelProp ()
pix2 = makePixelProp ()
pix3 = makePixelProp ()

r3:setLayer ( l0 )
pix1:setLoc ( -200, 150 )
pix2:setLoc ( -151, 200 )
pix3:setLoc ( -119, 200 )
r3:addProp ( pix1 )
r3:addProp ( pix2 )
r3:addProp ( pix3 )

r1:addProp ( p1 )
r1:addProp ( p3 )
r1:setLayer ( l1 )


r2:addProp ( p2 )
r2:setLayer ( l1 )

function threadFunc ()
	print ( 'Move Rig 1 to a offset location' )
	local action = r1.transform:seekLoc ( 50, 50, 1 )

	print ( 'Moving layer 2 to a offest location')
	l2:seekLoc ( -200, -150)

	MOAIThread.blockOnAction ( action ) 

	print ( '"cont" to continue' )
	debug.debug ()

	print ( 'Setting rig1 AND rig2 to layer2' )
	r2:setLayer ( l2 )
	r1:setLayer ( l2 ) 
end

thread = MOAIThread.new ()
thread:run ( threadFunc )



function onClick ( down )

	if down then

		local x, y  = MOAIInputMgr.device.pointer:getLoc () 
		print ( 'World Coordinates:', l3:wndToWorld ( x, y ) ) 

	end
end
MOAIInputMgr.device.mouseLeft:setCallback ( onClick )


--l2:insertProp ( p1 )

--r1:setLayer ( l2 )

--debug.debug ()




