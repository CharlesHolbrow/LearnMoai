local gBWall =	{ name = 'Green Brick Wall', obstruct = true }
local gBPath =	{ name = 'Green Brick Path' }
local gravel =	{ name = 'Gravel' }
local cactus = 	{ name = 'Cactus', obstruct = true }
local rocks =	{ name = 'Rocks', obstruct = true }
local sWall = 	{ name = 'Stone Wall', obstruct = true }
local sPath = 	{ name = 'Stone Path' }
local lBush = 	{ name = 'Large Bush', obstruct = true }
local sBush = 	{ name = 'Small Bush', obstruct = true }
local sign	=	{ name = 'Sign', read = 'This sign is empty' }
local desert = 	{ name = 'Desert' }

return { 

	gBWall, gBWall, gBWall,	gravel, gravel, gravel, gravel, gravel,
	gBWall, gBWall, gBWall,	gravel, gravel, gravel, gravel, gravel,
	gBWall, gBWall, gBWall, gBWall, gBWall, gravel, gravel, gravel, 
	sWall, sWall, sWall, gbWall, gbWall, desert, cactus, rocks, 
	sWall, sPath, sWall, sWall, sWall, lBush, lBush, lBush, 
	sWall, sPath, sWall, sWall, sWall, sign, sBush, sBush, 

}
