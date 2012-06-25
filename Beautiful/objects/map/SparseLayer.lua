Rig = require ( 'objects.Rig' )

local SparseMapLayer = {}

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

return SparseMapLayer