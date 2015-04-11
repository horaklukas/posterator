describe 'Component PosterSelect', ->
  before ->
    @actionsMock = selectPoster: sinon.spy()

    mockery.registerMock "../actions/poster-actions-creators", @actionsMock
    PosterSelect = require "../../../public/scripts/components/poster-select"

    @props =
      posters: [
        {url: 'url1', name: 'title1'}, {url: 'url2', name: 'title2'},
        {url: 'url3', name: 'title3'}
      ]
    @sel = TestUtils.renderIntoDocument React.createElement(PosterSelect, @props)

  beforeEach ->
    @actionsMock.selectPoster.reset()

  after ->
    mockery.deregisterAll()

  it 'should render thumbnail for all posters', ->
    @posters = TestUtils.scryRenderedDOMComponentsWithClass @sel, 'thumbnail'

    expect(@posters).to.have.length 3
    expect(@posters[0].props.children[0].props.children).to.equal 'title1'
    expect(@posters[0].props.children[1].props.src).to.equal 'url1'
    expect(@posters[1].props.children[0].props.children).to.equal 'title2'
    expect(@posters[1].props.children[1].props.src).to.equal 'url2'
    expect(@posters[2].props.children[0].props.children).to.equal 'title3'
    expect(@posters[2].props.children[1].props.src).to.equal 'url3'

  it 'should create selectPoster action with thumbnail id when clicked', ->
    @posters = TestUtils.scryRenderedDOMComponentsWithClass @sel, 'thumbnail'

    TestUtils.Simulate.click @posters[1]

    @actionsMock.selectPoster.should.been.calledOnce.and.calledWithExactly 1