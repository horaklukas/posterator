React = require 'react'
HorizontalSlider = require './horizontal-slider'
FontSelector = require './font-selector'
Checkbox = require './checkbox'
ColorPicker = require './color-picker'

actions = require '../../actions/editor-actions-creators'
constants = require '../../constants/editor-constants'

class Toolbox extends React.Component
  handleTextChange: (e) =>
    actions.changeTitleText e.target.value

  handleFontChange: (property, value) ->
    actions.changeTitleFont property, value

  handleChangeAngle: (name, angle) ->
    actions.changeTitleAngle angle

  handleColorChange: (color) ->
    actions.changeTitleFont 'color', color

  render: ->
    {fonts} = @props
    {family, size, bold, italic, color} = @props.font

    fontSelector = if fonts
      <FontSelector fonts={fonts} selected={family} onChange={@handleFontChange} />

    <div className="toolbox">
      <span className="label">Text</span>
      <input type="text" className="text" value={@props.text}
        onChange={@handleTextChange} />

      {fontSelector}

      <HorizontalSlider name="size" value={size} label="Font size"
          min={10} max={100} onChange={@handleFontChange} />
      <HorizontalSlider name="angle" value={@props.titleAngle} label="Text rotation"
          min={0} max={360} onChange={@handleChangeAngle} />

      <div>
        <Checkbox label="Bold" name="bold" checked={bold}
          onChange={@handleFontChange} />

        <Checkbox label="Italic" name="italic" checked={italic}
          onChange={@handleFontChange} />
      </div>

      <ColorPicker color={color} label="Font color" onChange={@handleColorChange} />

    </div>

module.exports = Toolbox