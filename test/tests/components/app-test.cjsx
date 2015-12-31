describe 'Component App', ->
  beforeAll ->
    @posterStoreMock =
      getAllPosters: jasmine.createSpy()
      getSelectedPoster: jasmine.createSpy()
      getPosterTitles: jasmine.createSpy()
      addChangeListener: jasmine.createSpy()
      removeChangeListener: jasmine.createSpy()

    @editorStoreMock =
      addChangeListener: jasmine.createSpy()
      removeChangeListener: jasmine.createSpy()
      getSelectedTitleId: jasmine.createSpy()
      getAvailableFonts: jasmine.createSpy()
      getHoveredTitleId: jasmine.createSpy()

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

    @app = TestUtils.renderIntoDocument <App {...@props} />
    @changeCb = @posterStoreMock.addChangeListener.calls.mostRecent()?.args[0]

  afterAll ->
    mockery.deregisterAll()

  it 'should listen all stores for change', ->
    expect(@posterStoreMock.addChangeListener.calls.count()).toEqual 1
    expect(@posterStoreMock.addChangeListener.calls.mostRecent().args[0]).toEqual(
      jasmine.any(Function)
    )
    expect(@editorStoreMock.addChangeListener.calls.count()).toEqual 1
    expect(@editorStoreMock.addChangeListener.calls.mostRecent().args[0]).toEqual(
      jasmine.any(Function)
    )

  it 'should render posters list when selected poster is null', ->
    @posterStoreMock.getSelectedPoster.and.returnValue null

    @changeCb()

    TestUtils.findRenderedDOMComponentWithClass @app, 'posterSelectMock'
    editor = TestUtils.scryRenderedDOMComponentsWithClass(@app, 'editorMock')
    expect(editor.length).toEqual 0

  it 'should render poster editor when selected poster is defined', ->
    @posterStoreMock.getSelectedPoster.and.returnValue {url: './image.png', name: 'Nm'}

    @changeCb()

    TestUtils.findRenderedDOMComponentWithClass @app, 'editorMock'
    select = TestUtils.scryRenderedDOMComponentsWithClass(@app, 'posterSelectMock')
    expect(select.length).toEqual 0

  it 'should supply poster and its titles to editor component', ->
    poster = {url: './poster.png', name: 'Poster 1'}
    titles = [{'one': 1}, {'two': 2}, {'three': 3}, {'four': 4}]

    @posterStoreMock.getSelectedPoster.and.returnValue poster
    @posterStoreMock.getPosterTitles.and.returnValue titles

    @changeCb()

    editor = TestUtils.findRenderedDOMComponentWithClass @app, 'editorMock'
    expect(editor.props.poster).toEqual poster
    expect(editor.props.titles).toEqual titles

  it 'should supply selected title to editor component', ->
    @editorStoreMock.getSelectedTitleId.and.returnValue 2

    @changeCb()

    editor = TestUtils.findRenderedDOMComponentWithClass @app, 'editorMock'
    expect(editor.props.selectedTitle).toEqual 2

  it 'should supply hovered title to editor component', ->
    @editorStoreMock.getHoveredTitleId.and.returnValue 4

    @changeCb()

    editor = TestUtils.findRenderedDOMComponentWithClass @app, 'editorMock'
    expect(editor.props.hoveredTitle).toEqual 4
