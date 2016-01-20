React = require 'react'
PosterSelect = require './poster-select'
Editor = require './poster-editor'
PosterStore = require '../stores/poster-store'
EditorStore = require '../stores/editor-store'
Modal = require('react-bootstrap/lib/Modal')

getAppState = ->
	posters: PosterStore.getAllPosters()
	poster: PosterStore.getSelectedPoster()
	titles: PosterStore.getPosterTitles()
	selectedTitle: EditorStore.getSelectedTitleId()
	hoveredTitle: EditorStore.getHoveredTitleId()
	fonts: EditorStore.getAvailableFonts()

class App extends React.Component
	@DEFAULT_WIDTH = 1024
	@DEFAULT_HEIGHT = 768

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
		{poster, titles, fonts, selectedTitle, hoveredTitle, posters} = @state

		unless poster?
			showModal = true
			# default poster dimensions
			poster = width: App.DEFAULT_WIDTH, height: App.DEFAULT_HEIGHT

		<div>
			<Modal show={showModal} bsSize="lg" className="intro-modal" animation={false}>
				<Modal.Header>
          <Modal.Title>Poster background select</Modal.Title>
        </Modal.Header>
				<Modal.Body>
					<PosterSelect posters={posters} />
				</Modal.Body>
			</Modal>

			<Editor poster={poster} titles={titles} selectedTitle={selectedTitle}
				hoveredTitle={hoveredTitle} fonts={fonts} />
		</div>

module.exports = App