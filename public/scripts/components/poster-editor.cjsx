React = require 'react'
Title = require './editable-title'
Toolbox = require './toolbox'
Canvas = require './canvas'
EditorStore = require '../stores/editor-store'
_map = require 'lodash.map'

class Editor extends React.Component
  createTitle: (title, id) ->
    {position, text, font} = title
    dragged = EditorStore.isTitleDragged(id)

    <Title position={position} font={font} text={text} key={id} id={id}
      dragged={dragged} />

  render: ->
    {poster} = @props
    Titles = _map @props.titles, @createTitle

    <div className="editor" style={height: poster.height} >
      <Canvas poster={poster} />
      {Titles}
      <Toolbox left={poster.width} />
    </div>

module.exports = Editor
