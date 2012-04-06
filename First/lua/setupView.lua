--==============================================================
-- Create a Window, a viewport and a layer
--==============================================================

local function createViewport ( xSize, ySize, xScale, yScale)
   xScale = xScale or xSize
   yScale = yScale or ySize

   local viewport = MOAIViewport.new ()
   viewport:setSize ( xSize, ySize )
   viewport:setScale ( xScale, yScale)

   return viewport
end

local function addNewLayerToViewport ( viewport )
   local layer = MOAILayer2D.new ()
   layer:setViewport ( viewport )
   MOAISim.pushRenderPass ( layer )
   return layer
end

-- TODO: find a better way to set the size - global variables are bad
MOAISim.openWindow("Fast Game", X_SIZE, Y_SIZE)
mainViewport = createViewport ( X_SIZE , Y_SIZE, X_SIZE, Y_SIZE)
mainLayer = addNewLayerToViewport ( mainViewport )

mainCamera = MOAICamera2D.new () 
mainLayer:setCamera ( mainCamera )

