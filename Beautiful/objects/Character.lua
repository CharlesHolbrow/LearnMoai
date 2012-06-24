local GameObject = require ( 'objects.GameObject' )
local Character = Rig.new ( GameObject )

function Character:talk ( msg )

	print ( self.name .. ': ' ..  ( msg or 'Hello!' ) )

end


function newCharacter () 

	local char = Rig.new ( Character ) 

	char:initGameObject ()
	
	char.name = 'Player Character'
	-- Add a character

	char.data.deck = deckCache:addDeck ( 'img/man_map_3x1.png' )

	local prop = MOAIProp2D.new ()
	prop:setDeck ( char.data.deck )

	char:addProp ( prop )

	return char 
end

