React = require 'react'
Fluxxor = require 'fluxxor'
FluxChildMixin = Fluxxor.FluxChildMixin React
TitleToolbar = require './title-toolbar'
domEvents = require 'dom-events'

appfonts =
  'arial': 'Arial'
  'tnr': 'Times New Roman'
  'verd': 'Verdana'

module.exports = Title = React.createClass
  mixins: [FluxChildMixin]

  startDrag: {}

  onTextChange: ({target}) ->
    @getFlux().actions.titles.changeText @props.key, target.value

  onActivateEditMode: (e) ->
    @props.onEditModeActivate true, @props.key

  onEditDialogConfirm: ->
    @props.onEditModeActivate false

  onDragMover: (e) ->
    @startDrag =
      x: e.pageX
      y: e.pageY

    domEvents.on document, 'mousemove', @onMove
    domEvents.on document, 'mouseup', @onDropMover

  onMove: (e) ->
    @setState {
      offsetX: e.pageX - @startDrag.x
      offsetY: e.pageY - @startDrag.y
    }

  onDropMover: ->
    domEvents.off document, 'mousemove', @onMove
    domEvents.off document, 'mouseup', @onDropMover    

    @getFlux().actions.titles.changePosition(
      @props.key
      @props.left + @state.offsetX
      @props.top + @state.offsetY
    )

    @setState @getInitialState()

  getInitialState: ->
    offsetX: 0
    offsetY: 0

  render: ->
    containerStyles =
      top: @props.top + @state.offsetY
      left: @props.left + @state.offsetX

    boxHeight = @props.size + 10

    inputStyles =
      fontSize: @props.size
      fontFamily: appfonts[@props.font]
      fontWeight: if @props.bold then 'bold' else 'normal'
      fontStyle: if @props.italic then 'italic' else 'normal'
      height: boxHeight
      lineHeight: "#{boxHeight}px"
      backgroundColor: if @props.editing then 'white' else 'transparent'


    <div className="title" style={containerStyles}>
      <span className="mover" onMouseDown={@onDragMover}>&nbsp;</span>
      <input type="text" style={inputStyles} value={@props.text}
        onFocus={@onActivateEditMode}
        onChange={@onTextChange}
        size={@props.text.length} />
      {
        if @props.editing
          @transferPropsTo(<TitleToolbar titleId={@props.key} fonts={appfonts}
            onConfirm={@onEditDialogConfirm} />
          )
      }
    </div>