React = require 'react'
Fluxxor = require 'fluxxor'
FluxChildMixin = Fluxxor.FluxChildMixin React
ColorPicker = require 'react-colorpicker'

module.exports = TitleToolbar = React.createClass
  mixins: [FluxChildMixin]

  handleSizeChange: ({target}) ->
    @handleFontChange 'size', Number target.value

  handleFontFamilyChange: ({target}) ->
    @handleFontChange 'font', target.value

  handleModifierChange: (name, value) ->
    @handleFontChange name, value

  handleFontChange: (property, value) ->
    @getFlux().actions.titles.changeFont @props.titleId, property, value

  handleColorChange: (ev) ->

  getInitialState: ->
    color: '#000000'

  ###*
  * @param {string} name Name of modifier, also name of property
  * @param {boolean} value Value for modifier 
  ###
  createModifier: (name, value) ->
    <FontModifier name={name} value={value} onChange={@handleModifierChange} />

  render: ->
    selectedFont = null

    fontsList = (for id, font of @props.fonts
    	<option value={id}>{font}</option>
    )

    <div className="toolbar" >
      <p>
        <label>Size</label>
        <input type='number' min={2} max={100} size={3} value={@props.size}
          onChange={@handleSizeChange} />
        <label>Font family</label>
        <select value={@props.font} onChange={@handleFontFamilyChange}>
          {fontsList}
        </select>
      </p>
      <p>
        <label>Bold</label>
        {@createModifier 'bold', @props.bold}
        <label>Italic</label>
        {@createModifier 'italic', @props.italic}
        <ColorPicker color={@state.color} onChange={@handleColorChange} />
      </p>
      <p>
        <button style={width: '100%'} onClick={@props.onConfirm}>Confirm</button>
      </p>
    </div>

FontModifier = React.createClass
  handleChange: (e) ->
    @props.onChange @props.name, e.target.checked

  render: ->
    <input type='checkbox' checked={@props.value} onChange={@handleChange} />
