local resourceCache = CCRig.new ()

function initResourceCache ()
	cache = CCRig.new ( resourceCache )
	-- Make resources a weak table for values
	mt = getmetatable ( cache )
	mt.__mode = 'v'
	return cache
end


function resourceCache:addDeck ( fn, key )
	local name, xSize, ySize = string.match ( fn, '^(.*)(%d+)x(%d+)\.png$' )
	local deck 
	-- assume textureName3x2.png is a MOAITileDeck2D texture
	if xSize and ySize then 
		deck = MOAITileDeck2D.new ()
		deck:setTexture ( fn )
		deck:setSize ( tonumber ( xSize ), tonumber ( ySize ) )
	else
		name = fn
		deck = MOAIGfxQuad2D.new ()
		deck:setTexture ( fn )
	end

	deck:setRect ( -16, -16, 16, 16 ) -- TODO: fix static 32x32 33?
	self [key or name] = deck 
	return deck
end

