React = require 'react'
Picker = require 'react-color-picker'

class ColorPicker extends React.Component
  render: ->
    <div>
      <span className="label">{@props.label}</span>
      <Picker value={@props.color} onDrag={@props.onChange} />
    </div>

module.exports = ColorPicker