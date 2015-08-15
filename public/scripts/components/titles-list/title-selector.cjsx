React = require 'react'
actions = require '../../actions/editor-actions-creators'

class TitleSelector extends React.Component
  handleClick: =>
    actions.selectTitle @props.id

  render: ->
    <span className="title" onClick={@handleClick}>{@props.label}</span>

TitleSelector.propTypes =
  label: React.PropTypes.string

module.exports = TitleSelector