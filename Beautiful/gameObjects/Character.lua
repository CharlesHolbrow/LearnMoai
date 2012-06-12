Character = Rig.new ()

function Character.new () 

	local char = Rig.new ()
	char.name = 'Player Character'
	-- Add a character

	char.data.deck = deckCache:addDeck ( 'img/man_map_3x1.png' )

	local prop = MOAIProp2D.new ()
	prop:setDeck ( char.data.deck )

	char:addProp ( prop )

	function char.setIndex (self,  i )
	 	self.data.props[1]:setIndex ( i )
	end

	return char 
end


return Character