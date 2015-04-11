React = require 'react'
PosterSelect = require './poster-select'
Editor = require './poster-editor'
PosterStore = require '../stores/poster-store'
EditorStore = require '../stores/editor-store'

_map = require 'lodash.map'

getAppState = ->
	posters: PosterStore.getAllPosters()
	poster: PosterStore.getSelectedPoster()
	titles: PosterStore.getPosterTitles()
	#fonts: AppStore.getFonts()

class App extends React.Component
	constructor: (props) ->
		super props

		@state = getAppState()

	_onChange: =>
		@setState getAppState()

	componentWillMount: ->
		PosterStore.addChangeListener @_onChange
		EditorStore.addChangeListener @_onChange

	componentWillUmount: ->
		PosterStore.removeChangeListener @_onChange
		EditorStore.removeChangeListener @_onChange

	render: ->
		{poster} = @state
		Content =
			if poster? then <Editor poster={poster} titles={@state.titles} />
			else <PosterSelect posters={@state.posters} />

		<div>{Content}</div>

module.exports = App