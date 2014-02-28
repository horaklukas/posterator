goog.provide 'app.comps.Canvas'

goog.require 'app.comps.TitleEdit'
goog.require 'este.react'
goog.require 'goog.array'
goog.require 'goog.object'

editsDef = [
	{ 
		'top': 170, 'left': 150, 'width': 300, 'height': 100, 'text': 'Krkanka'
		'size': 20 , 'font': 'Verdana'
	}
	{
		'top': 400, 'left': 160, 'width': 400, 'height': 65, 'text': 'termin'
		'size': 16 	
	}
]

app.comps.Canvas = este.react.create (`/** */`)
	onEditModeChange: (isEditMode) ->
		@setState 'editMode': isEditMode

	getDefaultProps: ->
		'width': 800, 'height': 600, 'url': ''

	getInitialState: ->
		'editMode': false

	render: ->
		size =
			'width': @props['width']
			'height': @props['height']

		styles = goog.object.clone size
		goog.object.extend styles, {'backgroundImage': "url(#{@props['url']})"}

		overlayStyles = goog.object.clone  size
		goog.object.extend overlayStyles, {
			'visibility': if @state['editMode'] then 'visible' else 'hidden'
		}

		# common props, same for each titleEdit
		titleEditProps = 'editModeChange': @onEditModeChange

		titleEdits = goog.array.map editsDef, (def) ->
			goog.object.extend def, titleEditProps
			app.comps.TitleEdit def
		, this

		@div {'style': styles}, [
			@div {'className': 'overlay', 'style': overlayStyles}
			titleEdits
		]