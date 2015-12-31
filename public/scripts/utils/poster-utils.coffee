AppDispatcher = require '../dispatcher/app-dispatcher'
constants = require '../constants/poster-constants'
getJSON = require 'jquery-ajax-json'

PHP_BACKEND_URL = '../backend/get-data.php'

PosterUtils =
  loadPosters: ->
    getJSON(PHP_BACKEND_URL)
      .done(PosterUtils._handlePostersLoaded)
      .fail (err) -> console.error 'Failed to load posters' + err.toString()

  _handlePostersLoaded: (posters) ->
    AppDispatcher.dispatch {type: constants.POSTERS_LOADED, posters: posters}

module.exports = PosterUtils