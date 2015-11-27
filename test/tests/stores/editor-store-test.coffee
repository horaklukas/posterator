describe 'EditorStore', ->
  beforeAll ->
    @dispatcherMock = register: jasmine.createSpy('register')

    mockery.registerMock '../dispatcher/app-dispatcher', @dispatcherMock
    @editorStore = require '../../../public/scripts/stores/editor-store'
    @constants = require '../../../public/scripts/constants/editor-constants'
    @actionHandler = @dispatcherMock.register.calls.mostRecent()?.args[0]

  beforeEach ->
    spyOn @editorStore, 'emit'

  afterAll ->
    mockery.deregisterAll()
    #@editorStore.emit.restore()

  it 'should register action handler when store required', ->
    expect(@dispatcherMock.register.calls.count()).toBe 1
    expect(@dispatcherMock.register.calls.argsFor(0)).toEqual [jasmine.any(Function)]

  it 'should emit change event for known actions', ->
    @actionHandler {type: @constants.FONTS_LOADED, fonts: []}
    expect(@editorStore.emit.calls.count()).toBe 1

    @actionHandler {
      type: @constants.TITLE_MOVE_START, titleId: 3, x: 3, y: 6,
      startPosition: {x: 4, y: 6}
    }
    expect(@editorStore.emit.calls.count()).toBe 2

    @actionHandler {type: @constants.TITLE_MOVE_STOP}
    expect(@editorStore.emit.calls.count()).toBe 3

    @actionHandler {type: @constants.TITLE_SELECT, titleId: 1}
    expect(@editorStore.emit.calls.count()).toBe 4

    @actionHandler {type: @constants.TITLE_UNSELECT}
    expect(@editorStore.emit.calls.count()).toBe 5

  it 'should not emit change event for unknown actions', ->
    @actionHandler {type: @constants.UNKNOWN_ACTION, titles: []}
    expect(@editorStore.emit).not.toHaveBeenCalled()

  it 'should save title id and position when action TITLE_MOVE_START is invoked', ->
    expect(@editorStore.dragged.id).toBeFalsy()

    @actionHandler {
      type: @constants.TITLE_MOVE_START, titleId: 3, x: 30, y: 60,
      startPosition: {x: 40, y: 60}
    }

    expect(@editorStore.dragged.id).toEqual 3
    expect(@editorStore.dragged.x).toEqual 30
    expect(@editorStore.dragged.y).toEqual 60
    expect(@editorStore.dragged.initialPosition).toEqual {
      x: 40, y: 60
    }

  it 'should clear dragged title id when action TITLE_MOVE_STOP is invoked', ->
    @actionHandler {
      type: @constants.TITLE_MOVE_START, titleId: 3, x: 1, y: 2
      startPosition: {x: 40, y: 60}
    }

    expect(@editorStore.dragged).not.toEqual {}

    @actionHandler {type: @constants.TITLE_MOVE_STOP}

    expect(@editorStore.dragged).toEqual {}

  it 'should save selected title id when action TITLE_SELECT is invoked', ->
    expect(@editorStore.selectedTitle).toBeFalsy()

    @actionHandler {type: @constants.TITLE_SELECT, titleId: 4}

    expect(@editorStore.selectedTitle).toEqual 4

  it 'should clear selected title id when action TITLE_UNSELECT is invoked', ->
    @actionHandler {type: @constants.TITLE_SELECT, titleId: 4}

    expect(@editorStore.selectedTitle).toBeTruthy

    @actionHandler {type: @constants.TITLE_UNSELECT}

    expect(@editorStore.selectedTitle).toBeNull

  describe 'method isTitleDragged', ->
    it 'should return true when passed id is equal to dragged id', ->
      @actionHandler {type: @constants.TITLE_MOVE_START, titleId: 6, startPosition: {}}
      expect(@editorStore.isTitleDragged 6).toBeTrue

    it 'should return false when passed id is not equal to dragged id', ->
      @actionHandler {type: @constants.TITLE_MOVE_START, titleId: 8, startPosition: {}}
      expect(@editorStore.isTitleDragged 7).toBeFalse

  describe 'method countTitlePosition', ->
    it 'shhould return title position by passed client x and y', ->
      @actionHandler {
        type: @constants.TITLE_MOVE_START, titleId: 3, x: 10, y: 12
        startPosition: {x: 84, y: 49}
      }

      expect(@editorStore.countTitlePosition 20, 31).toEqual {x: 94, y: 68}
      expect(@editorStore.countTitlePosition 4, 6).toEqual {x: 78, y: 43}

  describe 'method isTitleSelected', ->
    it 'should return true when passed id is equal to dragged id', ->
      @actionHandler {type: @constants.TITLE_SELECT, titleId: 3}
      expect(@editorStore.isTitleSelected 3).toBeTrue

    it 'should return false when passed id is not equal to dragged id', ->
      @actionHandler {type: @constants.TITLE_SELECT, titleId: 12}
      expect(@editorStore.isTitleSelected 7).toBeFalse
