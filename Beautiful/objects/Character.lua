local Character = Rig.new ( GameObject )

function Character:talk ( msg )

	print ( self.name .. ': ' ..  ( msg or 'Hello!' ) )

end


function newCharacter () 

	local char = Rig.new ( Character ) 

	GameObject.init ( char )
	
	char.name = 'Player Character'
	-- Add a character

	char.data.deck = deckCache:addDeck ( 'img/man_map_3x1.png' )

	local prop = MOAIProp2D.new ()
	prop:setDeck ( char.data.deck )

	GameObject.addProp ( char, prop )

	return char 
end

