local Rig = {}
Rig.__index = Rig

function Rig.new ( initial )
	newRig = {}
	local mt = initial or Rig
	
	setmetatable ( newRig,  { __index = mt } )
	return newRig
end 

function Rig:debug ()
	print 'Rig contents: '
	for k, v in pairs ( self ) do
		print ( k, v )
	end
	print 'Metatable contents: '
	local mt = getmetatable ( self )
	for k, v in pairs ( mt ) do
		print ( k, v )
	end
	if mt.__index then
		print 'Metatable.__index contents:'
		for k, v in pairs ( mt.__index ) do
			print ( k, v )
		end
	end
end

return Rig 