describe 'Component PosterEditor', ->
  Editor = null

  beforeAll ->
    @editorStoreMock =
      isTitleDragged: jasmine.createSpy()
      isTitleSelected: jasmine.createSpy()

    mockery.registerMock './editable-title', mockComponent 'titleMock'
    mockery.registerMock './toolbox/toolbox', mockComponent 'toolboxMock'
    mockery.registerMock './canvas', mockComponent 'canvasMock'
    mockery.registerMock './titles-list/titles-list', mockComponent 't-list'
    mockery.registerMock '../stores/editor-store', @editorStoreMock

    Editor = require "../../../public/scripts/components/poster-editor"
    @titlesData = [
      {
        position: {top: 170, left: 150}, text: 'Title 1 bottom', angle: 0, font: {
          size: 20, family: 'Verdana', bold: false, italic: false, color: '000'
        }
      }
      {
        position: {top: 46, left: 200}, text: 'Title 2 top', angle: 45, font: {
          size: 16, family: 'Arial', bold: true, italic: false, color: 'f0f0f0'
        }
      }
    ]
    @props =
      poster: {width: 80, height: 96}
      titles: @titlesData
      selectedTitle: 1
      hoveredTitle: 69

    @editor = TestUtils.renderIntoDocument <Editor {...@props} />
    @elem = TestUtils.findRenderedDOMComponentWithClass @editor, 'editor'
    @titles = TestUtils.scryRenderedDOMComponentsWithClass @editor, 'titleMock'

  beforeEach ->
    @editorStoreMock.isTitleDragged.calls.reset()

  afterAll ->
    mockery.deregisterAll()

  it 'should set panel left position to passed poster width', ->
    panel = TestUtils.findRenderedDOMComponentWithClass @elem, 'panel'
    expect(panel.props.style.left).toEqual 80

  it 'should set editor height equal to poster', ->
    expect(@elem.props.style.height).toEqual 96

  it 'should create toolbox when selected title id exists', ->
    TestUtils.findRenderedDOMComponentWithClass @editor, 'toolboxMock'

  it 'should create list of available titles if no title selected', ->
    props = titles: @titlesData, selectedTitle: null, poster: @props.poster
    editor = TestUtils.renderIntoDocument <Editor {...props} />

    TestUtils.findRenderedDOMComponentWithClass editor, 't-list'

  it 'should not create panel content if no titles available', ->
    props = titles: null, selectedTitle: null, poster: @props.poster
    editor = TestUtils.renderIntoDocument <Editor {...props} />
    panel = TestUtils.findRenderedDOMComponentWithClass editor, 'panel'

    expect(panel.props.children[1]).toBeNull
    expect(panel.props.children[0].props.className).toContain 'btn'

  it 'should disable generate button when no titles available', ->
    props = titles: null, selectedTitle: null, poster: @props.poster
    editor = TestUtils.renderIntoDocument <Editor {...props} />

    btn = TestUtils.findRenderedDOMComponentWithClass editor, 'btn'
    expect(btn.props.disabled).toEqual true

  it 'should supply selected title data to toolbox', ->
    toolbox = TestUtils.findRenderedDOMComponentWithClass @editor, 'toolboxMock'

    expect(toolbox.props.titleAngle).toEqual 45
    expect(toolbox.props.text).toEqual 'Title 2 top'
    expect(toolbox.props.font).toEqual {
      size: 16, family: 'Arial', bold: true, italic: false, color: 'f0f0f0'
    }

  it 'should supply hovered title data to canvas', ->
    canvas = TestUtils.findRenderedDOMComponentWithClass @editor, 'canvasMock'

    expect(canvas.props.hoveredTitle).toEqual 69
