--==============================================================
-- Create Decks
--==============================================================

-- should addDeck be local?
-- TODO: file nameing scheme, 
-- TODO: Different functions for TileDeck, Quad, TextBox

function addDeck ( fileName, name )
	local newDeck = MOAITileDeck2D.new ()
	newDeck:setTexture ( fileName)
	newDeck:setSize (4, 1)
	newDeck:setRect ( -28, -40, 28, 40 )-- Size of tiles in world space

	mainDecks[name] = newDeck
end

addDeck ( "img/man_map_4x1.png", 'characters' )