appfonts = 
	'arial': 'Arial'
	'tnr': 'Times New Roman'
	'verd': 'Verdana'

module.exports = React.createClass
	onFontChange: ->
		@setState {
			'font': appfonts[@refs.font.getDOMNode().value]
			'size': @refs.size.getDOMNode().value
			'bold': @refs.bold.getDOMNode().checked
			'italic': @refs.italic.getDOMNode().checked
		}

	createEditForm: ->
		selectedFont = null
		
		fontsList = (for id, font of appfonts
			selectedFont = id if @props['font'] is font
			<option value={id}>font</option> 
		)

		<div style={{'backgroundColor': '#ccc'}} >
			<label>Size</label>
			<input type='number' min={2} max={100} defaultValue={@props.size}
				ref='size' onChange={@onFontChange} />
			<br />
			<label>Font</label>
			<select ref='font' defaultValue={selectedFont} onChange={@onFontChange}>
				fontsList
			</select>
			<br />
			<label>Bold</label>
			<input type='checkbox' ref='bold' defaultChecked={@porps.bold}
				onChange={@onFontChange} />
			<label>Italic</label>
			<input type='checkbox' ref='italic' defaultChecked={@props.italic}
				onChange={@onFontChange} />
		</div>

	getDefaultProps: ->
		top: 0, left: 0, width: 100, height: 100, text: ''

	getInitialState: ->
		size: 10, font: 'Arial', bold: false, italic: false

	render: ->
		containerStyles =
			position: 'absolute'
			top: @props.top
			left: @props.left

		inputStyles =
			fontSize: @state.size
			fontFamily: @state.font
			fontWeight: if @state.bold then 'bold' else 'normal'
			fontStyle: if @state.italic then 'italic' else 'normal' 
			width: @props.width
			height: @props.height
			backgroundColor: 'transparent'
			border: '1px solid black'

		<div style={containerStyles}>
			<input type='text' style={inputStyles} defaultValue={@props.text}
			{@createEditForm()}
		</div>