describe 'Poster utils', ->
  beforeAll ->
    @failStub = jasmine.createSpy()
    @doneStub = jasmine.createSpy().and.returnValue {fail: @failStub}

    @getJsonStub = jasmine.createSpy().and.returnValue {done: @doneStub}
    @dispatcherMock = dispatch: jasmine.createSpy()
    @constants = require '../../../public/scripts/constants/poster-constants'

    mockery.registerMock 'jquery-ajax-json', @getJsonStub
    mockery.registerMock '../dispatcher/app-dispatcher', @dispatcherMock

    @utils = require '../../../public/scripts/utils/poster-utils'

  afterAll ->
    mockery.deregisterAll()

  describe 'method loadPosters', ->
    beforeAll ->
      expect(@constants.POSTERS_LOADED).not.toBeNull()
      expect(@constants.POSTERS_LOAD_FAILED).not.toBeNull()

    beforeEach ->
      @getJsonStub.calls.reset()
      @dispatcherMock.dispatch.calls.reset()
      @failStub.calls.reset()
      @doneStub.calls.reset()

    it 'should request posters data', ->
      @utils.loadPosters()

      expect(@getJsonStub.calls.mostRecent().args[0]).toEqual(
        jasmine.stringMatching(/get-data.php\?type=posters$/)
      )

    it 'should dispatch POSTERS_LOADED action when load succeded', ->
      posters = {'df': 'fake poster data 1', 'er': 'fake poster data 2'}

      @utils.loadPosters()
      @doneStub.calls.mostRecent().args[0](posters)

      expect(@dispatcherMock.dispatch.calls.count()).toEqual 1
      expect(@dispatcherMock.dispatch.calls.mostRecent().args[0]).toEqual {
        type: @constants.POSTERS_LOADED, posters: posters
      }

    it 'should dispatch POSTERS_LOAD_FAILED action when load failed', ->
      @utils.loadPosters()
      @failStub.calls.mostRecent().args[0]()

      expect(@dispatcherMock.dispatch.calls.count()).toEqual 1
      expect(@dispatcherMock.dispatch.calls.mostRecent().args[0]).toEqual {
        type: @constants.POSTERS_LOAD_FAILED, message: 'Loading posters failed'
      }

  describe 'method loadPosterTitles', ->
    beforeAll ->
      expect(@constants.TITLES_LOADED).not.toBeNull()
      expect(@constants.TITLES_LOAD_FAILED).not.toBeNull()

    beforeEach ->
      @getJsonStub.calls.reset()
      @dispatcherMock.dispatch.calls.reset()
      @failStub.calls.reset()
      @doneStub.calls.reset()

    it 'should request poster titles data', ->
      @utils.loadPosterTitles('df8')

      expect(@getJsonStub.calls.mostRecent().args[0]).toEqual(
        jasmine.stringMatching(/get-data.php\?type=titles&poster=df8$/)
      )

    it 'should dispatch TITLES_LOADED action when load succeded', ->
      titles = ['fake title 1', 'fake title 2']

      @utils.loadPosterTitles()
      @doneStub.calls.mostRecent().args[0](titles)

      expect(@dispatcherMock.dispatch.calls.count()).toEqual 1
      expect(@dispatcherMock.dispatch.calls.mostRecent().args[0]).toEqual {
        type: @constants.TITLES_LOADED, titles: titles
      }

    it 'should dispatch TITLES_LOAD_FAILED action when load failed', ->
      @utils.loadPosterTitles()
      @failStub.calls.mostRecent().args[0]()

      expect(@dispatcherMock.dispatch.calls.count()).toEqual 1
      expect(@dispatcherMock.dispatch.calls.mostRecent().args[0]).toEqual {
        type: @constants.TITLES_LOAD_FAILED, message: 'Loading titles failed'
      }
