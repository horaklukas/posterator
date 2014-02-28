goog.provide 'app.comps.TitleEdit'

goog.require 'este.react'

app.comps.fonts = 
	'arial': 'Arial'
	'tnr': 'Times New Roman'
	'verd': 'Verdana'

app.comps.TitleEdit = este.react.create (`/** */`)
	onFocusChange: (ev) ->
		showEditForm = ev?.type is 'focus'
		
		@setState 'editing': showEditForm
		@props['editModeChange'](showEditForm)

	onFontChange: ->
		@setState {
			'font': app.comps.fonts[@refs['font'].getDOMNode().value]
			'size': @refs['size'].getDOMNode().value
			'bold': @refs['bold'].getDOMNode().checked
			'italic': @refs['italic'].getDOMNode().checked
		}

	createEditForm: ->
		selectedFont = null
		
		fontsList = (for id, font of app.comps.fonts
			selectedFont = id if @state['font'] is font
			@option {'value': id }, font 
		)

		@div {'className': 'fontForm'}, [
			@label 'Size'
			@input({
				'type': 'number',	'min': 2, 'max': 100,  'defaultValue': @state['size']
				'ref': 'size',	'onChange': @onFontChange
			})
			@br()
			@label('Font'),	@select({
				'ref': 'font', 'defaultValue': selectedFont, 'onChange': @onFontChange
			}, fontsList)
			@br()
			@label 'Bold'
			@input {
				'type': 'checkbox', 'ref': 'bold', 'defaultChecked': @state['bold']
				'onChange': @onFontChange
			}
			@label 'Italic'
			@input {
				'type': 'checkbox', 'ref': 'italic','defaultChecked': @state['italic']
				'onChange': @onFontChange
			}
		]

	getDefaultProps: ->
		'top': 0, 'left': 0, 'width': 100, 'height': 100, 'text': ''

	getInitialState: ->
		state = 
			'size': @props['size'] ? 10
			'font': @props['font'] ? 'Arial'
			'bold': @props['bold'] ? false
			'italic': @props['italic'] ? false
			'editing': false
		
	render: ->
		containerProps =
			'style':
				'position': 'absolute'
				'top': @props['top']
				'left': @props['left']
			'className': 'titleEdit'

		if @state['editing'] then containerProps.className += ' editing'

		inputStyles =
			'fontSize': @state['size']
			'fontFamily': @state['font']
			'fontWeight': if @state['bold'] then 'bold' else 'normal'
			'fontStyle': if @state['italic'] then 'italic' else 'normal' 
			'width': @props['width']
			'height': @props['height']

		@div containerProps, [
			@input { 
				'type': 'text', style: inputStyles, 'defaultValue': @props['text']
				'className': 'title', 'onFocus': @onFocusChange
			}
			@createEditForm()
			@button {'onClick': @onFocusChange, 'className': 'confirm'}, 'OK'
		]