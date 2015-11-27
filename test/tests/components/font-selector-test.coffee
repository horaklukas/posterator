describe 'Component FontSelector', ->
  beforeAll ->
    FontSelector = require "../../../public/scripts/components/toolbox/font-selector"

    @props =
      fonts: ['Font1', 'Font2', 'Font3']
      onChange: jasmine.createSpy()

    @sel = TestUtils.renderIntoDocument React.createElement(FontSelector, @props)

  beforeEach ->
    @props.onChange.calls.reset()

  it 'should create font options from passed list', ->
    options = TestUtils.scryRenderedDOMComponentsWithTag @sel, 'option'

    expect(options.length).toEqual 3
    expect(options[0].props.children).toEqual 'Font1'
    expect(options[0].props.style.fontFamily).toEqual 'Font1'
    expect(options[0].props.value).toEqual 'Font1'
    expect(options[1].props.children).toEqual 'Font2'
    expect(options[1].props.style.fontFamily).toEqual 'Font2'
    expect(options[1].props.value).toEqual 'Font2'
    expect(options[2].props.children).toEqual 'Font3'
    expect(options[2].props.style.fontFamily).toEqual 'Font3'
    expect(options[2].props.value).toEqual 'Font3'

  it 'should call onChange callback when font changed', ->
    select = TestUtils.findRenderedDOMComponentWithTag @sel, 'select'

    TestUtils.Simulate.change select, target: value: 'Font2'

    expect(@props.onChange.calls.count()).toEqual 1
    expect(@props.onChange.calls.argsFor(0)).toEqual ['family', 'Font2']