React = require 'react'
Fluxxor = require 'fluxxor'
FluxChildMixin = Fluxxor.FluxChildMixin React
TitleToolbar = require './title-toolbar'

appfonts =
  'arial': 'Arial'
  'tnr': 'Times New Roman'
  'verd': 'Verdana'

module.exports = Title = React.createClass
  mixins: [FluxChildMixin]

  onTextChange: ({target}) ->
    @getFlux().actions.titles.changeText @props.key, target.value

  onActivateEditMode: (e) ->
    @props.onEditModeActivate true, @props.key

  onEditDialogConfirm: ->
    @props.onEditModeActivate false

  render: ->
    containerStyles =
      position: 'absolute'
      top: @props.top
      left: @props.left

    boxHeight = @props.size + 10

    inputStyles =
      fontSize: @props.size
      fontFamily: appfonts[@props.font]
      fontWeight: if @props.bold then 'bold' else 'normal'
      fontStyle: if @props.italic then 'italic' else 'normal'
      width: 'auto'
      height: boxHeight
      lineHeight: "#{boxHeight}px"
      backgroundColor: if @props.editing then 'white' else 'transparent'
      border: 0#'1px solid black'
      textOverflow: 'visible'

    <div style={containerStyles}>
      <input type='text' style={inputStyles} value={@props.text}
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