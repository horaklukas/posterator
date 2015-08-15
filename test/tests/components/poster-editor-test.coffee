describe 'Component PosterEditor', ->
  Editor = null

  before ->
    @editorStoreMock =
      isTitleDragged: sinon.stub()
      isTitleSelected: sinon.stub()

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

    @editor = TestUtils.renderIntoDocument React.createElement(Editor, @props)
    @elem = TestUtils.findRenderedDOMComponentWithClass @editor, 'editor'
    @titles = TestUtils.scryRenderedDOMComponentsWithClass @editor, 'titleMock'

  beforeEach ->
    @editorStoreMock.isTitleDragged.reset()

  after ->
    mockery.deregisterAll()

  it 'should set panel left position to passed poster width', ->
    panel = TestUtils.findRenderedDOMComponentWithClass @elem, 'panel'
    expect(panel.props).to.have.deep.property 'style.left', 80

  it 'should set editor height equal to poster', ->
    expect(@elem.props.style).to.be.an('object').and.have.property 'height', 96

  it 'should create toolbox when selected title id exists', ->
    TestUtils.findRenderedDOMComponentWithClass @editor, 'toolboxMock'

  it 'should create list of available titles if no title selected', ->
    props = titles: @titlesData, selectedTitle: null, poster: @props.poster
    editor = TestUtils.renderIntoDocument React.createElement(Editor, props)

    TestUtils.findRenderedDOMComponentWithClass editor, 't-list'

  it 'should pass selected title data to toolbox', ->
    toolbox = TestUtils.findRenderedDOMComponentWithClass @editor, 'toolboxMock'

    expect(toolbox.props).to.have.property 'titleAngle', 45
    expect(toolbox.props).to.have.property 'text', 'Title 2 top'
    expect(toolbox.props).to.have.property('font').that.eql {
      size: 16, family: 'Arial', bold: true, italic: false, color: 'f0f0f0'
    }