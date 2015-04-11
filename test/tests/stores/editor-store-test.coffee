describe 'EditorStore', ->
  before ->
    @dispatcherMock = register: sinon.stub()

    mockery.registerMock '../dispatcher/app-dispatcher', @dispatcherMock
    @editorStore = require '../../../public/scripts/stores/editor-store'
    @constants = require '../../../public/scripts/constants/editor-constants'
    @actionHandler = @dispatcherMock.register.lastCall?.args[0]

  after ->
    mockery.deregisterAll()

  it 'should register action handler when store required', ->
    @dispatcherMock.register.should.been.calledOnce
    @dispatcherMock.register.lastCall.args[0].should.be.a 'function'

  it 'should save title id and position when action TITLE_MOVE_START is invoked', ->
    expect(@editorStore.dragged.id).to.be.falsy

    @actionHandler {
      type: @constants.TITLE_MOVE_START, titleId: 3, x: 30, y: 60,
      startPosition: {x: 40, y: 60}
    }

    expect(@editorStore.dragged.id).to.equal 3
    expect(@editorStore.dragged.x).to.equal 30
    expect(@editorStore.dragged.y).to.equal 60
    expect(@editorStore.dragged).to.have.property('initialPosition').that.eql {
      x: 40, y: 60
    }

  it 'should clear dragged title id when action TITLE_MOVE_STOP is invoked', ->
    @actionHandler {
      type: @constants.TITLE_MOVE_START, titleId: 3, x: 1, y: 2
      startPosition: {x: 40, y: 60}
    }

    expect(@editorStore.dragged).to.not.be.empty

    @actionHandler {type: @constants.TITLE_MOVE_STOP}

    expect(@editorStore.dragged).to.be.empty

  describe 'method isTitleDragged', ->
    it 'should return true when passed id is equal to dragged id', ->
      @actionHandler {type: @constants.TITLE_MOVE_START, titleId: 6, startPosition: {}}
      expect(@editorStore.isTitleDragged 6).to.be.true

    it 'should return false when passed id is not equal to dragged id', ->
      @actionHandler {type: @constants.TITLE_MOVE_START, titleId: 8, startPosition: {}}
      expect(@editorStore.isTitleDragged 7).to.be.false

  describe 'method countTitlePosition', ->
    it 'shhould return title position by passed client x and y', ->
      @actionHandler {
        type: @constants.TITLE_MOVE_START, titleId: 3, x: 10, y: 12
        startPosition: {x: 84, y: 49}
      }

      expect(@editorStore.countTitlePosition 20, 31).to.eql {x: 94, y: 68}
      expect(@editorStore.countTitlePosition 4, 6).to.eql {x: 78, y: 43}