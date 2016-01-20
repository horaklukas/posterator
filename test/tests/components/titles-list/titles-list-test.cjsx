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
    @list = TestUtils.renderIntoDocument <List {...@props} />

  afterEach ->
    React.unmountComponentAtNode React.findDOMNode(@list)

  afterAll ->
    mockery.deregisterAll()

  it 'should create list of available titles', ->
    titles = TestUtils.scryRenderedDOMComponentsWithClass @list, 'titleMock'

    expect(titles.length).toEqual 2
    expect(titles[0].props.label).toEqual 'Title 1 bottom'
    expect(titles[1].props.label).toEqual 'Title 2 top'

  it 'should display message if there are no titles', ->
    list = TestUtils.renderIntoDocument <List titles={[]} />
    message = 'There are no existing titles for poster'

    alert = TestUtils.findRenderedDOMComponentWithClass list, 'alert'
    titles = TestUtils.scryRenderedDOMComponentsWithClass list, 'titleMock'

    expect(React.findDOMNode(alert).textContent).toEqual message
    expect(titles.length).toEqual 0

  it 'should create button for add new title', ->

    btn = TestUtils.findRenderedDOMComponentWithClass @list, 'btn'
    expect(React.findDOMNode(btn).textContent).toEqual 'Add new title'

  it 'should invoke addNewTitle action when clicked button for add', ->
    button = TestUtils.findRenderedDOMComponentWithClass @list, 'btn'

    TestUtils.Simulate.click button

    expect(@actionsMock.addNewTitle.calls.count()).toEqual 1