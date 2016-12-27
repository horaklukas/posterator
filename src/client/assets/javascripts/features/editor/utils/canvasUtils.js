export function drawTitleOnCanvas(context, title, id, isHovered) {
  let {text, angle} = title,
    {x, y} = title.position,
    {italic, bold, size, family, color} = title.fontl

  context.save();

  if (isHovered) {
      size += 3;
      context.strokeStyle = 'lime';
  }

  let fontDefinition = `${italic ? 'italic ' : ''}${bold ? 'bold ' : ''}${size}px ${family}`;

  context.font = fontDefinition;
  context.fillStyle = color;

  let {width} = context.measureText(title.text);

  if (angle) {
    angleInRadians = CanvasUtils.degToRad(angle);
  }

  // move the start of coordination system to the text position and then
  // rotate around this point
  context.translate(x, y);
  context.rotate(angleInRadians);

  // since start of coordinate system is text position, text should be drawn
  // there
  x = 0,
  y = 0;

  context.fillText(text, x, y + size);
  context.strokeText(text, x, y + size);

  context.restore();

  // return width of drawn text because we restored context and measuring then
  // wouldnt be precisely
  return width;
}

export function degToRad(degAngle) {
  return degAngle * Math.PI / 180;
}
