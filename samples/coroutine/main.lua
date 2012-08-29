MOAISim.openWindow ( 'Coroutine Test', 100, 100 )


c1 = MOAICoroutine.new ()
c2 = MOAICoroutine.new ()

m = MOAICoroutine.new ()

a = MOAIAction.new ()
a:start ()


function f ( s )

	while not MOAIInputMgr.device.mouseLeft:down () do

		print ( 'Waiting for mouse down, but not blocking', s )
		coroutine.yield ()
	end

	print ( 'Mouse Down' )
end


function mainLoop () 

	for i = 1, 1000 do 

		print ( 'Main Loop', i )
		coroutine.yield ()
	end 
end

c2:run ( f, 'This is C2' )
c1:run ( f, 'This is C1' )

m:run ( mainLoop )

m:addChild ( c1 ) 
c1:addChild ( c2 )



