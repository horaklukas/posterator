describe 'PosterStore', ->
  before ->
    @dispatcherMock =
      register: sinon.stub().returns 'id_1'
      waitFor: sinon.stub()

    @editorStoreMock =
      getDraggedTitleId: sinon.stub()
      countTitlePosition: sinon.stub()
      dispatcherIndex: 'id2'

    mockery.registerMock './editor-store', @editorStoreMock
    mockery.registerMock '../dispatcher/app-dispatcher', @dispatcherMock
    @posterStore = require '../../../public/scripts/stores/poster-store'
    @constants = require '../../../public/scripts/constants/poster-constants'
    @constants2 = require '../../../public/scripts/constants/editor-constants'
    @actionHandler = @dispatcherMock.register.lastCall?.args[0]
    sinon.stub @posterStore, 'emit'

  beforeEach ->
    @dispatcherMock.waitFor.reset()
    @posterStore.emit.reset()

  after ->
    mockery.deregisterAll()
    @posterStore.emit.restore()

  it 'should register action handler when store required', ->
    @dispatcherMock.register.should.been.calledOnce
    @dispatcherMock.register.lastCall.args[0].should.be.a 'function'

  it 'save id of poster when action POSTER_SELECTED is invoked', ->
    expect(@posterStore.selected).to.be.falsy

    @actionHandler {type: @constants.POSTER_SELECTED, posterId: 4}

    expect(@posterStore.selected).to.equal 4

  it 'should save posters list when action POSTERS_LOADED is invoked', ->
    postersList = ['faked', 'posters', 'list']
    expect(@posterStore.getAllPosters()).to.be.falsy

    @actionHandler {type: @constants.POSTERS_LOADED, posters: postersList}

    expect(@posterStore.getAllPosters()).to.eql postersList

  it 'should save titles list when action TITLES_LOADED is invoked', ->
    titlesList = [{'f': 'faked'}, {'t': 'titles'}, {'l': 'list'}]
    expect(@posterStore.getPosterTitles()).to.be.an('array').and.empty

    @actionHandler {type: @constants.TITLES_LOADED, titles: titlesList}

    expect(@posterStore.getPosterTitles()).to.eql titlesList

  it 'should count new title position when action TITLE_MOVE is invoked', ->
    titles = [ { position:{x: 0, y: 0} }, { position:{x: 0, y: 0} } ]

    @editorStoreMock.getDraggedTitleId.returns 1
    @editorStoreMock.countTitlePosition.withArgs(5, 6).returns {x: 20, y: 30}

    @actionHandler {type: @constants.TITLES_LOADED, titles: titles}
    @actionHandler {type: @constants2.TITLE_MOVE, x: 5, y: 6}

    @dispatcherMock.waitFor.should.been.calledOnce.and.calledWithExactly(
      [@editorStoreMock.dispatcherIndex]
    )
    expect(@posterStore.getPosterTitles()).to.eql [
      { position:{x: 0, y: 0} }, { position:{x: 20, y: 30} }
    ]

  it 'should emit change event for known actions', ->
    @actionHandler {type: @constants.POSTERS_LOADED, posters: []}
    @posterStore.emit.should.been.calledOnce

    @actionHandler {type: @constants.POSTER_SELECTED, posterId: 1}
    @posterStore.emit.should.been.calledTwice

    @actionHandler {type: @constants.TITLES_LOADED, titles: [{position:{x:0,y:0}}]}
    @posterStore.emit.should.been.calledThrice

    @editorStoreMock.getDraggedTitleId.returns 0
    @actionHandler {type: @constants2.TITLE_MOVE, x: 6, y: 8}
    @posterStore.emit.callCount.should.equal 4

  it 'should not emit change event for unknown actions', ->
    @actionHandler {type: @constants.UNKNOWN_ACTION, posters: []}
    @posterStore.emit.should.not.been.called
