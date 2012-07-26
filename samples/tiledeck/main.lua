SCREEN_WIDTH = 480	
SCREEN_HEIGHT = 720
TILE_WIDTH = 16
TILE_HEIGHT = 20 

MOAISim.openWindow ( 'Cloud Communication', SCREEN_WIDTH, SCREEN_HEIGHT )

v = MOAIViewport.new ()
v:setSize ( SCREEN_WIDTH, SCREEN_HEIGHT )
v:setScale ( SCREEN_WIDTH, SCREEN_HEIGHT )

l = MOAILayer2D.new () 
l:setViewport ( v )

renderTable = { l }
MOAIRenderMgr.setRenderTable ( renderTable )


d = MOAITileDeck2D.new ()
d:setTexture ( 'elements7x4.png' )

-- Absolute width of our tiles. this 
-- Indicates how far apart our tiles are
local cellWidth		= 32 / 112 
local cellHeight	= 40 / 80
-- Our cells are now twice the size of a tile in elements7x4.png

-- Determine size of cell within a tile. 
-- will grow or shrink from the tile's upper left hand corner
local tileWidth 	= 16 / 112
local tileHeight 	= 20 / 80
-- Our tiles are the size of one tile

-- move by a half tile
local xOff = 8 / 112
local yOff = 10 / 80
-- tiles are now oncorrectly places exactly at the intersection of four tiles

-- tiles/cells are indexed from the top left like the order of words on a page of a book
-- how many of our tiles do we want to be indexable. 
local width, height = 2, 2
-- Only four tiles are indexable

d:setSize ( width, height, cellWidth, cellHeight, xOff, yOff, tileWidth, tileHeight )

-- How big are the props that instance this deck? (in model space dimensions)
d:setRect ( -32, -40, 32, 40 )

p = MOAIProp2D.new ()
p:setIndex ( 3 )
p:setDeck ( d )

l:insertProp ( p )

function main ()

	while true do

		local performance = MOAISim.getPerformance ()
		if performance < 55 then print ( performance ) end
		coroutine.yield ()

	end
end

c = MOAICoroutine.new ()
c:run ( main )




