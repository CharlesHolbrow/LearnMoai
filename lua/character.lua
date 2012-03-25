Base = { init = function () print ( 'Base.init called' ) end }

function Base:new ( o )
	o = o or {}

	-- Use 'self' for metatable and __index 
	-- self will point to the subclass table
	setmetatable ( o, self )
	self.__index = self
	o:init ()
	return o
end

Character = Base:new ()

function Character:init ()
	print ( 'Init Character')
	self.prop = MOAIProp2D.new ()

	self.prop:setDeck ( mainDecks.characters )
	self.prop:setIndex ( 1 )
	self.prop:setLoc ( 0, 0 )
end


-- temporarily expose some prop methods
function Character:getIndex ()
	return self.prop:getIndex ()
end

function Character:setIndex ( i )
	self.prop:setIndex ( i )
end

function Character:moveLoc ( ... )
	self.prop:moveLoc ( ... )
end



