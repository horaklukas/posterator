React = require 'react'
actions = require '../../actions/editor-actions-creators'

class TitleSelector extends React.Component
  handleMouseOver: =>
    actions.hoverTitle @props.id

  handleMouseOut: ->
    actions.unhoverTitle()

  handleClick: =>
    actions.selectTitle @props.id

  render: ->
    <span className="title" onClick={@handleClick} onMouseOver={@handleMouseOver}
      onMouseOut={@handleMouseOut}>{@props.label}</span>

TitleSelector.propTypes =
  label: React.PropTypes.string

module.exports = TitleSelector