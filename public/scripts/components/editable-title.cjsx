React = require 'react'
domEvents = require 'dom-events'
actions = require '../actions/editor-actions-creators'
_includes = require 'lodash.includes'

TITLE_CLASS = 'editable-title'

class EditableTitle extends React.Component
  handleDrag: (e) =>
    {position} = @props
    actions.startTitleMove(
      @props.id, e.clientX, e.clientY, position.x, position.y
    )

    domEvents.on document, 'mousemove', @handleMove
    domEvents.on document, 'mouseup', @handleDrop

  handleMove: (e) =>
    if @props.dragged isnt true then return e.preventDefault()

    actions.titleMove e.clientX, e.clientY

  handleDrop: (e) =>
    actions.stopTitleMove @props.id

    domEvents.off document, 'mousemove', @handleMove
    domEvents.off document, 'mouseup', @handleDrop

  handleSelect: (e) =>
    actions.selectTitle @props.id

    canvasElement = document.querySelector '.canvas'
    domEvents.once canvasElement, 'click', @handleUnselect

  handleUnselect: (e) =>
    if _includes e.target.className, TITLE_CLASS then return e.preventDefault()

    actions.unselectTitle @props.id

  render: ->
    {position, font, angle} = @props
    styles =
      top: position.y
      left: position.x
      fontFamily: font.family
      fontSize: font.size
      color: '#' + font.color
      # TODO add vendor prefix variations of transform property
      transform: "rotate(#{angle}deg)"

    styles.fontStyle =
      if font.italic is true then 'italic'
      else if font.bold then 'bold'

    classes = TITLE_CLASS
    classes += ' dragged' if @props.dragged
    classes += ' selected' if @props.selected

    <div className={classes} style={styles}
      onClick={@handleSelect}
      onMouseDown={@handleDrag}
      onMouseMove={@handleMove}
      onMouseUp={@handleDrop}>{@props.text}</div>

module.exports = EditableTitle