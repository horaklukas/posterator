React = require 'react'
PosterSelect = require './poster-select'
Editor = require './poster-editor'
PosterStore = require '../stores/poster-store'
EditorStore = require '../stores/editor-store'

getAppState = ->
	posters: PosterStore.getAllPosters()
	poster: PosterStore.getSelectedPoster()
	titles: PosterStore.getPosterTitles()
	selectedTitle: EditorStore.getSelectedTitleId()
	fonts: EditorStore.getAvailableFonts()

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
		{poster, titles, fonts, selectedTitle, posters} = @state
		Content =
			if poster?
				<Editor poster={poster} titles={titles} selectedTitle={selectedTitle}
					fonts={fonts} />
			else
				<PosterSelect posters={posters} />

		<div>{Content}</div>

module.exports = App