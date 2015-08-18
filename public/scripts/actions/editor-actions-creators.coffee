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

  selectTitle: (titleId) ->
    AppDispatcher.dispatch {type: constants.TITLE_SELECT, titleId: titleId}

  unselectTitle: (titleId) ->
    AppDispatcher.dispatch {type: constants.TITLE_UNSELECT}

  changeTitleText: (text) ->
    AppDispatcher.dispatch {type: constants.TITLE_TEXT_CHANGED, text: text}

  changeTitleFont: (property, value) ->
    AppDispatcher.dispatch {
      type: constants.TITLE_FONT_CHANGED, property: property, value: value
    }

  changeTitleAngle: (angle) ->
    AppDispatcher.dispatch {type: constants.TITLE_ANGLE_CHANGED, angle: angle}

  generatePoster: ->
    AppDispatcher.dispatch {type: constants.GENERATE_POSTER}