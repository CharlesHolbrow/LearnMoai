Character = Rig.new ()

function Character.new () 

	local char = Rig.new ()
	char.name = 'Player Character'
	-- Add a character

	char.deck = deckCache:addDeck ( 'img/man_map_3x1.png' )
	char:setProp ( MOAIProp2D.new () )
	char.prop:setDeck ( char.deck )
	char.prop.rig = char

	function char.setIndex (self,  i )
	 	self.prop:setIndex ( i )
	end

	return char 
end


return Character