local Character = {}

function Character:talk ( msg )

	print ( self.name .. ': ' ..  ( msg or 'Hello!' ) )

end


function Character.new () 

	local char = Rig.new ( Character ) 

	GameObject.init ( char )
	
	char.name = 'Player Character'

	char.deck = deckCache:addDeck ( 'img/man_map_3x1.png' )

	local prop = MOAIProp2D.new ()
	prop:setDeck ( char.deck )

	GameObject.addProp ( char, prop )

	return char 

end

return Character