React = require 'react'
Fluxxor = require 'fluxxor'
FluxChildMixin = Fluxxor.FluxChildMixin React

module.exports = TitleToolbar = React.createClass
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
    @getFlux().actions.titles.changeFont @props.titleId, property, value

  render: ->
    selectedFont = null
    
    fontsList = (for id, font of @props.fonts 
    	<option value={id}>{font}</option>
    )

    <div>
      <div style={{'backgroundColor': '#ccc'}} >
        <label>Size</label>
        <input type='number' min={2} max={100} value={@props.size} 
          onChange={@onSizeChange} />
        <label>Font family</label>
        <select value={@props.font} onChange={@onFontFamilyChange}>
          {fontsList}
        </select>
        <label>Bold</label>
        <input type='checkbox' checked={@props.bold} onChange={@onBoldChange} />
        <label>Italic</label>
        <input type='checkbox' checked={@props.italic} onChange={@onItalicChange} />
      </div>
    </div>
