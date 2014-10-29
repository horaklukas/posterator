Fluxxor = require 'fluxxor'

module.exports = TitlesStore = Fluxxor.createStore
	initialize: (titles) ->
		@titles_ = titles

		@bindActions 'FONT_CHANGE', @handleFontChange
		@bindActions 'TEXT_CHANGE', @handleTextChange

	handleFontChange: (payload) ->
		@titles_[payload.id][payload.prop] = payload.value

		@emit 'change'

	handleTextChange: (payload) ->
		@titles_[payload.id].text = payload.text

		@emit 'change'

	getTitles: ->
		@titles_

	