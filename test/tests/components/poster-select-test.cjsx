describe 'Component PosterSelect', ->
  beforeAll ->
    @actionsMock = selectPoster: jasmine.createSpy()

    mockery.registerMock "../actions/poster-actions-creators", @actionsMock
    PosterSelect = require "../../../public/scripts/components/poster-select"

    @props =
      posters: [
        {url: 'url1', name: 'title1'}, {url: 'url2', name: 'title2'},
        {url: 'url3', name: 'title3'}
      ]
    @sel = TestUtils.renderIntoDocument <PosterSelect {...@props} />

  beforeEach ->
    @actionsMock.selectPoster.calls.reset()

  afterAll ->
    mockery.deregisterAll()

  it 'should render thumbnail for all posters', ->
    @posters = TestUtils.scryRenderedDOMComponentsWithClass @sel, 'thumbnail'

    expect(@posters.length).toEqual 3
    expect(@posters[0].props.children[0].props.children).toEqual 'title1'
    expect(@posters[0].props.children[1].props.src).toEqual 'url1'
    expect(@posters[1].props.children[0].props.children).toEqual 'title2'
    expect(@posters[1].props.children[1].props.src).toEqual 'url2'
    expect(@posters[2].props.children[0].props.children).toEqual 'title3'
    expect(@posters[2].props.children[1].props.src).toEqual 'url3'

  it 'should create selectPoster action with thumbnail id when clicked', ->
    @posters = TestUtils.scryRenderedDOMComponentsWithClass @sel, 'thumbnail'

    TestUtils.Simulate.click @posters[1]

    expect(@actionsMock.selectPoster.calls.count()).toEqual 1
    expect(@actionsMock.selectPoster.calls.argsFor(0)).toEqual [1]