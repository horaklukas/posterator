React = require 'react'
Fluxxor = require 'fluxxor'
FluxMixin = Fluxxor.FluxMixin React
StoreWatchMixin = Fluxxor.StoreWatchMixin
TitleEdit = require './titleEdit'


module.exports = React.createClass
	mixins: [
		FluxMixin
		StoreWatchMixin('TitlesStore')
	]

	createTitle: (title, i) ->
		<TitleEdit
			top={title.y} left={title.x} 
			width={title.w} height={title.h} 
			text={title.text} 
			size={title.size} 
			font={title.font}
			bold={title.bold}
			italic={title.italic}
			key={i} />

	getStateFromFlux: ->
		flux = @getFlux()

		poster: flux.store('PostersStore').getPoster()
		titles: flux.store('TitlesStore').getTitles()

	render: ->
		styles =
			width: @state.poster.w
			height: @state.poster.h
			backgroundImage: "url(#{@state.poster.url})"

		<div style={styles}>
			{@state.titles.map @createTitle}
		</div>