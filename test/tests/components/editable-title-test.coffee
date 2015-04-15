describe 'Component EditableTitle', ->
  before ->
    @actionsMock =
      startTitleMove: sinon.spy()
      stopTitleMove: sinon.spy()
      selectTitle: sinon.spy()
      unselectTitle: sinon.spy()

    @domEventsMock = on: sinon.spy(), off: sinon.spy(), once: sinon.spy()

    mockery.registerMock '../actions/editor-actions-creators', @actionsMock
    mockery.registerMock 'dom-events', @domEventsMock

    @Title = require "../../../public/scripts/components/editable-title"
    @props =
      id: 8
      position: {x: 136, y: 20}
      text: 'This text is editable'
      font: {family: 'Arial', size: 24, bold: true, italic: false, color: 'bbb'}

    @title = TestUtils.renderIntoDocument React.createElement(@Title, @props)
    @elem = TestUtils.findRenderedDOMComponentWithClass @title, 'editable-title'

  beforeEach ->
    @actionsMock.startTitleMove.reset()
    @actionsMock.stopTitleMove.reset()
    @actionsMock.selectTitle.reset()
    @actionsMock.unselectTitle.reset()
    @domEventsMock.on.reset()
    @domEventsMock.once.reset()
    @domEventsMock.off.reset()

  after ->
    mockery.deregisterAll()

  it 'should set title to given absolute position', ->
    expect(@elem.props.style).to.have.property 'top', 20
    expect(@elem.props.style).to.have.property 'left', 136

  it 'should set given font family, size and color for title', ->
    expect(@elem.props.style).to.have.property 'fontFamily', 'Arial'
    expect(@elem.props.style).to.have.property 'fontSize', 24
    expect(@elem.props.style).to.have.property 'color', '#bbb'

  it 'should set font style for bold title text', ->
    expect(@elem.props.style).to.have.property 'fontStyle', 'bold'

  it 'should set font style for italic title text', ->
    props = position: {}, font: {bold: false, italic: true}

    title = TestUtils.renderIntoDocument React.createElement(@Title, props)
    elem = TestUtils.findRenderedDOMComponentWithClass title, 'editable-title'

    expect(elem.props.style).to.have.property 'fontStyle', 'italic'

  it 'should show given text inside title', ->
    expect(@elem.props.children).to.equal 'This text is editable'

  it 'should have class dragged when title is actually dragged', ->
    @props.dragged = true

    title = TestUtils.renderIntoDocument React.createElement(@Title, @props)
    elem = TestUtils.findRenderedDOMComponentWithClass title, 'editable-title'

    expect(elem.props.className).to.contain ' dragged'

  it 'should have class selected when title is actually selected', ->
    @props.selected = true
    @props.dragged = false

    title = TestUtils.renderIntoDocument React.createElement(@Title, @props)
    elem = TestUtils.findRenderedDOMComponentWithClass title, 'editable-title'

    expect(elem.props.className).to.contain ' selected'

  it 'should create startTitleMove action with title id when mouse down', ->
    TestUtils.Simulate.mouseDown @elem, {clientX: 60, clientY: 30}

    @actionsMock.startTitleMove.should.been.calledOnce.and.calledWithExactly(
      8, 60, 30, 136, 20
    )

  it 'should create selectTitle action with title id when clicked', ->
    TestUtils.Simulate.click @elem

    @actionsMock.selectTitle.should.been.calledOnce.and.calledWithExactly 8

  it 'should listen for click in canvas to unselect title', ->
    TestUtils.Simulate.click @elem

    @domEventsMock.once.should.been.calledOnce
    @domEventsMock.once.lastCall.args[1].should.equal 'click'
    @domEventsMock.once.lastCall.args[2].should.equal @title.handleUnselect

  it 'should listen for mouse events over document when mousedown', ->
    TestUtils.Simulate.mouseDown @elem, {clientX: 60, clientY: 30}

    @domEventsMock.on.should.been.calledTwice
    @domEventsMock.on.firstCall.should.been.calledWithExactly(
      document, 'mousemove', @title.handleMove
    )
    @domEventsMock.on.secondCall.should.been.calledWithExactly(
      document, 'mouseup',  @title.handleDrop
    )

  it 'should create stopTitleMove action with title id when mouse up', ->
    TestUtils.Simulate.mouseUp @elem

    @actionsMock.stopTitleMove.should.been.calledOnce.and.calledWithExactly 8

  it 'should unlisten for mouse events over document when mouseup', ->
    TestUtils.Simulate.mouseUp @elem, {clientX: 60, clientY: 30}

    @domEventsMock.off.should.been.calledTwice
    @domEventsMock.off.firstCall.should.been.calledWithExactly(
      document, 'mousemove', @title.handleMove
    )
    @domEventsMock.off.secondCall.should.been.calledWithExactly(
      document, 'mouseup',  @title.handleDrop
    )

  describe 'method unselectTitle', ->
    it 'should unselect currently selected title when target not title', ->
      @title.handleUnselect {target: {className: 'not-tit'}, preventDefault: ->}

      @actionsMock.unselectTitle.should.been.calledOnce

    it 'should not unselect currently selected title when target is title', ->
      @title.handleUnselect {target: @elem.getDOMNode(), preventDefault: ->}

      @actionsMock.unselectTitle.should.not.been.called
