React = require 'react'
Fluxxor = require 'fluxxor'
FluxMixin = Fluxxor.FluxMixin React
StoreWatchMixin = Fluxxor.StoreWatchMixin
TitleEdit = require './title'
Canvas = require './canvas'

module.exports = App = React.createClass
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
		{w, h, url} = @state.poster
		overlayStyles =
			backgroundColor: 'black'
			position: 'absolute'
			top: 0
			right: 0
			bottom: 0
			left: 0
			opacity: 0.7
			display: 'none'

		<div>
			<div style={overlayStyles} />
			<Canvas width={w} height={h} url={url} />
			{@state.titles.map @createTitle}
		</div>