React = require 'react'
EditorStore = require '../stores/editor-store'
CanvasUtils = require '../utils/canvas-utils'
actions = require '../actions/editor-actions-creators'
BBox = require '../utils/bbox'
_map = require 'lodash.map'
_forEach = require 'lodash.foreach'
domEvents = require 'dom-events'

class Canvas extends React.Component
  constructor: (props) ->
    super props
    @state = titlesBBoxes: []

  componentWillReceiveProps: (nextProps) ->
    @redrawCanvas nextProps.titles, nextProps.hoveredTitle

  redrawCanvas: (titles, hoveredTitle) =>
    ctx = @refs.canvas.getDOMNode().getContext '2d'
    ctx.drawImage @refs.image.getDOMNode(), 0, 0

    titlesBBoxes = []

    _forEach titles, (title, i) ->
      isHovered = hoveredTitle is i
      width = CanvasUtils.drawTitleOnCanvas ctx, title, i, isHovered
      {x, y} = title.position

      titlesBBoxes[i] = new BBox(x, y, width, title.font.size, title.angle)

    @setState titlesBBoxes: titlesBBoxes

  handleMouseDown: (e) =>
    {offsetX, offsetY} = e.nativeEvent

    for id, bbox of @state.titlesBBoxes when bbox.contains(offsetX, offsetY)
      titleId = Number(id)
      break

    if titleId?
      {x, y} = @props.titles[titleId].position

      actions.selectTitle titleId
      actions.startTitleMove(titleId, e.clientX, e.clientY, x, y)

      domEvents.on document, 'mousemove', @handleMove
      domEvents.on document, 'mouseup', @handleMouseUp
    else
      # no title clicked, so unselect actual selected title
      selectedTitleId = EditorStore.getSelectedTitleId()
      if selectedTitleId? then actions.unselectTitle selectedTitleId

  handleMove: (e) =>
    return e.preventDefault() unless EditorStore.getDraggedTitleId()?

    actions.titleMove e.clientX, e.clientY

  handleMouseUp: (e) =>
    selectedTitleId = EditorStore.getDraggedTitleId()

    return unless selectedTitleId?

    actions.stopTitleMove selectedTitleId

    domEvents.off document, 'mousemove', @handleMove
    domEvents.off document, 'mouseup', @handleMouseUp

  render: ->
    {width, height, url} = @props.poster

    canvasClasses = 'canvas'
    canvasClasses += ' dragging-title' if EditorStore.getDraggedTitleId()?

    <div className={canvasClasses}>
      <img src={url} ref="image" width={width} height={height}
        onLoad={@handleImageLoad} />
      <canvas id="result-poster" ref="canvas" width={width} height={height}
        onClick={@handleCanvasClick}
        onMouseDown={@handleMouseDown}
        onMouseMove={@handleMove}
        onMouseUp={@handleMouseUp}
        onLoad={@handleImageLoad}>
      </canvas>
    </div>

Canvas.propTypes =
  poster: React.PropTypes.shape {
    width: React.PropTypes.number, height: React.PropTypes.number
  }

module.exports = Canvas