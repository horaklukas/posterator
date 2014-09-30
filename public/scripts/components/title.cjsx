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
    @setState editing: true

  getInitialState: ->
    editing: false

  render: ->
    containerStyles =
      position: 'absolute'
      top: @props.top
      left: @props.left

    inputStyles =
      fontSize: @props.size
      fontFamily: appfonts[@props.font]
      fontWeight: if @props.bold then 'bold' else 'normal'
      fontStyle: if @props.italic then 'italic' else 'normal' 
      width: @props.width
      height: @props.height
      backgroundColor: 'transparent'
      border: '1px solid black'

    <div style={containerStyles}>
      <input type='text' style={inputStyles} value={@props.text} 
        onFocus={@onActivateEditMode}
        onChange={@onTextChange} />
      {@transferPropsTo(<TitleToolbar titleId={@props.key} fonts={appfonts} />) if @state.editing}
    </div>