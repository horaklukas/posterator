AppDispatcher = require '../dispatcher/app-dispatcher'
Store = require './store'
constants = require '../constants/editor-constants'

class EditorStore extends Store
  constructor: ->
    @dragged = {}
    @dispatcherIndex = AppDispatcher.register @actionsHandler

  actionsHandler: (payload) =>
    {type} = payload

    switch type
      when constants.FONTS_LOADED then @fonts = payload.fonts

      when constants.TITLE_MOVE_START
        @dragged = {
          id: payload.titleId,
          x: payload.x,
          y: payload.y
          initialPosition: {
            x: payload.startPosition.x, y: payload.startPosition.y
          }
        }

      when constants.TITLE_MOVE_STOP then @dragged = {}
      when constants.TITLE_SELECT
        @selectedTitle = payload.titleId
        @hoveredTitle = null

      when constants.TITLE_UNSELECT then @selectedTitle = null
      when constants.TITLE_HOVER_IN_LIST then @hoveredTitle = payload.titleId
      when constants.TITLE_UNHOVER_IN_LIST then @hoveredTitle = null
      else return # dont emit change since we didnt any change

    @emit Store.CHANGE_EVENT

  getAvailableFonts: ->
    @fonts

  isTitleDragged: (titleId) ->
    @dragged.id is titleId

  getDraggedTitleId: ->
    @dragged.id

  countTitlePosition: (actualClientX, actualClientY) ->
    x: (actualClientX - @dragged.x) + @dragged.initialPosition.x
    y: (actualClientY - @dragged.y) + @dragged.initialPosition.y

  isTitleSelected: (id) ->
    @selectedTitle is id

  getSelectedTitleId: ->
    @selectedTitle

  getHoveredTitleId: ->
    @hoveredTitle

module.exports = new EditorStore