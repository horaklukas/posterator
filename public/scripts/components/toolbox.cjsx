React = require 'react'
HorizontalSlider = require './horizontal-slider'
FontSelector = require './font-selector'

actions = require '../actions/editor-actions-creators'
constants = require '../constants/editor-constants'

class Toolbox extends React.Component
  handleTextChange: (e) =>
    actions.changeTitleText e.target.value

  handleFontChange: (property, value) ->
    actions.changeTitleFont property, value

  handleChangeAngle: (name, angle) ->
    actions.changeTitleAngle angle

  render: ->
    styles = left: @props.left
    {fonts} = @props
    {family, size} = @props.font

    fontSelector = if fonts
      <FontSelector fonts={fonts} selected={family} onChange={@handleFontChange} />

    <div className="toolbox" style={styles}>
      <span className="label">Text</span>
      <input type="text" className="text" value={@props.text}
        onChange={@handleTextChange} />

      {fontSelector}

      <HorizontalSlider name="size" value={size} label="Font size"
          min={10} max={100} onChange={@handleFontChange} />
      <HorizontalSlider name="angle" value={@props.titleAngle} label="Text rotation"
          min={0} max={360} onChange={@handleChangeAngle} />
    </div>

module.exports = Toolbox