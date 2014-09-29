Fluxxor = require 'fluxxor'

module.exports = TitlesStore = Fluxxor.createStore
	initialize: (posters, selected = 0) ->
		@posters_ = posters
		@selected_ = selected

	getPoster: ->
		@posters_[@selected_]

	