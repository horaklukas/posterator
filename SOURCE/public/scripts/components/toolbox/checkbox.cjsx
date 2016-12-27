React = require 'react'

class Checkbox extends React.Component
  constructor: (props) ->
    super props

  handleCheck: =>
    @props.onChange @props.name, !@props.checked

  render: ->
    <div className="checkbox-container">
      <div className="checkbox" onClick={@handleCheck}>
        {if !!@props.checked then '✔' else ''}
      </div>
      <span className="label">{@props.label}</span>
    </div>

module.exports = Checkbox