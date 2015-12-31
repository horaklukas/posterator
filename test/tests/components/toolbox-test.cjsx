describe 'Component Toolbox', ->
  beforeAll ->
    @actionsMock =
      changeTitleText: jasmine.createSpy()
      changeTitleFont: jasmine.createSpy()
      changeTitleAngle: jasmine.createSpy()

    mockery.registerMock '../../actions/editor-actions-creators', @actionsMock
    mockery.registerMock 'react-slider', mockComponent 'sliderMock'

    @constants = require '../../../public/scripts/constants/editor-constants'
    Toolbox = require "../../../public/scripts/components/toolbox/toolbox"
    @props =
      text: 'Title text 1'
      titleAngle: 35
      font: {
        size: 20, family: 'Verdana', bold: false, italic: false, color: '000'
      }

    @tbox = TestUtils.renderIntoDocument <Toolbox {...@props} />
    @elem = TestUtils.findRenderedDOMComponentWithClass @tbox, 'toolbox'

  beforeEach ->
    @actionsMock.changeTitleText.calls.reset()

  afterAll ->
    mockery.deregisterAll()

  it 'should show passed text at input', ->
    input = TestUtils.findRenderedDOMComponentWithClass @elem, 'text'

    expect(input.props.value).toEqual 'Title text 1'

  it 'should call changeTitle callback when text changed', ->
    input = TestUtils.findRenderedDOMComponentWithClass @elem, 'text'
    TestUtils.Simulate.change input, {target: value: 'Title text 1 extended'}

    expect(@actionsMock.changeTitleText.calls.count()).toEqual 1
    expect(@actionsMock.changeTitleText.calls.argsFor(0)).toEqual(
      ['Title text 1 extended']
    )

  describe 'Font slider', ->
    beforeEach ->
      [@container] = TestUtils.scryRenderedDOMComponentsWithClass @elem, 'slider-container'
      @slider = TestUtils.findRenderedDOMComponentWithClass @container, 'sliderMock'
      @actionsMock.changeTitleFont.calls.reset()

    it 'should have label as a first child inside container', ->
      label = TestUtils.findRenderedDOMComponentWithClass @container, 'label'
      expect(label.getDOMNode().textContent).toEqual 'Font size'

    it 'should have constant min and max equal to defined constants', ->
      expect(@slider.props.min).toEqual @constants.FONT_SIZE.MIN
      expect(@slider.props.max).toEqual @constants.FONT_SIZE.MAX

    it 'should set actual value', ->
      expect(@slider.props.value).toEqual 20

    it 'should call changeTitleFont with name "size" and value when changed', ->
      callback = @slider.props.onChange
      callback(30)

      expect(@actionsMock.changeTitleFont.calls.count()).toEqual 1
      expect(@actionsMock.changeTitleFont.calls.argsFor(0)).toEqual ['size', 30]

  describe 'Text rotator', ->
    beforeEach ->
      containers = TestUtils.scryRenderedDOMComponentsWithClass @elem, 'slider-container'
      @container = containers[1]
      @slider = TestUtils.findRenderedDOMComponentWithClass @container, 'sliderMock'
      @actionsMock.changeTitleAngle.calls.reset()

    it 'should have label as a first child inside container', ->
      label = TestUtils.findRenderedDOMComponentWithClass @container, 'label'
      expect(label.getDOMNode().textContent).toEqual 'Text rotation'

    it 'should have range defined from 0 to 360', ->
      expect(@slider.props.min).toEqual 0
      expect(@slider.props.max).toEqual 360

    it 'should set title angle as a actual value', ->
      expect(@slider.props.value).toEqual 35

    it 'should call changeTitleAngle with angle value when changed', ->
      callback = @slider.props.onChange
      callback(38)

      expect(@actionsMock.changeTitleAngle.calls.count()).toEqual 1
      expect(@actionsMock.changeTitleAngle.calls.argsFor(0)).toEqual [38]