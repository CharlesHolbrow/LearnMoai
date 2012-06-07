-- test SparceMapLayer

print ( '--- Testing SparseMapLayer ---' )

SparseMapLayer = dofile ( 'modules/SparseMapLayer.lua' )
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



