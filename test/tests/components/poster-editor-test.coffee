describe 'Component PosterEditor', ->
  before ->
    @editorStoreMock = isTitleDragged: sinon.stub()

    mockery.registerMock './editable-title', mockComponent 'titleMock'
    mockery.registerMock './toolbox', mockComponent 'toolboxMock'
    mockery.registerMock './canvas', mockComponent 'canvasMock'
    mockery.registerMock '../stores/editor-store', @editorStoreMock

    @Editor = require "../../../public/scripts/components/poster-editor"
    @titles = [
      {
        position: {top: 170, left: 150}, text: 'Title 1 bottom', font: {
          size: 20, family: 'Verdana', bold: false, italic: false, color: '000'
        }
      }
      {
        position: {top: 46, left: 200}, text: 'Title 2 top', font: {
          size: 16, family: 'Arial', bold: true, italic: false, color: 'f0f0f0'
        }
      }
    ]
    @props =
      poster: {width: 80, height: 96}
      titles: @titles

    @editor = TestUtils.renderIntoDocument React.createElement(@Editor, @props)
    @elem = TestUtils.findRenderedDOMComponentWithClass @editor, 'editor'
    @titles = TestUtils.scryRenderedDOMComponentsWithClass @editor, 'titleMock'

  beforeEach ->
    @editorStoreMock.isTitleDragged.reset()

  after ->
    mockery.deregisterAll()

  it 'should create all passed title', ->
    expect(@titles).to.have.length 2

  it 'should create each title with position, font and text', ->
    expect(@titles[0].props).to.have.property('position').that.eql {
      top:170, left: 150
    }
    expect(@titles[0].props).to.have.property 'text', 'Title 1 bottom'
    expect(@titles[0].props).to.have.property('font').that.eql {
      size: 20, family: 'Verdana', bold: false, italic: false, color: '000'
    }
    expect(@titles[1].props).to.have.property('position').that.eql {
      top:46, left: 200
    }
    expect(@titles[1].props).to.have.property 'text', 'Title 2 top'
    expect(@titles[1].props).to.have.property('font').that.eql {
      size: 16, family: 'Arial', bold: true, italic: false, color: 'f0f0f0'
    }

  it 'should set property dragged for each title', ->
    @editorStoreMock.isTitleDragged.withArgs(0).returns true
    @editorStoreMock.isTitleDragged.withArgs(1).returns false

    @editor.forceUpdate()

    expect(@titles[0].props).to.have.property 'dragged', true
    expect(@titles[1].props).to.have.property 'dragged', false

  it 'should set editor height equal to poster', ->
    expect(@elem.props.style).to.be.an('object').and.have.property 'height', 96

  it 'should set toolbox left position equal to poster width', ->
    toolbox = TestUtils.findRenderedDOMComponentWithClass @elem, 'toolboxMock'

    expect(toolbox.props).to.have.property 'left', 80

