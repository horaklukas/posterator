// @flow

import * as utils from './canvasUtils';
import {Point} from 'models/editor';

function rotatePoint(point: Point, angleSin: number, angleCos: number, shiftX: number, shiftY: number): Point {
  let x = point.x - shiftX,
    y = point.y - shiftY;

  return {
    x: Math.round((x * angleCos) + (y * angleSin)) + shiftX,
    y: Math.round((-1 * x * angleSin) + (y * angleCos)) + shiftY
  };
}

/**
 * Counts scalar product of two vectors 
 *  https://en.wikipedia.org/wiki/Dot_product
 */
function countVectorsScalarProduct(vector1: Point, vector2: Point): number {
  return vector1.x * vector2.x + vector1.y * vector2.y;
}

function countVector(point1: Point, point2: Point): Point {
  return {
    x: point2.x - point1.x, 
    y: point2.y - point1.y
  };
}

export default class BBox {
  constructor(x, y, width, height, angle = 0) {
      // top left, top right, bottom left and bottom right corner coordinates
      this.tl = {
        x: x, 
        y: y
      };
      this.tr = {
        x: x + width, 
        y: y
      };
      this.bl = {
        x: x, 
        y: y + height
      };
      this.br = {
        x: this.tr.x, 
        y: this.bl.y
      };
  
      if (angle > 0){
        // algorithm for rotation rotate point counter clockwise, but we need 
        // rotate it clockwise (equal to as the canvas does it) and change
        // positive angle to negative reverse the direction
        let radiansAngle = utils.degToRad(-1 * angle),
          angleSin = Math.sin(radiansAngle);
          angleCos = Math.cos(radiansAngle);
  
        this.tr = rotatePoint(this.tr, angleSin, angleCos, x, y);
        this.bl = rotatePoint(this.bl, angleSin, angleCos, x, y);
        this.br = rotatePoint(this.br, angleSin, angleCos, x, y);
      }
  }    

  contains(x, y) {
    // See http://math.stackexchange.com/a/190373 for method how to count if
    // point is inside (possibly rotated) rectangle
    let tlTrVect = countVector(this.tl, this.tr),
      tlBlVect = countVector(this.tl, this.bl),
      tlPointVect = countVector(this.tl, {x: x, y: y});

    vx = countVectorsScalarProduct(tlTrVect, tlTrVect);
    vy = countVectorsScalarProduct(tlBlVect, tlBlVect);

    withinX = 0 <= (countVectorsScalarProduct(tlPointVect, tlTrVect)) <= vx;
    withinY = 0 <= (countVectorsScalarProduct(tlPointVect, tlBlVect)) <= vy;

    return withinX && withinY;
  }
}