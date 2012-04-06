CCRig = {}
CCRig.__index = CCRig

function CCRig.new ( initial )
	newRig = {}
	local mt = initial or CCRig
	
	setmetatable ( newRig,  { __index = mt } )
	return newRig
end 

function CCRig:debug ()
	print 'Rig contents: '
	for k, v in pairs ( self ) do
		print ( k, v )
	end
	print 'Metatable contants: '
	for k, v in pairs ( getmetatable ( self ) ) do
		print ( k, v )
	end
end
