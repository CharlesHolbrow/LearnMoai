MOAISim.openWindow ( 'Coroutine Test', 100, 100 )


c = MOAICoroutine.new () -- Do this, but use a regular coroutine, and call coroutine.resume from state's onUpdate
a = MOAIAction.new ()
p = MOAIProp2D.new ()


a:start ()

print ( 'start- isactive', a:isActive () )

function g ()

	--print ( MOAISim.getPerformance () )

	if MOAIInputMgr.device.mouseLeft:down () then

		a:addChild ( p:moveLoc ( 4, 4, 5 ) ) 
		a:start ()
		print ( "isActive", a:isActive () )

		--return 
	end

	if a:isActive () then 

		print ( 'a is active', a:isActive () )
	else

		print  ( 'NOT ACTIVE' )
	end


	return 'running'
end


function f ()

	local done = false

	while g() == 'running' do

		coroutine.yield ()
	end

	-- advance pointer! 

end
 
c:run ( f )

print ( 'OKAY' )




