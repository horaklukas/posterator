describe 'PosterStore', ->
  beforeAll ->
    @dispatcherMock =
      register: jasmine.createSpy('register').and.returnValue 'id_1'
      waitFor: jasmine.createSpy('waitFor')

    @editorStoreMock =
      getDraggedTitleId: jasmine.createSpy('getDraggedTitleId')
      getSelectedTitleId: jasmine.createSpy('getSelectedTitleId')
      countTitlePosition: jasmine.createSpy('countTitlePosition')
      dispatcherIndex: 'id2'

    mockery.registerMock './editor-store', @editorStoreMock
    mockery.registerMock '../dispatcher/app-dispatcher', @dispatcherMock

    @posterStore = require '../../../public/scripts/stores/poster-store'

    @constants = require '../../../public/scripts/constants/poster-constants'
    @constants2 = require '../../../public/scripts/constants/editor-constants'
    @actionHandler = @dispatcherMock.register.calls.mostRecent()?.args[0]
    spyOn @posterStore, 'emit'

  beforeEach ->
    @posterStore.posters = null
    @dispatcherMock.waitFor.calls.reset()
    @posterStore.emit.calls.reset()

  afterAll ->
    mockery.deregisterAll()

  it 'should register action handler when store required', ->
    expect(@dispatcherMock.register.calls.count()).toEqual(1)
    expect(@dispatcherMock.register.calls.argsFor(0)).toEqual [jasmine.any Function]


  it 'should save posters list when action POSTERS_LOADED is invoked', ->
    postersList = ['faked', 'posters', 'list']
    expect(@posterStore.getAllPosters()).toBeFalsy

    @actionHandler {type: @constants.POSTERS_LOADED, posters: postersList}

    expect(@posterStore.getAllPosters()).toEqual postersList

  it 'save id and titles of poster when action POSTER_SELECTED is invoked', ->
    titlesList = [{'f': 'faked'}, {'t': 'titles'}, {'l': 'list'}]
    posters = ['fake', {url: 'almost real', titles: titlesList}, 'fake 2']
    @posterStore.posters = posters

    expect(@posterStore.selected).toBeFalsy
    expect(@posterStore.titles).toBeFalsy

    @actionHandler {type: @constants.POSTER_SELECTED, posterId: 1}

    expect(@posterStore.selected).toEqual 1
    expect(@posterStore.getPosterTitles()).toEqual titlesList

  xit 'should save titles list when action TITLES_LOADED is invoked', ->
    titlesList = [{'f': 'faked'}, {'t': 'titles'}, {'l': 'list'}]
    expect(@posterStore.getPosterTitles()).toBeNull()

    @actionHandler {type: @constants.TITLES_LOADED, titles: titlesList}

    expect(@posterStore.getPosterTitles()).toEqual titlesList

  it 'should count new title position when action TITLE_MOVE is invoked', ->
    @posterStore.titles = [{ position:{x: 0, y: 0} }, { position:{x: 0, y: 0} }]

    @editorStoreMock.getDraggedTitleId.and.returnValue 1
    @editorStoreMock.countTitlePosition.and.returnValue {x: 20, y: 30}

    @actionHandler {type: @constants2.TITLE_MOVE, x: 5, y: 6}

    expect(@editorStoreMock.countTitlePosition.calls.argsFor(0)).toEqual [5, 6]
    expect(@dispatcherMock.waitFor.calls.count()).toEqual 1
    expect(@dispatcherMock.waitFor.calls.argsFor(0)[0]).toEqual(
      [@editorStoreMock.dispatcherIndex]
    )
    expect(@posterStore.getPosterTitles()).toEqual [
      { position:{x: 0, y: 0} }, { position:{x: 20, y: 30} }
    ]

  it 'should set new title text when action TITLE_TEXT_CHANGED is invoked', ->
    @posterStore.titles = [{ text: 'Title text 1' }, { text: 'Title text 2' }]

    @editorStoreMock.getSelectedTitleId.and.returnValue 0

    @actionHandler {type: @constants2.TITLE_TEXT_CHANGED, text: 'Title text 19'}

    expect(@dispatcherMock.waitFor.calls.count()).toEqual 1
    expect(@dispatcherMock.waitFor.calls.argsFor(0)[0]).toEqual(
      [@editorStoreMock.dispatcherIndex]
    )
    expect(@posterStore.getPosterTitles()).toEqual [
      { text: 'Title text 19' }, { text: 'Title text 2' }
    ]

  it 'should set new value of title property when action TITLE_FONT_CHANGED is invoked', ->
    @posterStore.titles = [ { text: 'text 1', font: {size: 6, family: 'Arial'} } ]

    @editorStoreMock.getSelectedTitleId.and.returnValue 0

    actualTitles = @posterStore.getPosterTitles()
    expect(actualTitles[0].font.size).toEqual 6
    expect(actualTitles[0].font.family).toEqual 'Arial'

    @actionHandler {type: @constants2.TITLE_FONT_CHANGED, property: 'size', value: 8}
    @actionHandler {type: @constants2.TITLE_FONT_CHANGED, property: 'family', value: 'Verdana'}

    expect(@dispatcherMock.waitFor.calls.count()).toEqual 2
    expect(@dispatcherMock.waitFor.calls.argsFor(0)[0]).toEqual(
      [@editorStoreMock.dispatcherIndex]
    )
    expect(@dispatcherMock.waitFor.calls.argsFor(1)[0]).toEqual(
      [@editorStoreMock.dispatcherIndex]
    )

    actualTitles = @posterStore.getPosterTitles()
    expect(actualTitles[0].font.size).toEqual 8
    expect(actualTitles[0].font.family).toEqual 'Verdana'

  it 'should set new title angle when action TITLE_ANGLE_CHANGED is invoked', ->
    @posterStore.titles = [ { angle: 168 }, { angle: 230}  ]

    @editorStoreMock.getSelectedTitleId.and.returnValue 1

    actualTitles = @posterStore.getPosterTitles()
    expect(actualTitles[1].angle).toEqual 230

    @actionHandler {type: @constants2.TITLE_ANGLE_CHANGED, angle: 233}

    expect(@dispatcherMock.waitFor).toHaveBeenCalledWith [@editorStoreMock.dispatcherIndex]

    actualTitles = @posterStore.getPosterTitles()
    expect(actualTitles[1].angle).toEqual 233

  it 'should add new empty title when action ADD_NEW_TITLE is invoked', ->
    @posterStore.titles = [ { angle: 168 }, { angle: 230}  ]

    actualTitles = @posterStore.getPosterTitles()
    expect(actualTitles.length).toEqual 2

    @actionHandler {type: @constants.ADD_NEW_TITLE}

    actualTitles = @posterStore.getPosterTitles()

    expect(actualTitles.length).toEqual 3
    expect(actualTitles[2]).toEqual {
      position: {x: 10, y: 10}
      angle: 0,
      text: 'Title',
      font: {size: 15, family: 'Arial', color: '#000000', italic: false, bold: false}
    }

  it 'should emit change event for known actions', ->
    @editorStoreMock.getSelectedTitleId.and.returnValue 0

    @actionHandler {type: @constants.POSTERS_LOADED, posters: [{titles: []}, {titles: []}]}
    expect(@posterStore.emit.calls.count()).toEqual(1)

    @actionHandler {type: @constants.POSTER_SELECTED, posterId: 1}
    expect(@posterStore.emit.calls.count()).toEqual 2

    title = {position:{x:0,y:0}, font:{}}
    @posterStore.titles = [title]

    @editorStoreMock.getDraggedTitleId.and.returnValue 0
    @actionHandler {type: @constants2.TITLE_MOVE, x: 6, y: 8}
    expect(@posterStore.emit.calls.count()).toEqual 3

    @actionHandler {type: @constants2.TITLE_TEXT_CHANGED, text: ''}
    expect(@posterStore.emit.calls.count()).toEqual 4

    @actionHandler {type: @constants2.TITLE_FONT_CHANGED, property: 'size', value: 3}
    expect(@posterStore.emit.calls.count()).toEqual 5

    @actionHandler {type: @constants2.TITLE_ANGLE_CHANGED, angle: 12}
    expect(@posterStore.emit.calls.count()).toEqual 6

    @actionHandler {type: @constants.ADD_NEW_TITLE}
    expect(@posterStore.emit.calls.count()).toEqual 7

  it 'should not emit change event for unknown actions', ->
    @actionHandler {type: @constants.UNKNOWN_ACTION, posters: []}
    expect(@posterStore.emit).not.toHaveBeenCalled
