describe 'Component Canvas', ->
  Canvas = null

  beforeAll ->
    @editorStoreMock =
      getDraggedTitleId: jasmine.createSpy()
      getSelectedTitleId: jasmine.createSpy()

    @canvasUtilsMock = drawTitleOnCanvas: jasmine.createSpy()
    @actionsMock =
      selectTitle: jasmine.createSpy()
      unselectTitle: jasmine.createSpy()
      startTitleMove: jasmine.createSpy()
      titleMove: jasmine.createSpy()
      stopTitleMove: jasmine.createSpy()

    @domEventsMock = on: jasmine.createSpy(), off: jasmine.createSpy(), once: jasmine.createSpy()

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
    @ctx = drawImage: jasmine.createSpy()
    @canvas.refs.canvas.getDOMNode().getContext =
      jasmine.createSpy().and.returnValue @ctx
    @elem = @canvas.refs.canvas

  beforeEach ->
    @domEventsMock.on.calls.reset()
    @domEventsMock.off.calls.reset()
    @canvasUtilsMock.drawTitleOnCanvas.calls.reset()
    @actionsMock.selectTitle.calls.reset()
    @actionsMock.unselectTitle.calls.reset()
    @actionsMock.startTitleMove.calls.reset()
    @actionsMock.titleMove.calls.reset()
    @actionsMock.stopTitleMove.calls.reset()

  afterAll ->
    @canvas.refs.canvas.getDOMNode().getContext = null

  it 'should create all next props titles', ->
    @canvas.componentWillReceiveProps @props
    expect(@canvasUtilsMock.drawTitleOnCanvas.calls.count()).toEqual 2

  it 'should create all titles at canvas context with title\'s data', ->
    @canvas.componentWillReceiveProps @props

    drawTitleOnCanvasCalls = @canvasUtilsMock.drawTitleOnCanvas.calls.all()
    expect(drawTitleOnCanvasCalls[0].args[0]).toEqual @ctx
    expect(drawTitleOnCanvasCalls[0].args[1]).toEqual @titlesData[0]

    expect(drawTitleOnCanvasCalls[1].args[0]).toEqual @ctx
    expect(drawTitleOnCanvasCalls[1].args[1]).toEqual @titlesData[1]

  describe 'mousedown', ->
    beforeEach ->
      @bboxes = [
        {contains: jasmine.createSpy().and.returnValue false}
        {contains: jasmine.createSpy().and.returnValue false}
      ]
      @canvas.setState titlesBBoxes: @bboxes

    it 'should create startTitleMove action with id when title mouse down', ->
      @bboxes[1].contains.and.returnValue true

      TestUtils.Simulate.mouseDown @elem, {
        clientX: 260, clientY: 130, nativeEvent: {offsetX: 230, offsetY: 78}
      }

      expect(@bboxes[1].contains).toHaveBeenCalledWith 230, 78
      expect(@actionsMock.startTitleMove.calls.count()).toEqual 1
      expect(@actionsMock.startTitleMove.calls.argsFor(0)).toEqual(
        [1, 260, 130, 200, 46]
      )

    it 'should create selectTitle action with id when title mouse down', ->
      @bboxes[1].contains.and.returnValue true

      TestUtils.Simulate.mouseDown @elem, {
        clientX: 260, clientY: 130, nativeEvent: {offsetX: 230, offsetY: 78}
      }
      expect(@bboxes[1].contains).toHaveBeenCalledWith 230, 78
      expect(@actionsMock.selectTitle.calls.count()).toEqual 1
      expect(@actionsMock.selectTitle.calls.argsFor(0)).toEqual [1]

    it 'should unselect selected title when clicked to canvas not title', ->
      @editorStoreMock.getSelectedTitleId.and.returnValue 0

      TestUtils.Simulate.mouseDown @elem, {
        clientX: 260, clientY: 130, nativeEvent: {offsetX: 230, offsetY: 78}
      }

      expect(@actionsMock.unselectTitle.calls.count()).toEqual 1
      expect(@actionsMock.unselectTitle.calls.argsFor(0)).toEqual [0]

    it 'should listen for mouse events over document when mousedown', ->
      @bboxes[1].contains.and.returnValue true

      TestUtils.Simulate.mouseDown @elem, {
        clientX: 260, clientY: 130, nativeEvent: {offsetX: 230, offsetY: 78}
      }

      expect(@bboxes[1].contains).toHaveBeenCalledWith(230, 78)
      expect(@domEventsMock.on.calls.count()).toEqual 2
      expect(@domEventsMock.on.calls.argsFor(0)).toEqual(
        [document, 'mousemove', @canvas.handleMove]
      )
      expect(@domEventsMock.on.calls.argsFor(1)).toEqual(
        [document, 'mouseup',  @canvas.handleMouseUp]
      )

  describe 'mouseup', ->
    it 'should create stopTitleMove action with title id when mouse up', ->
      @editorStoreMock.getDraggedTitleId.and.returnValue 8
      TestUtils.Simulate.mouseUp @elem

      expect(@actionsMock.stopTitleMove.calls.count()).toEqual 1
      expect(@actionsMock.stopTitleMove.calls.argsFor(0)).toEqual [8]

    it 'should not create stopTitleMove action if dragged title id is falsy', ->
      @editorStoreMock.getDraggedTitleId.and.returnValue null
      TestUtils.Simulate.mouseUp @elem

      expect(@actionsMock.stopTitleMove).not.toHaveBeenCalled

    it 'should unlisten for mouse events over document when mouseup', ->
      @editorStoreMock.getDraggedTitleId.and.returnValue 3
      TestUtils.Simulate.mouseUp @elem, {clientX: 60, clientY: 30}

      expect(@domEventsMock.off.calls.count()).toEqual 2
      expect(@domEventsMock.off.calls.argsFor(0)).toEqual(
        [document, 'mousemove', @canvas.handleMove]
      )
      expect(@domEventsMock.off.calls.argsFor(1)).toEqual(
        [document, 'mouseup',  @canvas.handleMouseUp]
      )