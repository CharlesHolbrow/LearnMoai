X, Y = 512, 512
MOAISim.openWindow ( 'Testing some rendering', X, Y )

v = MOAIViewport.new ()
v:setSize ( X, Y )
v:setScale ( X, Y )

l = MOAILayer.new () 
l:setViewport ( v ) 

print ( 'Render Table:', MOAIRenderMgr.getRenderTable () ) 

print ( ' Clear render stack...' ) 
MOAIRenderMgr.clearRenderStack ()
print ( 'Render Table:', MOAIRenderMgr.getRenderTable () ) 

print ( 'Setting the render table...' ) 
MOAIRenderMgr.setRenderTable { l }
print ( 'Render Table:', MOAIRenderMgr.getRenderTable () ) 

print ( ' Clear render stack...' ) 
MOAIRenderMgr.clearRenderStack () 
print ( 'Render Table:', MOAIRenderMgr.getRenderTable () ) -- returns nil after clear

print ( 'Garbage collection....' ) 
MOAISim.forceGarbageCollection () 
collectgarbage ()
print ( 'Render Table:', MOAIRenderMgr.getRenderTable () ) 







