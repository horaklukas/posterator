AppDispatcher = require '../dispatcher/app-dispatcher'
constants = require '../constants/editor-constants'

module.exports =
  startTitleMove: (titleId, x, y, titleX, titleY) ->
    AppDispatcher.dispatch {
      type: constants.TITLE_MOVE_START, titleId: titleId, x: x, y: y,
      startPosition: {x: titleX, y: titleY}
    }

  titleMove: (x, y) ->
    AppDispatcher.dispatch {
      type: constants.TITLE_MOVE, x: x, y: y
    }

  stopTitleMove: (titleId) ->
    AppDispatcher.dispatch {type: constants.TITLE_MOVE_STOP}
