describe 'Component FontSelector', ->
  before ->
    FontSelector = require "../../../public/scripts/components/toolbox/font-selector"

    @props =
      fonts: ['Font1', 'Font2', 'Font3']
      onChange: sinon.stub()

    @sel = TestUtils.renderIntoDocument React.createElement(FontSelector, @props)

  beforeEach ->
    @props.onChange.reset()

  it 'should create font options from passed list', ->
    options = TestUtils.scryRenderedDOMComponentsWithTag @sel, 'option'

    expect(options).to.have.length 3
    expect(options[0].props.children).to.equal 'Font1'
    expect(options[0].props.style.fontFamily).to.equal 'Font1'
    expect(options[0].props.value).to.equal 'Font1'
    expect(options[1].props.children).to.equal 'Font2'
    expect(options[1].props.style.fontFamily).to.equal 'Font2'
    expect(options[1].props.value).to.equal 'Font2'
    expect(options[2].props.children).to.equal 'Font3'
    expect(options[2].props.style.fontFamily).to.equal 'Font3'
    expect(options[2].props.value).to.equal 'Font3'

  it 'should call onChange callback when font changed', ->
    select = TestUtils.findRenderedDOMComponentWithTag @sel, 'select'

    TestUtils.Simulate.change select, target: value: 'Font2'

    expect(@props.onChange).to.been.calledOnce.and.calledWith 'family', 'Font2'