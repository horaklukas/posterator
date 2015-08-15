describe 'Component Canvas', ->
  Canvas = null

  before ->
    @editorStoreMock =
      getDraggedTitleId: sinon.stub()
      getSelectedTitleId: sinon.stub()

    @canvasUtilsMock = drawTitleOnCanvas: sinon.stub()
    @actionsMock =
      selectTitle: sinon.spy()
      unselectTitle: sinon.spy()
      startTitleMove: sinon.spy()
      titleMove: sinon.spy()
      stopTitleMove: sinon.spy()

    @domEventsMock = on: sinon.spy(), off: sinon.spy(), once: sinon.spy()

    mockery.registerMock '../stores/editor-store', @editorStoreMock
    mockery.registerMock '../utils/canvas-utils', @canvasUtilsMock
    mockery.registerMock '../actions/editor-actions-creators', @actionsMock
    mockery.registerMock 'dom-events', @domEventsMock

    Canvas = require "../../../public/scripts/components/canvas"
    @titlesData = [
      {
        position: {x: 150, y: 170}, text: 'Title 1 bottom', angle: 0, font: {
          size: 20, family: 'Verdana', bold: false, italic: false, color: '000'
        }
      }, {
        position: {x: 200, y: 46}, text: 'Title 2 top', angle: 45, font: {
          size: 16, family: 'Arial', bold: true, italic: false, color: 'f0f0f0'
        }
      }
    ]

    @props =
      poster: {width: 80, height: 96}
      titles: @titlesData
      selectedTitle: 1

    @canvas = TestUtils.renderIntoDocument React.createElement(Canvas, @props)

    # fake canvas `getContext` method that is not available at used jsdom
    @ctx = drawImage: sinon.spy()
    @canvas.refs.canvas.getDOMNode().getContext = sinon.stub().returns @ctx
    @elem = @canvas.refs.canvas

  beforeEach ->
    @domEventsMock.on.reset()
    @domEventsMock.off.reset()
    @canvasUtilsMock.drawTitleOnCanvas.reset()
    @actionsMock.selectTitle.reset()
    @actionsMock.unselectTitle.reset()
    @actionsMock.startTitleMove.reset()
    @actionsMock.titleMove.reset()
    @actionsMock.stopTitleMove.reset()

  after ->
    @canvas.refs.canvas.getDOMNode().getContext = null

  it 'should create all next props titles', ->
    @canvas.componentWillReceiveProps @props
    expect(@canvasUtilsMock.drawTitleOnCanvas).to.been.calledTwice

  it 'should create all titles at canvas context with title\'s data', ->
    @canvas.componentWillReceiveProps @props

    expect(@canvasUtilsMock.drawTitleOnCanvas.firstCall).to.been.calledWith @ctx
    expect(@canvasUtilsMock.drawTitleOnCanvas.firstCall.args[1]).to.eql @titlesData[0]

    expect(@canvasUtilsMock.drawTitleOnCanvas.secondCall).to.been.calledWith @ctx
    expect(@canvasUtilsMock.drawTitleOnCanvas.secondCall.args[1]).to.eql @titlesData[1]

  describe 'mousedown', ->
    beforeEach ->
      @bboxes = [
        {contains: sinon.stub().returns false}
        {contains: sinon.stub().returns false}
      ]
      @canvas.setState titlesBBoxes: @bboxes

    it 'should create startTitleMove action with id when title mouse down', ->
      @bboxes[1].contains.withArgs(230, 78).returns true

      TestUtils.Simulate.mouseDown @elem, {
        clientX: 260, clientY: 130, nativeEvent: {offsetX: 230, offsetY: 78}
      }

      @actionsMock.startTitleMove.should.been.calledOnce.and.calledWithExactly(
        1, 260, 130, 200, 46
      )

    it 'should create selectTitle action with id when title mouse down', ->
      @bboxes[1].contains.withArgs(230, 78).returns true

      TestUtils.Simulate.mouseDown @elem, {
        clientX: 260, clientY: 130, nativeEvent: {offsetX: 230, offsetY: 78}
      }

      @actionsMock.selectTitle.should.been.calledOnce.and.calledWithExactly 1

    it 'should unselect selected title when clicked to canvas not title', ->
      @editorStoreMock.getSelectedTitleId.returns 0

      TestUtils.Simulate.mouseDown @elem, {
        clientX: 260, clientY: 130, nativeEvent: {offsetX: 230, offsetY: 78}
      }

      @actionsMock.unselectTitle.should.been.calledOnce.and.calledWithExactly 0

    it 'should listen for mouse events over document when mousedown', ->
      @bboxes[1].contains.withArgs(230, 78).returns true

      TestUtils.Simulate.mouseDown @elem, {
        clientX: 260, clientY: 130, nativeEvent: {offsetX: 230, offsetY: 78}
      }

      @domEventsMock.on.should.been.calledTwice
      @domEventsMock.on.firstCall.should.been.calledWithExactly(
        document, 'mousemove', @canvas.handleMove
      )
      @domEventsMock.on.secondCall.should.been.calledWithExactly(
        document, 'mouseup',  @canvas.handleMouseUp
      )

  describe 'mousedown', ->
    it 'should create stopTitleMove action with title id when mouse up', ->
      @editorStoreMock.getDraggedTitleId.returns 8
      TestUtils.Simulate.mouseUp @elem

      @actionsMock.stopTitleMove.should.been.calledOnce.and.calledWithExactly 8

    it 'should not create stopTitleMove action if dragged title id is falsy', ->
      @editorStoreMock.getDraggedTitleId.returns null
      TestUtils.Simulate.mouseUp @elem

      @actionsMock.stopTitleMove.should.not.been.called

    it 'should unlisten for mouse events over document when mouseup', ->
      @editorStoreMock.getDraggedTitleId.returns 3
      TestUtils.Simulate.mouseUp @elem, {clientX: 60, clientY: 30}

      @domEventsMock.off.should.been.calledTwice
      @domEventsMock.off.firstCall.should.been.calledWithExactly(
        document, 'mousemove', @canvas.handleMove
      )
      @domEventsMock.off.secondCall.should.been.calledWithExactly(
        document, 'mouseup',  @canvas.handleMouseUp
      )