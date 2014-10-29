Fluxxor = require 'fluxxor'

module.exports = TitlesStore = Fluxxor.createStore
	initialize: (titles) ->
		@titles_ = titles

		@bindActions 'FONT_CHANGE', @handleFontChange
		@bindActions 'TEXT_CHANGE', @handleTextChange
		@bindActions 'POSITION_CHANGE', @handlePositionChange

	handleFontChange: (payload) ->
		@titles_[payload.id][payload.prop] = payload.value

		@emit 'change'

	handleTextChange: (payload) ->
		@titles_[payload.id].text = payload.text

		@emit 'change'

	handlePositionChange: (payload) ->
		title = @titles_[payload.id]
		title.x = payload.x
		title.y = payload.y

		@emit 'change'

	getTitles: ->
		@titles_

	