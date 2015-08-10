React = require 'react'
Title = require './editable-title'
Toolbox = require './toolbox'
Canvas = require './canvas'
EditorStore = require '../stores/editor-store'
_map = require 'lodash.map'
actions = require '../actions/editor-actions-creators'

class Editor extends React.Component
  createTitle: (title, id) ->
    {position, text, font, angle} = title
    dragged = EditorStore.isTitleDragged(id)
    selected = EditorStore.isTitleSelected(id)

    <Title position={position} font={font} text={text} key={id} id={id}
      angle={angle} dragged={dragged} selected={selected} />

  createToolbox: (title, leftPosition, fonts) ->
    <Toolbox left={leftPosition} text={title.text} font={title.font}
      titleAngle={title.angle} fonts={fonts} />

  createTitlesList: (titles) =>
    <div className="titles-list">
      {titles.map @createTitleSelector}
    </div>

  createTitleSelector: ({text}, id) =>
    <TitleSelector id={id} label={text} key={id} />

  render: ->
    {poster, titles, selectedTitle, fonts} = @props
    styles = left: poster.width
    titleToEdit = titles[selectedTitle] ? null

    Titles = _map titles, @createTitle
    panelContent =
      if titleToEdit? then @createToolbox titleToEdit, poster.width, fonts
      else  @createTitlesList titles

    <div className="editor" style={height: poster.height} >
      <Canvas poster={poster} />
      {Titles}
      <div className="panel" style={styles}>
        {panelContent}
      </div>
    </div>

class TitleSelector extends React.Component
  handleClick: =>
    actions.selectTitle @props.id

  render: ->
    <span className="title" onClick={@handleClick}>{@props.label}</span>

module.exports = Editor
