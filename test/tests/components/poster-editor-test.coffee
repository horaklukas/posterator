describe 'Component PosterEditor', ->
  before ->
    @editorStoreMock =
      isTitleDragged: sinon.stub()
      isTitleSelected: sinon.stub()

    mockery.registerMock './editable-title', mockComponent 'titleMock'
    mockery.registerMock './toolbox', mockComponent 'toolboxMock'
    mockery.registerMock './canvas', mockComponent 'canvasMock'
    mockery.registerMock '../stores/editor-store', @editorStoreMock

    @Editor = require "../../../public/scripts/components/poster-editor"
    @titles = [
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
      titles: @titles
      selectedTitle: 1

    @editor = TestUtils.renderIntoDocument React.createElement(@Editor, @props)
    @elem = TestUtils.findRenderedDOMComponentWithClass @editor, 'editor'
    @titles = TestUtils.scryRenderedDOMComponentsWithClass @editor, 'titleMock'

  beforeEach ->
    @editorStoreMock.isTitleDragged.reset()

  after ->
    mockery.deregisterAll()

  it 'should create all passed title', ->
    expect(@titles).to.have.length 2

  it 'should create each title with position, font, angle and text', ->
    expect(@titles[0].props).to.have.property('angle').that.eql 0
    expect(@titles[0].props).to.have.property('position').that.eql {
      top:170, left: 150
    }
    expect(@titles[0].props).to.have.property 'text', 'Title 1 bottom'
    expect(@titles[0].props).to.have.property('font').that.eql {
      size: 20, family: 'Verdana', bold: false, italic: false, color: '000'
    }
    expect(@titles[1].props).to.have.property('angle').that.eql 45
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

  it 'should set property selected for each title', ->
    @editorStoreMock.isTitleSelected.withArgs(0).returns false
    @editorStoreMock.isTitleSelected.withArgs(1).returns true

    @editor.forceUpdate()

    expect(@titles[0].props).to.have.property 'selected', false
    expect(@titles[1].props).to.have.property 'selected', true

  it 'should set editor height equal to poster', ->
    expect(@elem.props.style).to.be.an('object').and.have.property 'height', 96

  it 'should create toolbox when selected title id exists', ->
    TestUtils.findRenderedDOMComponentWithClass @editor, 'toolboxMock'

  it 'should pass selected title data to toolbox', ->
    toolbox = TestUtils.findRenderedDOMComponentWithClass @editor, 'toolboxMock'

    expect(toolbox.props).to.have.property 'titleAngle', 45
    expect(toolbox.props).to.have.property 'text', 'Title 2 top'
    expect(toolbox.props).to.have.property('font').that.eql {
      size: 16, family: 'Arial', bold: true, italic: false, color: 'f0f0f0'
    }

  it 'should set toolbox left position equal to poster width', ->
    toolbox = TestUtils.findRenderedDOMComponentWithClass @elem, 'toolboxMock'

    expect(toolbox.props).to.have.property 'left', 80

  it 'should not create toolbox when selected title id not exists', ->
    props =
      titles: @titles
      selectedTitle: null
      poster: @props.poster

    editor = TestUtils.renderIntoDocument React.createElement(@Editor, props)
    elem = TestUtils.findRenderedDOMComponentWithClass editor, 'editor'

    toolbox = TestUtils.scryRenderedDOMComponentsWithClass editor, 'toolboxMock'
    expect(toolbox).to.have.length 0
