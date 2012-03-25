Map = Class:new ()


function Map:init ()

	-- Create the tile grid
	self.grid = MOAIGrid.new ()
	self.grid:initHexGrid ( 4, 12, 64 )
	--grid:initRectGrid ( 4, 12, 64, 64)
	self.grid:setRepeat ( false )

	for y = 1, 12 do
		for x = 1, 4 do
	    	self.grid:setTile ( x, y, (x * 2 ) - ( y % 2 ) )
		end
	end

	self.grid:setTile ( 2, 2, 3)

	self.prop = MOAIProp2D.new ()
	self.prop:setDeck ( mainDecks['hexMap'] )
	self.prop:setGrid ( self.grid )
	self.prop:setLoc ( 0, 0 )
	self.prop:setLoc ( -440, -330 )
	--self.prop:forceUpdate ()
end

function Map:worldToTileCoordinates ( worldX, worldY )
	propX, propY = self.prop:getLoc ()
	mapX = worldX - propX
	mapY = worldY - propY

	gridX, gridY = self.grid:locToCoord ( mapX, mapY )
	print (gridX .. ', ' .. gridY )

	self:hideTile ( gridX, gridY ) -- Debug

	return gridX, gridY
end

function Map:hideTile ( gridX, gridY )
	self.grid:setTileFlags ( gridX, gridY, 0x80000000)
end
