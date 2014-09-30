React = require 'react'
Fluxxor = require 'fluxxor'
FluxChildMixin = Fluxxor.FluxChildMixin React

appfonts = 
  'arial': 'Arial'
  'tnr': 'Times New Roman'
  'verd': 'Verdana'

module.exports = Title = React.createClass
  mixins: [FluxChildMixin]

  onSizeChange: ({target}) ->
    @onFontChange 'size', Number target.value

  onFontFamilyChange: ({target}) ->
    @onFontChange 'font', target.value

  onBoldChange: ({target}) ->
    @onFontChange 'bold', target.checked

  onItalicChange: ({target}) ->
    @onFontChange 'italic', target.checked

  onFontChange: (property, value) ->
    @getFlux().actions.titles.changeFont @props.key, property, value

  onTextChange: ({target}) ->
    @getFlux().actions.titles.changeText @props.key, target.value

  onActivateEditMode: (e) ->
    @setState editing: true

  createEditForm: ->
    selectedFont = null
    
    fontsList = (for id, font of appfonts
      selectedFont = id if @props['font'] is font
      <option value={id}>{font}</option> 
    )

    <div>
      <div style={{'backgroundColor': '#ccc'}} >
        <label>Size</label>
        <input type='number' min={2} max={100} value={@props.size} 
          onChange={@onSizeChange} />
        <label>Font family</label>
        <select value={selectedFont} onChange={@onFontFamilyChange}>
          {fontsList}
        </select>
        <label>Bold</label>
        <input type='checkbox' checked={@props.bold} onChange={@onBoldChange} />
        <label>Italic</label>
        <input type='checkbox' checked={@props.italic} onChange={@onItalicChange} />
      </div>
    </div>

  getInitialState: ->
    editing: false

  render: ->
    containerStyles =
      position: 'absolute'
      top: @props.top
      left: @props.left

    inputStyles =
      fontSize: @props.size
      fontFamily: @props.font
      fontWeight: if @props.bold then 'bold' else 'normal'
      fontStyle: if @props.italic then 'italic' else 'normal' 
      width: @props.width
      height: @props.height
      backgroundColor: 'transparent'
      border: '1px solid black'

    <div style={containerStyles}>
      <input type='text' style={inputStyles} value={@props.text} 
        onFocus={@onActivateEditMode}
        onBlur={@onActivateEditMode} 
        onChange={@onTextChange} />
      {@createEditForm() if @state.editing}
    </div>