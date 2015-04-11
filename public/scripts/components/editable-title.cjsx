React = require 'react'
domEvents = require 'dom-events'
actions = require '../actions/editor-actions-creators'

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

  render: ->
    {position, font} = @props
    styles =
      top: position.y
      left: position.x
      fontFamily: font.family
      fontSize: font.size
      color: '#' + font.color


    styles.fontStyle =
      if font.italic is true then 'italic'
      else if font.bold then 'bold'

    classes = 'editable-title'
    classes += ' dragged' if @props.dragged

    <div className={classes} style={styles}
      onMouseDown={@handleDrag}
      onMouseMove={@handleMove}
      onMouseUp={@handleDrop}>{@props.text}</div>

module.exports = EditableTitle