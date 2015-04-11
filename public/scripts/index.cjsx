React = require 'react'
App = require './components/app'
PosterUtils = require './utils/poster-utils'

fontsList = [
  'Arial'
  'Times New Roman'
  'Verdana'
]

React.render <App />, document.getElementById 'app'

PosterUtils.loadPosters()