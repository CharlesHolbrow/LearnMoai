Character = Class:new ()

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



