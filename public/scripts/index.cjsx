React = require 'react'
App = require './components/app'
EditorUtils = require './utils/editor-utils'
PosterUtils = require './utils/poster-utils'

React.render <App />, document.getElementById 'app'

PosterUtils.loadPosters()
EditorUtils.loadFonts()