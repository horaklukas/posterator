describe 'TitlesList', ->
  List = null

  beforeAll ->
    @actionsMock = selectTitle: jasmine.createSpy()

    mockery.registerMock '../../actions/editor-actions-creators', @actionsMock

    List = require "../../../public/scripts/components/titles-list/titles-list"
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
    @props = titles: @titlesData

  beforeEach ->
    @actionsMock.selectTitle.calls.reset()

  afterAll ->
    mockery.deregisterAll()

  it 'should create list of available titles', ->
    props = titles: @titlesData
    list = TestUtils.renderIntoDocument React.createElement(List, props)

    titles = TestUtils.scryRenderedDOMComponentsWithClass list, 'title'

    expect(titles.length).toEqual 2
    expect(titles[0].props.children).toEqual 'Title 1 bottom'
    expect(titles[1].props.children).toEqual 'Title 2 top'

  it 'should call selectTitle action when clicked title selector', ->
    props = titles: @titlesData
    list = TestUtils.renderIntoDocument React.createElement(List, props)

    titles = TestUtils.scryRenderedDOMComponentsWithClass list, 'title'

    TestUtils.Simulate.click titles[1]

    expect(@actionsMock.selectTitle.calls.count()).toEqual 1
    expect(@actionsMock.selectTitle.calls.argsFor(0)).toEqual [1]