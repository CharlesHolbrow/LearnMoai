--[[------------------------------------------------------------
MOAIDataBuffer
Buffer for loading and holding data. Data operations may be 
performed without additional penalty of marshalling buffers 
between Lua and C.
 	base64Decode
 	base64Encode
 	deflate
 	getSize
 	getString
 	inflate
 	load
 	loadAsync
 	save
 	saveAsync
 	setString
 	toCppHeader


MOAIDataBufferStream
MOAIDataBufferStream locks an associated MOAIDataBuffer for 
reading and writing.
	open 
	close

MOAIFileStream
MOAIFileStream opens a system file handle for eading or writing.
	open
	close

MOAIMemStream 
MOAIMemStream implements an in-memory stream and grows as 
needed. The mem stream expands on demands by allocating 
additional 'chunks' or memory. The chunk size may be configured 
by the user. Note that the chunks are not guaranteed to be 
contiguous in memory.
	open
	cloase

MOAIStream
Interface for reading/writing binary data.
	flush
 	getCursor
 	getLength
 	read
 	read8
 	read16
 	read32
 	readDouble
 	readFloat
 	readFormat
 	readU8
 	readU16
 	readU32
 	seek
 	write
 	write8
 	write16
 	write32
 	writeDouble
 	writeFloat
 	writeFormat
 	writeStream
 	writeU8
 	writeU16
 	writeU32

 MOAIStreamReader
 MOAIStreamReader may be attached to another stream for the 
 purpose of decoding and/or decompressing bytes read from that 
 stream using a given algorithm (such as base64 or 'deflate').
	close
 	openBase64
 	openDeflate

MOAIStreamWriter
MOAIStreamWriter may be attached to another stream for the 
purpose of encoding and/or compressing bytes written to that 
stream using a given algorithm (such as base64 or 'deflate').
 	close
 	openBase64
 	openDeflate

----------------------------------------------------------------

IMORTANT:
There is an error in the docs. Most Stream classes derive from 
MOAIStream. They inherit all the MOAIStream methods even though
you can't actually see them in the docs when you click "List of 
All Members"

--------------------------------------------------------------]]

-- To use a stream to CREATE a new stream, and open it
-- The three basic types that can be used for this are:
--		MOAIDataBufferStream
--		MOAIMemStream
--		MOAIFileStream

fs = MOAIFileStream.new ()
success = fs:open ( 'test.bin', MOAIFileStream.READ_WRITE_NEW )  -- error in docs, this takes three args
assert ( success, 'Failed to open test.bin for read/write' )

-- Now you can write to the stream 
fs:write8 ( 0, 1, 2, 3, 4, 5, 6, 7 ) -- omission in the docs. write methods can take multiple args
fs:write8 ( 8, 9, 10, 11, 12, 13, 14, 15 )
fs:write ( 'abcdefghijklmnop' )
fs:write16 ( 65536, 65535, 0, 0, 0, 0, 0, 0 )

-- when finished writing, flush
fs:flush ()
-- for karma, close the file when complete
fs:close ()

----------------------------------------------------------------
-- You can also use deflate and Base64
-- deflate is for compressing data
-- base64 is for converting binary to text

text = [[
0000000000000123456abcdefg0000000000000000000000000000000
0000000000000123456abcdefg0000000000000000000000000000000
0000000000000123456abcdefg0000000000000000000000000000000
0000000000000123456abcdefg0000000000000000000000000000000
0000000000000123456abcdefg0000000000000000000000000000000
0000000000000123456abcdefg0000000000000000000000000000000
0000000000000123456abcdefg0000000000000000000000000000000
0000000000000123456abcdefg0000000000000000000000000000000
0000000000000123456abcdefg0000000000000000000000000000000
]]

-- to use deflate or b64, first make a stream 
fs = MOAIFileStream.new ()
success = fs:open ( 'comp.b64', MOAIFileStream.READ_WRITE_NEW )
assert ( success, 'Failed to open FileStream for read/write' )


-- then open the newly created stream with a MOAIStreamWriter
b64Writer = MOAIStreamWriter.new ()
b64Writer:openBase64 ( fs ) 
-- b64Writer will write to the file

deflateWriter = MOAIStreamWriter.new ()
deflateWriter:openDeflate ( b64Writer ) 
-- deflateWriter will write to the b64Writer

-- Push the text through 
-- deflateWriter -> b64Writer -> FileStream
deflateWriter:write ( text )
deflateWriter:flush ()

-- close the writers in the correct order 
deflateWriter:close ()
b64Writer:close ()

-- reuse the FileStream writer
fs:seek ( 0 ) 

-- Run the readers in the reverse order
-- FileStream -> b64Reader -> inflateReader
b64Reader = MOAIStreamReader.new ()
success = b64Reader:openBase64 ( fs )
assert ( success, 'Failed to open FileStream for base64' )

inflateReader = MOAIStreamReader.new ()
success = inflateReader:openDeflate ( b64Reader )
assert ( success, 'Failed to open StreamReader for deflate' )

-- Pull the text through. 
print ( inflateReader:read ( #text ) ) 








