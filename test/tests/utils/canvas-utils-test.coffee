describe 'Canvas utils', ->
  utils = null

  before ->
    utils = require '../../../public/scripts/utils/canvas-utils'

  describe 'method drawTitleOnCanvas', ->
    beforeEach ->
      @context =
        fillText: sinon.spy()
        measureText: sinon.stub().returns width: 100
        save: sinon.spy()
        restore: sinon.spy()
        translate: sinon.spy()
        rotate: sinon.spy()

    it 'should define font color', ->
        title = {font: {size: 9, family: 'Arial', color: '#654231'}, position: {}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.fillStyle).to.equal '#654231'

    it 'should draw title to context', ->
        title = {text: 'New title', font: {size: 13, family: 'Arial'}, position: {}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.fillText).to.been.calledWith 'New title'

    describe 'font', ->
      it 'should define only text size and family', ->
        title = {font: {size: 13, family: 'Arial'}, position: {}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.font).to.equal '13px Arial'

      it 'should define text bold', ->
        title = {font: {size: 15, family: 'Verdana', bold: true}, position: {}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.font).to.equal 'bold 15px Verdana'

      it 'should define text italic', ->
        title = {font: {size: 16, family: 'Courier', italic: true}, position: {}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.font).to.equal 'italic 16px Courier'

      it 'should define text italic and bold', ->
        title = {
          font: {size: 18, family: 'Arial', bold: true, italic: true}
          position: {}
        }
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.font).to.equal 'italic bold 18px Arial'

    describe 'rotation', ->
      beforeEach ->
        @context.fillText.reset()
        @context.translate.reset()
        @context.rotate.reset()

      it 'should draw title on supplied position if angle is not defined', ->
        title = {font: {size: 16, family: 'F'}, position: {x: 13, y: 40}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.fillText.lastCall.args[1]).to.equal 13
        expect(@context.fillText.lastCall.args[2]).to.equal 56

      it 'should draw title on supplied position if angle is 0', ->
        title = {font: {size: 16, family: 'F'}, angle: 0, position: {x: 3, y: 1}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.fillText.lastCall.args[1]).to.equal 3
        expect(@context.fillText.lastCall.args[2]).to.equal 17

      it 'should transform canvas if angle is greater than 0', ->
        title = {font: {size: 1, family: 'F'}, angle: 180, position: {x: 9, y: 7}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.translate).to.been.calledOnce.and.calledWithExactly 9, 7
        expect(@context.rotate).to.been.calledOnce
        expect(@context.rotate.lastCall.args[0]).to.be.within 3.14, 3.15

      it 'should draw title on x = 0 and y = font size if angle is greater than 0', ->
        title = {font: {size: 9, family: 'F'}, angle: 90, position: {x: 2, y: 3}}
        utils.drawTitleOnCanvas @context, title, 1

        expect(@context.fillText.lastCall.args[1]).to.equal 0
        expect(@context.fillText.lastCall.args[2]).to.equal 9
