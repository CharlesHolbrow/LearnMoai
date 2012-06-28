local gBWall =	{ name = 'Green Brick Wall', 	elements = { rocky = 80 } }
local gBPath =	{ name = 'Green Brick Path', 	elements = { rocky = 0 } }
local gravel =	{ name = 'Gravel', 				elements = { rocky = 10 } }
local cactus = 	{ name = 'Cactus', 				elements = { overgrown = 80 } }
local rocks =	{ name = 'Rocks', 				elements = { rocky = 50 } }
local sWall = 	{ name = 'Stone Wall', 			elements = { rocky = 80 } }
local sPath = 	{ name = 'Stone Path', 			elements = { rocky = 0 } }
local lBush = 	{ name = 'Large Bush', 			elements = { overgrown = 70, wooden = 50 } }
local sBush = 	{ name = 'Small Bush', 			elements = { overgrown = 30, wooden = 30 } }
local sign	=	{ name = 'Sign',  				elements = { wooden = 80 },					text = 'This sign is empty' }
local desert = 	{ name = 'Desert', 				elements = { wooden = 70 } }

return { 

	gBWall, gBWall, gBWall,	gravel, gravel, gravel, gravel, gravel,
	gBWall, gBWall, gBWall,	gravel, gravel, gravel, gravel, gravel,
	gBWall, gBWall, gBWall, gBWall, gBWall, gravel, gravel, gravel, 
	sWall, 	sWall, 	sWall, 	gBWall, gBWall, desert, cactus, rocks, 
	sWall, 	sPath, 	sWall, 	sWall, 	sWall, 	lBush, 	lBush, 	lBush, 
	sWall, 	sPath, 	sWall, 	sWall, 	sWall, 	sign, 	sBush, 	sBush, 

}
