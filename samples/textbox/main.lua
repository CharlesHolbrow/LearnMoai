XS = 512
YS = 512

MOAISim.openWindow ( 'Text Box Tests', XS, YS )

v = MOAIViewport.new ()
v:setSize ( XS, YS )
v:setScale ( XS, YS )

l = MOAILayer2D.new ()
l:setViewport ( v )
layerTable = { l }
MOAIRenderMgr.setRenderTable ( layerTable )

-- Make a MOAIFont 
charcodes = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .,:;!?()&/-'
font = MOAIFont.new ()

-- font:loadFromTTF Args: 
--	font file name
--	string containing Characters Load
--	font size in points 
--	dots per inch
--
-- Load a font texture containing charcodes, 
-- The Size and resolution is determined by a combination of the font size and dpi arguments
font:loadFromTTF ( 'arial-rounded.TTF', charcodes, 12, 163 )


-- Make a MOAITextBox
text = 'The quick <c:f70>brown<c> fox jumps over the <c:7f3>lazy<c> dog. \nNow here is a whole bunch more text thank you very much, and it really just keeps going and going. should add support for multiple pages. really I would like this string to be quite long. Also Moai is really pretty great. thank you very much. I hope I can find out what is causing that weird bug that I mentioned' 

textbox = MOAITextBox.new ()
textbox:setString ( text )
textbox:setFont ( font )
textbox:setTextSize ( 12, 163 )
textbox:setRect ( -100, -130, 100, 130 )
textbox:setYFlip ( true )
l:insertProp ( textbox )
-- Now that have loaded a texture. Size of the texture in memory is determined by the size, dpi and charcodes

spoolAction = textbox:spool ()
textbox:setSpeed ( 15 )
textbox:revealAll ()

textbox:nextPage ()

function onClick ( down ) 

	if not down then return end 

	if spoolAction:isBusy () then 

		spoolAction:stop ()
		textbox:revealAll ()

	elseif textbox:more () then 
		textbox:nextPage ()
		spoolAction = textbox:spool ()

	else
		textbox:setString ( 'Done' )
	end
end

MOAIInputMgr.device.mouseLeft:setCallback ( onClick )

