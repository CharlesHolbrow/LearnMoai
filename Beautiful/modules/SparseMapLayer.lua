Rig = require ( 'modules.Rig' )

local SparseMapLayer = Rig.new () 

function SparseMapLayer.new () 

	local newLayer = Rig.new () 
	newLayer.columns = {}

	function newLayer.addRig ( self, rig, x, y )

		if not self.columns [ x ] then
			self.columns [ x ] = {} 
		end

		if not self.columns [ x ] [ y ] then 
			self.columns [ x ] [ y ] = {} 
		end

		table.insert ( self.columns [ x ] [ y ] , rig )

		return rig
	end

	function newLayer.getRigs (  self, x, y )

		local check = nil 
		check = self.columns [ x ]
		if not check then return nil end

		check = check [ y ]
		if not check or #check == 0 then return nil end

		return check 
	end

	return newLayer
end

function SparseMapLayer.test ()

	local test = SparseMapLayer.new ()
	local rig = Rig.new ()
	local result = nil

	print ( 'Adding Rig at 3, 4' )
	test:addRig ( rig, 3, 4 )

	print ( 'Testing getRigs' )
	result = test:getRigs ( 3, 4 )
	assert ( result [1] == rig )

	print ( 'Testing getRigs at 3, 3 (Should return nil)' )
	result = test:getRigs ( 3, 3 )
	assert ( result == nil )

	print ( 'emptying table at 3, 4' )
	test.columns [ 3 ] [ 4 ] = {}
	print ( 'Checking that getRigs 3, 4 returns nil' )
	result = test:getRigs ( 3, 4 )
	assert ( result == nil )


	return test
end

return SparseMapLayer