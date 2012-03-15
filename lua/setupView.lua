--==============================================================
-- Create a Window, a viewport and a layer
--==============================================================

local function createViewport ( xSize, ySize, xScale, yScale)
   if xScale == nil then xScale = xSize end
   if yScale == nil then yScale = ySize end

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

MOAISim.openWindow("Fast Game", X_SIZE, Y_SIZE)
mainViewport = createViewport ( X_SIZE, Y_SIZE )
mainLayer = addNewLayerToViewport ( mainViewport )
