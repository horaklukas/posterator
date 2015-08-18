CanvasUtils =
  drawTitleOnCanvas: (context, title, id) ->
    {text, angle} = title
    {x, y} = title.position
    {italic, bold, size, family, color} = title.font

    context.save()

    fontDefinition = (if italic then 'italic ' else '') +
      (if bold then 'bold ' else '') +
      "#{size}px #{family}"

    context.font = fontDefinition
    context.fillStyle = color

    {width} = context.measureText(title.text)

    if angle? and angle > 0
      angleInRadians = CanvasUtils.degToRad(angle)

      # move the start of coordination system to the text position and then
      # rotate around this point
      context.translate x, y
      context.rotate(angleInRadians)

      # since start of coordinate system is text position, text should be drawn
      # there
      x = 0
      y = 0

    context.fillText text, x, y + size

    context.restore()

    # return width of drawn text because we restored context and measuring then
    # wouldnt be precisely
    return width

  degToRad: (degAngle) ->
    degAngle * Math.PI / 180

module.exports = CanvasUtils