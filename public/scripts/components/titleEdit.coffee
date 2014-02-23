goog.provide 'app.comps.TitleEdit'

goog.require 'este.react'

app.comps.fonts = 
	'arial': 'Arial'
	'tnr': 'Times New Roman'
	'verd': 'Verdana'

app.comps.TitleEdit = este.react.create (`/** */`)
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
			selectedFont = id if @props['font'] is font
			@option {'value': id }, font 
		)

		@div {'style': {'backgroundColor': '#ccc'}}, [
			@label 'Size'
			@input({
				'type': 'number',	'min': 2, 'max': 100,  'defaultValue': @props['size']
				'ref': 'size',	'onChange': @onFontChange
			})
			@br()
			@label('Font'),	@select({
				'ref': 'font', 'defaultValue': selectedFont, 'onChange': @onFontChange
			}, fontsList)
			@br()
			@label 'Bold'
			@input {
				'type': 'checkbox', 'ref': 'bold', 'defaultChecked': @props['bold']
				'onChange': @onFontChange
			}
			@label 'Italic'
			@input {
				'type': 'checkbox', 'ref': 'italic','defaultChecked': @props['italic']
				'onChange': @onFontChange
			}
		]

	getDefaultProps: ->
		'top': 0, 'left': 0, 'width': 100, 'height': 100, 'text': ''

	getInitialState: ->
		'size': 10, 'font': 'Arial', 'bold': false, 'italic': false

	render: ->
		containerStyles =
			'position': 'absolute'
			'top': @props['top']
			'left': @props['left']

		inputStyles =
			'fontSize': @state['size']
			'fontFamily': @state['font']
			'fontWeight': if @state['bold'] then 'bold' else 'normal'
			'fontStyle': if @state['italic'] then 'italic' else 'normal' 
			'width': @props['width']
			'height': @props['height']
			'backgroundColor': 'transparent'
			'border': '1px solid black'

		@div {'style': containerStyles}, [
			@input 'type': 'text', style: inputStyles, 'defaultValue': @props['text']
			@createEditForm()
		]