React = require 'react'
ReactSlider = require 'react-slider'
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
    {font} = @props

    <div className="toolbox" style={styles}>
      <span className="label">Text</span>
      <input type="text" className="text" value={@props.text}
        onChange={@handleTextChange} />
      <HorizontalSlider name="size" value={font.size} label="Font size"
          min={10} max={100} onChange={@handleFontChange} />

      <HorizontalSlider name="angle" value={@props.titleAngle} label="Text rotation"
          min={0} max={360} onChange={@handleChangeAngle} />
    </div>

class HorizontalSlider extends React.Component
  handleChange: (value) =>
    @props?.onChange @props.name, value

  render: ->
    {value, min, max, label} = @props

    <div className="slider-container">
      <span className="label">{label}</span>
      <ReactSlider value={value} orientation="horizontal" min={min} max={max}
        onChange={@handleChange}>
        <div>{value}</div>
      </ReactSlider>
    </div>


module.exports = Toolbox