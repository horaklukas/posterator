React = require 'react'
Fluxxor = require 'fluxxor'
FluxChildMixin = Fluxxor.FluxChildMixin React

module.exports = TitleToolbar = React.createClass
  mixins: [FluxChildMixin]

  onSizeChange: ({target}) ->
    @onFontChange 'size', Number target.value

  onFontFamilyChange: ({target}) ->
    @onFontChange 'font', target.value

  handleModifierChange: (name, value) ->
    @onFontChange name, value

  onFontChange: (property, value) ->
    @getFlux().actions.titles.changeFont @props.titleId, property, value

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
          onChange={@onSizeChange} />
        <label>Font family</label>
        <select value={@props.font} onChange={@onFontFamilyChange}>
          {fontsList}
        </select>
      </p>
      <p>
        <label>Bold</label>
        {@createModifier 'bold', @props.bold}
        <label>Italic</label>
        {@createModifier 'italic', @props.italic}
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
