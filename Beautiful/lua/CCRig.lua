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

return CCRig 