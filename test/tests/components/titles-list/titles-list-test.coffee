describe 'TitlesList', ->
  List = null

  beforeAll ->
    @actionsMock = addNewTitle: jasmine.createSpy()

    mockery.registerMock '../../actions/poster-actions-creators', @actionsMock
    mockery.registerMock './title-selector', mockComponent('titleMock')

    List = require "../../../../public/scripts/components/titles-list/titles-list"
    @titlesData = [{text: 'Title 1 bottom'}, {text: 'Title 2 top'}]
    @props = titles: @titlesData

  beforeEach ->
    @actionsMock.addNewTitle.calls.reset()

  afterAll ->
    mockery.deregisterAll()

  it 'should create list of available titles', ->
    list = TestUtils.renderIntoDocument React.createElement(List, @props)

    titles = TestUtils.scryRenderedDOMComponentsWithClass list, 'titleMock'

    expect(titles.length).toEqual 2
    expect(titles[0].props.label).toEqual 'Title 1 bottom'
    expect(titles[1].props.label).toEqual 'Title 2 top'

  it 'should create button for add new title', ->
    editor = TestUtils.renderIntoDocument React.createElement(List, @props)

    btn = TestUtils.findRenderedDOMComponentWithClass editor, 'btn'
    expect(btn.getDOMNode().textContent).toEqual 'Add new title'

  it 'should invoke addNewTitle action when clicked button for add', ->
    list = TestUtils.renderIntoDocument React.createElement(List, @props)

    button = TestUtils.findRenderedDOMComponentWithClass list, 'btn'

    TestUtils.Simulate.click button

    expect(@actionsMock.addNewTitle.calls.count()).toEqual 1