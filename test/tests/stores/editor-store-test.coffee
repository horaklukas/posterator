describe 'EditorStore', ->
  before ->
    @dispatcherMock = register: sinon.stub()

    mockery.registerMock '../dispatcher/app-dispatcher', @dispatcherMock
    @editorStore = require '../../../public/scripts/stores/editor-store'
    @constants = require '../../../public/scripts/constants/editor-constants'
    @actionHandler = @dispatcherMock.register.lastCall?.args[0]
    sinon.stub @editorStore, 'emit'

  beforeEach ->
    @editorStore.emit.reset()

  after ->
    mockery.deregisterAll()
    @editorStore.emit.restore()

  it 'should register action handler when store required', ->
    @dispatcherMock.register.should.been.calledOnce
    @dispatcherMock.register.lastCall.args[0].should.be.a 'function'

  it 'should emit change event for known actions', ->
    @actionHandler {type: @constants.FONTS_LOADED, fonts: []}
    @editorStore.emit.should.been.calledOnce

    @actionHandler {
      type: @constants.TITLE_MOVE_START, titleId: 3, x: 3, y: 6,
      startPosition: {x: 4, y: 6}
    }
    @editorStore.emit.should.been.calledTwice

    @actionHandler {type: @constants.TITLE_MOVE_STOP}
    @editorStore.emit.should.been.calledThrice

    @actionHandler {type: @constants.TITLE_SELECT, titleId: 1}
    @editorStore.emit.callCount.should.equal 4

    @actionHandler {type: @constants.TITLE_UNSELECT}
    @editorStore.emit.callCount.should.equal 5

  it 'should not emit change event for unknown actions', ->
    @actionHandler {type: @constants.UNKNOWN_ACTION, titles: []}
    @editorStore.emit.should.not.been.called

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

  it 'should save selected title id when action TITLE_SELECT is invoked', ->
    expect(@editorStore.selectedTitle).to.be.falsy

    @actionHandler {type: @constants.TITLE_SELECT, titleId: 4}

    expect(@editorStore.selectedTitle).to.equal 4

  it 'should clear selected title id when action TITLE_UNSELECT is invoked', ->
    @actionHandler {type: @constants.TITLE_SELECT, titleId: 4}

    expect(@editorStore.selectedTitle).to.be.truthy

    @actionHandler {type: @constants.TITLE_UNSELECT}

    expect(@editorStore.selectedTitle).to.be.null

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

  describe 'method isTitleSelected', ->
    it 'should return true when passed id is equal to dragged id', ->
      @actionHandler {type: @constants.TITLE_SELECT, titleId: 3}
      expect(@editorStore.isTitleSelected 3).to.be.true

    it 'should return false when passed id is not equal to dragged id', ->
      @actionHandler {type: @constants.TITLE_SELECT, titleId: 12}
      expect(@editorStore.isTitleSelected 7).to.be.false
