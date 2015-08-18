AppDispatcher = require '../dispatcher/app-dispatcher'
Store = require './store'
EditorStore = require './editor-store'
posterConstants = require '../constants/poster-constants'
editorConstants = require '../constants/editor-constants'

class PostersStore extends Store
  constructor: ->
    @dispatcherIndex = AppDispatcher.register @actionsHandler

  actionsHandler: (payload) =>
    {type} = payload

    switch type
      when posterConstants.POSTER_SELECTED then @selected = payload.posterId
      when posterConstants.POSTERS_LOADED then @posters = payload.posters
      when posterConstants.TITLES_LOADED then @titles = payload.titles
      when editorConstants.TITLE_MOVE
        AppDispatcher.waitFor [EditorStore.dispatcherIndex]
        titleId = EditorStore.getDraggedTitleId()

        @titles[titleId].position = EditorStore.countTitlePosition(
          payload.x, payload.y
        )

      when editorConstants.TITLE_TEXT_CHANGED
        AppDispatcher.waitFor [EditorStore.dispatcherIndex]
        titleId = EditorStore.getSelectedTitleId()

        @titles[titleId].text = payload.text

      when editorConstants.TITLE_FONT_CHANGED
        AppDispatcher.waitFor [EditorStore.dispatcherIndex]
        titleId = EditorStore.getSelectedTitleId()

        @titles[titleId].font[payload.property] = payload.value

      when editorConstants.TITLE_ANGLE_CHANGED
        AppDispatcher.waitFor [EditorStore.dispatcherIndex]
        titleId = EditorStore.getSelectedTitleId()

        @titles[titleId].angle = payload.angle

      else return # dont emit change since we didnt any change

    @emit Store.CHANGE_EVENT

  getAllPosters: ->
    @posters ? null

  getSelectedPoster: ->
    if @posters? and @selected? then @posters[@selected] else null

  getPosterTitles: ->
    @titles ? null

module.exports = new PostersStore