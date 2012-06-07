Character = Rig.new ()

function Character.new () 

	local char = Rig.new ()
	-- Add a character
	char = Rig.new ()

	char.deck = deckCache:addDeck ( 'img/man_map_3x1.png' )
	char.prop = MOAIProp2D.new () 
	char.prop:setDeck ( char.deck )

	function char.setIndex (self,  i )
	 	self.prop:setIndex ( i )
	end

	return char 
end


return Character