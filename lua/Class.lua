Class = {}

function Class:init () 
		print ( 'Class:init' ) 
end 

function Class:new ( o )
	o = o or {}

	-- Use 'self' for metatable and __index 
	-- self will point to the subclass table
	setmetatable ( o, self )
	self.__index = self
	o:init ()
	return o
end