React = require 'react'
Title = require './editable-title'
Toolbox = require './toolbox'
Canvas = require './canvas'
EditorStore = require '../stores/editor-store'
_map = require 'lodash.map'

class Editor extends React.Component
  createTitle: (title, id) ->
    {position, text, font, angle} = title
    dragged = EditorStore.isTitleDragged(id)
    selected = EditorStore.isTitleSelected(id)

    <Title position={position} font={font} text={text} key={id} id={id}
      angle={angle} dragged={dragged} selected={selected} />

  render: ->
    {poster, titles, selectedTitle, fonts} = @props
    titleToEdit = titles[selectedTitle] ? null

    Titles = _map titles, @createTitle
    TitleToolbox = if titleToEdit?
      <Toolbox left={poster.width} text={titleToEdit.text} font={titleToEdit.font}
        titleAngle={titleToEdit.angle} fonts={fonts} />

    <div className="editor" style={height: poster.height} >
      <Canvas poster={poster} />
      {Titles}
      {TitleToolbox}
    </div>

module.exports = Editor
