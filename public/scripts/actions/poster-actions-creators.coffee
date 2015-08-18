AppDispatcher = require '../dispatcher/app-dispatcher'
constants = require '../constants/poster-constants'
PosterUtils = require '../utils/poster-utils'

module.exports =
  selectPoster: (posterId) ->
    AppDispatcher.dispatch {type: constants.POSTER_SELECTED, posterId: posterId}

    PosterUtils.loadPosterTitles(posterId)