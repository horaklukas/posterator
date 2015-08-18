React = require 'react'
ReactSlider = require 'react-slider'

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

module.exports = HorizontalSlider