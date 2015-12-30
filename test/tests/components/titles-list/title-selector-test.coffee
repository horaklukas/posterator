describe 'TitlesSelector', ->
  Selector = null

  beforeAll ->
    @actionsMock =
      selectTitle: jasmine.createSpy()
      hoverTitle: jasmine.createSpy()
      unhoverTitle: jasmine.createSpy()

    mockery.registerMock '../../actions/editor-actions-creators', @actionsMock

    Selector = require "../../../../public/scripts/components/titles-list/title-selector"
    @props = label: 'titleSelectorLabel', id: 1

  beforeEach ->
    @actionsMock.selectTitle.calls.reset()

  afterAll ->
    mockery.deregisterAll()

  it 'should display selector title', ->
    list = TestUtils.renderIntoDocument React.createElement(Selector, @props)

    title = TestUtils.findRenderedDOMComponentWithClass list, 'title'
    expect(title.getDOMNode().textContent).toEqual 'titleSelectorLabel'

  it 'should call selectTitle action when clicked title selector', ->
    list = TestUtils.renderIntoDocument React.createElement(Selector, @props)

    title = TestUtils.findRenderedDOMComponentWithClass list, 'title'

    TestUtils.Simulate.click title

    expect(@actionsMock.selectTitle.calls.count()).toEqual 1
    expect(@actionsMock.selectTitle.calls.argsFor(0)).toEqual [1]

  it 'should call hoverTitle action when mouse over title', ->
    list = TestUtils.renderIntoDocument React.createElement(Selector, {label: '', id: 2})
    title = TestUtils.findRenderedDOMComponentWithClass list, 'title'

    TestUtils.Simulate.mouseOver title

    expect(@actionsMock.hoverTitle.calls.count()).toEqual 1
    expect(@actionsMock.hoverTitle.calls.argsFor(0)).toEqual [2]

  it 'should call unhoverTitle action when mouse out title', ->
    list = TestUtils.renderIntoDocument React.createElement(Selector, @prps)
    title = TestUtils.findRenderedDOMComponentWithClass list, 'title'

    TestUtils.Simulate.mouseOut title

    expect(@actionsMock.unhoverTitle.calls.count()).toEqual 1
