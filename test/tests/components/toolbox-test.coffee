describe 'Component Toolbox', ->
  before ->
    @actionsMock =
      changeTitleText: sinon.spy()
      changeTitleFont: sinon.spy()

    mockery.registerMock '../actions/editor-actions-creators', @actionsMock
    mockery.registerMock 'react-slider', mockComponent 'sliderMock'

    @constants = require '../../../public/scripts/constants/editor-constants'
    @Toolbox = require "../../../public/scripts/components/toolbox"
    @props =
      left: 600
      text: 'Title text 1'
      font: {
        size: 20, family: 'Verdana', bold: false, italic: false, color: '000'
      }

    @tbox = TestUtils.renderIntoDocument React.createElement(@Toolbox, @props)
    @elem = TestUtils.findRenderedDOMComponentWithClass @tbox, 'toolbox'

  beforeEach ->
    @actionsMock.changeTitleText.reset()

  after ->
    mockery.deregisterAll()

  it 'should set toolbox to passed left position', ->

    expect(@elem.props).to.have.deep.property 'style.left', 600

  it 'should show passed text at input', ->
    input = TestUtils.findRenderedDOMComponentWithClass @elem, 'text'

    expect(input.props).to.have.property 'value', 'Title text 1'

  it 'should call changeTitle callback when text changed', ->
    input = TestUtils.findRenderedDOMComponentWithClass @elem, 'text'
    TestUtils.Simulate.change input, {target: value: 'Title text 1 extended'}

    @actionsMock.changeTitleText.should.been.calledOnce.and.calledWithExactly(
      'Title text 1 extended'
    )

  describe 'Font slider', ->
    beforeEach ->
      [@container] = TestUtils.scryRenderedDOMComponentsWithClass @elem, 'slider-container'
      @slider = TestUtils.findRenderedDOMComponentWithClass @container, 'sliderMock'
      @actionsMock.changeTitleFont.reset()

    it 'should have label as a first child inside container', ->
      expect(@container.props.children[0]).to.equal 'Font size'

    it 'should have constant min and max equal to defined constants', ->
      expect(@slider.props).to.have.property 'min', @constants.FONT_SIZE.MIN
      expect(@slider.props).to.have.property 'max', @constants.FONT_SIZE.MAX

    it 'should set actual value', ->
      expect(@slider.props).to.have.property 'value', 20

    it 'should call changeTitleFont with name "size" and value when changed', ->
      callback = @slider.props.onChange
      callback(30)

      @actionsMock.changeTitleFont.should.been.calledOnce
      @actionsMock.changeTitleFont.should.been.calledWithExactly(
        'size', 30
      )