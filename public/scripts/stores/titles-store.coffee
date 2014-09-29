Fluxxor = require 'fluxxor'

module.exports = TitlesStore = Fluxxor.createStore
	initialize: (titles) ->
		@titles_ = titles

		@bindActions 'FONT_CHANGE', @handleFontChange

	handleFontChange: (payload) ->
		@titles_[payload.id][payload.prop] = payload.value

		@emit 'change'

	getTitles: ->
		@titles_

	