utils = require './canvas-utils'

class BBox
  constructor: (x, y, width, height, angle = 0) ->
    # top left, top right, bottom left and bottom right corner coordinates
    @tl = x: x, y: y
    @tr = x: x + width, y: y
    @bl = x: x, y: y + height
    @br = x: @tr.x, y: @bl.y

    if angle > 0
      # algorithm for rotation rotate point counter clockwise, but we need rotate
      # it clockwise (equal to as the canvas does it) and change positive angle
      # to negative reverse the direction
      radiansAngle = utils.degToRad(-1 * angle)
      angleSin = Math.sin radiansAngle
      angleCos = Math.cos radiansAngle

      @tr = @_rotatePoint @tr, angleSin, angleCos, x, y
      @bl = @_rotatePoint @bl, angleSin, angleCos, x, y
      @br = @_rotatePoint @br, angleSin, angleCos, x, y

  ###*
  * @param {Object.<string, number>} point Point structure with keys `x` & `y`
  ###
  _rotatePoint: (point, angleSin, angleCos, shiftX, shiftY) ->
    x = point.x - shiftX
    y = point.y - shiftY

    x: Math.round((x * angleCos) + (y * angleSin)) + shiftX
    y: Math.round((-1 * x * angleSin) + (y * angleCos)) + shiftY

  contains: (x, y) ->
    # See http://math.stackexchange.com/a/190373 for method how to count if
    # point is inside (possibly rotated) rectangle
    tlTrVect = @_countVector @tl, @tr
    tlBlVect = @_countVector @tl, @bl
    tlPointVect = @_countVector @tl, {x: x, y: y}

    vx = @_countVectorsScalarProduct tlTrVect, tlTrVect
    vy = @_countVectorsScalarProduct tlBlVect, tlBlVect

    withinX = 0 <= (@_countVectorsScalarProduct tlPointVect, tlTrVect) <= vx
    withinY = 0 <= (@_countVectorsScalarProduct tlPointVect, tlBlVect) <= vy

    return withinX and withinY

  _countVector: (point1, point2) ->
    x: point2.x - point1.x, y: point2.y - point1.y

  ###*
  * Counts scalar product of two vectors https://en.wikipedia.org/wiki/Dot_product
  *
  * @param {Object.<string, number>} vector1
  * @param {Object.<string, number>} vector2
  ###
  _countVectorsScalarProduct: (vector1, vector2) ->
    vector1.x * vector2.x + vector1.y * vector2.y

module.exports = BBox