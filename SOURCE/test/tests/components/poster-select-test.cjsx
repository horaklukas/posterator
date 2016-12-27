describe 'Component PosterSelect', ->
  Thumbnail = require 'react-bootstrap/lib/Thumbnail'

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
    @posters = TestUtils.scryRenderedComponentsWithType @sel, Thumbnail

    expect(@posters.length).toEqual 3

    title1 = TestUtils.findRenderedDOMComponentWithTag(@posters[0], 'h5')
    title2 = TestUtils.findRenderedDOMComponentWithTag(@posters[1], 'h5')
    title3 = TestUtils.findRenderedDOMComponentWithTag(@posters[2], 'h5')

    expect(React.findDOMNode(title1).textContent).toEqual 'title1'
    expect(@posters[0].props.src).toEqual 'url1'
    expect(React.findDOMNode(title2).textContent).toEqual 'title2'
    expect(@posters[1].props.src).toEqual 'url2'
    expect(React.findDOMNode(title3).textContent).toEqual 'title3'
    expect(@posters[2].props.src).toEqual 'url3'

  it 'should create selectPoster action with thumbnail id when clicked', ->
    @posters = TestUtils.scryRenderedDOMComponentsWithClass @sel, 'thumbnail'

    TestUtils.Simulate.click @posters[1]

    expect(@actionsMock.selectPoster.calls.count()).toEqual 1
    expect(@actionsMock.selectPoster.calls.argsFor(0)).toEqual [1]