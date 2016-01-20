AppDispatcher = require '../dispatcher/app-dispatcher'
constants = require '../constants/poster-constants'
getJSON = require 'jquery-ajax-json'

PHP_BACKEND_URL = '../backend/get-data.php'

PosterUtils =
  loadPosters: ->
    getJSON("#{PHP_BACKEND_URL}?type=posters")
      .done(PosterUtils._handlePostersLoaded)
      .fail(PosterUtils._handlePostersLoadFailed)

  _handlePostersLoaded: (posters) ->
    AppDispatcher.dispatch {type: constants.POSTERS_LOADED, posters: posters}

  _handlePostersLoadFailed: ->
    AppDispatcher.dispatch {
      type: constants.POSTERS_LOAD_FAILED
      message: 'Loading posters failed'
    }

  loadPosterTitles: (posterId) ->
    getJSON("#{PHP_BACKEND_URL}?type=titles&poster=#{posterId}")
      .done(PosterUtils._handleTitlesLoaded)
      .fail(PosterUtils._handleTitlesLoadFailed)

  _handleTitlesLoaded: (titles) ->
    AppDispatcher.dispatch {type: constants.TITLES_LOADED, titles: titles}

  _handleTitlesLoadFailed: ->
    AppDispatcher.dispatch {
      type: constants.TITLES_LOAD_FAILED
      message: 'Loading titles failed'
    }


module.exports = PosterUtils