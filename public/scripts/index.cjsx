React = require 'react'
App = require './components/app'
EditorUtils = require './utils/editor-utils'
PosterUtils = require './utils/poster-utils'
AppDispatcher = require './dispatcher/app-dispatcher'
constants = require './constants/editor-constants'

React.render <App />, document.getElementById 'app'

PosterUtils.loadPosters()
EditorUtils.loadFonts()

AppDispatcher.register ({type}) ->
  if type is constants.GENERATE_POSTER then EditorUtils.generatePoster()