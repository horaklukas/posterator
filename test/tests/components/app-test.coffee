describe 'Component App', ->
  before ->
    @posterStoreMock =
      getAllPosters: sinon.stub()
      getSelectedPoster: sinon.stub()
      getPosterTitles: sinon.stub()
      addChangeListener: sinon.spy()
      removeChangeListener: sinon.spy()

    @editorStoreMock =
      addChangeListener: sinon.spy()
      removeChangeListener: sinon.spy()

    mockery.registerMock './poster-editor', mockComponent 'editorMock'
    mockery.registerMock './poster-select', mockComponent 'posterSelectMock'
    mockery.registerMock '../stores/poster-store', @posterStoreMock
    mockery.registerMock '../stores/editor-store', @editorStoreMock
    App = require '../../../public/scripts/components/app'

    @props =
      posters: [
        {url: 'url1', name: 'title1'}, {url: 'url2', name: 'title2'},
        {url: 'url3', name: 'title3'}
      ]

    @app = TestUtils.renderIntoDocument React.createElement(App, @props)
    @changeCb = @posterStoreMock.addChangeListener.lastCall?.args[0]

  after ->
    mockery.deregisterAll()

  it 'should listen all stores for change', ->
    @posterStoreMock.addChangeListener.should.been.calledOnce
    @posterStoreMock.addChangeListener.lastCall.args[0].should.be.a 'function'
    @editorStoreMock.addChangeListener.should.been.calledOnce
    @editorStoreMock.addChangeListener.lastCall.args[0].should.be.a 'function'

  it 'should render posters list when selected poster is null', ->
    @posterStoreMock.getSelectedPoster.returns null

    @changeCb()

    TestUtils.findRenderedDOMComponentWithClass @app, 'posterSelectMock'
    editor = TestUtils.scryRenderedDOMComponentsWithClass(@app, 'editorMock')
    expect(editor).to.have.length 0

  it 'should render poster editor when selected poster is defined', ->
    @posterStoreMock.getSelectedPoster.returns {url: './image.png', name: 'Nm'}

    @changeCb()

    TestUtils.findRenderedDOMComponentWithClass @app, 'editorMock'
    select = TestUtils.scryRenderedDOMComponentsWithClass(@app, 'posterSelectMock')
    expect(select).to.have.length 0

  it 'should pass poster and its titles to editor component', ->
    poster = {url: './poster.png', name: 'Poster 1'}
    titles = [{'one': 1}, {'two': 2}, {'three': 3}, {'four': 4}]

    @posterStoreMock.getSelectedPoster.returns poster
    @posterStoreMock.getPosterTitles.returns titles

    @changeCb()

    editor = TestUtils.findRenderedDOMComponentWithClass @app, 'editorMock'

    expect(editor.props).to.have.property('poster').that.eql poster
    expect(editor.props).to.have.property('titles').that.eql titles


