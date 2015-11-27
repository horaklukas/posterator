describe 'Canvas utils', ->
  utils = null

  beforeAll ->
    utils = require '../../../public/scripts/utils/canvas-utils'

  describe 'method drawTitleOnCanvas', ->
    beforeEach ->
      @context =
        fillText: jasmine.createSpy()
        measureText: jasmine.createSpy().and.returnValue width: 100
        save: jasmine.createSpy()
        restore: jasmine.createSpy()
        translate: jasmine.createSpy()
        rotate: jasmine.createSpy()

    it 'should define font color', ->
        title = {font: {size: 9, family: 'Arial', color: '#654231'}, position: {}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.fillStyle).toEqual '#654231'

    it 'should draw title to context', ->
        title = {text: 'New title', font: {size: 13, family: 'Arial'}, position: {}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.fillText.calls.mostRecent().args[0]).toEqual 'New title'

    describe 'font', ->
      it 'should define only text size and family', ->
        title = {font: {size: 13, family: 'Arial'}, position: {}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.font).toEqual '13px Arial'

      it 'should define text bold', ->
        title = {font: {size: 15, family: 'Verdana', bold: true}, position: {}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.font).toEqual 'bold 15px Verdana'

      it 'should define text italic', ->
        title = {font: {size: 16, family: 'Courier', italic: true}, position: {}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.font).toEqual 'italic 16px Courier'

      it 'should define text italic and bold', ->
        title = {
          font: {size: 18, family: 'Arial', bold: true, italic: true}
          position: {}
        }
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.font).toEqual 'italic bold 18px Arial'

    describe 'rotation', ->
      beforeEach ->
        @context.fillText.calls.reset()
        @context.translate.calls.reset()
        @context.rotate.calls.reset()

      it 'should draw title on supplied position if angle is not defined', ->
        title = {font: {size: 16, family: 'F'}, position: {x: 13, y: 40}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.fillText.calls.mostRecent().args[1]).toEqual 13
        expect(@context.fillText.calls.mostRecent().args[2]).toEqual 56

      it 'should draw title on supplied position if angle is 0', ->
        title = {font: {size: 16, family: 'F'}, angle: 0, position: {x: 3, y: 1}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.fillText.calls.mostRecent().args[1]).toEqual 3
        expect(@context.fillText.calls.mostRecent().args[2]).toEqual 17

      it 'should transform canvas if angle is greater than 0', ->
        title = {font: {size: 1, family: 'F'}, angle: 180, position: {x: 9, y: 7}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.translate.calls.count()).toEqual(1)
        expect(@context.translate.calls.argsFor(0)).toEqual [9, 7]
        expect(@context.rotate.calls.count()).toEqual(1)
        expect(@context.rotate.calls.mostRecent().args[0]).toBeGreaterThan 3.14
        expect(@context.rotate.calls.mostRecent().args[0]).toBeLessThan 3.15

      it 'should draw title on x = 0 and y = font size if angle is greater than 0', ->
        title = {font: {size: 9, family: 'F'}, angle: 90, position: {x: 2, y: 3}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.fillText.calls.mostRecent().args[1]).toEqual 0
        expect(@context.fillText.calls.mostRecent().args[2]).toEqual 9
