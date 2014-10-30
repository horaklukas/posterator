React = require 'react'
classSet = require 'react/lib/cx'
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

	createTitle: (title, idx) ->
		<TitleEdit
			top={title.y} left={title.x}
			width={title.w} height={title.h}
			text={title.text}
			size={title.size}
			font={title.font}
			bold={title.bold}
			italic={title.italic}
			key={idx}
			editing={@state.editingTitle is idx}
			onEditModeActivate={@editModeActivate} } />

	###*
  * @param {boolean} activate If edit mode activate or deactivate
  * @param {?number} titleId Index of title that will be edited
	###
	editModeActivate: (activate, titleId) ->
		@setState editingTitle: if activate then titleId else null

	onOverlayClick: ->
		if @state.editingTitle? then @setState editingTitle: null

	getStateFromFlux: ->
		flux = @getFlux()

		poster: flux.store('PostersStore').getPoster()
		titles: flux.store('TitlesStore').getTitles()

	getInitialState: ->
		editingTitle: null

	render: ->
		{w, h, url} = @state.poster
		overlayClasses = classSet {
			overlay: true
			visible: @state.editingTitle?
		}

		<div>
			<Canvas width={w} height={h} url={url} />
			<div className={overlayClasses} onClick={@onOverlayClick} />
			{@state.titles.map @createTitle}
		</div>