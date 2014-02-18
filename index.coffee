fs = require 'fs'
Canvas = require 'canvas'
{Image} = Canvas
posterPath = "#{__dirname}/posters/krkanka_base.png"

createOutputFile = (outPath, canvas) ->
	out = fs.createWriteStream outPath
	stream = canvas.pngStream()

	stream.on 'data', (chunk) -> out.write chunk
	stream.on 'end', -> console.log "Output file #{outPath} created"

drawText = (context, text, font, x, y) ->
	context.font = "#{font.size}px #{font.family}";
	#context.rotate(.1);
	context.fillText text, x, y + font.size

	###
	te = context.measureText text
	context.strokeStyle = 'rgba(0,250,0,1)'
	context.beginPath()
	context.lineTo x, y + 2
	context.lineTo x + te.width, y + 2
	context.stroke()
	###

fs.readFile posterPath, (err, squid) ->
	if err then throw err

	posterBg = new Image
	posterBg.src = squid
	{width, height} = posterBg

	canvas = new Canvas width, height
	ctx = canvas.getContext '2d'	 

	ctx.drawImage posterBg, 0, 0, width, height

	font = size: 55, family: 'Times New Roman'
	drawText ctx, '26.12. 2014', font, 150, 180
	drawText ctx, 'XVII.', font, 180, 380

	createOutputFile "#{__dirname}/posters/krkanka_2014_new.png", canvas